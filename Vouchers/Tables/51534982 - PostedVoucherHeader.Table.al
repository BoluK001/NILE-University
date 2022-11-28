table 51534982 "Posted Voucher Header"
{
    DrillDownPageID = "Posted Voucher List";
    LookupPageID = "Posted Voucher List";

    fields
    {
        field(1; "Voucher Type"; Enum "Voucher Type")
        {
            // OptionCaption = 'JV,CPV,CRV,BPV,BRV,Contra,PettyCash';
            // OptionMembers = JV,CPV,CRV,BPV,BRV,Contra,PettyCash;
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; "Account Type"; Option)
        {
            Caption = '"Account Type"';
            OptionCaption = '"G/L Account",Customer,Vendor,"Bank Account",Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account"),
                                "Voucher Type" = CONST(JV)) "G/L Account" WHERE("Direct Posting" = FILTER(true))
            ELSE
            IF ("Account Type" = CONST(Customer),
                                         "Voucher Type" = CONST(JV)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor),
                                                  "Voucher Type" = CONST(JV)) Vendor
            ELSE
            IF ("Voucher Type" = CONST(CPV),
                                                           "Account Type" = CONST("Bank Account")) "Bank Account"."No." WHERE(Cash = CONST(true))
            ELSE
            IF ("Voucher Type" = CONST(CRV),
                                                                    "Account Type" = CONST("Bank Account")) "Bank Account"."No." WHERE(Cash = CONST(true))
            ELSE
            IF ("Voucher Type" = CONST(BPV),
                                                                             "Account Type" = CONST("Bank Account")) "Bank Account"."No." WHERE(Bank = CONST(true))
            ELSE
            IF ("Voucher Type" = CONST(BRV),
                                                                                      "Account Type" = CONST("Bank Account")) "Bank Account"."No." WHERE(Bank = CONST(true));
        }
        field(5; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            CalcFormula = Sum("Posted Voucher Line".Amount WHERE("Voucher Type" = FIELD("Voucher Type"),
                                                       "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Posted Voucher Line"."Amount (LCY)" WHERE("Voucher Type" = FIELD("Voucher Type"),
                                                       "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(16; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(17; Narration; Text[150])
        {
        }
        field(19; "Document Date"; Date)
        {
        }
        field(20; "Posting Date"; Date)
        {
        }
        field(21; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(23; "Exchange Rate"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(24; "External Document No."; Code[20])
        {
        }
        field(30; "Debit Amount"; Decimal)
        {
            CalcFormula = Sum("Posted Voucher Line"."Debit Amount" WHERE("Voucher Type" = FIELD("Voucher Type"), "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Credit Amount"; Decimal)
        {
            CalcFormula = Sum("Posted Voucher Line"."Credit Amount" WHERE("Voucher Type" = FIELD("Voucher Type"),
                                                       "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(51; "Posting No. Series"; Code[20])
        {
        }
        field(70; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(75; "Check Printed"; Boolean)
        {
            Caption = 'Check Printed';
            Editable = false;
        }
        field(76; "Source Code"; Code[20])
        {
        }
        field(100; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(101; "Created By Name"; Text[50])
        {
            Editable = false;
        }
        field(102; "Created Date"; Date)
        {
            Editable = false;
        }
        field(103; "Created Time"; Time)
        {
            Editable = false;
        }
        field(104; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(105; "Modified By Name"; Text[50])
        {
            Editable = false;
        }
        field(106; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(107; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(108; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(109; "Posted By Name"; Text[50])
        {
            Editable = false;
        }
        field(110; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(111; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(112; "Reference Voucher No."; Code[20])
        {
        }
        field(121; "Responsibilty Center"; Code[20])
        {
            TableRelation = "Responsibility Center";

            // trigger OnValidate()
            // begin
            //     //VALIDATE("Shortcut Dimension 1 Code", "Responsibility Center");
            //     UpdateVoucherLines(FIELDNO("Responsibility Center"));
            // end;
        }
        field(50000; "Expense Request No."; Code[20])
        {
        }
        field(50001; "Bank Receipt Type"; Option)
        {
            OptionMembers = " ","Advance Payment";
        }
        field(50002; "Teller / Cheque No."; Code[20])
        {
        }
        field(60000; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(60001; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(60002; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(60003; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(60004; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(60005; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(60006; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(60007; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(60008; PostedEntry; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."Document No." WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60009; "Line Account No."; Code[20])
        {
            CalcFormula = Lookup("Posted Voucher Line"."Account No." WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60010; "Line Account Name"; Code[100])
        {
            CalcFormula = Lookup("Posted Voucher Line"."Account Name" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60011; "Leave Payment"; boolean)
        {

        }
        field(60012; "Net Amount"; Decimal)
        {

        }
        field(60013; "Net Amount (LCY)"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Voucher Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You Cannot Delete Posted Voucher');

        PVLines.SETRANGE("Voucher Type", "Voucher Type");
        PVLines.SETRANGE("Document No.", "No.");
        IF PVLines.FIND('-') THEN
            PVLines.DELETEALL;
    end;

    var
        PVLines: Record "Posted Voucher Line";
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RespCenter: Record "Responsibility Center";

    [Scope('OnPrem')]
    procedure Navigate()
    var
        NavigatePage: Page Navigate;
    begin
        NavigatePage.SetDoc("Posting Date", "No.");
        NavigatePage.RUN;
    end;
    // local procedure UpdateVoucherLines(FieldRef: Integer)
    // var
    //     VoucherLine: Record "voucher Line";
    // begin
    //     VoucherLine.LOCKTABLE;
    //     VoucherLine.SETRANGE("Document No.", "No.");
    //     VoucherLine.SETFILTER("Account No.", '<>%1', '');
    //     IF VoucherLine.FIND('-') THEN BEGIN
    //         REPEAT
    //             CASE FieldRef OF
    //                 FIELDNO("Posting Date"):
    //                     VoucherLine.VALIDATE("Posting Date", "Posting Date");
    //                 FIELDNO(Status):
    //                     VoucherLine.VALIDATE(Status, Status);
    //                 FIELDNO("Shortcut Dimension 1 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
    //                 FIELDNO("Shortcut Dimension 2 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
    //                 FIELDNO("Shortcut Dimension 3 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
    //                 FIELDNO("Shortcut Dimension 4 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
    //                 FIELDNO("Shortcut Dimension 5 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
    //                 FIELDNO("Shortcut Dimension 6 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
    //                 FIELDNO("Shortcut Dimension 7 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
    //                 FIELDNO("Shortcut Dimension 8 Code"):
    //                     VoucherLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
    //                 FIELDNO("Currency Code"):
    //                     VoucherLine.VALIDATE("Currency Code", "Currency Code");
    //                 FIELDNO("Currency Factor"):
    //                     VoucherLine.VALIDATE("Currency Factor", "Currency Factor");
    //                 FIELDNO("Responsibility Center"):
    //                     VoucherLine.VALIDATE("Responsibility Center", "Responsibility Center");
    //                 FIELDNO("External Document No."):
    //                     VoucherLine.VALIDATE("External Document No.", "External Document No.");

    //             END;
    //             VoucherLine.MODIFY(TRUE);
    //         UNTIL VoucherLine.NEXT = 0;
    //     END;
    // end;


    // local procedure GetNoSeriesCode(): Code[20]
    // begin
    //     CASE "Voucher Type" OF
    //         "Voucher Type"::JV:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Journal Voucher Nos.")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."JV Nos." = '' THEN
    //                         EXIT(GLSetup."Journal Voucher Nos.")
    //                     ELSE
    //                         EXIT(RespCenter."JV Nos.")
    //                 END;
    //             END;

    //         "Voucher Type"::CRV:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Cash Receipt Voucher No")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."CRV Nos." = '' THEN
    //                         EXIT(GLSetup."Cash Receipt Voucher No")
    //                     ELSE
    //                         EXIT(RespCenter."CRV Nos.")
    //                 END;
    //             END;

    //         "Voucher Type"::BPV:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Bank Payment Voucher No")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."BPV Nos." = '' THEN
    //                         EXIT(GLSetup."Bank Payment Voucher No")
    //                     ELSE
    //                         EXIT(RespCenter."BPV Nos.")
    //                 END;
    //             END;

    //         "Voucher Type"::BRV:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Bank Receipt Voucher No")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."BRV Nos." = '' THEN
    //                         EXIT(GLSetup."Bank Receipt Voucher No")
    //                     ELSE
    //                         EXIT(RespCenter."BRV Nos.")
    //                 END;
    //             END;

    //         "Voucher Type"::CPV:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Cash Payment Voucher No")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."CPV Nos." = '' THEN
    //                         EXIT(GLSetup."Cash Payment Voucher No")
    //                     ELSE
    //                         EXIT(RespCenter."CPV Nos.")
    //                 END;
    //             END;


    //         "Voucher Type"::Contra:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Contra Voucher Nos.")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."Contra Voucher Nos." = '' THEN
    //                         EXIT(GLSetup."Contra Voucher Nos.")
    //                     ELSE
    //                         EXIT(RespCenter."Contra Voucher Nos.")
    //                 END;
    //             END;

    //         "Voucher Type"::PettyCash:
    //             BEGIN
    //                 IF "Responsibility Center" = '' THEN
    //                     EXIT(GLSetup."Petty Cash Voucher No")
    //                 ELSE BEGIN
    //                     RespCenter.GET("Responsibility Center");
    //                     IF RespCenter."Petty Cash Nos" = '' THEN
    //                         EXIT(GLSetup."Petty Cash Voucher No")
    //                     ELSE
    //                         EXIT(RespCenter."Petty Cash Nos")
    //                 END;
    //             END;



    //     END;

    // end;

    [Scope('OnPrem')]
    procedure ShowDocDim()
    var
        DocDim: Record "IC Document Dimension";
    begin
        CASE "Voucher Type" OF
            "Voucher Type"::JV:
                BEGIN
                    DocDim.SETRANGE("Table ID", DATABASE::"Posted Voucher Header");
                    //DocDim.SETRANGE("Document Type",DocDim."Document Type" :: JV);
                    DocDim.SETRANGE("Transaction No.");
                    DocDim.SETRANGE("Line No.", 0);
                END;
            "Voucher Type"::CPV:
                BEGIN
                    DocDim.SETRANGE("Table ID", DATABASE::"Posted Voucher Header");
                    //DocDim.SETRANGE("Voucher Type",DocDim."Document Type" :: CPV);
                    DocDim.SETRANGE("Transaction No.");
                    DocDim.SETRANGE("Line No.", 0);
                END;
            "Voucher Type"::CRV:
                BEGIN
                    DocDim.SETRANGE("Table ID", DATABASE::"Posted Voucher Header");
                    //DocDim.SETRANGE("Voucher Type",DocDim."Document Type" :: CRV);
                    DocDim.SETRANGE("Transaction No.");
                    DocDim.SETRANGE("Line No.", 0);
                END;
            "Voucher Type"::BPV:
                BEGIN
                    DocDim.SETRANGE("Table ID", DATABASE::"Posted Voucher Header");
                    //DocDim.SETRANGE("Voucher Type",DocDim."Document Type" :: BPV);
                    DocDim.SETRANGE("Transaction No.");
                    DocDim.SETRANGE("Line No.", 0);
                END;
            "Voucher Type"::BRV:
                BEGIN
                    DocDim.SETRANGE("Table ID", DATABASE::"Posted Voucher Header");
                    //DocDim.SETRANGE("Voucher Type",DocDim."Document Type" :: BRV);
                    DocDim.SETRANGE("Transaction No.");
                    DocDim.SETRANGE("Line No.", 0);
                END;

        END;
        //DocDims.DocDims.VALIDATESETTABLEVIEW(DocDim);
        //DocDims.RUNMODAL;
        GET("Voucher Type", "No.");
    end;
}

