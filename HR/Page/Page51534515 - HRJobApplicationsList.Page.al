page 51534515 "HR Job Applications List"
{
    CardPageID = "HR Job Applications Card";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Job Applications List';
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = "HR Job Applications";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Application No"; "Application No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
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
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = all;
                }
                field(Age; Age)
                {
                    ApplicationArea = all;
                }
                field("Applicant Type"; "Applicant Type")
                {
                    ApplicationArea = all;
                }
                field("Date Applied"; "Date Applied")
                {
                    StyleExpr = TRUE;
                }
                field("Job Applied For"; "Job Applied For")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = all;
                }
                field("Ethnic Origin"; "Ethnic Origin")
                {
                    ApplicationArea = all;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = all;
                }
                field("Health Assesment?"; "Health Assesment?")
                {
                    ApplicationArea = all;
                }
                field("Health Assesment Date"; "Health Assesment Date")
                {
                    ApplicationArea = all;
                }
                field("Home Phone Number"; "Home Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Ext."; "Ext.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Fax Number"; "Fax Number")
                {
                    ApplicationArea = all;
                }
                field("Postal Address"; "Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; "Residential Address")
                {
                    ApplicationArea = all;
                }
                field(Qualified; Qualified)
                {
                    ApplicationArea = all;
                }
                field("Total Score"; "Total Score")
                {
                    ApplicationArea = all;
                }
                field("Interview Invitation Sent"; "Interview Invitation Sent")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755009; "HR Job Applications Factbox")
            {
                SubPageLink = "Application No" = FIELD("Application No");
                ApplicationArea = All;
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
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Applications Card";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action("&Upload to Employee Card")
                {
                    Caption = '&Upload to Employee Card';
                    Image = ImportDatabase;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    begin

                        if HREmpApplication.Get("Employee Requisition No") then begin
                            HREmpApplication."Turn Around Time" := (Today - HREmpApplication."Requisition Date");
                            HREmpApplication.Modify;
                            Commit;
                        end;

                        if "Employee No" = '' then begin
                            //IF NOT CONFIRM('Are you sure you want to Upload Applicants information to the Employee Card',FALSE) THEN EXIT;
                            HRJobApplications.SetFilter(HRJobApplications."Application No", "Application No");
                            REPORT.RUN(51534705, true, false, HRJobApplications);
                        end else begin
                            Message('This applicants information already exists in the employee card');
                        end;
                    end;
                }
                action("Send Interview Invitation")
                {
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Email: List of [Text];
                    begin
                        /*IF NOT CONFIRM(Text002,FALSE) THEN EXIT;
                        
                        HRJobApplications.SETFILTER(HRJobApplications."Application No","Application No");
                        REPORT.RUN(51534540,TRUE,FALSE,HRJobApplications);
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

                            Email.Add(HRJobApplications."E-Mail");
                            SMTP.CreateMessage(CompInfo.Name, CompInfo."E-Mail", Email,
                           HrIntMessage.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' +
                           HrIntMessage.Message + ' ' + 'at' + HrIntMessage.Venue + ' ' + 'On' + Format(HrIntMessage.Date), true);
                            SMTP.Send();
                            Message('Applicant has been Notified for the Invitation');
                        end;

                    end;
                }
                action("Interview Message Setup")
                {
                    Caption = 'Interview Message Setup';
                    ApplicationArea = all;
                    RunObject = Page "Hr Interview Evaluatn Msg List";
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action(Referees)
                {
                    Caption = 'Referees';
                    Image = ContactReference;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    ApplicationArea = all;
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    //RunObject = Page "HR Applicant Hobbies";
                    //RunPageLink = "Job Application No" = FIELD ("Application No");
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", "Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.RUN(51534525, true, true, HRJobApplications);
                    end;
                }
                action("Generate Offer Letter")
                {
                    Caption = 'Generate Offer Letter';
                    Image = Document;
                    ApplicationArea = all;
                    Promoted = true;
                    RunObject = Report "HR Employement Letter";
                    Visible = false;
                }
                action("Upload Attachments")
                {
                    Caption = 'Upload Attachments';
                    Image = Attachments;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Application No");
                }
                action("XMLport Job Application")
                {
                    Caption = 'Import Applicant Test Score';
                    Image = XMLFile;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    //RunObject = XMLport "Import Job Application";
                }
                action("XMLport Export Applicant")
                {
                    Caption = 'Export Applicant Test Score';
                    Image = XMLFile;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunObject = XMLport "Export Job Application Test";
                    Visible = true;
                }
                action("Export Job Application")
                {
                    Caption = 'Export Job Application';
                    Image = XMLFile;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Report Report39006004;
                }
                action("Import Job App FRM Excel")
                {
                    Caption = 'Import Ext. Applicant';
                    Image = excel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*ImportfromExcel.RUN;
                        CurrPage.UPDATE(TRUE); *///Lateef

                    end;
                }
                action("Export Job Apps to Excel")
                {
                    Caption = 'Export Job Apps to Excel';
                    Image = Export;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Codeunit Codeunit39005566;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //EmportToExcel.RUN;                          //39005566
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Report "HR Job Applications";

                    trigger OnAction()
                    begin
                        /*HRJobApplications.RESET;
                        HRJobApplications.SETRANGE(HRJobApplications."Application No","Application No");
                        IF HRJobApplications.FIND('-') THEN
                        REPORT.RUN(51534525,TRUE,TRUE,HRJobApplications);  *///Lateef

                    end;
                }
            }
        }
        area(reporting)
        {
            action("Job Applications")
            {
                Caption = 'Job Applications';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Job Applications";
            }
            action("Shortlisted Candidates")
            {
                Caption = 'Shortlisted Candidates';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Shortlisted Candidates";
            }
        }
    }

    var
        HRJobApplications: Record "HR Job Applications";
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send an Interview Application?';
        HREmpApplication: Record "HR Employee Requisitions";
        CompInfo: Record "Company Information";
        HrIntMessage: Record "Hr Interview Evaluatn Message";
        SMTP: Codeunit "SMTP Mail";
}

