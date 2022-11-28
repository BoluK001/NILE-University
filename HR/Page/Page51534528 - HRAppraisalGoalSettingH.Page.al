page 51534528 "HR Appraisal Goal Setting H"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Appraisal Goal Setting H";

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
                field("Appraisal Half"; "Appraisal Half")
                {
                    Editable = true; //jj271022
                    Caption = 'Appraisal Quarter';
                    ApplicationArea = All;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Contract Type"; "Contract Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Queried; Queried)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    Caption = 'Current Salary Grade';
                    Editable = false;
                    Enabled = false;
                    HideValue = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(l; Step)
                {
                    Caption = 'Current Grade';
                    Editable = false;
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Current Location"; "Current Location")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Unit; Unit)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Signature Appraisee"; "Signature Appraisee")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Time In Present Position"; "Time In Present Position")
                {
                    ApplicationArea = all;
                }
                field("Membership of Prof. Bodies"; "Membership of Prof. Bodies")
                {
                    ApplicationArea = all;
                }
                field(Qualifications; Qualifications)
                {
                    ApplicationArea = all;
                }
                field("New Qualification in last 1 yr"; "New Qualification in last 1 yr")
                {
                    ApplicationArea = all;
                }
                field("Desired Department"; "Desired Department")
                {
                    ApplicationArea = all;
                }
                field("Date Of Last Promotion/Notch"; "Date Of Last Promotion/Notch")
                {
                    ApplicationArea = all;
                }
            }
            group("Self Evaluation")
            {
                part(Control31; "Self Evaluation")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;
                    SubPageLink = "Appraisal No." = FIELD("Appraisal No"),
                                  "Appraisal Period" = FIELD("Appraisal Period");
                }
                part(Control32; "HR Appraisal Self Eval")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Provider = Control31;
                    SubPageLink = Code = FIELD("Appraisal No."), Description = FIELD(Description);
                }
            }
            label("Behavioral Evaluation")
            {
            }
            part("Functional Assessment"; "HR Appraisal Behavioural A")
            {
                Caption = 'Functional Assessment';
                ApplicationArea = All;
                Visible = false;
                Editable = FunctionalAssessment;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = FILTER('FUNCTIONAL ASSESSMENT'));
            }
            part("Organisational Capability"; "HR Appraisal Behavioural A")
            {
                Caption = 'Organisational Capability';
                ApplicationArea = All;
                Editable = OrgCap;
                Visible = false;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = FILTER('ORGANISATIONAL CAPABILITY'));
            }
            part("Management Competencies"; "HR Appraisal Behavioural A")
            {
                Caption = 'Management Competencies';
                ApplicationArea = All;
                //Editable = MgtCompetence;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                SubPageView = WHERE("Behavioural Group" = CONST('MANAGEMENT COMPETENCIES'));
                //Visible = TbVisible;
                Visible = false;
            }
            label("Balanced Score Card")
            {
            }
            part(Control7; "HR Appraisal KPI B")
            {
                ApplicationArea = All;
                Visible = false;
                //Editable = Financial;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part(Control8; "HR Appraisal KPI C")
            {
                ApplicationArea = All;
                Caption = 'Self Evaluation';
                //Editable = Customer;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part("Internal Process"; "HR Appraisal KPI D")
            {
                ApplicationArea = All;
                Caption = 'Internal Process';
                Visible = false;
                //Editable = Internal1;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            part("Learning & Growth"; "HR Appraisal KPI E")
            {
                ApplicationArea = All;
                Caption = 'Learning & Growth';
                Visible = false;
                //Editable = Learning;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No"),
                              "Appraisal Period" = FIELD("Appraisal Period"),
                              Half = FIELD("Appraisal Half");
            }
            group("Career Development And Training Needs")
            {
                Caption = 'Career Development And Training Needs';
                part("Career  Development And Training Needs"; "HR Appraisal Career Dev Ques")
                {
                    ApplicationArea = All;
                    Caption = 'Career  Development And Training Needs';
                    SubPageLink = "Appraisal Code" = FIELD("Appraisal No"),
                                  "Appraisal Period" = FIELD("Appraisal Period");
                }
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
                    CaptionClass = '3,' + SuperApp[1];
                    Editable = true;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("HOD Comment"; Comment3)
                {
                    CaptionClass = '3,' + SuperApp[2];
                    Editable = true;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("MD Comment"; Comment4)
                {
                    CaptionClass = '3,' + SuperApp[3];
                    Editable = true;
                    ApplicationArea = all;
                    MultiLine = true;
                }
            }
            group(Recommendation)
            {
                Caption = 'Recommendation';
                Visible = RecomVis;
                field("Recommendations 1"; "Recommendations 1")
                {
                    CaptionClass = '3,' + SuperApp[1];
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Recommendation 2"; "Recommendation 2")
                {
                    CaptionClass = '3,' + SuperApp[2];
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Recommendation 3"; "Recommendation 3")
                {
                    CaptionClass = '3,' + SuperApp[3];
                    MultiLine = true;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000002; Outlook)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1000000003; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
            part(Control3; "Hr Appraisal Rating Factbox")
            {
                ApplicationArea = All;
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
                    ApplicationArea = all;
                    Promoted = true;
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
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal No", "Appraisal No");
                            KPIGoalSetting.SetRange(KPIGoalSetting."Appraisal Period", "Appraisal Period");
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
                    end;
                }
                action("Send to supervisor for review")
                {
                    Caption = 'Send to supervisor for review';
                    Image = SendTo;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;

                    trigger OnAction()

                    begin
                        LinesExists;

                        if Confirm('Do you want to send this Appraisal Form to  your Supervisor?', false) = true then begin

                            ApprovalSetup.Reset;
                            ApprovalSetup.SetCurrentKey(ApprovalSetup."Sequence No.");
                            ApprovalSetup.SetRange(ApprovalSetup."User ID", "User ID");
                            if ApprovalSetup.FindFirst then begin
                                CompanyEmail.Add(ApprovalSetup."E-Mail");

                                Clear(SMTP);
                                SMTP.CreateMessage('System Generated, Appraisal Review Notification', 'appraisalreview@pensure-nigeria.com', CompanyEmail, 'Appraisal Review Notification',
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
                        ApprovalEntries: Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::Appraisal;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"HR Appraisal Goal Setting H", DocType.AsInteger(), Rec."Appraisal No");
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

                    begin
                        //CheckPercentage;  jj271022 remmed to unremm later
                        TestField("Signature Appraisee", true);
                        if ApprovalMgt.CheckHRAppraisalEvalApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRAppraisalEvalForApproval(Rec);
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
                    var
                        CompanyEmail: List of [Text];

                    begin
                        HREmp.Get("Employee No");
                        UserSetup.Get(HREmp."User ID");
                        CalcFields("Current Location");

                        if Approver.Get("Current Location") then begin
                            //message('ok');
                            CompanyEmail.Add(Approver."E-Mail");
                            Clear(SMTP);
                            SMTP.CreateMessage('System Generated, Appraisal Reminder', 'reminder@pensure-nigeria.com', CompanyEmail, 'Appraisal Notification',
                            'Appraisal ' + "Appraisal No" + ' has been sent to you for assessment', true);
                            SMTP.Send;
                            Message('Reminder has been sent to supervisor');
                        end;
                    end;
                }
                action("Appraisal Score")
                {
                    Caption = 'Score Statistics';
                    Image = Statistics;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Appraisal Score Statistics";
                    RunPageLink = "No." = FIELD("Employee No"),
                                  "Current Appraisal Period" = FIELD("Appraisal Period");
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

                    begin
                        ApprovalMgt.OnCancelHRAppraisalEvalForApproval(Rec);
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
                        CompanyEmail.Add(Approver."E-Mail");
                        Clear(SMTP);
                        SMTP.CreateMessage('System Generated, Return To Supervisor', '', CompanyEmail, 'Appraisal Notification',
                        'Appraisal ' + "Appraisal No" + ' has been returned back to you for assessment', true);
                        SMTP.Send;
                    end;
                }
                action(Attachment)
                {
                    /*
                    Caption = 'Attach Supporting Doc';
                    RunObject = Page "Attachment Test";
                    ApplicationArea = All;
                    RunPageLink = "Employee No" = FIELD("User ID"),
                                  "Application No" = FIELD("Appraisal No"),
                                  "Document Type" = FILTER(Evaluation),
                                  "Folder Type" = FILTER(HR);
                                  */
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
        Rec.CalcFields("Functional Ass. First Half", "Org. Capability First Half", "Mgt. Competencies First Half");
        Rec."Behavioural First Half Score" := (Rec."Functional Ass. First Half" + Rec."Org. Capability First Half" + Rec."Mgt. Competencies First Half") * 0.4;
        TabsVisible;
        if Rec."Appraisal No" <> '' then begin
            HRDisciplinaryCases.SetRange(HRDisciplinaryCases."Employee No", Rec."Employee No");
            HRDisciplinaryCases.SetRange(HRDisciplinaryCases."Appraisal Period", Hrsetup."Appraisal Period");
            if HRDisciplinaryCases.FindFirst then
                Rec.Queried := true;
        end;
        MovementTracker;
        Sup1 := false;
        sup2 := false;
        sup3 := false;


        if (Rec.Status = Rec.Status::Open) then
            kpiVis := true
        else
            kpiVis := false;


        if (Rec.Status = Rec.Status::"Pending Approval") then begin
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
        /*
        Hrsetup.GET;
        HRLookUpValues.RESET;
        HRLookUpValues.SETRANGE(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
        HRLookUpValues.SETRANGE(HRLookUpValues.Closed,FALSE);
        IF HRLookUpValues.FINDFIRST THEN BEGIN
        
        HRAppraisalGoal.SETRANGE(HRAppraisalGoal."User ID",USERID);
        HRAppraisalGoal.SETRANGE(HRAppraisalGoal."Appraisal Period",HRLookUpValues.Code);
        HRAppraisalGoal.SETRANGE(HRAppraisalGoal."Appraisal Half",HRAppraisalGoal."Appraisal Half"::First);
        IF HRAppraisalGoal.COUNT > 0 THEN
         ERROR('Appraisal form for first half already exists,you can not create a new form within this appraisal period');
         END;
         */

        Hrsetup.Get;
        //HRLookUpValues.RESET;
        //HRLookUpValues.SETRANGE(HRLookUpValues.Type,HRLookUpValues.Type::"Appraisal Period");
        //HRLookUpValues.SETRANGE(HRLookUpValues.Closed,FALSE);
        //IF HRLookUpValues.FINDFIRST THEN BEGIN
        HRAppraisalGoal.Reset;
        HRAppraisalGoal.SetRange(HRAppraisalGoal."User ID", UserId);
        HRAppraisalGoal.SetRange(HRAppraisalGoal."Appraisal Period", Hrsetup."Appraisal Period");
        HRAppraisalGoal.SetRange(HRAppraisalGoal."Appraisal Half", HRAppraisalGoal."Appraisal Half"::First);

        //if HRAppraisalGoal.Count > 0 then
        //Error('Appraisal form for second half already exist,you can not create a new form within this appraisal period'); jj291022

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // "Appraisal Half" := "Appraisal Half"::First;  //jj271022
        Rec."Appraisal Half" := Rec."Appraisal Half"::" ";
    end;

    trigger OnOpenPage()
    begin
        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then begin
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

        if (Rec.Status = Rec.Status::Open) then
            kpiVis := true
        else
            kpiVis := false;

        MovementTracker;

        if (Rec.Status = Rec.Status::"Pending Approval") then begin
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
        //DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        DocType: Enum "Approval Document Type";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
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
        CompanyEmail: List of [Text];
        ApprovalSetup: Record "Approval User Setup";
        CommentEditable: Boolean;
        HRLookUpValues: Record "HR Lookup Values";
        Sup1: Boolean;
        sup2: Boolean;
        sup3: Boolean;
        kpiVis: Boolean;
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
        if Rec.Level = Rec.Level::"1-4" then
            TbVisible := true
        else
            if Rec.Level = Rec.Level::"5-8" then
                TbVisible := false;
    end;

    local procedure MovementTracker()
    var
        i: Integer;
    begin
        if Rec.Status = Rec.Status::Open then begin
            CurrPage.Editable := true;
            exit;
        end;

        //Users.RESET;
        //Users.SETRANGE(Users."User Name","User ID");
        //IF Users.FINDFIRST THEN
        if UserId = Rec."User ID" then begin
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
        //AppEntry.SETFILTER(AppEntry.Status,'<>%1|<>%2',AppEntry.Status::Rejected,AppEntry.Status::Canceled);
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

