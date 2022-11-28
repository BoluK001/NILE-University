page 51534948 "Appraisal First Half Self"
{
    Caption = 'Appraisal Goal Setting First Half';
    CardPageID = "HR Appraisal Goal Setting H";
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Appraisal Goal Setting First Half';
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE("Appraisal Half" = CONST(First));

    layout
    {
        area(content)
        {
            repeater("Appraisee Information")
            {
                Caption = 'Appraisee Information';
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
                field(Status; Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = All;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
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
                action("Send To Appraiser")
                {
                    Caption = 'Send To Appraiser';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LinesExists;

                        if Confirm('Do you want to send this Appraisal Form to your Appraiser?', false) = true then begin
                            Status := Status::"Pending Approval";
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
                        /*IF "Job Title"='' THEN
                        ERROR('Please specify the employees job title in the Employee card before proceeding');
                        
                        
                        IF CONFIRM('Any previous job specific evaluations made for '+"Employee Name"+' Appraisal Period '+"Appraisal Period"+' '+
                        'will be deleted. Proceed?',TRUE)=FALSE THEN EXIT;
                        
                        HRAppraisalEvaluations.RESET;
                        HRAppraisalEvaluations.SETRANGE(HRAppraisalEvaluations."Employee No","Employee No");
                        HRAppraisalEvaluations.SETRANGE(HRAppraisalEvaluations."Appraisal Period","Appraisal Period");
                        HRAppraisalEvaluations.SETRANGE(HRAppraisalEvaluations.Category,HRAppraisalEvaluations.Category::"JOB SPECIFIC EVALUATION AREA");
                        IF HRAppraisalEvaluations.FIND('-') THEN
                        HRAppraisalEvaluations.DELETEALL;
                        
                        
                        //COPY EVALUATION AREA FOR ONE EMPLOYEE
                        HRAppraisalEvaluationAreas.RESET;
                        IF HREmp.GET("Employee No") THEN
                          IF HREmp.Supervisor = FALSE THEN
                          HRAppraisalEvaluationAreas.SETRANGE(HRAppraisalEvaluationAreas.Supervisor,FALSE);
                        //HRAppraisalEvaluationAreas.SETRANGE(HRAppraisalEvaluationAreas."Assign To","Job Title");
                        IF HRAppraisalEvaluationAreas.FINDSET THEN
                        REPEAT
                          HRAppraisalEvaluations.INIT;
                          HRAppraisalEvaluations."Employee No":="Employee No";
                          HRAppraisalEvaluations."Evaluation Code":=HRAppraisalEvaluationAreas.Code;
                          HRAppraisalEvaluations."Sub Category":=HRAppraisalEvaluationAreas."Sub Category";
                          HRAppraisalEvaluations.Group:=HRAppraisalEvaluationAreas.Group;
                          HRAppraisalEvaluations.Category:=HRAppraisalEvaluationAreas."Categorize As";
                          HRAppraisalEvaluations."Evaluation Description":=HRAppraisalEvaluationAreas.Description;
                          HRAppraisalEvaluations."Line No":=HRAppraisalEvaluationAreas."Line No";
                          HRAppraisalEvaluations."Appraisal Period":="Appraisal Period";
                          HrRatings.FINDLAST;
                          HRAppraisalEvaluations."Total Target":=HrRatings.Answer;
                          HRAppraisalEvaluations.INSERT(TRUE);
                        UNTIL HRAppraisalEvaluationAreas.NEXT=0;
                         */

                    end;
                }
                action("Send to supervisor for review")
                {
                    Caption = 'Send to supervisor for review';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LinesExists;

                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin
                            Status := 1;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Get KPI")
                {
                    Caption = 'Get KPI';
                    Image = ChangeTo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //COPY KPI FOR ONE EMPLOYEE
                        NextKPI.Reset;
                        NextKPI.SetRange(NextKPI."Appraisal No", "Appraisal No");
                        NextKPI.SetRange(NextKPI."KPI Period", NextKPI."KPI Period"::Next);
                        NextKPI.DeleteAll;

                        KPIGoalSetting.Reset;
                        KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal No", "Appraisal No");
                        KPIGoalSetting.SetRange("KPI Period", KPIGoalSetting."KPI Period"::Current);
                        if KPIGoalSetting.FindSet then
                            repeat
                                NextKPI.Init;
                                NextKPI.TransferFields(KPIGoalSetting);
                                NextKPI."KPI Period" := NextKPI."KPI Period"::Next;
                                NextKPI.Insert(true);
                            until KPIGoalSetting.Next = 0;
                    end;
                }
                separator(Action1000000009)
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
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcScores;
    end;

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetRange("User ID", UserId);
        FilterGroup(0);
    end;

    var
        HasLines: Boolean;
        Text19033494: Label 'Set your goals and objectives in line with your departments strategy.';
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalEvaluationsF: Page "HR Appraisal Evaluation Lines";
        HREmp: Record "HR Employees";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        KPIGoalSetting: Record "HR Appraisal Goal Setting L";
        NextKPI: Record "HR Appraisal Goal Setting L";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";

    [Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        HRAppraisalGoals: Record "HR Appraisal Goal Setting L";
    begin
        HasLines := false;
        HRAppraisalGoals.Reset;
        HRAppraisalGoals.SetRange(HRAppraisalGoals."Appraisal No", "Appraisal No");
        if HRAppraisalGoals.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    [Scope('OnPrem')]
    procedure CalcScores()
    var
        Employee: Record "HR Employees";
    begin
        CompanyScoreAppraisee := ("Company Score" / 100) * 40;
        KPIScoreAppraisee := ("KPIs Mgt Score" / 100) * 30;

        PFBase := 44;
        if Employee.Get("Employee No") then
            if Employee.Supervisor = true then
                PFBase := 64;

        PFScoreAppraisee := ("Performance Score Mgt" / PFBase) * 30
    end;

    local procedure CheckPercentage()
    var
        AppLine: Record "HR Appraisal Goal Setting L";
        TotalWeight: Decimal;
    begin
        AppLine.Reset;
        AppLine.SetRange(AppLine."Appraisal No", "Appraisal No");
        AppLine.SetRange(AppLine."Evaluation Type", AppLine."Evaluation Type"::KPI);
        if AppLine.FindFirst then begin
            repeat
                TotalWeight += AppLine."Target Score %";
            until AppLine.Next = 0;

        end;

        if TotalWeight <> 100 then
            Error('Total scorecard weighting must be equal to 100');
    end;
}

