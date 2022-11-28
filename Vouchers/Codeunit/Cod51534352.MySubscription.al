codeunit 51534352 MySubscription
{
    //TableNo = Vendor;

    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Table, DATABASE::"Vendor", 'OnAssistEditOnBeforeExit', '', false, false)]
    local procedure SetVendorSeriesOnAssistEditOnBeforeExit(var Vendor: Record Vendor)
    var
        PurchSetup: record "Purchases & Payables Setup";
    begin
        IF (Vendor."No." = '') AND (Vendor."Vendor Type" = Vendor."Vendor Type"::"With Holding Tax") THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("WHT No.");
            Vendor.VALIDATE(Vendor."No.", PurchSetup."WHT No.")
        end;
    end;
}
