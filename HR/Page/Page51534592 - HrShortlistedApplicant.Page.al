page 51534592 "Hr Shortlisted Applicant"
{
    CardPageID = "HR Job Applications Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE(Qualified = CONST(true));
    AdditionalSearchTerms = 'Hr Shortlisted Applicant';

    layout
    {
        area(content)
        {
            repeater(Control1000000011)
            {
                Editable = false;
                ShowCaption = false;
                field("Application No"; "Application No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Date Applied"; "Date Applied")
                {
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Job Applied For"; "Job Applied For")
                {
                    ApplicationArea = all;
                }
                field("HRJobApplications.""Employee Requisition No"""; HRJobApplications."Employee Requisition No")
                {
                    Caption = 'Employee Requisition No';
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Qualified; Qualified)
                {
                    ApplicationArea = all;
                }
                field("Interview Invitation Sent"; "Interview Invitation Sent")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "HR Job Applications Factbox")
            {
                SubPageLink = "Application No" = FIELD("Application No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action("Send Interview Invitation")
                {
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        /*IF NOT CONFIRM(Text002,FALSE) THEN EXIT;
                        
                        HRJobApplications.SETFILTER(HRJobApplications."Application No","Application No");
                        REPORT.RUN(39003940,TRUE,FALSE,HRJobApplications);
                        */


                        TestField(Qualified);
                        CompInfo.Get();
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No");
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
                           HrIntMessage.Message, true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                        end;

                    end;
                }
                action("Interview Message Setup")
                {
                    Caption = 'Interview Message Setup';
                    RunObject = Page "Hr Interview Evaluatn Msg List";
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = FIELD("Application No"),
                                  Status = CONST(Applicant);
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.Run(51534525, true, true, HRJobApplications);
                    end;
                }
                action("Generate Offer Letter")
                {
                    Caption = 'Generate Offer Letter';
                    Image = Document;
                    Promoted = true;
                    RunObject = Report "HR Employement Letter";
                    Visible = false;
                }
                action("Upload Attachments")
                {
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Application No");
                }
                action("&Send Test Invitation")
                {
                    Caption = '&Send Test Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        TestField(Qualified);
                        /* HRJobApplications.SETFILTER(HRJobApplications."Application No","Application No");
                        REPORT.RUN(39003940,FALSE,FALSE,HRJobApplications);
                         */

                        if "Interview Invitation Sent" = true then
                            Error('Applicant has been notified');


                        TestField(Qualified);
                        CompInfo.Get();
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No");
                        //HRJobApplications.SETRANGE(HRJobApplications.Qualified,TRUE);
                        if HRJobApplications.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB INTERVIEW

                            HrIntMessage.Reset;
                        HrIntMessage.SetRange(HrIntMessage.Stages, HrIntMessage.Stages::"Invite for Interview");
                        if HrIntMessage.Find('-') then begin
                            HRJobApplications.TestField(HRJobApplications."E-Mail");
                            CompInfo.TestField(CompInfo."E-Mail");
                            EmailAdd.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", EmailAdd,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message + ' ' + 'at' + HrIntMessage.Venue + ' ' + 'On' + Format(HrIntMessage.Date), true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                            "Interview Invitation Sent" := true;
                            Modify;
                        end;

                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Report "HR Job Applications";

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.Run(51534525, true, true, HRJobApplications);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Shortlisted Candidates")
            {
                Caption = 'Shortlisted Candidates';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Shortlisted Candidates";
            }
        }
    }

    var
        EmailAdd: List of [Text];
        HRJobApplications: Record "HR Job Applications";
        HREmpApplication: Record "HR Employee Requisitions";
        CompInfo: Record "Company Information";
        HrIntMessage: Record "Hr Interview Evaluatn Message";
        SMTP: Codeunit "SMTP Mail";
}

