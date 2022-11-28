page 51534575 "Hr interview Evaluation List"
{
    Caption = 'Interview Evaluation List';
    CardPageID = "HR Interview Evaluation Card1";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Hr interview Evaluation List';
    SourceTable = "Hr Interview Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview No."; "Interview No.")
                {
                    ApplicationArea = all;
                }
                field("Application No."; "Application No.")
                {
                    ApplicationArea = all;
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
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Offer Status"; "Offer Status")
                {
                    ApplicationArea = all;
                }
                field("Stage 1 Score"; "Stage 1 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 2 Score"; "Stage 2 Score")
                {
                    ApplicationArea = all;
                }
                field("Stage 3 Score"; "Stage 3 Score")
                {
                    ApplicationArea = all;
                }
                field("Recommend for Stage 2"; "Recommend for Stage 2")
                {
                    ApplicationArea = all;
                }
                field("Recommend for Stage 3"; "Recommend for Stage 3")
                {
                    ApplicationArea = all;
                }
                field("Recommendation for Hire"; "Recommendation for Hire")
                {
                    ApplicationArea = all;
                }
                field("Job Acceptance"; "Job Acceptance")
                {
                    ApplicationArea = all;
                }
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
                action("&Recommend For Stage 2 Mail")
                {
                    Caption = '&Recommend For Stage 2 Mail';
                    ApplicationArea = all;
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        TestField("Recommend for Stage 2");

                        CompInfo.Get();
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No.");
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW

                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Invite for Interview");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EMailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message + ' ' + 'at' + HrIntMessage.Venue + ' ' + 'On' + Format(HrIntMessage.Date), true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                        end;
                    end;
                }
                action("&Recommend for Stage 3 Mail")
                {
                    Caption = '&Recommend for Stage 3 Mail';
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        TestField("Recommend for Stage 2");
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
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EMailAdd,
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
                    Image = SendMail;

                    trigger OnAction()
                    begin
                        CompInfo.Get();
                        TestField(Status, Status::Approved);
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
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EMailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message, true);
                            SMTP.Send();

                            Message('Applicant has been Notified for the Job Employment');
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
            }
            group("&MD Approval")
            {
                Caption = '&MD Approval';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;


                    trigger OnAction()
                    var
                        ApprovalEntries:Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Staff Advance";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Hr Interview Evaluation", DocType.AsInteger(), "Interview No.");
                    end;

                }
                action("Send For MD Approval")
                {
                    Caption = 'Send For MD Approval';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        TestField("Recommendation for Hire");
                        if Confirm('Send this Applicant for Approval?', true) = false then exit;

                        if ApprovalMgt.CheckHRInterviewEvalApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRInterviewEvalForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        /*IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                        ApprovalMgt.CancelInterviewAppRequest(Rec,TRUE,TRUE); */

                    end;
                }
            }
        }
    }

    var
        EmailAdd: List of [Text];
        HRJobApplications: Record "HR Job Applications";
        HrIntMessage: Record "Hr Interview Evaluatn Message";
        SMTP: Codeunit "SMTP Mail";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        CompInfo: Record "Company Information";
}

