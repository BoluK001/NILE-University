page 51534453 "HR HOD Training Need card"
{
    PageType = Document;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No"; "Application No")
                {
                    ApplicationArea = all;
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                }
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = all;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = all;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = all;
                }
                field("No. of Applicants"; "No. of Applicants")
                {
                    ApplicationArea = all;
                }
            }
            part(Control17; "Hr Training Need App SF")
            {
                SubPageLink = "Document No." = FIELD("Application No");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = Comment;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocumentType := DocumentType::"Training Requisition";
                        /*
                        ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.RUN;
                         */

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal,"Canteen Application";
                        ApprovalEntries : Page "Approval Entries";
                    begin
                        DocType := DocType::"Training Requisition";
                        ApprovalEntries.Setfilters(DATABASE::"HR Training Applications", DocType, "Application No");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval &Request")
                {
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //TESTFIELDS;

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        if ApprovalMgt.CheckHRTrainingApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRTrainingAppForApproval(Rec);
                    end;
                }
                action("&Cancel Approval request")
                {
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request', true) = false then exit;
                        ApprovalMgt.OnCancelHRTrainingAppForApproval(Rec);
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintForm;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No", "Application No");
                        if HRTrainingApplications.Find('-') then
                            REPORT.Run(51534685, true, true, HRTrainingApplications);
                    end;
                }
                action("<A ction1102755042>")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Status := Status::New;
                        Modify;
                    end;
                }
                action("Generate PV")
                {
                    Image = Payment;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);
                        GeneratePV;
                    end;
                }
                action(" Attachments")
                {
                    Caption = ' Attachments';
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Application No"),
                                  "Document Type" = CONST(Training);
                }
                action("Send Mail")
                {
                    Image = Mail;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DisPCase: Record "HR Disciplinary Cases";
                        Emp: Record "HR Employees";
                    begin
                        TestField(Status, Status::Approved);
                        SendMail;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::HOD;
    end;

    var
        EmailAdd: List of [Text];
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        TrainingApplicant: Record "HR Training Need Participant";
        VendorName: Code[50];
        HREmailParameters: Record "HR E-Mail Parameters";

    local procedure SendMail()
    var
        HREmp: Record "HR Employees";
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        HrComm: Record "HR Committees";
        Emp: Record "HR Employees";
        EmpNames: Text[50];
    begin
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        if "Sent to Staff" then Error('All applicants have been notified');
        //TESTFIELD("Applicant Type","Applicant Type"::Internal);
        TrainingApplicant.SetRange(TrainingApplicant."Document No.", "Application No");
        if TrainingApplicant.FindFirst then begin
            repeat
                HREmailParameters.Reset;
                HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Training Application");
                if HREmailParameters.Find('-') then begin
                    HREmp.Get(TrainingApplicant."Employee Code");
                    HREmp.TestField(HREmp."Company E-Mail");
                    EmailAdd.Add(HREmp."Company E-Mail");
                    SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", EmailAdd,
                    HREmailParameters.Subject, '', true);

                    SMTP.AppendBody('Dear,' + HREmp."Full Name" + '<BR><BR>');
                    SMTP.AppendBody(HREmailParameters.Body + ' ' + '<BR><BR>');  //get mail template
                    SMTP.AppendBody('<p>');
                    SMTP.AppendBody('Venue: ' + Format(Location) + '<BR><BR>');
                    SMTP.AppendBody('Start Date: ' + Format("From Date", 0, 4) + '<BR><BR>');
                    SMTP.AppendBody('End Date: ' + Format("To Date", 0, 4) + '<BR><BR>');
                    SMTP.AppendBody(HREmailParameters."Body 3" + ' ' + '<BR><BR>');  //get mail template

                    SMTP.AppendBody('Regards,<BR>');
                    SMTP.AppendBody('HR <BR>');
                    SMTP.Send;


                end;
            until TrainingApplicant.Next = 0;
            Message('Applicants have been notified');
        end;

        "Sent to Staff" := true;
        Modify;
    end;
}

