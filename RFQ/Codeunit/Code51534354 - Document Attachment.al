Codeunit 51534354 DocumentAttachment
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        PaymentTerms: Record "Payment Terms";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Payment Terms":
                begin
                    RecRef.Open(DATABASE::"Payment Terms");
                    if PaymentTerms.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(PaymentTerms);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Employee":
                begin
                    RecRef.Open(DATABASE::"HR Employee");
                    if HREmployee.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(HREmployee);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Staff Advance Surrender Header":
                begin
                    RecRef.Open(Database::"Staff Advance Surrender Header");
                    If StaffRet.get(DocumentAttachment."No.") then
                        RecRef.GetTable(StaffRet);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Staff Advance Header":
                begin
                    RecRef.Open(Database::"Staff Advance Header");
                    If StaffAdv.get(DocumentAttachment."No.") then
                        RecRef.GetTable(StaffAdv);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Staff Claims Header":
                begin
                    RecRef.Open(Database::"Staff Claims Header");
                    If StaffClaim.get(DocumentAttachment."No.") then
                        RecRef.GetTable(StaffClaim);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Training Applications":
                begin
                    RecRef.Open(Database::"HR Training Applications");
                    If HRTrainingingApp.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRTrainingingApp);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Employees":
                begin
                    RecRef.Open(Database::"HR Employees");
                    If HREmp.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HREmp);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Leave Acknowledgement":
                begin
                    RecRef.Open(Database::"HR Leave Acknowledgement");
                    If HRLeaveAck.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRLeaveAck);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Leave Application":
                begin
                    RecRef.Open(Database::"HR Leave Application");
                    If HRLeaveApp.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRLeaveApp);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Voucher Header":
                begin
                    RecRef.Open(Database::"Voucher Header");
                    If VHeader.get(DocumentAttachment."Document Type", DocumentAttachment."No.") then
                        RecRef.GetTable(VHeader);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Purchase Quote Header":
                begin
                    RecRef.Open(Database::"Purchase Quote Header");
                    If PurchaseQuoteHeader.get(DocumentAttachment."Document Type", DocumentAttachment."No.") then
                        RecRef.GetTable(PurchaseQuoteHeader);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR HMO":
                begin
                    RecRef.Open(Database::"HR HMO");
                    If HRHMO.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRHMO);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Jobs":
                begin
                    RecRef.Open(Database::"HR Jobs");
                    If HRJob.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRJob);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"HR Job Applications":
                begin
                    RecRef.Open(Database::"HR Job Applications");
                    If HRJobsApp.get(DocumentAttachment."No.") then
                        RecRef.GetTable(HRJobsApp);
                end;
        end;
        case DocumentAttachment."Table ID" of
            DATABASE::"Store Requisition Header":
                begin
                    RecRef.Open(Database::"Store Requisition Header");
                    If StoreReq.get(DocumentAttachment."No.") then
                        RecRef.GetTable(StoreReq);
                end;
        end;
        
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Payment Terms":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
        case RecRef.Number of
            DATABASE::"HR Employee":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
        Case RecRef.Number of
            Database::"Staff Advance Surrender Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Staff Advance Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Staff Claims Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"HR Training Applications":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Store Requisition Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        case RecRef.Number of
            DATABASE::"Voucher Header",
            DATABASE::"Voucher Line":
                begin
                    FieldRef := RecRef.Field(1);
                    DocType := FieldRef.Value;
                    DocumentAttachment.SetRange("Document Type", DocType);

                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);

                    FlowFieldsEditable := false;
                end;
        end;
        Case RecRef.Number of
            Database::"Purchase Quote Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;
        case RecRef.Number of
            DATABASE::"HR Leave Acknowledgement",
            DATABASE::"HR Transport Requisition",
            DATABASE::"HR Job Applications",
            DATABASE::"HR Policies",
            //DATABASE::"Purchase Quote Header",
            DATABASE::"HR Company Activities",
            DATABASE::"HR HMO",
            DATABASE::"HR Appraisal Goal Setting H",
            DATABASE::"Emp Traing Eval. Questionaire",
            DATABASE::"HR HMO Hospital",
            DATABASE::"HR Employees",
            DATABASE::"HR-Employee":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Payment Terms":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);

                end;
        end;
        case RecRef.Number of
            DATABASE::"HR Employee":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
        Case RecRef.Number of
            Database::"Staff Advance Surrender Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Staff Advance Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Staff Claims Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"HR Training Applications":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
        case RecRef.Number of
            DATABASE::"Voucher Header",
            DATABASE::"Voucher Line":
                begin
                    FieldRef := RecRef.Field(1);
                    DocType := FieldRef.Value;
                    DocumentAttachment.Validate("Document Type", DocType);

                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;

        Case RecRef.Number of
            Database::"Purchase Quote Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
        Case RecRef.Number of
            Database::"Store Requisition Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        End;

        case RecRef.Number of
            DATABASE::"Voucher Line":
                begin
                    FieldRef := RecRef.Field(10);
                    LineNo := FieldRef.Value;
                    DocumentAttachment.Validate("Line No.", LineNo);
                end;
        end;
        case RecRef.Number of
            DATABASE::"HR Leave Acknowledgement",
            DATABASE::"HR Transport Requisition",
            DATABASE::"HR Job Applications",
            DATABASE::"HR Policies",
           // DATABASE::"Purchase Quote Header",
            DATABASE::"HR Company Activities",
            DATABASE::"HR HMO",
            DATABASE::"HR Appraisal Goal Setting H",
            DATABASE::"Emp Traing Eval. Questionaire",
            DATABASE::"HR HMO Hospital",
            DATABASE::"HR Employees",
            DATABASE::"HR-Employee":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

    var
        HREmployee: Record "HR Employee";
        ServiceItem: Record "Service Item";
        ServiceHeader: Record "Service Header";
        RecNo: Code[20];
        //DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Employee;
        DocType: enum DocType;
        FlowFieldsEditable: Boolean;
        LineNo: Integer;
        FieldRef: FieldRef;
        StaffRet: Record "Staff Advance Surrender Header";
        StaffAdv: Record "Staff Advance Header";
        StaffClaim: Record "Staff Claims Header";
        HRTrainingingApp: Record "HR Training Applications";
        VHeader: Record "Voucher Header";

        HRJob: Record "HR Jobs";
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        HRHMOHospital: Record "HR HMO Hospital";
        EmpTrainingEvalQst: Record "Emp Traing Eval. Questionaire";
        HRHMO: Record "HR HMO";
        HRCompActivities: Record "HR Company Activities";
        PurchaseQuoteHeader: Record "Purchase Quote Header";
        HRLeaveAck: Record "HR Leave Acknowledgement";
        HRLeaveApp: Record "HR Leave Application";
        HREmp: Record "HR Employees";
        HRPolicies: Record "HR Policies";
        HREmpExitInterviews: Record "HR Employee Exit Interviews";
        HRTransportReq: Record "HR Transport Requisition";
        HRJobsApp: Record "HR Job Applications";
        StoreReq: Record "Store Requisition Header";
}
