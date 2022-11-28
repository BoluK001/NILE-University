codeunit 51534983 "Voucher Post"
{
    SingleInstance = true;
    TableNo = "Voucher Header";

    trigger OnRun()
    var
        TmpGenJrnlLine: Record "Gen. Journal Line";
        TmpGenJrnlLine2: Record "Gen. Journal Line" temporary;
    begin
        TESTFIELD(Status, Status::Released);
        TESTFIELD("Posting Date");
        PostedVoucherHeader.LOCKTABLE;

        PostedVoucherHeader.INIT;
        PostedVoucherHeader.TRANSFERFIELDS(Rec);
        PostedVoucherHeader."Posted By" := USERID;
        PostedVoucherHeader."Posted Date" := TODAY;
        PostedVoucherHeader."Posted Time" := TIME;
        PostedVoucherHeader."Reference Voucher No." := "No.";
        PostedVoucherHeader."No." := NoSeriesMgt.GetNextNo("Posting No. Series", "Posting Date", TRUE);
        PostedVoucherHeader."No." := "No.";
        CASE "Voucher Type" OF
            "Voucher Type"::JV:
                I := 7;
            "Voucher Type"::CPV:
                I := 8;
            "Voucher Type"::CRV:
                I := 9;
            "Voucher Type"::BPV:
                I := 10;
            "Voucher Type"::BRV:
                I := 11;
            "Voucher Type"::Contra:
                I := 12;
        END;

        PostedVoucherHeader.INSERT;

        VoucherLine.RESET;
        VoucherLine.SETRANGE("Voucher Type", "Voucher Type");
        VoucherLine.SETRANGE("Document No.", "No.");
        IF VoucherLine.FIND('-') THEN
            REPEAT
                PostedVoucherLine.TRANSFERFIELDS(VoucherLine);
                PostedVoucherLine."Document No." := PostedVoucherHeader."No.";
                PostedVoucherLine.INSERT;
                CASE "Voucher Type" OF
                    "Voucher Type"::JV:
                        I := 7;
                    "Voucher Type"::CPV:
                        I := 8;
                    "Voucher Type"::CRV:
                        I := 9;
                    "Voucher Type"::BPV:
                        I := 10;
                    "Voucher Type"::BRV:
                        I := 11;
                    "Voucher Type"::Contra:
                        I := 12;
                END;
            UNTIL VoucherLine.NEXT = 0;

        CASE "Voucher Type" OF
            "Voucher Type"::JV:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::JV);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN
                        REPEAT
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'JV');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'JV');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'JV');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'JV');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            IF VoucherLine."Debit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::JV);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                            GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                            GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                            GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");

                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'JV');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'JV');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

                    /*   //print report UNL
                       PostedVoucherHeader2 := PostedVoucherHeader;
                       PostedVoucherHeader2.SETRECFILTER;
                       REPORT.RUN(50049,FALSE,FALSE,PostedVoucherHeader2);
                       */
                    /*TempApprovalEntry.RESET;
                    TempApprovalEntry.DELETEALL;
                    ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                    ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: JV);
                    ApprovalEntry.SETRANGE("Document No.","No.");
                    IF ApprovalEntry.FINDSET THEN BEGIN
                      REPEAT
                        TempApprovalEntry.INIT;
                        TempApprovalEntry := ApprovalEntry;
                        TempApprovalEntry.INSERT;
                      UNTIL ApprovalEntry.NEXT = 0;
                    END;
                    ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                    ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",7,"No.");*/
                END;

            "Voucher Type"::CPV:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::CPV);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN BEGIN
                        REPEAT //Voucher Line G/L
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'CPV');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'CPV');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'CPV');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'CPV');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            IF "Account Type" = "Account Type"::Customer then
                                GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::" "//Dennis
                            else
                                GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment;
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            IF VoucherLine."Debit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CPV);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                            GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                            GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");

                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;

                        GenJrnlLine.INIT;
                        GenJrnlLine.VALIDATE("Journal Template Name", 'CPV');
                        GenJrnlLine.VALIDATE("Journal Batch Name", 'CPV');
                        GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        IF "Account Type" = "Account Type"::Customer then
                            GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::" "//Dennis
                        else
                            GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment;
                        GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        GenJrnlLine."Cheque No." := "Teller / Cheque No.";
                        CALCFIELDS("Amount (LCY)");
                        IF "Exchange Rate" <> 0 THEN
                            GenJrnlLine.VALIDATE(Amount, -("Amount (LCY)" / "Exchange Rate"));
                        CALCFIELDS("Amount (LCY)");
                        GenJrnlLine.VALIDATE("Amount (LCY)", -"Amount (LCY)");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        //GenJrnlLine.VALIDATE(Description,VoucherLine.Narration);
                        Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                        GenJrnlLine.VALIDATE(Description, Narr);
                        GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment; //Dennis
                        GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CPV);
                        GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                        /*GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type" ,VoucherLine."FA Posting Type");
                        GenJrnlLine.VALIDATE("FA Posting Date",VoucherLine."FA Posting Date");*/

                        GenJrnlLine.INSERT;
                    END;

                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'CPV');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'CPV');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);
                    Message('Posted Successfully');//Biyi

                    /*//print report UNL
                    PostedVoucherHeader2 := PostedVoucherHeader;
                    PostedVoucherHeader2.SETRECFILTER;
                    REPORT.RUN(50056,TRUE,FALSE,PostedVoucherHeader2);*/

                    /* TempApprovalEntry.RESET;
                     TempApprovalEntry.DELETEALL;
                     ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                     ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: CPV);
                     ApprovalEntry.SETRANGE("Document No.","No.");
                     IF ApprovalEntry.FINDSET THEN BEGIN
                       REPEAT
                         TempApprovalEntry.INIT;
                         TempApprovalEntry := ApprovalEntry;
                         TempApprovalEntry.INSERT;
                       UNTIL ApprovalEntry.NEXT = 0;
                     END;
                     ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                     ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",8,"No.");*/
                END;


            "Voucher Type"::BPV:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::BPV);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN BEGIN

                        // IF (VoucherLine."WHT Vendor Code" = '') and (VoucherLine."WHT Amount" = 0) then begin

                        //Without Withholding Tax
                        VoucherLine.Setfilter("WHT Vendor Code", '%1', '');
                        VoucherLine.Setrange("WHT Amount", 0);
                        If VoucherLine.Find('-') then begin
                            REPEAT
                                GenJrnlLine.RESET;
                                GenJrnlLine.SETRANGE("Journal Template Name", 'BPV');
                                GenJrnlLine.SETRANGE("Journal Batch Name", 'BPV');
                                GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                                IF GenJrnlLine.FIND('-') THEN
                                    GenJrnlLine.DELETEALL;
                                GenJrnlLine.RESET;
                                GenJrnlLine.INIT;
                                GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                                GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                                GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                                GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                                GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");

                                GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                                GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                                GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                                GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                                GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                                // IF VoucherLine."Debit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");

                                // IF VoucherLine."Credit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                                IF VoucherLine."Net Amount (LCY)" <> 0 THEN
                                    GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Net Amount (LCY)");
                                // IF VoucherLine.Net Amount(LCY) " <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Credit Amount", VoucherLine.Net Amount (LCY) ");

                                IF VoucherLine."Posting Group" <> '' THEN
                                    GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                                Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                                GenJrnlLine.VALIDATE(Description, Narr);
                                GenJrnlLine.VALIDATE("Source Code", "Source Code");
                                GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                                GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                //GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                                GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                                GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                                GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                                GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                                GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                                GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                                GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                                GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                                GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                                GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";

                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                                GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                                GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");
                                GenJrnlLine.INSERT;
                            UNTIL VoucherLine.NEXT = 0;
                        end;

                        // GenJrnlLine.INIT;
                        // GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                        // GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                        // GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        // GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        // GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        // GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        // GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        // GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        // GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        // GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        // GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        // GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                        // CALCFIELDS("Amount (LCY)");
                        // IF "Exchange Rate" <> 0 THEN
                        //     GenJrnlLine.VALIDATE(Amount, -("Amount (LCY)" / "Exchange Rate"));
                        // CALCFIELDS("Amount (LCY)");
                        // GenJrnlLine.VALIDATE("Amount (LCY)", -"Amount (LCY)");
                        // GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        // //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");

                        // Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                        // GenJrnlLine.VALIDATE(Description, Narr);
                        // GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        // GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        // GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                        // GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        // GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        // GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        // GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        // GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        // GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        // GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        // GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        // GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        // GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        // GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        // GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        // GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                        // GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                        // GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);

                        // /*GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type" ,VoucherLine."FA Posting Type");
                        // GenJrnlLine.VALIDATE("FA Posting Date",VoucherLine."FA Posting Date");*/

                        // GenJrnlLine.INSERT;
                        // end else begin
                        VoucherLine.Setfilter("WHT Vendor Code", '<>%1', '');
                        VoucherLine.Setfilter("WHT Amount", '<>%1', 0);
                        If VoucherLine.Find('-') then begin
                            REPEAT
                                GenJrnlLine.RESET;
                                GenJrnlLine.SETRANGE("Journal Template Name", 'BPV');
                                GenJrnlLine.SETRANGE("Journal Batch Name", 'BPV');
                                GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                                IF GenJrnlLine.FIND('-') THEN
                                    GenJrnlLine.DELETEALL;
                                GenJrnlLine.RESET;
                                GenJrnlLine.INIT;
                                GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                                GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                                GenJrnlLine.VALIDATE("Line No.", +10000);
                                GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                                GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                                GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                                GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");

                                // if VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::" ")
                                // else
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::Payment);

                                GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                                GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                                GenJrnlLine.VALIDATE("External Document No.", "External Document No.");

                                IF VoucherLine."Debit Amount" <> 0 THEN
                                    GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Net Amount");

                                // IF VoucherLine."Credit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Credit Amount", -VoucherLine."Net Amount");
                                IF VoucherLine."Posting Group" <> '' THEN
                                    GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE(Description, VoucherLine."Account Name");
                                Narr := COPYSTR(VoucherLine.Narration, 1, 100);
                                GenJrnlLine.VALIDATE(Description, Narr);
                                GenJrnlLine.VALIDATE("Source Code", "Source Code");
                                GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                                GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                                GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                                GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                                GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                                GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                                GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                                GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                                GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                                GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                                GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                                GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";

                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                                GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                                GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");
                                GenJrnlLine.INSERT;

                                //Debit Vendor WHT with WHT amount on the voucher Line Amount

                                //GenJrnlLine.RESET;
                                GenJrnlLine.INIT;
                                GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                                GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                                GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 1000);
                                GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                                GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                                // if VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::" ")
                                // else
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::Payment);


                                GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                                GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                                GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                                GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                                GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                                IF VoucherLine."Debit Amount" <> 0 THEN
                                    GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."WHT Amount");

                                // IF VoucherLine."Credit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Credit Amount", -VoucherLine."WHT Amount");
                                IF VoucherLine."Posting Group" <> '' THEN
                                    GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                                GenJrnlLine.VALIDATE("Narration 1", 'WithHolding Tax on' + ' ' + VoucherLine."Account Name");

                                //Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                                GenJrnlLine.VALIDATE(Description, 'WithHolding Tax on' + ' ' + VoucherLine."Account Name");
                                GenJrnlLine.VALIDATE("Source Code", "Source Code");
                                GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                                GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                                GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                                GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                                GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                                GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                                GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                                GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                                GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                                GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                                GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                                GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";

                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                                GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                                GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");
                                GenJrnlLine.INSERT;

                                //Credit WHT Vendor with  WHT Amount ON vOCUHER LINE
                                GenJrnlLine.INIT;
                                GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                                GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                                GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 1);
                                GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                                GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                                // if VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::" ")
                                // else
                                //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::Payment);

                                GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                                GenJrnlLine.VALIDATE("Account No.", VoucherLine."WHT Vendor Code");
                                GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                                GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                                GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                                // IF VoucherLine."Debit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."WHT Amount");

                                // IF VoucherLine."Credit Amount" <> 0 THEN
                                //     GenJrnlLine.VALIDATE("Credit Amount", -VoucherLine."WHT Amount");
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."WHT Amount");
                                IF VoucherLine."Posting Group" <> '' THEN
                                    GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE("Narration 1", 'WithHolding Tax on' + ' ' + VoucherLine."Account Name");

                                //Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                                GenJrnlLine.VALIDATE(Description, 'WithHolding Tax on' + ' ' + VoucherLine."Account Name");
                                GenJrnlLine.VALIDATE("Source Code", "Source Code");
                                GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                                GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                //GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                                GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                                GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                                GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                                GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                                GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                                GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                                GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                                GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                                GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                                GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                                GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";

                                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                                GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                                GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                                GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                                GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");
                                GenJrnlLine.INSERT;
                            UNTIL VoucherLine.NEXT = 0;
                        end;

                        //Header(Bank posting)
                        GenJrnlLine.INIT;
                        GenJrnlLine.VALIDATE("Journal Template Name", 'BPV');
                        GenJrnlLine.VALIDATE("Journal Batch Name", 'BPV');
                        GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                        CALCFIELDS("Net Amount");
                        IF "Exchange Rate" <> 0 THEN
                            GenJrnlLine.VALIDATE(Amount, -("Net Amount" / "Exchange Rate"));
                        CALCFIELDS("Net Amount");
                        GenJrnlLine.VALIDATE("Amount (LCY)", -"Net Amount");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                        // if VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                        //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::" ")
                        // else
                        //     GenJrnlLine.Validate("Document Type", GenJrnlLine."Document Type"::Payment);

                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        GenJrnlLine.VALIDATE(Description, VoucherLine.Narration);

                        GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BPV);
                        GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);

                        /*GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type" ,VoucherLine."FA Posting Type");
                        GenJrnlLine.VALIDATE("FA Posting Date",VoucherLine."FA Posting Date");*/

                        GenJrnlLine.INSERT;
                    end;
                    //END;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'BPV');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'BPV');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

                    /*//print report UNL
                    PostedVoucherHeader2 := PostedVoucherHeader;
                    PostedVoucherHeader2.SETRECFILTER;
                    REPORT.RUN(50058,TRUE,FALSE,PostedVoucherHeader2);*/


                    /* TempApprovalEntry.RESET;
                     TempApprovalEntry.DELETEALL;
                     ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                     ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: BPV);
                     ApprovalEntry.SETRANGE("Document No.","No.");
                     IF ApprovalEntry.FINDSET THEN BEGIN
                       REPEAT
                         TempApprovalEntry.INIT;
                         TempApprovalEntry := ApprovalEntry;
                         TempApprovalEntry.INSERT;
                       UNTIL ApprovalEntry.NEXT = 0;
                     END;
                     ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                     ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",10,"No.");*/
                END;

            "Voucher Type"::CRV:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::CRV);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN BEGIN
                        REPEAT
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'CRV');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'CRV');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'CRV');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'CRV');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            IF VoucherLine."Debit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CRV);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                            GenJrnlLine.VALIDATE("Applies-to ID", VoucherLine."Applies-to ID");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);

                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;
                        GenJrnlLine.INIT;
                        GenJrnlLine.VALIDATE("Journal Template Name", 'CRV');
                        GenJrnlLine.VALIDATE("Journal Batch Name", 'CRV');
                        GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        CALCFIELDS("Amount (LCY)");
                        IF "Exchange Rate" <> 0 THEN
                            GenJrnlLine.VALIDATE(Amount, -("Amount (LCY)" / "Exchange Rate"));
                        CALCFIELDS("Amount (LCY)");
                        GenJrnlLine.VALIDATE("Amount (LCY)", -"Amount (LCY)");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                        Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                        GenJrnlLine.VALIDATE(Description, Narr);
                        GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CRV);
                        GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                        GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        GenJrnlLine.VALIDATE("Applies-to ID", VoucherLine."Applies-to ID");

                        GenJrnlLine.INSERT;
                    END;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'CRV');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'CRV');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

                    /* //print report UNL
                     PostedVoucherHeader2 := PostedVoucherHeader;
                     PostedVoucherHeader2.SETRECFILTER;
                     REPORT.RUN(50055,TRUE,FALSE,PostedVoucherHeader2);*/

                    /* TempApprovalEntry.RESET;
                     TempApprovalEntry.DELETEALL;
                     ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                     ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: CRV);
                     ApprovalEntry.SETRANGE("Document No.","No.");
                     IF ApprovalEntry.FINDSET THEN BEGIN
                       REPEAT
                         TempApprovalEntry.INIT;
                         TempApprovalEntry := ApprovalEntry;
                         TempApprovalEntry.INSERT;
                       UNTIL ApprovalEntry.NEXT = 0;
                     END;
                     ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                     ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",9,"No.");*/
                END;

            "Voucher Type"::BRV:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::BRV);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN BEGIN
                        REPEAT
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'BRV');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'BRV');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'BRV');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'BRV');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";

                            IF VoucherLine."Net Amount (LCY)" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Amount (LCY)");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BRV);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                            GenJrnlLine.VALIDATE("Applies-to ID", VoucherLine."Applies-to ID");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);

                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;
                        GenJrnlLine.RESET;
                        GenJrnlLine.INIT;
                        GenJrnlLine.VALIDATE("Journal Template Name", 'BRV');
                        GenJrnlLine.VALIDATE("Journal Batch Name", 'BRV');
                        GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                        CALCFIELDS("Amount (LCY)");

                        IF "Exchange Rate" <> 0 THEN
                            GenJrnlLine.VALIDATE(Amount, -("Amount (LCY)" / "Exchange Rate"));
                        CALCFIELDS("Amount (LCY)");
                        GenJrnlLine.VALIDATE("Amount (LCY)", -"Amount (LCY)");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                        Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                        GenJrnlLine.VALIDATE(Description, Narr);
                        GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::BRV);
                        GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                        GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        GenJrnlLine.VALIDATE("Applies-to ID", VoucherLine."Applies-to ID");
                        GenJrnlLine.INSERT;
                    END;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'BRV');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'BRV');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

                    //print report UNL
                    /* PostedVoucherHeader2 := PostedVoucherHeader;
                     PostedVoucherHeader2.SETRECFILTER;
                     REPORT.RUN(50057,TRUE,FALSE,PostedVoucherHeader2);*/


                    /*TempApprovalEntry.RESET;
                    TempApprovalEntry.DELETEALL;
                    ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                    ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: BRV);
                    ApprovalEntry.SETRANGE("Document No.","No.");
                    IF ApprovalEntry.FINDSET THEN BEGIN
                      REPEAT
                        TempApprovalEntry.INIT;
                        TempApprovalEntry := ApprovalEntry;
                        TempApprovalEntry.INSERT;
                      UNTIL ApprovalEntry.NEXT = 0;
                    END;
                    ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                    ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",11,"No.");*/
                END;

            "Voucher Type"::Contra:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::Contra);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN
                        REPEAT
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'CONTRA');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'CONTRA');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'CONTRA');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'CONTRA');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            IF VoucherLine."Debit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Bal. Account Type", GenJrnlLine."Bal. Account Type"::Vendor);
                            GenJrnlLine.VALIDATE("Bal. Account No.", VoucherLine."Bal. Account No.");
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CONTRA);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'CONTRA');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'CONTRA');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);
                    TempApprovalEntry.RESET;
                    TempApprovalEntry.DELETEALL;
                    ApprovalEntry.SETRANGE("Table ID", DATABASE::"Voucher Header");
                    //ApprovalEntry.SETRANGE("Document Type", ApprovalEntry."Document Type"::"15");
                    ApprovalEntry.SETRANGE("Document No.", "No.");
                    IF ApprovalEntry.FINDSET THEN BEGIN
                        REPEAT
                            TempApprovalEntry.INIT;
                            TempApprovalEntry := ApprovalEntry;
                            TempApprovalEntry.INSERT;
                        UNTIL ApprovalEntry.NEXT = 0;
                    END;
                    //ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                    // ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",11,"No.");
                END;

            "Voucher Type"::PettyCash:
                BEGIN
                    VoucherLine.RESET;
                    VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::PettyCash);
                    VoucherLine.SETRANGE("Document No.", "No.");
                    IF VoucherLine.FIND('-') THEN BEGIN
                        REPEAT //Voucher Line G/L
                            GenJrnlLine.RESET;
                            GenJrnlLine.SETRANGE("Journal Template Name", 'PettyCash');
                            GenJrnlLine.SETRANGE("Journal Batch Name", 'PettyCash');
                            GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                            IF GenJrnlLine.FIND('-') THEN
                                GenJrnlLine.DELETEALL;
                            GenJrnlLine.RESET;
                            GenJrnlLine.INIT;
                            GenJrnlLine.VALIDATE("Journal Template Name", 'PettyCash');
                            GenJrnlLine.VALIDATE("Journal Batch Name", 'PettyCash');
                            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                            GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
                            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                            GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                            IF VoucherLine."Debit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Debit Amount", VoucherLine."Debit Amount");
                            IF VoucherLine."Credit Amount" <> 0 THEN
                                GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                            IF VoucherLine."Posting Group" <> '' THEN
                                GenJrnlLine.VALIDATE("Posting Group", VoucherLine."Posting Group");
                            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                            //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                            GenJrnlLine.VALIDATE(Description, Narr);
                            GenJrnlLine.VALIDATE("Source Code", "Source Code");
                            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::PETTYCASH);
                            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");

                            GenJrnlLine.INSERT;
                        UNTIL VoucherLine.NEXT = 0;
                        GenJrnlLine.INIT;
                        GenJrnlLine.VALIDATE("Journal Template Name", 'PettyCash');
                        GenJrnlLine.VALIDATE("Journal Batch Name", 'PettyCash');
                        GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
                        GenJrnlLine.VALIDATE("Posting Date", "Posting Date");
                        GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                        GenJrnlLine.VALIDATE("Account Type", "Account Type");
                        GenJrnlLine.VALIDATE("Account No.", "Account No.");
                        GenJrnlLine.VALIDATE("Currency Code", "Currency Code");
                        GenJrnlLine.VALIDATE("Currency Factor", "Currency Factor");
                        GenJrnlLine.VALIDATE("External Document No.", "External Document No.");
                        GenJrnlLine."Responsibility Center" := "Responsibility Center";
                        GenJrnlLine."Cheque No." := "Teller / Cheque No.";

                        CALCFIELDS("Amount (LCY)");
                        IF "Exchange Rate" <> 0 THEN
                            GenJrnlLine.VALIDATE(Amount, -("Amount (LCY)" / "Exchange Rate"));
                        CALCFIELDS("Amount (LCY)");
                        GenJrnlLine.VALIDATE("Amount (LCY)", -"Amount (LCY)");
                        GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                        //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                        Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                        GenJrnlLine.VALIDATE(Description, Narr);
                        GenJrnlLine.VALIDATE("Source Code", "Source Code");
                        GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                        GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::PETTYCASH);
                        GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                        GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                        GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                        GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                        GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                        GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                        GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                        GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                        GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                        GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                        GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                        GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                        GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                        GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");

                        GenJrnlLine.INSERT;
                    END;
                    GenJrnlLine.RESET;
                    GenJrnlLine.SETRANGE("Journal Template Name", 'PettyCash');
                    GenJrnlLine.SETRANGE("Journal Batch Name", 'PettyCash');
                    GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

                    //print report UNL
                    PostedVoucherHeader2 := PostedVoucherHeader;
                    PostedVoucherHeader2.SETRECFILTER;
                    REPORT.RUN(50056, TRUE, FALSE, PostedVoucherHeader2);

                    /*  TempApprovalEntry.RESET;
                      TempApprovalEntry.DELETEALL;
                      ApprovalEntry.SETRANGE("Table ID",DATABASE::"Voucher Header");
                      ApprovalEntry.SETRANGE("Document Type",ApprovalEntry."Document Type" :: PettyCash);
                      ApprovalEntry.SETRANGE("Document No.","No.");
                      IF ApprovalEntry.FINDSET THEN BEGIN
                        REPEAT
                          TempApprovalEntry.INIT;
                          TempApprovalEntry := ApprovalEntry;
                          TempApprovalEntry.INSERT;
                        UNTIL ApprovalEntry.NEXT = 0;
                      END;
                      ApprovalMgt.MoveApprvalEntryToPosted(TempApprovalEntry,DATABASE::"Posted Voucher Header",PostedVoucherHeader."No.");
                      ApprovalMgt.DeleteApprovalEntry(DATABASE::"Voucher Header",8,"No.");*/
                END;
        END;

        //

        //

        DELETE(TRUE);
        COMMIT;

    end;

    var
        PostedVoucherHeader: Record "Posted Voucher Header";
        VoucherLine: Record "Voucher Line";
        PostedVoucherLine: Record "Posted Voucher Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        TempJnlLineDim: Record "Dimension Set Entry" temporary;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJrnlLine: Record "Gen. Journal Line";
        ApprovalEntry: Record "Approval Entry";
        TempApprovalEntry: Record "Approval Entry" temporary;
        DimMgt: Codeunit 408;
        I: Integer;
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        Text001: Label 'Voucher Successfully Posted';
        PostedVoucherHeader2: Record "Posted Voucher Header";
        Narr: Text[50];

    Local procedure WithHoldingTax()
    begin

        VoucherLine.RESET;
        VoucherLine.SETRANGE("Voucher Type", VoucherLine."Voucher Type"::CPV);
        VoucherLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
        IF VoucherLine.FIND('-') THEN BEGIN
            REPEAT //Voucher Line G/L
                GenJrnlLine.RESET;
                GenJrnlLine.SETRANGE("Journal Template Name", 'CPV');
                GenJrnlLine.SETRANGE("Journal Batch Name", 'CPV');
                GenJrnlLine.SETFILTER(Amount, '=%1', 0);
                IF GenJrnlLine.FIND('-') THEN
                    GenJrnlLine.DELETEALL;
                GenJrnlLine.RESET;
                GenJrnlLine.INIT;
                GenJrnlLine.VALIDATE("Journal Template Name", 'CPV');
                GenJrnlLine.VALIDATE("Journal Batch Name", 'CPV');
                GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No.");
                GenJrnlLine.VALIDATE("Posting Date", VoucherLine."Posting Date");
                GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
                GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
                IF VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                    GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::" "//Dennis
                else
                    GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment;
                GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
                GenJrnlLine.VALIDATE("Account No.", VoucherLine."W/Tax Code");
                GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
                GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
                GenJrnlLine.VALIDATE("External Document No.", VoucherLine."External Document No.");
                //IF VoucherLine."Debit Amount" <> 0 THEN
                GenJrnlLine.VALIDATE(Amount, VoucherLine."WHT Amount");

                //IF VoucherLine."Credit Amount" <> 0 THEN
                //  GenJrnlLine.VALIDATE("Credit Amount", VoucherLine."Credit Amount");
                //IF VoucherLine."Posting Group" <> '' THEN
                //  GenJrnlLine.VALIDATE("Posting Group", VoucherLine."WHT Posting Group");
                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration + '(With Holding Tax)');
                //GenJrnlLine.VALIDATE(Description,VoucherLine."Account Name");
                Narr := COPYSTR(VoucherLine.Narration, 1, 50);
                GenJrnlLine.VALIDATE(Description, Narr + '[With Holding Tax]');
                GenJrnlLine.VALIDATE("Source Code", VoucherLine."Source Code");
                GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
                GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CPV);
                GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
                GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
                GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
                GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
                GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
                GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
                GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
                GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
                GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
                GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
                GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
                GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
                GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
                GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
                GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
                GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration);
                GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type", VoucherLine."FA Posting Type");
                GenJrnlLine.VALIDATE("FA Posting Date", VoucherLine."FA Posting Date");
                GenJrnlLine.VALIDATE("Depreciation Book Code", VoucherLine."Depreciation Book Code");

                GenJrnlLine.INSERT;
            UNTIL VoucherLine.NEXT = 0;

            GenJrnlLine.INIT;
            GenJrnlLine.VALIDATE("Journal Template Name", 'CPV');
            GenJrnlLine.VALIDATE("Journal Batch Name", 'CPV');
            GenJrnlLine.VALIDATE("Line No.", VoucherLine."Line No." + 10000);
            GenJrnlLine.VALIDATE("Posting Date", VoucherLine."Posting Date");
            GenJrnlLine.VALIDATE("Document No.", PostedVoucherHeader."No.");
            IF VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::" "//Dennis
            else
                GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment;
            GenJrnlLine.VALIDATE("Account Type", VoucherLine."Account Type");
            GenJrnlLine.VALIDATE("Account No.", VoucherLine."Account No.");
            GenJrnlLine.VALIDATE("Currency Code", VoucherLine."Currency Code");
            GenJrnlLine.VALIDATE("Currency Factor", VoucherLine."Currency Factor");
            GenJrnlLine.VALIDATE("External Document No.", VoucherLine."External Document No.");
            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
            GenJrnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
            VoucherLine.CALCFIELDS("Amount (LCY)");
            IF VoucherLine."Exchange Rate" <> 0 THEN
                GenJrnlLine.VALIDATE(Amount, -(VoucherLine."WHT Amount"));
            VoucherLine.CALCFIELDS("Amount (LCY)");
            GenJrnlLine.VALIDATE("Amount (LCY)", -VoucherLine."Amount (LCY)");
            GenJrnlLine.VALIDATE("Narration 1", VoucherLine.Narration + '[With Holding Tax]');
            //GenJrnlLine.VALIDATE(Description,VoucherLine.Narration);
            Narr := COPYSTR(VoucherLine.Narration, 1, 50);
            GenJrnlLine.VALIDATE(Description, Narr + '[With Holding Tax]');
            GenJrnlLine.VALIDATE("Source Code", VoucherLine."Source Code");
            GenJrnlLine."Document Type" := GenJrnlLine."Document Type"::Payment; //Dennis
            GenJrnlLine."Responsibility Center" := VoucherLine."Responsibility Center";
            GenJrnlLine.VALIDATE("Voucher Type", GenJrnlLine."Voucher Type"::CPV);
            GenJrnlLine."Created By Name" := PostedVoucherHeader."Created By Name";
            GenJrnlLine."Created Date" := PostedVoucherHeader."Created Date";
            GenJrnlLine."Created Time" := PostedVoucherHeader."Created Time";
            GenJrnlLine."Modified By" := PostedVoucherHeader."Modified By";
            GenJrnlLine."Modified By Name" := PostedVoucherHeader."Modified By Name";
            GenJrnlLine."Modified Date" := PostedVoucherHeader."Modified Date";
            GenJrnlLine."Modified Time" := PostedVoucherHeader."Modified Time";
            GenJrnlLine."Posted By" := PostedVoucherHeader."Posted By";
            GenJrnlLine."Posted By Name" := PostedVoucherHeader."Posted By Name";
            GenJrnlLine."Posted Date" := PostedVoucherHeader."Posted Date";
            GenJrnlLine."Posted Time" := PostedVoucherHeader."Posted Time";
            GenJrnlLine.VALIDATE("Applies-to Doc. Type", VoucherLine."Applies-to Doc. Type");
            GenJrnlLine.VALIDATE("Applies-to Doc. No.", VoucherLine."Applies-to Doc. No.");
            GenJrnlLine.VALIDATE("Shortcut Dimension 1 Code", VoucherLine."Shortcut Dimension 1 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 2 Code", VoucherLine."Shortcut Dimension 2 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 3 Code", VoucherLine."Shortcut Dimension 3 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 4 Code", VoucherLine."Shortcut Dimension 4 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 5 Code", VoucherLine."Shortcut Dimension 5 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 6 Code", VoucherLine."Shortcut Dimension 6 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 7 Code", VoucherLine."Shortcut Dimension 7 Code");
            GenJrnlLine.VALIDATE("Shortcut Dimension 8 Code", VoucherLine."Shortcut Dimension 8 Code");
            /*GenJrnlLine.VALIDATE(GenJrnlLine."FA Posting Type" ,VoucherLine."FA Posting Type");
          GenJrnlLine.VALIDATE("FA Posting Date",VoucherLine."FA Posting Date");*/

            GenJrnlLine.INSERT;
        END;

        GenJrnlLine.RESET;
        GenJrnlLine.SETRANGE("Journal Template Name", 'CPV');
        GenJrnlLine.SETRANGE("Journal Batch Name", 'CPV');
        GenJrnlLine.SETRANGE("Document No.", PostedVoucherHeader."No.");
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJrnlLine);

    end;

    local procedure WithHoldingTaxX()
    var
        WHTSetup: Record "With-Holding Tax Setup";
        GenJnlLine: Record "Gen. Journal Line";
        strText: Text[100];
    begin
        //POST W/TAX to Respective W/TAX GL Account
        WHTSetup.RESET;
        WHTSetup.SETRANGE(Code, VoucherLine."W/Tax Code");
        IF WHTSetup.FIND('-') THEN BEGIN
            WHTSetup.TESTFIELD("Account No.");
            LineNo := LineNo + 1000;
            GenJnlLine.INIT;
            GenJrnlLine.SETRANGE("Journal Template Name", 'BPV');
            GenJrnlLine.SETRANGE("Journal Batch Name", 'BPV');
            GenJnlLine.VALIDATE("Source Code", VoucherLine."Source Code");
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := VoucherLine."Posting Date";

            IF VoucherLine."Account Type" = VoucherLine."Account Type"::Customer then
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
            else
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

            GenJnlLine."Document No." := VoucherLine."Document No.";
            GenJnlLine."Cheque No." := VoucherLine."Teller / Cheque No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := WHTSetup."Account No.";
            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := VoucherLine."Currency Code";
            GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor" := VoucherLine."Currency Factor";
            GenJnlLine.VALIDATE("Currency Factor");

            GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
            GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
            GenJnlLine."Gen. Bus. Posting Group" := '';
            GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
            GenJnlLine."Gen. Prod. Posting Group" := '';
            GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
            GenJnlLine."VAT Bus. Posting Group" := '';
            GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
            GenJnlLine."VAT Prod. Posting Group" := '';
            GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
            GenJnlLine.Amount := -VoucherLine."WHT Amount";
            GenJnlLine.VALIDATE(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '';
            GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
            GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(VoucherLine.Narration) + '::' + strText, 1, 50);
            GenJnlLine.ValidateShortcutDimCode(1, VoucherLine."Shortcut Dimension 1 Code");
            GenJnlLine.ValidateShortcutDimCode(2, VoucherLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, VoucherLine."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, VoucherLine."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5, VoucherLine."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6, VoucherLine."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7, VoucherLine."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8, VoucherLine."Shortcut Dimension 8 Code");
            IF GenJnlLine.Amount <> 0 THEN
                GenJnlLine.INSERT;
        END;

    end;


}

