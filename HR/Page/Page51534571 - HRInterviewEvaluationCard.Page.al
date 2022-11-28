page 51534571 "HR Interview Evaluation Card1"
{
    PageType = Card;
    SourceTable = "Hr Interview Evaluation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interview No."; "Interview No.")
                {
                    ApplicationArea = all;
                }
                field("Interview Process"; "Interview Process")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Job Position"; "Job Position")
                {
                    ApplicationArea = all;
                }
                field("Application No."; "Application No.")
                {

                    trigger OnValidate()
                    begin
                        /*CurrPage.UPDATE;
                        SetColumns;
                        VALIDATE("Experience Level")
                         */

                    end;
                }
                field("Requisition No."; "Requisition No.")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                        SetColumns;
                        Validate("Experience Level");
                    end;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field(Initial; Initial)
                {
                    ApplicationArea = all;
                }
                field("Date Applied"; "Date Applied")
                {
                    ApplicationArea = all;
                }
                field(Email; Email)
                {
                    ApplicationArea = all;
                }
                field("Interview Date"; "Interview Date")
                {
                    ApplicationArea = all;
                }
                field("Interview Done By"; "Interview Done By")
                {
                    Visible = false;
                }
                field("Interviewer Name"; "Interviewer Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Current Salary (N) P/A"; "Current Salary (N) P/A")
                {
                    ApplicationArea = all;
                }
                field("Expected Salary (N) P/A"; "Expected Salary (N) P/A")
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Technical Knowledge/Competence"; "Technical Knowledge/Competence")
                {
                    ApplicationArea = all;
                }
                field("Culture Fit"; "Culture Fit")
                {
                    ApplicationArea = all;
                }
                field("Communication & Oral Presentat"; "Communication & Oral Presentat")
                {
                    ApplicationArea = all;
                }
                field("Personal Value"; "Personal Value")
                {
                    ApplicationArea = all;
                }
                field("Total Evaluation Score"; "Total Evaluation Score")
                {
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Recommend for Stage 2"; "Recommend for Stage 2")
                {
                    Caption = 'Recommend To ED';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Recommend for Stage 3"; "Recommend for Stage 3")
                {
                    Caption = 'Recommend To MD';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("HMO Stage"; "HMO Stage")
                {
                    Caption = 'Recommend for Medical Test Stage';
                    ApplicationArea = all;
                }
                field("Recommendation for Hire"; "Recommendation for Hire")
                {
                    Caption = 'Recommend for Hire';
                }
                field("Interview Assessment"; "Interview Assessment")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    Caption = 'ED Comment';
                    Editable = CommentEditable;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field(Comment2; Comment2)
                {
                    Caption = 'MD Comment';
                    Editable = CommentEditable;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Offer Status"; "Offer Status")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Pass Mark (%)"; "Pass Mark (%)")
                {
                    ApplicationArea = all;
                }
                field("Experience Level"; "Experience Level")
                {

                    trigger OnValidate()
                    begin
                        if "Experience Level" = "Experience Level"::"0-4 Years" then begin
                            PageVisible := false;
                            PageVisibleA := true;
                        end else
                            if "Experience Level" = "Experience Level"::"5 Years & Above" then begin
                                PageVisible := true;
                                PageVisibleA := false;
                            end;

                        CurrPage.Update;
                    end;
                }
                field("Job Acceptance"; "Job Acceptance")
                {
                    ApplicationArea = all;
                }
            }
            part(Communication; "HR Oral Interview Evaluation")
            {
                Caption = 'COMMUNICATION/ORAL PRESENTATION';
                SubPageLink = "Interview No." = FIELD("Interview No.");
                SubPageView = WHERE("Interview Group" = CONST('COMMUNICATION/ORAL PRESENTATION'),
                                    "Experience Level" = CONST("5 Years & Above"));
                Visible = PageVisible;
            }
            part(LeadwayPensure; "HR Oral Interview Evaluation")
            {
                Caption = 'CULTURE FIT';
                SubPageLink = "Interview No." = FIELD("Interview No.");
                SubPageView = WHERE("Interview Group" = CONST('CULTURE FIT'),
                                    "Experience Level" = CONST("5 Years & Above"));
                Visible = PageVisible;
            }
            part(TechnicalKnow; "HR Oral Interview Evaluation")
            {
                Caption = 'TECHNICAL KNOWLEDGE/COMPETENCY';
                SubPageLink = "Interview No." = FIELD("Interview No.");
                SubPageView = WHERE("Interview Group" = CONST('TECHNICAL KNOWLEDGE/COMPETENCY'),
                                    "Experience Level" = CONST("5 Years & Above"));
                Visible = PageVisible;
            }
            part(PersonalValues; "HR Oral Interview Evaluation")
            {
                Caption = 'PERSONAL VALUES';
                SubPageLink = "Interview No." = FIELD("Interview No.");
                SubPageView = WHERE("Interview Group" = CONST('PERSONAL VALUES'),
                                    "Experience Level" = CONST("5 Years & Above"));
                Visible = PageVisible;
            }
            part(AppAssessment; "HR Oral Interview A")
            {
                Caption = 'Applicant Assessment';
                SubPageLink = "Interview No." = FIELD("Interview No.");
                SubPageView = WHERE("Experience Level" = CONST("0-4 Years"));
                Visible = PageVisibleA;
            }
            part("Interviewers' Comment"; "HR Interviewer Comment2")
            {
                Caption = 'Interviewers'' Comment';
                SubPageLink = "Interview No." = FIELD("Interview No."),
                              "Requisition No" = FIELD("Requisition No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Interview Recomendation Mail")
            {
                Caption = '&Interview Recomendation Mail';
                Image = SendMail;
                action("&Recommend to ED  Mail")
                {
                    Caption = '&Recommend to ED  Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Recommend for Stage 2") ;
                        if "Interview Invitation (Stage 2)" = true then Error('Applicant has been notified');

                        CompInfo.Get();
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW

                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Recommend for Stage 2");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                            "Interview Invitation (Stage 2)" := true;
                            Modify;
                        end;
                    end;
                }
                action("&Recommend to MD Mail")
                {
                    Caption = '&Recommend to MD Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        TestField("Recommend for Stage 3");

                        CompInfo.Get();
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW

                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Recommend for Stage 3");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message + ' ' + 'at' + HrIntMessage.Venue + ' ' + 'On' + Format(HrIntMessage.Date), true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                        end;
                    end;
                }
                action("&Recommend For Hire Mail")
                {
                    Caption = '&Recommend For Hire Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        CompInfo.Get();
                        TestField("Recommendation for Hire");
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW
                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Recommend for Hire");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();

                            Message('Applicant has been Notified for the Job Employment');
                        end;
                    end;
                }
                action("Recommend for HMO Stage")
                {
                    Caption = '&Recommend for Medical Test Stage';
                    ApplicationArea = all;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        TestField("HMO Stage");
                        CompInfo.Get();

                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW
                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Recommend for HMO");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();
                            "HMO Stage" := true;
                            Modify;
                            Message('Applicant has been Notified of Medical Test');
                        end;
                    end;
                }
                action("Successful Candidate")
                {
                    Caption = 'Successful Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        CompInfo.Get();
                        TestField(Status, Status::Approved);
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW
                            HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::Successful);
                        HrIntMessage.Reset;
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();

                            Message('Applicant has been Notified for the Job Employment');
                        end;
                        TestField(Status, Status::Approved);
                        "Offer Status" := "Offer Status"::Successful;
                    end;
                }
                action("Not Successful Candidates")
                {
                    Caption = 'Not Successful Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        CompInfo.Get();
                        TestField(Status, Status::Approved);
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW
                            HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Not Successful");
                        HrIntMessage.Reset;
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EMailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EMailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();

                            Message('Applicant has been Notified for not being successful');
                        end;
                    end;
                }
                action("&Messages & Venue Setup")
                {
                    Caption = '&Messages & Venue Setup';
                    Image = Setup;
                    ApplicationArea = all;
                    RunObject = Page "Hr Interview Evaluatn Msg List";
                }
                action("&Keep In-View")
                {
                    Caption = '&Keep In-View';
                    Image = History;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to keep this Applicant In-View?', true) = false then
                            exit
                        else
                            "Offer Status" := "Offer Status"::"Keep In-view";

                        CompInfo.Get();
                        //TESTFIELD(Status,Status<>Approved);
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW
                            HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::Pending);
                        HrIntMessage.Reset;
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EMailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();

                            "Offer Status" := "Offer Status"::"Keep In-view";

                            Message('The applicant has been duly notified of status of the Job Application %1', "Job Position");
                        end;
                    end;
                }
                action("Revisit Candidate")
                {
                    Caption = 'Revisit Candidate';
                    Image = Reuse;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to revisit this Applicant Job Application?', true) = false then
                            exit
                        else
                            "Offer Status" := "Offer Status"::Revisited;
                    end;
                }
            }
            group("&MD Approval")
            {
                Caption = '&MD Approval';
                action("Send For ED/MD Approval")
                {
                    Caption = 'Send For ED/MD Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Recommendation for Hire");
                        TestField("Interview Process", "Interview Process"::"Requires ED & MD Approval");
                        CommentExist;
                        if Confirm('Send this Applicant for Approval?', true) = false then exit;
                        if ApprovalMgt.CheckHRInterviewEvalApprovalsWorkflowEnable(rec) then
                            ApprovalMgt.OnSendHRInterviewEvalForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then exit;
                        ApprovalMgt.OnCancelHRInterviewEvalForApproval(Rec);
                    end;
                }
                action("Get Evaluation Areas")
                {
                    Caption = 'Get Evaluation Areas';

                    trigger OnAction()
                    begin
                        LinesRec.Reset;
                        LinesRec.SetRange("Interview No.", "Interview No.");
                        if LinesRec.FindSet then
                            if Confirm('Do you want to overwrite the existing lines?', false) = true then begin
                                LinesRec.DeleteAll;
                                IntAreas.Reset;
                                IntAreas.SetRange(IntAreas.Job, "Job Title");
                                if IntAreas.Find('-') then begin
                                    repeat
                                        LinesRec.Init;
                                        LinesRec."Evaluation Code" := IntAreas."Requisition No.";
                                        LinesRec."Interview No." := "Interview No.";
                                        LinesRec."Evaluation Description" := IntAreas."Evaluation Description";
                                        LinesRec."Total Target" := IntAreas."Pass Mark";
                                        LinesRec.Stage := IntAreas.Stage;
                                        if Areas.Get(IntAreas."Requisition No.") then
                                            LinesRec.Weight := Areas."Evaluation Score";
                                        LinesRec.Insert;
                                    until IntAreas.Next = 0;
                                end;
                            end;
                    end;
                }
                action("Skip MD & ED")
                {
                    Image = StepOver;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup."HR Job" = true then begin

                            TestField("Interview Process", "Interview Process"::"Not Applicable");

                            if "HMO Stage" then exit;
                            if not Confirm('Are you sure you want to recommend applicant for medical', false) then
                                exit;
                            "HMO Stage" := true;
                            Modify;
                            Message('Successful');
                        end else
                            Error('you do not have permission to carry out this activity');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if "Experience Level" = "Experience Level"::"0-4 Years" then begin
            PageVisible := false;
            PageVisibleA := true;
        end else
            if "Experience Level" = "Experience Level"::"5 Years & Above" then begin
                PageVisible := true;
                PageVisibleA := false;
            end;
        CommentEditabl;
    end;

    trigger OnInit()
    begin
        PageVisible := false;
        PageVisibleA := false;
    end;

    trigger OnOpenPage()
    begin
        SetColumns;

        CommentEditabl;
    end;

    var
        EmailAdd: List of [Text];
        HRJobApplications: Record "HR Job Applications";
        HrIntMessage: Record "Hr Interview Evaluatn Message";
        SMTP: Codeunit "SMTP Mail";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        CompInfo: Record "Company Information";
        HREmpApplication: Record "HR Employee Requisitions";
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send an Interview Application?';
        LinesRec: Record "Hr Interview Specific Evaluatn";
        Areas: Record "Hr Interview Evaluation Areas";
        IntEv: Record "Hr Interview Evaluation";
        IntAreas: Record "HR Job Evaluation Areas";
        MatrixRecord: Record "HR Job Evaluation Areas";
        MatrixRecords: array[32] of Record "HR Job Evaluation Areas";
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        RunNo: Code[20];
        Family: Record "HR Job Evaluation Areas";
        EmpIntV: Record "HR Job Evaluation Areas";
        i: Integer;
        MachineCenter: Record "Machine Center";
        PageVisible: Boolean;
        PageVisibleA: Boolean;
        CommentEditable: Boolean;
        UserSetup: Record "User Setup";

    [Scope('OnPrem')]
    procedure SetColumns()
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        i := 0;
        Clear(MATRIX_CaptionSet);
        EmpIntV.SetRange(EmpIntV."ED of Requesting Dept", false);
        EmpIntV.SetRange(EmpIntV."Requisition No.", "Requisition No.");
        if EmpIntV.FindSet then begin
            repeat
                i += 1;
                MATRIX_CaptionSet[i] := EmpIntV."Employee Name";
            until EmpIntV.Next = 0;
        end;


        CurrPage.AppAssessment.PAGE.ShowColumnCap(MATRIX_CaptionSet);
        CurrPage.Communication.PAGE.ShowColumnCap(MATRIX_CaptionSet);
        CurrPage.LeadwayPensure.PAGE.ShowColumnCap(MATRIX_CaptionSet);
        CurrPage.TechnicalKnow.PAGE.ShowColumnCap(MATRIX_CaptionSet);
        CurrPage.PersonalValues.PAGE.ShowColumnCap(MATRIX_CaptionSet);
    end;

    local procedure CommentExist()
    var
        HRInterviewerComment: Record "HR Interviewer Comment";
    begin
        HRInterviewerComment.SetRange(HRInterviewerComment."Interview No.", "Interview No.");
        if not HRInterviewerComment.FindFirst then
            Error('interviewers comment not found');



        HRInterviewerComment.SetRange(HRInterviewerComment."Interview No.", "Interview No.");
        if HRInterviewerComment.FindFirst then
            repeat
                HRInterviewerComment.TestField(Comment);
            until HRInterviewerComment.Next = 0;
    end;

    local procedure CommentEditabl()
    begin
        if (Status = Status::New) or (Status = Status::Approved) then
            CommentEditable := false
        else
            if Status = Status::"Pending Approval" then
                CommentEditable := true;
    end;
}

