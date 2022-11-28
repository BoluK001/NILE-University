codeunit 51534412 EventSubscriber
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //GenJournalLine."Change of Ownership" := SalesHeader."Change of Ownership";
        //GenJournalLine.LPO := SalesHeader.LPO;
        //GenJournalLine."OEM Code" := SalesHeader."OEM Code";
        //GenJournalLine."Sales Type" := SalesHeader."Sales Type";
        //GenJournalLine."Alloted Phone No." := SalesHeader."Alloted Phone No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //CustLedgerEntry.LPO := GenJournalLine.LPO;
        //CustLedgerEntry."OEM Code" := GenJournalLine."OEM Code";
    end;

    [EventSubscriber(ObjectType::Table, database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //GLEntry.LPO := GenJournalLine.LPO;
        //GLEntry."OEM Code" := GenJournalLine."OEM Code";
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', true, true)]
    local procedure OnAfterGetNoSeriesCode(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    begin
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Quote:
                begin
                    IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::Requisition then
                        NoSeriesCode := PurchSetup."Requisition No";
                end;

        // PurchHeader."Document Type"::Order:
        //     begin
        //         IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::Foreign then
        //             NoSeriesCode := PurchSetup."Foreign Purchase Order";
        //         IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::Local then
        //             NoSeriesCode := PurchSetup."Local Purchase Order";
        //         IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::Cash then
        //             NoSeriesCode := PurchSetup."Cash Purchase Order";
        //         IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::"Import Charge" then
        //             NoSeriesCode := PurchSetup."Import Purchase Invoice";
        //     end;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 1535, 'OnBeforeSetCommonApprovalCommentLineFilters', '', true, true)]
    // procedure OnBeforeSetCommonApprovalCommentLineFilters(var RecRef: RecordRef; var ApprovalCommentLine: Record "Approval Comment Line"; var IsHandle: Boolean)

    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number of
    //         DATABASE::"Voucher Header":
    //             begin
    //                 ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
    //                 ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
    //                 FindOpenApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
    //             end;
    //     end;
    // end;


    Var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalEntry: Record "Approval Entry";
        RecRef: RecordRef;
        Variant: Variant;
}