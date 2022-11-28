codeunit 51534355 SendMail
{
    procedure PrintPurchQuoteHeader(PurchQuoteHeader: Record "Purchase Quote Header")
    var
        ReportSelections: Record "Report Selections";
        ReportUsage: Enum "Report Selection Usage";
        IsPrinted: Boolean;
        QRVendor: Record "Quotation Request Vendors";
    begin
        ReportUsage := GetPurchDocTypeUsage(PurchQuoteHeader);

        PurchQuoteHeader.SetRange("Document Type", PurchQuoteHeader."Document Type");
        PurchQuoteHeader.SetRange("No.", PurchQuoteHeader."No.");
        //CalcPurchDisc(PurchQuoteHeader);
        OnBeforeDoPrintPurchQuoteHeader(PurchQuoteHeader, ReportUsage.AsInteger(), IsPrinted);
        if IsPrinted then
            exit;

        //ReportSelections.PrintWithDialogForVend(ReportUsage, PurchQuoteHeader, true, PurchQuoteHeader.FieldNo("Buy-from Vendor No."));
        ReportSelections.PrintWithDialogForVend(ReportUsage, PurchQuoteHeader, true, 0);

    end;

    procedure PrintPurchQuoteHeaderToDocumentAttachment(var PurchQuoteHeader: Record "Purchase Quote Header");
    var
        ShowNotificationAction: Boolean;
    begin
        ShowNotificationAction := PurchQuoteHeader.Count() = 1;
        if PurchQuoteHeader.FindSet() then
            repeat
                DoPrintPurchQuoteHeaderToDocumentAttachment(PurchQuoteHeader, ShowNotificationAction);
            until PurchQuoteHeader.Next() = 0;
    end;

    local procedure DoPrintPurchQuoteHeaderToDocumentAttachment(PurchQuoteHeader: Record "Purchase Quote Header"; ShowNotificationAction: Boolean)
    var
        ReportSelections: Record "Report Selections";
        ReportUsage: Enum "Report Selection Usage";
    begin
        ReportUsage := GetPurchDocTypeUsage(PurchQuoteHeader);

        PurchQuoteHeader.SetRecFilter();
        //CalcPurchDisc(PurchQuoteHeader);
        ReportSelections.SaveAsDocumentAttachment(ReportUsage.AsInteger(), PurchQuoteHeader, PurchQuoteHeader."No.", ''/*PurchQuoteHeader."Pay-to Vendor No."*/, ShowNotificationAction);
    end;

    Local procedure GetPurchDocTypeUsage(PurchHeader: Record "Purchase Quote Header") ReportSelectionUsage: Enum "Report Selection Usage"
    var
        ReportSelections: Record "Report Selections";
        TypeUsage: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeGetPurchDocTypeUsage(PurchHeader, ReportSelectionUsage, IsHandled);
        if IsHandled then
            exit(ReportSelectionUsage);

        exit(ReportSelections.Usage::"P.Quote");

        // case PurchHeader."Document Type" of
        //     PurchHeader."Document Type"::Quote:
        //         exit(ReportSelections.Usage::"P.Quote");
        //     PurchHeader."Document Type"::"Blanket Order":
        //         exit(ReportSelections.Usage::"P.Blanket");
        //     PurchHeader."Document Type"::Order:
        //         exit(ReportSelections.Usage::"P.Order");
        //     PurchHeader."Document Type"::"Return Order":
        //         exit(ReportSelections.Usage::"P.Return");
        //     else begin
        //         IsHandled := false;
        //         OnGetPurchDocTypeUsageElseCase(PurchHeader, TypeUsage, IsHandled);
        //         if IsHandled then
        //             exit("Report Selection Usage".FromInteger(TypeUsage));
        //         Error('');
        //     end;
        // end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeDoPrintPurchQuoteHeader(var PurchHeader: Record "Purchase Quote Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetPurchDocTypeUsage(PurchaseHeader: Record "Purchase Quote Header"; var ReportSelectionUsage: Enum "Report Selection Usage"; var IsHandled: Boolean)
    begin
    end;

    Procedure RBSSendEmail(MailRecipients: List of [Text]; MailSubject: Text; MailBody: Text; htmlformat: Boolean; AttachFilename: Text)
    var
        EmailAccount: Record "Email Account";
        EmailMessage: Codeunit "Email Message";
        EmailSend: Codeunit Email;
        BodyMessage: Text;
        Receipient: List of [text];
    begin
        EmailAccount.reset;
        //EmailAccount.SetFilter(Connector, 'SMTP');
        IF EmailAccount.FindFirst() then begin
            clear(BodyMessage);
            Clear(Receipient);
            Receipient := MailRecipients;
            BodyMessage := MailBody;
            EmailMessage.Create(Receipient, MailSubject, BodyMessage, htmlformat);
            EmailMessage.AddAttachment(AttachFilename, 'PDF', '');
            EmailSend.Send(EmailMessage);
        end;

    end;

    var
        Email1: List of [Text];
        Email2: List of [Text];
        Email3: List of [Text];
        Email4: List of [Text];
        Email5: List of [Text];
}
