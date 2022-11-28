page 51534937 "HR Appraisal Goal EV MD"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field("Appraisal Period"; "Appraisal Period")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = all;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = all;
                }
                field("Company Score"; "Company Score")
                {
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    ApplicationArea = All;
                }
                field(CompanyScoreAppraisee; CompanyScoreAppraisee)
                {
                    Caption = 'Appraisee Company Score';
                    Editable = false;
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    ApplicationArea = All;
                }
                field("Bonus Point appraisee"; "Bonus Point appraisee")
                {
                    ApplicationArea = all;
                }
                field("KPIs Appraisee Score"; "KPIs Appraisee Score")
                {
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("KPIs Appraiser Score"; "KPIs Appraiser Score")
                {
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("KPIs Mgt Score"; "KPIs Mgt Score")
                {
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field(KPIScoreAppraisee; KPIScoreAppraisee)
                {
                    Caption = 'KPI Score';
                    Editable = false;
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("Performance Score Appraisee"; "Performance Score Appraisee")
                {
                    ExtendedDatatype = Ratio;
                    MaxValue = 64;
                    ApplicationArea = All;
                }
                field("Performance Score Appraiser"; "Performance Score Appraiser")
                {
                    ExtendedDatatype = Ratio;
                    MaxValue = 64;
                    ApplicationArea = All;
                }
                field("Performance Score Mgt"; "Performance Score Mgt")
                {
                    ExtendedDatatype = Ratio;
                    MaxValue = 64;
                    ApplicationArea = All;
                }
                field(PFScoreAppraisee; PFScoreAppraisee)
                {
                    Caption = 'Performance Score';
                    ExtendedDatatype = Ratio;
                    MaxValue = 64;
                    ApplicationArea = All;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Comments Appraiser"; "Comments Appraiser")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Comments Mgt"; "Comments Mgt")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            part("Set your goals and objectives in line with your department's strategy."; "HR Interviewer Details")
            {
                Caption = 'Set your goals and objectives in line with your department''s strategy.';
                SubPageLink = "Employee No." = FIELD("Appraisal No");
                ApplicationArea = All;
            }
            part(SF; "HR Mgt Evaluation Lines")
            {
                Caption = 'JOB SPECIFIC EVALUATION (KEY RESULTS IN LINE WITH STAFF JOB DESCRIPTION AND/ OR SCORECARD)';
                ApplicationArea = All;
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Period" = FIELD("Appraisal Period");
            }
            group("Evaluation Scores/Remarks")
            {
                Caption = 'Evaluation Scores/Remarks';
                Editable = false;
                field("Bonus Point Appraiser"; "Bonus Point Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Mgt"; "Bonus Point Mgt")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Appraiser Remarks"; "Bonus Point Appraiser Remarks")
                {
                    ApplicationArea = all;
                }
                field("Bonus Point Mgt Remarks"; "Bonus Point Mgt Remarks")
                {
                    ApplicationArea = all;
                }
                field("Recommendation Appraiser"; "Recommendation Appraiser")
                {
                    ApplicationArea = all;
                }
                field("Recommendation 2"; "Recommendation 2")
                {
                    ApplicationArea = all;
                }
                field("Recommendation Mgt"; "Recommendation Mgt")
                {
                    ApplicationArea = all;
                }
                field("Recommendation 3"; "Recommendation 3")
                {
                    ApplicationArea = all;
                }
                field("Development Requirements Appra"; "Development Requirements Appra")
                {
                    Caption = 'Development Requirements Appraisal';
                    ApplicationArea = All;
                }
                field("Overall Appraisee Score"; "Overall Appraisee Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Overall Appraiser Score"; "Overall Appraiser Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Overall Mgt Score"; "Overall Mgt Score")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                action("Close Appraisal")
                {
                    Caption = 'Close Appraisal';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Status := Status::Closed;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Get Job Specific Evaluation Areas")
                {
                    Caption = 'Get Job Specific Evaluation Areas';
                    Image = ChangeTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

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
                        //HRAppraisalEvaluationAreas.SETRANGE(HRAppraisalEvaluationAreas."Assign To","Job Title");
                        if HRAppraisalEvaluationAreas.FindSet then
                            repeat
                                HRAppraisalEvaluations.Init;
                                HRAppraisalEvaluations."Employee No" := "Employee No";
                                HRAppraisalEvaluations."Evaluation Code" := HRAppraisalEvaluationAreas.Code;
                                HRAppraisalEvaluations."Sub Category" := HRAppraisalEvaluationAreas."Sub Category";
                                HRAppraisalEvaluations.Group := HRAppraisalEvaluationAreas.Group;
                                HRAppraisalEvaluations.Category := HRAppraisalEvaluationAreas."Categorize As";
                                HRAppraisalEvaluations."Evaluation Description" := HRAppraisalEvaluationAreas.Description;
                                HRAppraisalEvaluations."Line No" := HRAppraisalEvaluationAreas."Line No";
                                HRAppraisalEvaluations."Appraisal Period" := "Appraisal Period";
                                HRAppraisalEvaluations.Insert(true);
                            until HRAppraisalEvaluationAreas.Next = 0;
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
                Promoted = true;
                PromotedCategory = Category5;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //FORM.RUNMODAL(39005843
                    //PAGE.Run(39003985, Rec);
                end;
            }
            action("Print Appraisal")
            {
                Caption = 'Print Appraisal';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetRange("Appraisal No", "Appraisal No");
                    REPORT.Run(51534715, true, true, Rec);
                    Reset;
                end;
            }
            separator(Action47)
            {
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntries:Page "Approval Entries";
                    WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    doctype: Enum "Approval Document Type";
                begin
                    DocType := DocType::"Staff Advance";
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Appraisal Goal Setting H", DocType.AsInteger(), "Appraisal No");
                end;

            }
            action("Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    IF NOT LinesExists THEN
                       ERROR('There are no Lines created for this Document');
                    
                    
                      IF NOT AllFieldsEntered THEN
                         ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                    
                    //Ensure No Items That should be committed that are not
                    IF LinesCommitmentStatus THEN
                      ERROR('There are some lines that have not been committed');
                    */
                    //Release the Imprest for Approval
                    /*IF ApprovalMgt.CheckApprTransfer(Rec) THEN;  */

                end;
            }
            action("Cancel Approval Re&quest")
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /* IF ApprovalMgt."------ EXPREQ----------------"(Rec,TRUE,TRUE) THEN;*/

                end;
            }
        }
    }

    var
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";
        UserSetup: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        Approver: Record "User Setup";
}

