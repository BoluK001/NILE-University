Codeunit 51534513 DocAttachment
{
    // EventSubscriberInstance = StaticAutomatic;
    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    // local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    // var
    //     HREmployee: Record "HR Employee";
    // begin
    //     case DocumentAttachment."Table ID" of
    //         DATABASE::"HR Employee":
    //             begin
    //                 RecRef.Open(DATABASE::"HR Employee");
    //                 if HREmployee.Get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HREmployee);
    //             end;
    //         DATABASE::"Staff Advance Surrender Header":
    //             begin
    //                 RecRef.Open(Database::"Staff Advance Surrender Header");
    //                 If StaffRet.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(StaffRet);
    //             end;
    //         DATABASE::"Staff Advance Header":
    //             begin
    //                 RecRef.Open(Database::"Staff Advance Header");
    //                 If StaffAdv.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(StaffAdv);
    //             end;
    //         DATABASE::"Staff Claims Header":
    //             begin
    //                 RecRef.Open(Database::"Staff Claims Header");
    //                 If StaffClaim.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(StaffClaim);
    //             end;
    //         DATABASE::"HR Training Applications":
    //             begin
    //                 RecRef.Open(Database::"HR Training Applications");
    //                 If HRTrainingingApp.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRTrainingingApp);
    //             end;
    //         DATABASE::"HR Employees":
    //             begin
    //                 RecRef.Open(Database::"HR Employees");
    //                 If HREmp.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HREmp);
    //             end;
    //         DATABASE::"HR Leave Acknowledgement":
    //             begin
    //                 RecRef.Open(Database::"HR Leave Acknowledgement");
    //                 If HRLeaveAck.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRLeaveAck);
    //             end;
    //         DATABASE::"HR Leave Application":
    //             begin
    //                 RecRef.Open(Database::"HR Leave Application");
    //                 If HRLeaveApp.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRLeaveApp);
    //             end;
    //         DATABASE::"Voucher Header":
    //             begin
    //                 RecRef.Open(Database::"Voucher Header");
    //                 If VHeader.get(DocumentAttachment."Document Type", DocumentAttachment."No.") then
    //                     RecRef.GetTable(VHeader);
    //             end;
    //         DATABASE::"Purchase Quote Header":
    //             begin
    //                 RecRef.Open(Database::"Purchase Quote Header");
    //                 If PurchaseQuoteHeader.get(DocumentAttachment."Document Type", DocumentAttachment."No.") then
    //                     RecRef.GetTable(PurchaseQuoteHeader);
    //             end;
    //         DATABASE::"HR HMO":
    //             begin
    //                 RecRef.Open(Database::"HR HMO");
    //                 If HRHMO.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRHMO);
    //             end;
    //         DATABASE::"HR Jobs":
    //             begin
    //                 RecRef.Open(Database::"HR Jobs");
    //                 If HRJob.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRJob);
    //             end;
    //         DATABASE::"HR Job Applications":
    //             begin
    //                 RecRef.Open(Database::"HR Job Applications");
    //                 If HRJobsApp.get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(HRJobsApp);
    //             end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    // local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    // var
    //     FieldRef: FieldRef;
    //     RecNo: Code[20];
    // begin
    //     case RecRef.Number of
    //         DATABASE::"HR Employee":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     end;
    //     Case RecRef.Number of
    //         Database::"Staff Advance Surrender Header":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     End;
    //     Case RecRef.Number of
    //         Database::"Staff Advance Header":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     End;
    //     Case RecRef.Number of
    //         Database::"Staff Claims Header":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     End;
    //     Case RecRef.Number of
    //         Database::"HR Training Applications":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     End;
    //     Case RecRef.Number of
    //         Database::"Voucher Header":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //                 DocumentAttachment.SetRange("Document Type", DocType)
    //             end;
    //     End;
    //     case RecRef.Number of
    //         DATABASE::"HR Leave Acknowledgement",
    //         DATABASE::"HR Transport Requisition",
    //         DATABASE::"HR Job Applications",
    //         DATABASE::"HR Policies",
    //         DATABASE::"Purchase Quote Header",
    //         DATABASE::"HR Company Activities",
    //         DATABASE::"HR HMO",
    //         DATABASE::"HR Appraisal Goal Setting H",
    //         DATABASE::"Emp Traing Eval. Questionaire",
    //         DATABASE::"HR HMO Hospital",
    //         DATABASE::"HR Employees",
    //         DATABASE::"HR-Employee":
    //             begin
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //             end;
    //     end;

    // end;




    var
        HREmployee: Record "HR Employee";
        ServiceItem: Record "Service Item";
        ServiceHeader: Record "Service Header";
        RecNo: Code[20];
        //DocType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Employee;
        DocType: enum "Approval Document Type";
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


}
