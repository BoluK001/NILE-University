page 51534671 "HR Emp Requisition Self"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID"; "Job ID")
                {
                    Editable = "Job IDEditable";
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Requisition No."; "Requisition No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Requisition Date"; "Requisition Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Requestor; Requestor)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Description"; "Job Description")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Reason For Request"; "Reason For Request")
                {
                    Editable = "Reason For RequestEditable";
                    ApplicationArea = all;
                }
                field("Reason for Request(Other)"; "Reason for Request(Other)")
                {
                    Caption = 'Reason for Request(If Other)';
                    ApplicationArea = all;
                    Editable = ReasonforRequestOtherEditable;
                }
                field(Score; Score)
                {
                    Editable = "Required PositionsEditable";
                    ApplicationArea = all;
                }
                field("Type of Contract Required"; "Type of Contract Required")
                {
                    Editable = "Required PositionsEditable";
                    ApplicationArea = all;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                    Editable = PriorityEditable;
                }
                field("Vacant Positions"; "Vacant Positions")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Required Positions"; "Required Positions")
                {
                    Editable = "Required PositionsEditable";
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Experience Level"; "Experience Level")
                {
                    Editable = "Required PositionsEditable";
                    ApplicationArea = all;
                }
                field("Closing Date"; "Closing Date")
                {
                    Editable = "Closing DateEditable";
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Editable = "Responsibility CenterEditable";
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Recruitment Type"; "Recruitment Type")
                {
                    Editable = "Requisition TypeEditable";
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
            }
            part("List of Interviewers"; "HR Job Interview Areas")
            {
                Caption = 'List of Interviewers';
                Editable = "Required PositionsEditable";
                SubPageLink = "Requisition No." = FIELD("Requisition No.");
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Any Additional Information"; "Any Additional Information")
                {
                    Editable = AnyAdditionalInformationEditab;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755022; "HR Employee Req. Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755020; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fu&nctions")
            {
                Caption = 'Fu&nctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocType := DocType::"Employee Requisition";
                        ApprovalEntries.Setfilters(DATABASE::"HR Employee Requisitions", DocType, "Requisition No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        if Confirm('Send this Requisition for Approval?', true) = false then exit;

                        TESTFIELDS;
                        if ApprovalsMgmt.CheckHREmpReqApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendHREmpReqForApproval(Rec);

                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then exit;


                        ApprovalsMgmt.OnCancelHREmpReqForApproval(Rec);
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                action("Mark as Closed/Open")
                {
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup."Reopen Doc" = true then begin
                            if Closed then begin
                                if not Confirm('Are you sure you want to Re-Open this Document', false) then exit;
                                Closed := false;
                                Modify;
                                Message('Employee Requisition %1 has been Re-Opened', "Requisition No.");

                            end else begin
                                if not Confirm('Are you sure you want to close this Document', false) then exit;
                                Closed := true;
                                Modify;
                                Message('Employee Requisition %1 has been marked as Closed', "Requisition No.");
                            end;
                        end else
                            Error('you do not have permission to perform this activity');
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmpReq.Reset;
                        HREmpReq.SetRange(HREmpReq."Requisition No.", "Requisition No.");
                        // if HREmpReq.Find('-') then
                        //REPORT.Run(39005489, true, true, HREmpReq);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then
                            if UserSetup."Reopen Doc" then begin
                                Status := Status::New;
                                Modify;
                            end else
                                Error('you do not have permission to perform this activity');
                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines(RO)";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities (RO)";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("&Send Mail to HR to add vacant position")
                {
                    Caption = '&Send Mail to HR to add vacant position';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin
                        UserSetup.SetRange("HR Job", true);
                        if UserSetup.FindFirst then begin
                            DimValue.Reset;
                            DimValue.SetRange(Code, "Shortcut Dimension 2 Code");
                            if objEmp.Find('-') then begin
                                if objEmp."Company E-Mail" = '' then Error('THe HR doesnt have an email Account');
                                //**********************send mail**********************************
                                //IF UserSetup.GET(DimValue."HR Officer") THEN
                                EmailAdd.Add(UserSetup."E-Mail");
                                SMTP.CreateMessage('Job Advertisement', 'info@leadway-pensure.com', EmailAdd,
                                'VACANT POSITION', 'Kindly create additional position(s) for  ' + "Job Description", true);
                                SMTP.Send();
                            end else begin
                                Message('There is no employee marked as HR in that Division');
                            end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        HRLookupValues.SetRange(HRLookupValues.Code, "Type of Contract Required");
        if HRLookupValues.Find('-') then
            ContractDesc := HRLookupValues.Description;
    end;

    trigger OnInit()
    begin
        TypeofContractRequiredEditable := true;
        AnyAdditionalInformationEditab := true;
        "Required PositionsEditable" := true;
        "Requisition TypeEditable" := true;
        "Closing DateEditable" := true;
        PriorityEditable := true;
        ReasonforRequestOtherEditable := true;
        "Reason For RequestEditable" := true;
        "Responsibility CenterEditable" := true;
        "Job IDEditable" := true;
        "Requisition DateEditable" := true;
        "Requisition No.Editable" := true;
    end;

    trigger OnOpenPage()
    begin
        if "Requisition No." <> '' then begin
            if Today > "Closing Date" then begin
                Closed := true;
                Modify;
            end;
        end;
    end;

    var
        EmailAdd: List of [Text];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        ApprovalEntries:Page "Approval Entries";
        HREmpReq: Record "HR Employee Requisitions";
        SMTP: Codeunit "SMTP Mail";
        HRSetup: Record "HR Setup";
        CTEXTURL: Text[30];
        HREmp: Record "HR Employees";
        HREmailParameters: Record "HR E-Mail Parameters";
        ContractDesc: Text[30];
        HRLookupValues: Record "HR Lookup Values";
        [InDataSet]
        "Requisition No.Editable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Reason For RequestEditable": Boolean;
        [InDataSet]
        ReasonforRequestOtherEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Closing DateEditable": Boolean;
        [InDataSet]
        "Requisition TypeEditable": Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        [InDataSet]
        AnyAdditionalInformationEditab: Boolean;
        [InDataSet]
        TypeofContractRequiredEditable: Boolean;
        DimValue: Record "Dimension Value";
        objEmp: Record "HR Employees";
        UserSetup: Record "User Setup";
        FileName: Text[100];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;

    [Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        TestField("Job ID");
        TestField("Closing Date");
        TestField("Type of Contract Required");
        TestField("Recruitment Type");
        TestField("Required Positions");
        if "Reason For Request" = "Reason For Request"::Other then
            TestField("Reason for Request(Other)");
        TestField("Experience Level");
    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin

        if Status = Status::New then begin
            "Requisition No.Editable" := true;
            "Requisition DateEditable" := true;
            "Job IDEditable" := true;
            "Responsibility CenterEditable" := true;
            "Reason For RequestEditable" := true;
            ReasonforRequestOtherEditable := true;
            PriorityEditable := true;
            "Closing DateEditable" := true;
            "Requisition TypeEditable" := true;
            "Required PositionsEditable" := true;
            "Required PositionsEditable" := true;
            AnyAdditionalInformationEditab := true;
            TypeofContractRequiredEditable := true;
        end else begin
            "Requisition No.Editable" := false;
            "Requisition DateEditable" := false;
            "Job IDEditable" := false;
            "Responsibility CenterEditable" := false;
            "Reason For RequestEditable" := false;
            ReasonforRequestOtherEditable := false;
            PriorityEditable := false;
            "Closing DateEditable" := false;
            "Requisition TypeEditable" := false;
            "Required PositionsEditable" := false;
            "Required PositionsEditable" := false;
            AnyAdditionalInformationEditab := false;

            TypeofContractRequiredEditable := false;
        end;
    end;
}

