codeunit 51534982 "Voucher Apply Entries"
{
    TableNo = "Voucher Line";

    trigger OnRun()
    begin
        VoucherLine.COPY(Rec);

        WITH VoucherLine DO BEGIN
            GetCurrency;
            IF "Bal. Account Type" IN
               ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor]
            THEN BEGIN
                AccType := "Bal. Account Type";
                AccNo := "Bal. Account No.";
            END ELSE BEGIN
                AccType := Account;
                AccNo := "Account No.";
            END;
            CASE AccType OF
                AccType::Customer:
                    BEGIN
                        CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, TRUE);
                        IF "Applies-to ID" = '' THEN
                            "Applies-to ID" := "Document No.";
                        IF "Applies-to ID" = '' THEN
                            ERROR(
                              Text000,
                              FIELDCAPTION("Document No."), FIELDCAPTION("Applies-to ID"));
                        //ApplyCustEntries.SetVoucherLine(VoucherLine,FIELDNO("Applies-to ID"));
                        ApplyCustEntries.SETRECORD(CustLedgEntry);
                        ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
                        ApplyCustEntries.LOOKUPMODE(TRUE);
                        OK := ApplyCustEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyCustEntries);
                        IF NOT OK THEN
                            EXIT;
                        CustLedgEntry.RESET;
                        CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                        CustLedgEntry.SETRANGE("Customer No.", AccNo);
                        CustLedgEntry.SETRANGE(Open, TRUE);
                        CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF CustLedgEntry.FIND('-') THEN BEGIN
                            CurrencyCode2 := CustLedgEntry."Currency Code";
                            IF Amount = 0 THEN BEGIN
                                REPEAT
                                    // PaymentToleranceMgt.DelPmtTolApllnDocNo2(VoucherLine,CustLedgEntry."Document No.");
                                    CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                    CustLedgEntry.CALCFIELDS("Remaining Amount");
                                    CustLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmount(
                                        CustLedgEntry."Remaining Amount",
                                        CustLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    CustLedgEntry."Remaining Amount" :=
                                      ROUND(CustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmount(
                                        CustLedgEntry."Remaining Pmt. Disc. Possible",
                                        CustLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      ROUND(CustLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                    CustLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmount(
                                        CustLedgEntry."Amount to Apply",
                                        CustLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    CustLedgEntry."Amount to Apply" :=
                                      ROUND(CustLedgEntry."Amount to Apply", Currency."Amount Rounding Precision");

                                    /* IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE) AND
                                        (ABS(CustLedgEntry."Amount to Apply") >=
                                         ABS(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible"))
                                     THEN
                                       Amount := Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                     ELSE */
                                    Amount := Amount - CustLedgEntry."Amount to Apply";
                                UNTIL CustLedgEntry.NEXT = 0;
                                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) OR
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                THEN
                                    Amount := -Amount;
                                VALIDATE(Amount);
                            END ELSE
                                REPEAT
                                    CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                                UNTIL CustLedgEntry.NEXT = 0;
                            IF "Currency Code" <> CurrencyCode2 THEN
                                IF Amount = 0 THEN BEGIN
                                    IF NOT
                                       CONFIRM(
                                         Text001 +
                                         Text002, TRUE,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         CustLedgEntry."Currency Code")
                                    THEN
                                        ERROR(Text003);
                                    "Currency Code" := CustLedgEntry."Currency Code"
                                END ELSE
                                    CheckAgainstApplnCurrency("Currency Code", CustLedgEntry."Currency Code", AccType::Customer, TRUE);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        END ELSE
                            "Applies-to ID" := '';
                        MODIFY;
                        // Check Payment Tolerance
                        /* IF  Rec.Amount <> 0 THEN
                           IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                             EXIT;  */
                    END;
                AccType::Vendor:
                    BEGIN
                        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                        VendLedgEntry.SETRANGE("Vendor No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, TRUE);
                        IF "Salespers./Purch. Code" = '' THEN
                            "Applies-to ID" := "Document No.";
                        IF "Applies-to ID" = '' THEN
                            ERROR(
                              Text000,
                              FIELDCAPTION("Document No."), FIELDCAPTION("Applies-to ID"));
                        //ApplyVendEntries.SetVoucherLine(VoucherLine,FIELDNO("Applies-to ID"));
                        ApplyVendEntries.SETRECORD(VendLedgEntry);
                        ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                        ApplyVendEntries.LOOKUPMODE(TRUE);
                        OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                        CLEAR(ApplyVendEntries);
                        IF NOT OK THEN
                            EXIT;
                        VendLedgEntry.RESET;
                        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                        VendLedgEntry.SETRANGE("Vendor No.", AccNo);
                        VendLedgEntry.SETRANGE(Open, TRUE);
                        VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF VendLedgEntry.FIND('-') THEN BEGIN
                            CurrencyCode2 := VendLedgEntry."Currency Code";
                            IF Amount = 0 THEN BEGIN
                                REPEAT
                                    // PaymentToleranceMgt.DelPmtTolApllnDocNo2(VoucherLine,VendLedgEntry."Document No.");
                                    CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, TRUE);

                                    VendLedgEntry.CALCFIELDS("Remaining Amount");
                                    VendLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmount(
                                        VendLedgEntry."Remaining Amount",
                                        VendLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    VendLedgEntry."Remaining Amount" :=
                                      ROUND(VendLedgEntry."Remaining Amount", Currency."Amount Rounding Precision");
                                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmount(
                                        VendLedgEntry."Remaining Pmt. Disc. Possible",
                                        VendLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      ROUND(VendLedgEntry."Remaining Pmt. Disc. Possible", Currency."Amount Rounding Precision");
                                    VendLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmount(
                                        VendLedgEntry."Amount to Apply",
                                        VendLedgEntry."Currency Code", "Currency Code", "Posting Date");
                                    VendLedgEntry."Amount to Apply" :=
                                      ROUND(VendLedgEntry."Amount to Apply", Currency."Amount Rounding Precision");

                                    /*IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(Rec,VendLedgEntry,0,FALSE) AND
                                       (ABS(VendLedgEntry."Amount to Apply") >=
                                        ABS(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible"))
                                    THEN
                                      Amount := Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                    ELSE */
                                    Amount := Amount - VendLedgEntry."Amount to Apply";

                                UNTIL VendLedgEntry.NEXT = 0;
                                IF ("Bal. Account Type" = "Bal. Account Type"::Customer) OR
                                   ("Bal. Account Type" = "Bal. Account Type"::Vendor)
                                THEN
                                    Amount := -Amount;
                                VALIDATE(Amount);
                            END ELSE
                                REPEAT
                                    CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, TRUE);
                                UNTIL VendLedgEntry.NEXT = 0;
                            IF "Currency Code" <> CurrencyCode2 THEN
                                IF Amount = 0 THEN BEGIN
                                    IF NOT
                                       CONFIRM(
                                         Text001 +
                                         Text002, TRUE,
                                         FIELDCAPTION("Currency Code"), TABLECAPTION, "Currency Code",
                                         VendLedgEntry."Currency Code")
                                    THEN
                                        ERROR(Text003);
                                    "Currency Code" := VendLedgEntry."Currency Code"
                                END ELSE
                                    CheckAgainstApplnCurrency("Currency Code", VendLedgEntry."Currency Code", AccType::Vendor, TRUE);
                            "Applies-to Doc. Type" := 0;
                            "Applies-to Doc. No." := '';
                        END ELSE
                            "Applies-to ID" := '';
                        MODIFY;
                        // Check Payment Tolerance
                        /*IF  Rec.Amount <> 0 THEN
                          IF NOT PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) THEN
                            EXIT;*/
                    END;
                ELSE
                    ERROR(
                      Text005,
                      FIELDCAPTION("Account Type"), FIELDCAPTION("Bal. Account Type"));
            END;
        END;

        Rec := VoucherLine;

    end;

    var
        VoucherLine: Record "Voucher Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        ApplyCustEntries: Page "Apply Customer Entries";
        ApplyVendEntries: Page "Apply Vendor Entries";
        AccNo: Code[20];
        CurrencyCode2: Code[20];
        OK: Boolean;
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        Text000: Label 'You must specify %1 or %2.';
        Text001: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text002: Label 'Do you wish to continue?';
        Text003: Label 'The update has been interrupted to respect the warning.';
        Text005: Label 'The %1 or %2 must be Customer or Vendor.';
        Text006: Label 'All entries in one application must be in the same currency.';
        Text007: Label 'All entries in one application must be in the same currency or one or more of the EMU currencies. ';

    [Scope('OnPrem')]
    procedure CheckAgainstApplnCurrency(ApplnCurrencyCode: Code[20]; CompareCurrencyCode: Code[20]; AccType: Option "G/L Account",Customer,"Local Vendor","Foreign Vendor","Import File",Intercomany,"Local Staff","Expat Staff",Cash,Bank,"Other Bank","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        IF ApplnCurrencyCode = CompareCurrencyCode THEN
            EXIT(TRUE);

        CASE AccType OF
            AccType::Customer:
                BEGIN
                    SalesSetup.GET;
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
            AccType::"Local Vendor", AccType::"Foreign Vendor", AccType::"Import File", AccType::"Local Staff", AccType::"Expat Staff":
                BEGIN
                    PurchSetup.GET;
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    CASE CurrencyAppln OF
                        CurrencyAppln::No:
                            BEGIN
                                IF ApplnCurrencyCode <> CompareCurrencyCode THEN
                                    IF Message THEN
                                        ERROR(Text006)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                        CurrencyAppln::EMU:
                            BEGIN
                                GLSetup.GET;
                                IF NOT Currency.GET(ApplnCurrencyCode) THEN
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency2.GET(CompareCurrencyCode) THEN
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                IF NOT Currency."EMU Currency" OR NOT Currency2."EMU Currency" THEN
                                    IF Message THEN
                                        ERROR(Text007)
                                    ELSE
                                        EXIT(FALSE);
                            END;
                    END;
                END;
        END;

        EXIT(TRUE);
    end;

    [Scope('OnPrem')]
    procedure GetCurrency()
    begin
        WITH VoucherLine DO BEGIN
            IF "Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                Currency.GET("Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;
}

