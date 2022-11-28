page 51534700 "HR Appraisal Closed"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions,NextPage';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Closed));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal No"; "Appraisal No")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Employee No"; "Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
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
                { ApplicationArea = all; }
                field("Evaluation Period End"; "Evaluation Period End")
                { ApplicationArea = all; }
                field("Appraisal Date"; "Appraisal Date")
                { ApplicationArea = all; }
                field("Contract Type"; "Contract Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Unit; Unit)
                { ApplicationArea = all; }
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
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field("Bonus Point appraisee"; "Bonus Point appraisee")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("KPIs Appraisee Score"; "KPIs Appraisee Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field("KPIs Appraiser Score"; "KPIs Appraiser Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field("KPIs Mgt Score"; "KPIs Mgt Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field(KPIScoreMgt; KPIScoreMgt)
                {
                    Caption = 'KPI Score';
                    Editable = false;
                    Enabled = false;
                    ExtendedDatatype = None;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Performance Score Appraisee"; "Performance Score Appraisee")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field("Performance Score Appraiser"; "Performance Score Appraiser")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field("Performance Score Mgt"; "Performance Score Mgt")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = All;
                }
                field(PFScoreMgt; PFScoreMgt)
                {
                    Caption = 'Performance Score';
                    Enabled = false;
                    ExtendedDatatype = None;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Comments Appraiser"; "Comments Appraiser")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Comments Mgt"; "Comments Mgt")
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Development Plans"; "Development Plans")
                {
                    Caption = 'Development Requirements Appraisee';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Development Requirements Appra"; "Development Requirements Appra")
                {
                    Caption = 'Development Requirements Appraiser';
                    ApplicationArea = All;
                }
                field("Development Requirements Mgt"; "Development Requirements Mgt")
                {
                    Caption = 'Development Requirements Mgt';
                    ApplicationArea = All;
                }
            }
            part("PERSONAL GOALS/OBJECTIVES"; "HR Appraisal Goal Setting L")
            {
                Caption = 'PERSONAL GOALS/OBJECTIVES';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");

            }
            part(SF; "HR Mgt Evaluation Lines")
            {
                Caption = 'JOB SPECIFIC EVALUATION (KEY RESULTS IN LINE WITH STAFF JOB DESCRIPTION AND/ OR SCORECARD)';
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Period" = FIELD("Appraisal Period");
            }
            part("Next Period's KPI"; "HR Appraisal Next KPI")
            {
                Caption = 'Next Period''s KPI';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            group("Evaluation Scores/Remarks")
            {
                Caption = 'Evaluation Scores/Remarks';
                Editable = false;
                field("Bonus Point Appraiser"; "Bonus Point Appraiser")
                { ApplicationArea = all; }
                field("Bonus Point Mgt"; "Bonus Point Mgt")
                { ApplicationArea = all; }
                field("Bonus Point Appraiser Remarks"; "Bonus Point Appraiser Remarks")
                { ApplicationArea = all; }
                field("Bonus Point Mgt Remarks"; "Bonus Point Mgt Remarks")
                { ApplicationArea = all; }
                field("Recommendation Appraiser"; "Recommendation Appraiser")
                { ApplicationArea = all; }
                field("Recommendation 2"; "Recommendation 2")
                { ApplicationArea = all; }
                field("Recommendation Mgt"; "Recommendation Mgt")
                { ApplicationArea = all; }
                field("Recommendation 3"; "Recommendation 3")
                { ApplicationArea = all; }
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
                field("Overal Rating Desc"; "Overal Rating Desc")
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
            group("MD's Recommendation & Comment")
            {
                field("MD's Recommendation"; "MD's Recommendation")
                {
                    MultiLine = false;
                    ApplicationArea = All;
                }
                field(Confirmation; Confirmation)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    Caption = 'Current Salary Grade';
                    ApplicationArea = All;
                }
                field(Step; Step)
                {
                    Caption = 'Current Step';
                    ApplicationArea = All;
                }
                field("MD's Comment"; "MD's Comment")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("MD's Remark"; "MD's Remark")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("MD's Signature"; "MD's Signature")
                { ApplicationArea = all; }
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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to Closed this Appraisal Period? for ' + "Employee Name", false) = true then begin

                            Status := Status::Closed;
                            Modify;
                            if Confirmation = true then
                                HREmp.SetRange(HREmp."No.", "Employee No");
                            if HREmp.FindFirst then begin
                                HREmp.Validate("Contract Type", "Contract Type");
                                HREmp.Validate(HREmp.Grade, "Salary Grade");
                                HREmp.Validate(HREmp."Salary Step", Step);
                                HREmp.Modify;
                            end
                            //MESSAGE('%1','Process Completed')
                        end;

                        Message('%1', 'Process Completed')
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
                    // PAGE.Run(39003985, Rec);
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
                    //SETRANGE("Appraisal No","Appraisal No");
                    REPORT.Run(51534715, true, true, Rec);
                    Reset;
                end;
            }
            action("Print Next KPI Report")
            {
                Caption = 'Print Next KPI Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                //RunObject = Report Report39006020;
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
        //REPORT.Run(51534715,TRUE,TRUE,Rec);
        Reset;
    end;

    var
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
        HasLines: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        KPIGoalSetting: Record "HR Appraisal Goal Setting L";
        NextKPI: Record "HR Appraisal Goal Setting L";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";
        UserSetup: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
}

