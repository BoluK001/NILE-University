page 51534702 "Appraisal Goal Setting List"
{
    Caption = 'Appraisal Goal Setting First Half';
    CardPageID = "HR Appraisal Goal Setting H";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Appraisal Goal Setting First Half';
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Appraisal Goal Setting H";
    //SourceTableView = WHERE(Status = CONST(Open),  //jj271022
    //"Appraisal Half" = CONST(First));

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
                    ApplicationArea = all;  //jj270422
                }
                field("Employee No"; "Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;  //jj270422
                }
                field("Employee Name"; "Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    Importance = Promoted;
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
                field("Appraisal Half"; "Appraisal Half")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Quarter';
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appraisal Date"; "Appraisal Date")
                { ApplicationArea = all; }
                field(Unit; Unit)
                { ApplicationArea = all; }
                field("Responsibility Center"; "Responsibility Center")
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
                        if HREmp.Get("Employee No") then
                            if HREmp.Supervisor = false then
                                HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas.Supervisor, false);
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
                                HrRatings.FindLast;
                                //HRAppraisalEvaluations."Total Target":=HrRatings.Answer;
                                HRAppraisalEvaluations.Insert(true);
                            until HRAppraisalEvaluationAreas.Next = 0;
                    end;
                }
                action("Send To Supervisor")
                {
                    Caption = 'Send To Supervisor';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                { }
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
                        ApprovalEntries: Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::Appraisal;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"HR Appraisal Goal Setting H", DocType.AsInteger(), Rec."Appraisal No");
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
                        if ApprovalMgt.CheckHRAppraisalEvalApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRAppraisalEvalForApproval(Rec);

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
                        //IF ApprovalMgt.SendAppraisalApprovalRequest(Rec) THEN;

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
                        ApprovalMgt.OnCancelHRAppraisalEvalForApproval(Rec);
                        //IF ApprovalMgt."--CoreTec--"(Rec,TRUE,TRUE) THEN;
                    end;
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
        /*{HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN
        SETRANGE("User ID",HREmp."User ID")
        ELSE }
        //user id may not be the creator of the doc
        SETFILTER("User ID",USERID);
        */
        //HREmp.Reset;
        //HREmp.SetRange(HREmp."User ID", UserId);
        //if HREmp.Get then begin
        //SETRANGE("User ID",HREmp."User ID")
        //FilterGroup(2);
        //SetRange("User ID", HREmp."User ID");
        //FilterGroup(0);


        //end else begin
        //user id may not be the creator of the doc
        //SETRANGE("User ID",USERID);

        //FilterGroup(2);
        //SetRange("User ID", UserId);
        //FilterGroup(0);
        //end;
    end;

    var
        HasLines: Boolean;
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
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
}
