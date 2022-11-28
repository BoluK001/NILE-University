page 51534558 "HR Appraisal Goal Setting H Se"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Review), "Appraisal Half" = CONST(Second));

    layout
    {
        area(content)
        {
            group("Appraisee Information")
            {
                Caption = 'Appraisee Information';
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
                field("Appraisal Half"; "Appraisal Half")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Queried; Queried)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                    Caption = 'Current Salary Grade';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field(l; Step)
                {
                    ApplicationArea = all;
                    Caption = 'Current Grade';
                    Editable = false;
                    Enabled = false;
                }
                field("Current Location"; "Current Location")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
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
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signature Appraisee"; "Signature Appraisee")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
            }
            group("Self Evaluation")
            {
                part(Control35; "Self Evaluation")
                {
                    Editable = false;
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No"),
                                  "Appraisal Period" = FIELD("Appraisal Period");
                }
                part(Control34; "HR Appraisal Self Eval")
                {
                    Provider = Control35;
                    SubPageLink = Code = FIELD("Appraisal No."),
                                  Description = FIELD(Description);
                }
            }
            part("Functional Assessment"; "HR Appraisal Behavioural A")
            {
                Caption = 'Functional Assessment';
                Editable = FunctionalAssessment;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = FILTER('FUNCTIONAL ASSESSMENT'));
            }
            part("Organisational Capability"; "HR Appraisal Behavioural A")
            {
                Caption = 'Organisational Capability';
                Editable = OrgCap;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = FILTER('ORGANISATIONAL CAPABILITY'));
            }
            part("Management Competencies"; "HR Appraisal Behavioural A")
            {
                Caption = 'Management Competencies';
                Editable = MgtCompetence;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = CONST('MANAGEMENT COMPETENCIES'));
                Visible = TbVisible;
            }
            label(KPI)
            {
            }
            part(Control7; "HR Appraisal KPI B")
            {
                Editable = Financial;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part(Control8; "HR Appraisal KPI C")
            {
                Editable = Customer;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part("Internal Process"; "HR Appraisal KPI D")
            {
                Caption = 'Internal Process';
                Editable = Internal1;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part("Learning & Growth"; "HR Appraisal KPI E")
            {
                Caption = 'Learning & Growth';
                Editable = Learning;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            group("Career Development And Training Needs")
            {
                Caption = 'Career Development And Training Needs';
                part("Career  Development And Training Needs"; "HR Appraisal Career Dev Ques")
                {
                    Caption = 'Career  Development And Training Needs';
                    SubPageLink = "Appraisal Code" = FIELD("Appraisal No"),
                                  "Employee No." = FIELD("Employee No");
                }
            }
            field("Desired Department"; "Desired Department")
            {
                ApplicationArea = all;
            }
            field("Date Of Last Promotion/Notch"; "Date Of Last Promotion/Notch")
            {
                ApplicationArea = all;
            }
            group(Comment)
            {
                Caption = 'Comment';
                field("Employee Comment "; Comment1)
                {
                    CaptionClass = '3,' + "Employee Name";
                    Editable = true;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Supervisor Comment"; Comment2)
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[1];
                    Editable = Sup1;
                    MultiLine = true;
                }
                field("HOD Comment"; Comment3)
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[2];
                    Editable = Sup2;
                    MultiLine = true;
                }
                field("MD Comment"; Comment4)
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[3];
                    Editable = sup3;
                    MultiLine = true;
                }
            }
            group(Recommendation)
            {
                Caption = 'Recommendation';
                Visible = RecomVis;
                field("Recommendations 1"; "Recommendations 1")
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[1];
                    MultiLine = true;
                }
                field("Recommendation 2"; "Recommendation 2")
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[2];
                    MultiLine = true;
                }
                field("Recommendation 3"; "Recommendation 3")
                {
                    ApplicationArea = all;
                    CaptionClass = '3,' + SuperApp[3];
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000002; Outlook)
            {
                Visible = false;
            }
            systempart(Control1000000003; Notes)
            {
                Visible = false;
            }
            part(Control3; "Hr Appraisal Rating Factbox")
            {
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

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
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    Visible = false;

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
                action("Get KPI")
                {
                    Caption = 'Get KPI';
                    Image = ChangeTo;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = KPIVIS;

                    trigger OnAction()
                    var
                        PreviousPeriod: Integer;
                        HRLookupValues: Record "HR Lookup Values";
                        PreviousCode: Code[20];
                        HRAppraisalGoal: Record "HR Appraisal Goal Setting H";
                    begin

                        HRLookupValues.Reset;
                        HRLookupValues.SetRange(HRLookupValues.Type, HRLookupValues.Type::"Appraisal Period");
                        HRLookupValues.SetRange(HRLookupValues.Closed, false);
                        if HRLookupValues.FindFirst then begin
                            PreviousCode := HRLookupValues.Code;
                        end;

                        Evaluate(PreviousPeriod, PreviousCode);



                        HRAppraisalGoal.Reset;
                        HRAppraisalGoal.SetRange(HRAppraisalGoal."Employee No", "Employee No");
                        HRAppraisalGoal.SetRange(HRAppraisalGoal."Appraisal Period", Format(PreviousPeriod - 1));
                        if HRAppraisalGoal.FindFirst then begin
                            //message('ok');


                            KPIGoalSetting.Reset;
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal No", HRAppraisalGoal."Appraisal No");
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal Period", HRAppraisalGoal."Appraisal Period");
                            KPIGoalSetting.SetRange(KPIGoalSetting."Evaluation Type", KPIGoalSetting."Evaluation Type"::KPI);
                            KPIGoalSetting.DeleteAll;

                            KPIGoalSetting.Reset;
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal No", HRAppraisalGoal."Appraisal No");
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal Period", HRAppraisalGoal."Appraisal Period");
                            KPIGoalSetting.SetRange(KPIGoalSetting."Evaluation Type", KPIGoalSetting."Evaluation Type"::KPI);
                            if KPIGoalSetting.FindFirst then begin
                                repeat
                                    NextKPI.Init;
                                    NextKPI."Appraisal No" := "Appraisal No";
                                    NextKPI."Appraisal Period" := "Appraisal Period";
                                    NextKPI."Evaluation Type" := KPIGoalSetting."Evaluation Type";
                                    NextKPI."Behavioural Group" := KPIGoalSetting."Behavioural Group";
                                    NextKPI.Half := "Appraisal Half";
                                    NextKPI."Planned Targets/Objectives" := KPIGoalSetting."Planned Targets/Objectives";
                                    NextKPI.Description := KPIGoalSetting.Description;
                                    NextKPI."Employee No" := "Employee No";
                                    NextKPI.Insert(true);
                                until KPIGoalSetting.Next = 0;
                            end;
                        end;

                        /*
                        //COPY KPI FOR ONE EMPLOYEE
                        NextKPI.RESET;
                        NextKPI.SETRANGE(NextKPI."Appraisal No","Appraisal No");
                        NextKPI.SETRANGE(NextKPI."KPI Period",NextKPI."KPI Period"::Next);
                        NextKPI.DELETEALL;
                        
                        KPIGoalSetting.RESET;
                        KPIGoalSetting.SETRANGE(KPIGoalSetting."Appraisal No","Appraisal No");
                        KPIGoalSetting.SETRANGE("KPI Period",KPIGoalSetting."KPI Period"::Current);
                        IF KPIGoalSetting.FINDSET THEN
                        REPEAT
                          NextKPI.INIT;
                          NextKPI.TRANSFERFIELDS(KPIGoalSetting);
                          NextKPI."KPI Period":=NextKPI."KPI Period"::Next;
                          NextKPI.INSERT(TRUE);
                        UNTIL KPIGoalSetting.NEXT=0;
                        */

                    end;
                }
                action("Send to supervisor for review")
                {
                    Caption = 'Send to supervisor for review';
                    Image = SendTo;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        LinesExists;

                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin

                            ApprovalSetup.Reset;
                            ApprovalSetup.SetCurrentKey(ApprovalSetup."Sequence No.");
                            ApprovalSetup.SetRange(ApprovalSetup."User ID", "User ID");
                            if ApprovalSetup.FindFirst then begin
                                EmailAdd.add(ApprovalSetup."E-Mail");
                                Clear(SMTP);
                                SMTP.CreateMessage('System Generated, Appraisal Review Notification', 'it@optivacp.com', EmailAdd, 'Appraisal Review Notification',
                                'Appraisal ' + "Appraisal No" + ' has been sent to you for assessment', true);
                                SMTP.Send;
                                Status := Status::Review;
                                Modify;
                                Message('Document has been sent to your line manager %1 for review.', ApprovalSetup."Approver ID")
                            end;
                        end;
                    end;
                }
                separator(Action1000000009)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;


                    trigger OnAction()
                    var
                        ApprovalEntries : Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Staff Advance";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Appraisal Goal Setting H", DocType.AsInteger(), "Appraisal No");
                    end;

                }
                action("Send To Supervisor")
                {
                    Caption = 'Send To Supervisor';
                    Image = SendTo;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        CheckPercentage;
                        TestField("Signature Appraisee", true);
                        //IF ApprovalMgt.SendAppraisalEvalApprovalReq(Rec) THEN;
                    end;
                }
                action("Notify Supervisor")
                {
                    Image = SendMail;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /* HREmp.Get("Employee No");
                         UserSetup.Get(HREmp."User ID");
                         CalcFields("Current Location");

                         if Approver.Get("Current Location") then begin
                             Approver.TestField(Approver."E-Mail");
                             Clear(SMTP);
                             SMTP.CreateMessage('System Generated, Appraisal Reminder', 'reminder@pensure-nigeria.com', Approver."E-Mail", 'Appraisal Notification',
                             'Appraisal ' + "Appraisal No" + ' has been sent to you for assessment', true);
                             SMTP.Send;
                             Message('Reminder has been sent to supervisor');
                         end;
                         */
                    end;
                }
                action("Close First Half KPI")
                {
                    Image = Archive;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to close the KPI period', false) then
                            exit;
                        AppraisalLines.SetRange(AppraisalLines."Appraisal No", "Appraisal No");
                        AppraisalLines.SetRange(AppraisalLines.Half, AppraisalLines.Half::" ");
                        AppraisalLines.SetRange(AppraisalLines."Submit to HR", false);
                        if AppraisalLines.FindFirst then
                            repeat
                                AppraisalLines."Submit to HR" := true;
                                AppraisalLines.Modify;
                            until AppraisalLines.Next = 0;
                        Message('First Half KPI Closed');
                    end;
                }
                action("Close Second Half KPI")
                {
                    Image = Archive;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to close the KPI periods', false) then
                            exit;
                        AppraisalLines.SetRange(AppraisalLines."Appraisal No", "Appraisal No");
                        AppraisalLines.SetRange(AppraisalLines.Half, AppraisalLines.Half::First);
                        AppraisalLines.SetRange(AppraisalLines."Submit to HR", false);
                        if AppraisalLines.FindFirst then
                            repeat
                                AppraisalLines."Submit to HR" := true;
                                AppraisalLines.Modify;
                            until AppraisalLines.Next = 0;
                        Message('Second Half KPI Closed');
                    end;
                }
                action("Reopen First Half KPI")
                {
                    Image = ReopenPeriod;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then
                            if UserSetup."Reopen Doc" then begin
                                if not Confirm('Are you sure you want to reopen the KPI period', false) then
                                    exit;
                                AppraisalLines.SetRange(AppraisalLines."Appraisal No", "Appraisal No");
                                AppraisalLines.SetRange(AppraisalLines.Half, AppraisalLines.Half::" ");
                                AppraisalLines.SetRange(AppraisalLines."Submit to HR", true);
                                if AppraisalLines.FindFirst then
                                    repeat
                                        AppraisalLines."Submit to HR" := false;
                                        AppraisalLines.Modify;
                                    until AppraisalLines.Next = 0;
                                Message('First Half KPI Reopened');
                            end
                            else
                                Error('you do not have permission to perform this activity');
                    end;
                }
                action("Reopen Second Half KPI")
                {
                    Image = ReopenPeriod;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then
                            if UserSetup."Reopen Doc" then begin
                                if not Confirm('Are you sure you want to reopen the KPI period', false) then
                                    exit;
                                AppraisalLines.SetRange(AppraisalLines."Appraisal No", "Appraisal No");
                                AppraisalLines.SetRange(AppraisalLines.Half, AppraisalLines.Half::First);
                                AppraisalLines.SetRange(AppraisalLines."Submit to HR", true);
                                if AppraisalLines.FindFirst then
                                    repeat
                                        AppraisalLines."Submit to HR" := false;
                                        AppraisalLines.Modify;
                                    until AppraisalLines.Next = 0;
                                Message('Second Half KPI Reopened');
                            end
                            else
                                Error('you do not have permission to perform this activity');
                    end;
                }
                action("Appraisal Score")
                {
                    Caption = 'Score Statistics';
                    Image = Statistics;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Appraisal Score Statistics";
                    RunPageLink = "No." = FIELD("Employee No");
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelAppraisalEvalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1000000011)
                {
                }
                action("Return To Supervisor")
                {
                    Caption = 'Return To Supervisor';
                    Enabled = false;
                    Image = Return;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Get("Employee No");
                        UserSetup.Get(HREmp."User ID");
                        Approver.Get(UserSetup."Approver ID");
                        EmailAdd.Add(Approver."E-Mail");
                        Clear(SMTP);
                        SMTP.CreateMessage('System Generated, Return To Supervisor', '', EmailAdd, 'Appraisal Notification',
                        'Appraisal ' + "Appraisal No" + ' has been returned back to you for assessment', true);
                        SMTP.Send;
                    end;
                }
                action(Attachment)
                {
                    Caption = 'Attach Supporting Doc';
                    ApplicationArea = all;
                    //RunObject = Page "Attachment Test";
                    //RunPageLink = "Employee No" = FIELD("User ID"),
                    //            "Application No" = FIELD("Appraisal No"),
                    //          "Document Type" = FILTER(Evaluation),
                    //        "Folder Type" = FILTER(HR);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Status = Status::Open then
            EvaVisible := false
        else
            EvaVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        CalcFields("Functional Ass. Second Half", "Org. Capability First Half", "Mgt. Competencies Second Half");
        "Behavioural Second Half Score" := ("Functional Ass. Second Half" + "Org. Capability Second Half" + "Mgt. Competencies Second Half") * 0.4;
        TabsVisible;
        if "Appraisal No" <> '' then begin
            HRDisciplinaryCases.SetRange(HRDisciplinaryCases."Employee No", "Employee No");
            HRDisciplinaryCases.SetRange(HRDisciplinaryCases."Appraisal Period", Hrsetup."Appraisal Period");
            if HRDisciplinaryCases.FindFirst then
                Queried := true;
        end;

        if (Status = Status::Open) then
            KpiVis := true
        else
            KpiVis := false;


        Sup1 := false;
        sup2 := false;
        sup3 := false;

        MovementTracker;

        if (Status = Status::"Pending Approval") then begin
            FunctionalAssessment := false;
            OrgCap := false;
            MgtCompetence := false;
            Financial := false;
            Customer := false;
            Internal1 := false;
            Learning := false;

        end

        else begin
            FunctionalAssessment := true;
            OrgCap := true;
            MgtCompetence := true;
            Financial := true;
            Customer := true;
            Internal1 := true;
            Learning := true;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Hrsetup.Get;
        //HRLookUpValues.RESET;
        //HRLookUpValues.SETRANGE(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
        //HRLookUpValues.SETRANGE(HRLookUpValues.Closed,FALSE);
        //IF HRLookUpValues.FINDFIRST THEN BEGIN
        HRAppraisalGoal.Reset;
        HRAppraisalGoal.SetRange(HRAppraisalGoal."User ID", UserId);
        HRAppraisalGoal.SetRange(HRAppraisalGoal."Appraisal Period", Hrsetup."Appraisal Period");
        HRAppraisalGoal.SetRange(HRAppraisalGoal."Appraisal Half", HRAppraisalGoal."Appraisal Half"::Second);
        if HRAppraisalGoal.Count > 0 then
            Error('Appraisal form for second half already exist,you can not create a new form within this appraisal period');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Appraisal Half" := "Appraisal Half"::Second;
    end;

    trigger OnOpenPage()
    begin
        if (Status = Status::Open) or (Status = Status::Approved) then begin
            EvaVisible := false;
            EvaEditable := false;
        end
        else begin
            EvaVisible := true;
            EvaEditable := true;
        end;

        Sup1 := false;
        sup2 := false;
        sup3 := false;

        if (Status = Status::Open) then
            KpiVis := true
        else
            KpiVis := false;


        MovementTracker;

        if (Status = Status::"Pending Approval") then begin
            FunctionalAssessment := false;
            OrgCap := false;
            MgtCompetence := false;
            Financial := false;
            Customer := false;
            Internal1 := false;
            Learning := false;

        end

        else begin
            FunctionalAssessment := true;
            OrgCap := true;
            MgtCompetence := true;
            Financial := true;
            Customer := true;
            Internal1 := true;
            Learning := true;
        end;
    end;

    var
        EmailAdd: List of [Text];
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
        UserSetup: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
        HrLookup: Record "HR Lookup Values";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        EvaVisible: Boolean;
        EvaEditable: Boolean;
        AppraisalLines: Record "HR Appraisal Goal Setting L";
        TbVisible: Boolean;
        HRAppraisalGoal: Record "HR Appraisal Goal Setting H";
        Hrsetup: Record "HR Setup";
        HRDisciplinaryCases: Record "HR Disciplinary Cases";
        ApprovalEntry: Record "Approval Entry";
        Hr: Boolean;
        Sup: Boolean;
        Staff: Boolean;
        App1: Text[100];
        App2: Text[100];
        App3: Text[100];
        AppEntry: Record "Approval Entry";
        Users: Record User;
        SuperApp: array[5] of Text;
        RecomVis: Boolean;
        ApprovalSetup: Record "Approval User Setup";
        CommentEditable: Boolean;
        SuperEditable: array[5] of Boolean;
        Sup1: Boolean;
        sup2: Boolean;
        sup3: Boolean;
        HRLookUpValues: Record "HR Lookup Values";
        KpiVis: Boolean;
        FunctionalAssessment: Boolean;
        OrgCap: Boolean;
        MgtCompetence: Boolean;
        Financial: Boolean;
        Customer: Boolean;

        Internal1: Boolean;
        Learning: Boolean;

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
        Job: Record "HR Jobs";
    begin
        /*
        CompanyScoreAppraisee:=("Company Score"/100)*40;
        
        CALCFIELDS("KPIs Appraisee Score");
        KPIScoreAppraisee:=("KPIs Appraisee Score"/100)*30;
        
        CALCFIELDS("KPIs Appraiser Score");
        KPIScoreAppraiser:=("KPIs Appraiser Score"/100)*30;
        
        CALCFIELDS("KPIs Mgt Score");
        KPIScoreMgt:=("KPIs Mgt Score"/100)*30;
        
        PFBase:=44;
        IF Employee.GET("Employee No") THEN
          IF Job.GET(Employee."Job Title") THEN
          //IF Employee.Supervisor=TRUE THEN
          IF Job."Is Supervisor" = TRUE THEN
            PFBase:=64;
        
        CALCFIELDS("Performance Score Appraisee");
        PFScoreAppraisee:=("Performance Score Appraisee"/PFBase)*30;
        
        CALCFIELDS("Performance Score Appraiser");
        PFScoreAppraiser:=("Performance Score Appraiser"/PFBase)*30;
        
        CALCFIELDS("Performance Score Mgt");
        PFScoreMgt:=("Performance Score Mgt"/PFBase)*30;
        
        
        "Overall Appraisee Score":=CompanyScoreAppraisee + KPIScoreAppraisee + PFScoreAppraisee;
        
        "Overall Appraiser Score":="Bonus Point Appraiser"+CompanyScoreAppraisee+KPIScoreAppraiser+PFScoreAppraiser;
        
        "Overall Mgt Score":="Bonus Point Mgt"+CompanyScoreAppraisee+KPIScoreMgt+PFScoreMgt;
        
        CalcTotals;
             */

    end;

    local procedure TabsVisible()
    begin
        if Level = Level::"1-4" then
            TbVisible := true
        else
            if Level = Level::"5-8" then
                TbVisible := false;
    end;

    local procedure MovementTracker()
    var
        i: Integer;
    begin
        if Status = Status::Open then begin
            CurrPage.Editable := true;
            exit;
        end;

        //Users.RESET;
        //Users.SETRANGE(Users."User Name","User ID");
        //IF Users.FINDFIRST THEN
        if UserId = "User ID" then begin
            CommentEditable := true;
            RecomVis := false;
        end else begin
            RecomVis := true;
            CommentEditable := false;
        end;

        Clear(SuperApp);
        ApprovalSetup.Reset;
        ApprovalSetup.SetCurrentKey("Sequence No.");
        ApprovalSetup.SetRange(ApprovalSetup."User ID", "User ID");
        //AppEntry.SETFILTER(AppEntry.Status,'<>%1',AppEntry.Status::Rejected);
        if ApprovalSetup.FindFirst then begin
            repeat
                Users.Reset;
                Users.SetRange(Users."User Name", ApprovalSetup."Approver ID");
                if Users.FindFirst then begin
                    i += 1;
                    SuperApp[i] := Users."Full Name";
                    if i = 1 then
                        Sup1 := true
                    else
                        if i = 2 then
                            sup2 := true
                        else
                            if i = 3 then
                                sup3 := true
                end;
            until ApprovalSetup.Next = 0;
        end;


        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Sequence No.");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Appraisal No");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            if ApprovalEntry."Approver ID" = UserId then
                CurrPage.Editable := true
            else
                CurrPage.Editable := false;
        end;



        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Sequence No.");
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Appraisal No");
        if ApprovalEntry.FindLast then begin
            if ApprovalEntry.Status = ApprovalEntry.Status::Approved then begin
                CurrPage.Editable := false;
            end
        end;
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

