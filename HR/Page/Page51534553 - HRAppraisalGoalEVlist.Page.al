page 51534553 "HR Appraisal Goal EV list"
{
    CardPageID = "HR Appraisal Goal EV";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    AdditionalSearchTerms = 'HR Appraisal Goal EV list';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Appraisal No"; "Appraisal No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Send To Appraisee")
                {
                    Caption = 'Send To Appraisee';
                    Image = Return;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Status := 0;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Get Job Specific Evaluation Areas")
                {
                    Caption = 'Get Job Specific Evaluation Areas';
                    Image = ChangeTo;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if "Job Title" = '' then
                            Error('Please specify the employees job title in the Employee card before proceeding');


                        if Confirm('Any previous job specific evaluations made for ' + "Employee Name" + ' Appraisal Period ' + "Appraisal Period" + ' ' +
                        'will be deleted. Proceed?', true) = false then
                            exit;

                        HRAppraisalEvaluations.Reset;
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations."Employee No", "Employee No");
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations."Appraisal Period", "Appraisal Period");
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations.Category, HRAppraisalEvaluations.Category::"JOB SPECIFIC EVALUATION AREA");
                        if HRAppraisalEvaluations.Find('-') then
                            HRAppraisalEvaluations.DeleteAll;


                        //COPY EVALUATION AREA FOR ONE EMPLOYEE
                        HRAppraisalEvaluationAreas.Reset;
                        HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."Assign To", "Job Title");
                        if HRAppraisalEvaluationAreas.Find('-') then
                            HRAppraisalEvaluationAreas.FindFirst;
                        begin
                            HRAppraisalEvaluations.Reset;
                            repeat
                                HRAppraisalEvaluations.Init;
                                HRAppraisalEvaluations."Employee No" := "Employee No";
                                HRAppraisalEvaluations."Evaluation Code" := HRAppraisalEvaluationAreas.Code;
                                HRAppraisalEvaluations."Sub Category" := HRAppraisalEvaluationAreas."Sub Category";
                                HRAppraisalEvaluations.Group := HRAppraisalEvaluationAreas.Group;
                                HRAppraisalEvaluations.Category := HRAppraisalEvaluationAreas."Categorize As";
                                HRAppraisalEvaluations."Line No" := HRAppraisalEvaluationAreas."Line No";
                                HRAppraisalEvaluations."Appraisal Period" := "Appraisal Period";
                                HRAppraisalEvaluations.Insert();
                            until HRAppraisalEvaluationAreas.Next = 0;
                            // HRAppraisalEvaluationAreas.FINDFIRST;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Next Page")
            {
                Caption = '&Next Page';
                Image = NextSet;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    //FORM.RUNMODAL(39005843
                    //PAGE.Run(39003985, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if HREmp.Get("Employee No") then
            "Job Title" := HREmp."Job Title";
    end;

    trigger OnOpenPage()
    begin
        /*
        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN
        SETRANGE("User ID",HREmp."User ID")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("User ID",USERID);
        */

    end;

    var
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
}

