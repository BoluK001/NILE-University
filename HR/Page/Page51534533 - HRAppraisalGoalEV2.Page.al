page 51534533 "HR Appraisal Goal EV 2"
{
    PageType = Document;
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE (Status = CONST ("Pending Approval"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                }
            }
            part(SF; "HR Appraisal Evaluation 3")
            {
            }
            label(Control1102755019)
            {
                CaptionClass = Text19043501;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
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

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Status := 0;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Import Evaluation Areas")
                {
                    Caption = 'Import Evaluation Areas';

                    trigger OnAction()
                    begin
                        HRAppraisalEvaluations.Reset;
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations."Employee No", "Employee No");
                        HRAppraisalEvaluations.SetRange(HRAppraisalEvaluations.Category, HRAppraisalEvaluations.Category::"EMPLOYEE PERFORMANCE FACTOR");
                        if HRAppraisalEvaluations.Find('-') then
                            HRAppraisalEvaluations.DeleteAll;

                        //COPY EVALUATION AREA FOR ONE EMPLOYEE
                        HRAppraisalEvaluationAreas.Reset;
                        HRAppraisalEvaluationAreas.SetRange
                        (HRAppraisalEvaluationAreas."Categorize As", HRAppraisalEvaluationAreas."Categorize As"::"EMPLOYEE PERFORMANCE FACTOR");
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
                                HRAppraisalEvaluations."Appraisal Period" := "Appraisal Period";
                                HRAppraisalEvaluations."Line No" := HRAppraisalEvaluationAreas."Line No";
                                //HRAppraisalEvaluations."Line No":=HRAppraisalEvaluations."Line No"+1;
                                HRAppraisalEvaluations.Insert();
                            until HRAppraisalEvaluationAreas.Next = 0;
                            // HRAppraisalEvaluationAreas.FINDFIRST;
                        end;
                    end;
                }
            }
        }
    }

    var
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        Text19043501: Label 'EMPLOYEE PERFORMANCE FACTORS ';
}

