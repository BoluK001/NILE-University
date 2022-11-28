page 51534451 "HR Training request Card"
{
    PageType = Card;
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
                    Editable = false;   //jj280922
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if "From Date" < Today then
                            Error('Select Valid Date');
                    end;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;  //jj270422
                    trigger OnValidate()
                    begin
                        Duration := ("To Date" - "From Date") + 1;
                        if "To Date" < "From Date" then
                            Error('Select Valid Date');

                    end;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = all;
                    Editable = false; //jj010522
                }
                field("Duration Units"; "Duration Units")
                {
                    ApplicationArea = all;
                }


                field("Application Date"; "Application Date")
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
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = all;
                }
                field("Approved Cost"; "Approved Cost")
                {
                    ApplicationArea = all;
                }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No. of Applicants"; "No. of Applicants")
                {
                    ApplicationArea = all;
                }
            }
            part(Control20; "Hr Training Need App SF")
            {
                SubPageLink = "Document No." = FIELD("Application No");
                ApplicationArea = All; //jj270422
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
                ApplicationArea = all;
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
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

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
                        // DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal,"Canteen Application";
                        ApprovalEntries : Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        DocType := DocType::"Training Requisition";
                        //ApprovalEntries.Setfilters(DATABASE::"HR Training Applications", DocType, "Application No");
                        //ApprovalEntries.Run;
                        // ApprovalEntries.Setfilters(DATABASE::"Staff Advance Header", DocumentType, "No.");
                        // ApprovalEntries.Run;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Training Applications", DocType.AsInteger(), "Application No");
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
                action("<Action1102755042>")
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
                    Caption = 'Generate Payment Request';
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
                /*   action("Test Attachment")
                  {
                      ApplicationArea = All;
                      Caption = 'Attachment';
                      RunObject = Page "Attachment Test";
                      RunPageLink = "Employee No" = FIELD("User ID"),
                                    "Document Type" = CONST(Training),
                                    "Application No" = FIELD("Application No"),
                                    "Folder Type" = CONST(HR);
                  } */
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::HR;
    end;

    var
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        DocumentType: Enum "Approval Document Type";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        //DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        DocType: Enum "Approval Document Type";
        TrainingApplicant: Record "HR Training Need Participant";
        VendorName: Code[50];
        HREmailParameters: Record "HR E-Mail Parameters";
        HREmployeeRec: Record "HR Employees";
        EmpEmail: Text;
        smtp: Codeunit "SMTP Mail";
        smtpTable: Record "SMTP Mail Setup";
        senderEmail: Text;
        receiverEmail: List of [Text];
        EmailSubject: Text[100];
        SenderName: Text[50];
        EmailBody: Text[250];

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

        if "Sent to Staff" then Error('All Applicants have been notified');
        TrainingApplicant.SetRange(TrainingApplicant."Document No.", "Application No");
        if TrainingApplicant.Find('-') then begin
            repeat

                HREmailParameters.Reset;
                HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Training Application");
                if HREmailParameters.Find('-') then begin

                    if HREmployeeRec.Get(TrainingApplicant."Employee Code") then begin
                        EmpEmail := HREmployeeRec."Company E-Mail";
                        if not smtpTable.Get then
                            Error('The SMTP Setup does not exist, the mail was not sent');
                        EmailSubject := StrSubstNo('TRAINING APPLICATION - %1', TrainingApplicant."Course Title");  //jj270422  I changed to Course Title from "Student Course Title"
                        receiverEmail.Add(EmpEmail);

                        senderEmail := 'olajumokeo@reeltechsolutions.com';   //jj270422
                        EmailBody := ('Dear, ' + HREmployeeRec."First Name" + '<BR><BR>' + HREmailParameters.Body + '<BR><BR>' + HREmailParameters."Body 2" + '<BR><BR>' + 'Venue:' + Location + '<BR><BR>' + 'Start:' + Format("From Date") + '<BR><BR>' +
                        'End:' + Format("To Date") + '<BR><BR>' + 'Regards');

                        SMTP.CreateMessage(SenderName, senderEmail, receiverEmail, EmailSubject, EmailBody, true);
                        SMTP.Send;

                    end;
                end;
            until TrainingApplicant.Next = 0;
            Message('Applicants have been notified');
        end;
        "Sent to Staff" := true;
        Modify;
    end;
}

