table 51534713 "Staff Advance Surrender Header"
{
    //DrillDownPageID = "Staff Advance Surrender List";
    //LookupPageID = "Staff Advance Surrender List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    //  GenLedgerSetup.GET;
                    NoSeriesMgt.TestManual("No. Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Surrender Date"; Date)
        {
        }
        field(3; Type; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code WHERE(Type = FILTER(Payment));

            trigger OnValidate()
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset;
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if RecPayTypes.Find('-') then begin
                    Grouping := RecPayTypes."Default Grouping";
                end;

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    "Transaction Name" := RecPayTypes.Description;

                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then begin
                        RecPayTypes.TestField(RecPayTypes."Account No.");
                        "Account No." := RecPayTypes."Account No.";
                        Validate("Account No.");
                    end;

                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"Bank Account" then begin
                        //RecPayTypes.TESTFIELD(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."Bank Account";
                        Validate("Account No.");
                    end;


                end;

                //VALIDATE("Account No.");
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT';
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(5; "Cheque No"; Code[20])
        {
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; "Cheque Type"; Code[20])
        {
            TableRelation = "Public Holidays";
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
        }
        field(12; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Employee,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee,"IC Partner";
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                /*
                "Account Name":='';
                RecPayTypes.RESET;
                RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                
                IF "Account Type" IN ["Account Type"::"G/L Account","Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"]
                THEN
                
                CASE "Account Type" OF
                  "Account Type"::"G/L Account":
                    BEGIN
                      GLAcc.GET("Account No.");
                      "Account Name":=GLAcc.Name;
                      "VAT Code":=RecPayTypes."VAT Code";
                      "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":='';
                    END;
                  "Account Type"::Customer:
                    BEGIN
                      Cust.GET("Account No.");
                      "Account Name":=Cust.Name;
                //      "VAT Code":=Cust."Default Withholding Tax Code";
                //      "Withholding Tax Code":=Cust."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    END;
                  "Account Type"::Vendor:
                    BEGIN
                      Vend.GET("Account No.");
                      "Account Name":=Vend.Name;
                //      "VAT Code":=Vend."Default VAT Code";
                //      "Withholding Tax Code":=Vend."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                    END;
                  "Account Type"::"Bank Account":
                    BEGIN
                      BankAcc.GET("Account No.");
                      "Account Name":=BankAcc.Name;
                      "VAT Code":=RecPayTypes."VAT Code";
                      "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                
                    END;
                    {
                  "Account Type"::"Fixed Asset":
                    BEGIN
                      FA.GET("Account No.");
                      "Account Name":=FA.Description;
                      "VAT Code":=FA."Default VAT Code";
                      "Withholding Tax Code":=FA."Default Withholding Tax Code";
                       "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    END;
                    }
                END;
                */

            end;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[50])
        {
        }
        field(20; Amount; Decimal)
        {
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(27; "Net Amount"; Decimal)
        {
        }
        field(28; "Paying Bank Account"; Code[20])
        {
        }
        field(29; Payee; Text[100])
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin

                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(33; "Bank Account No"; Code[20])
        {
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
        }
        field(35; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Posted,Approved,Cancelled;
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(39; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(44; "Imprest Issue Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "Imprest Issue Doc. No"; Code[20])
        {
            Caption = 'Advance Issue Doc. No';
            TableRelation = "Staff Advance Header"."No." WHERE(Posted = CONST(true),
                                                                "Account No." = FIELD("Account No."),
                                                                "Surrender Status" = CONST(" "));

            trigger OnLookup()
            begin
                AdvHeader.Reset;
                //"Staff Advance Header".No. WHERE (Posted=CONST(True),Account "No."=FIELD(Account No.),Surrender Status=CONST(" "))
                AdvHeader.SetRange(AdvHeader."Account No.", "Account No.");
                AdvHeader.SetRange(AdvHeader."Surrender Status", AdvHeader."Surrender Status"::" ");
                if PAGE.RunModal(51534813, AdvHeader) = ACTION::LookupOK then
                    Validate("Imprest Issue Doc. No", AdvHeader."No.");
            end;

            trigger OnValidate()
            begin


                /*Copy the details from the payments header tableto the imprest surrender table to enable the user work on the same document*/
                /*Retrieve the header details using the get statement*/
                //delete any existing lines

                ImpSurrLine.Reset;
                ImpSurrLine.SetRange(ImpSurrLine."Surrender Doc No.", "No.");
                ImpSurrLine.DeleteAll;

                PayHeader.Reset;
                if not PayHeader.Get(Rec."Imprest Issue Doc. No") then exit;
                /*Copy the details to the user interface*/
                "Paying Bank Account" := PayHeader."Paying Bank Account";
                Payee := PayHeader.Payee;
                PayHeader.CalcFields(PayHeader."Total Net Amount");
                Amount := PayHeader."Total Net Amount";
                "Amount Surrendered LCY" := PayHeader."Total Net Amount LCY";
                //Currencies
                "Currency Factor" := PayHeader."Currency Factor";
                "Currency Code" := PayHeader."Currency Code";

                "Date Posted" := PayHeader."Date Posted";
                "Global Dimension 1 Code" := PayHeader."Shortcut Dimension 1 Code";
                Validate("Global Dimension 1 Code");
                "Shortcut Dimension 2 Code" := PayHeader."Shortcut Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
                "Shortcut Dimension 3 Code" := PayHeader."Shortcut Dimension 3 Code";
                Dim3 := PayHeader.Dim3;
                "Shortcut Dimension 4 Code" := PayHeader."Shortcut Dimension 4 Code";

                "Imprest Issue Date" := PayHeader.Date;
                "Responsibility Center" := PayHeader."Responsibility Center";


                //Get Line No
                if ImpSurrLine.FindLast then
                    LineNo := ImpSurrLine."Line No." + 1
                else
                    LineNo := LineNo + 1;

                /*Copy the detail lines from the imprest details table in the database*/
                PayLine.Reset;
                PayLine.SetRange(PayLine."No.", "Imprest Issue Doc. No");
                if PayLine.Find('-') then /*Copy the lines to the line table in the database*/
                  begin
                    repeat
                        ImpSurrLine.Init;
                        ImpSurrLine."Surrender Doc No." := Rec."No.";
                        ImpSurrLine."Account No." := PayLine."Account No.";
                        ImpSurrLine."Imprest Type" := PayLine."Advance Type";
                        ImpSurrLine."Account Type" := PayLine."Account Type";
                        ImpSurrLine.Grouping := PayLine.Grouping;
                        ImpSurrLine.Validate(ImpSurrLine."Account No.");
                        //ImpSurrLine."Account Name":=PayLine."Account Name";
                        ImpSurrLine.Amount := PayLine.Amount;
                        ImpSurrLine."Due Date" := PayLine."Due Date";
                        ImpSurrLine."Advance Holder" := "Account No.";//PayLine."Advance Holder";
                        ImpSurrLine."Actual Spent" := PayLine."Actual Spent";
                        ImpSurrLine."Apply to" := PayLine."Apply to";
                        ImpSurrLine."Apply to ID" := PayLine."Apply to ID";
                        ImpSurrLine."Surrender Date" := PayLine."Surrender Date";
                        ImpSurrLine.Surrendered := PayLine.Surrendered;
                        ImpSurrLine."Cash Receipt No" := PayLine."M.R. No";
                        ImpSurrLine."Date Issued" := PayLine."Date Issued";
                        ImpSurrLine."Type of Surrender" := PayLine."Type of Surrender";
                        ImpSurrLine."Dept. Vch. No." := PayLine."Dept. Vch. No.";
                        ImpSurrLine."Currency Factor" := PayLine."Currency Factor";
                        ImpSurrLine."Currency Code" := PayLine."Currency Code";
                        ImpSurrLine."Imprest Req Amt LCY" := PayLine."Amount LCY";
                        ImpSurrLine."Budgetary Control A/C" := PayLine."Budgetary Control A/C";
                        ImpSurrLine."Shortcut Dimension 1 Code" := PayLine."Shortcut Dimension 1 Code";
                        ImpSurrLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                        ImpSurrLine."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
                        ImpSurrLine."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
                        ImpSurrLine."Line on Original Document" := true;
                        LineNo += 1;
                        ImpSurrLine."Line No." := LineNo;
                        ImpSurrLine.Insert;
                    until PayLine.Next = 0;
                end;

            end;
        }
        field(47; "Vote Book"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(48; "Total Allocation"; Decimal)
        {
        }
        field(49; "Total Expenditure"; Decimal)
        {
        }
        field(50; "Total Commitments"; Decimal)
        {
        }
        field(51; Balance; Decimal)
        {
        }
        field(52; "Balance Less this Entry"; Decimal)
        {
        }
        field(54; "Petty Cash"; Boolean)
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(59; "Function Name"; Text[50])
        {
        }
        field(60; "Budget Center Name"; Text[50])
        {
        }
        field(61; "User ID"; Code[50])
        {
            TableRelation = User."User Security ID";
        }
        field(62; "Issue Voucher Type"; Option)
        {
            OptionMembers = " ","Cash Voucher","Payment Voucher";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 3);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 4);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(86; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                /*
               TESTFIELD(Status,Status::Open,);
               IF NOT UserMgt.CheckRespCenter(1,"Shortcut Dimension 3 Code") THEN
                 ERROR(
                   Text001,
                   RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                 */

            end;
        }
        field(88; "Amount Surrendered LCY"; Decimal)
        {
            CalcFormula = Sum("Imprest Surrender Details"."Imprest Req Amt LCY" WHERE("Surrender Doc No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(89; "Actual Spent"; Decimal)
        {
            CalcFormula = Sum("Staff Advanc Surrender Details"."Actual Spent" WHERE("Surrender Doc No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(90; "No. Printed"; Integer)
        {
        }
        field(91; "Surrender Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                //Changed to ensure Posting date is not less than the Surrender Date entered
                //COMMENTED BY LK TO CATER FOR AGL MOTORS LATE POSTING
                /* IF "Surrender Posting Date"<"Surrender Date" THEN
                    ERROR('The Surrender Posting Date cannot be lesser than the Surrender Date');
                */

            end;
        }
        field(92; "Total Amount Advanced"; Decimal)
        {
        }
        field(95; "Allow Overexpenditure"; Boolean)
        {
            Editable = false;
        }
        field(96; "Open for Overexpenditure by"; Code[50])
        {
            Editable = false;
        }
        field(97; "Date opened for OvExpenditure"; Date)
        {
            Editable = false;
        }
        field(98; "Cash Receipt Amount"; Decimal)
        {
            CalcFormula = Sum("Staff Advanc Surrender Details"."Cash Receipt Amount" WHERE("Surrender Doc No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(99; "Actual Amount (LCY)"; Decimal)
        {
            CalcFormula = Sum("Staff Advanc Surrender Details"."Amount LCY" WHERE("Surrender Doc No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(100; "Commitment Status"; Boolean)
        {
        }
        field(101; Difference; Decimal)
        {
            CalcFormula = Sum("Staff Advanc Surrender Details".Difference WHERE("Surrender Doc No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(102; "Amount on Original Document"; Decimal)
        {
            Description = 'Inserted when document is sent for approval';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
        field(50001; Description2; Text[100])
        {
        }
        field(50003; "Group Head"; Code[20])
        {
            // TableRelation = "Group Head Approval";
        }
        field(50004; Narration; Text[100])
        {
        }
        field(50005; "Advance Narration"; Text[100])
        {
            TableRelation = "Staff Advance Header".Purpose;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // IF  Status=Status::Posted THEN
        Error('Cannot Delete Document is already Posted');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin

            GenLedgerSetup.Get;
            TestNoSeries;
            //NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, No, "No. Series");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Staff Advance Surrender No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        //"Account Type" := "Account Type"::Customer;
        "Account Type" := "Account Type"::Employee;
        "Surrender Date" := Today;
        Cashier := UserId;
        Validate(Cashier);

        //     if UserSetup.Get(UserId) then begin
        //         UserSetup.TestField("Staff Travel Account");
        //         "Account No." := UserSetup."Staff Travel Account";
        //         Validate("Account No.");
        //     end else
        //         Error('User must be setup under User Setup and their respective Account Entered');
    end;

    trigger OnModify()
    begin
        if Status = Status::Posted then
            Error('Cannot Modify Document is already Posted');
    end;

    var
        ImpSurrLine: Record "Staff Advanc Surrender Details";
        PayHeader: Record "Staff Advance Header";
        PayLine: Record "Staff Advance Lines";
        "Withholding Tax Code": Code[200];
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit 396;
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        CashierLinks: Record "Cash Office User Template";
        GLAccount: Record "G/L Account";
        EntryNo: Integer;
        SingleMonth: Boolean;
        DateFrom: Date;
        DateTo: Date;
        Budget: Decimal;
        CurrMonth: Code[20];
        CurrYR: Code[20];
        BudgDate: Text[30];
        BudgetDate: Date;
        YrBudget: Decimal;
        BudgetDateTo: Date;
        BudgetAvailable: Decimal;
        GenLedSetup: Record "Cash Office Setup";
        "Total Budget": Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        //LoadImprestDetails: Record "Cash Voucher Line";
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        "VAT Code": Code[20];
        RespCenter: Record "Responsibility Center";
        UserMgt: Codeunit "User Setup Management";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        LineNo: Integer;
        UserSetup: Record "User Setup";
        DimMgt: Codeunit 408;
        AdvHeader: Record "Staff Advance Header";

    local procedure TestNoSeries(): Boolean
    begin
        if "Payment Type" = "Payment Type"::Normal then
            GenLedgerSetup.TestField(GenLedgerSetup."Staff Advance Surrender No.")
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSrsRel: Record "No. Series Relationship";
        NoSeriesCode: Code[20];
    begin
        if "Payment Type" = "Payment Type"::Normal then
            NoSeriesCode := GenLedgerSetup."Staff Advance Surrender No.";
        /*
        NoSrsRel.SETRANGE(NoSrsRel.Code,NoSeriesCode);
        //NoSrsRel.SETRANGE(NoSrsRel."Responsibility Center","Responsibility Center");
        IF NoSrsRel.FINDFIRST THEN
        EXIT(NoSrsRel."Series Code")
        ELSE
        EXIT(NoSeriesCode);
        
        IF NoSrsRel.FINDSET THEN BEGIN
          IF PAGE.RUNMODAL(458,NoSrsRel,NoSrsRel."Series Code") = ACTION::LookupOK THEN
          EXIT(NoSrsRel."Series Code")
        END
        ELSE
        EXIT(NoSeriesCode);
        */
        exit(GetNoSeriesRelCode(NoSeriesCode));

    end;

    [Scope('OnPrem')]
    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Advance Surrender', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    [Scope('OnPrem')]
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    [Scope('OnPrem')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    [Scope('OnPrem')]
    procedure GetNoSeriesRelCode(NoSeriesCode: Code[20]): Code[20]
    var
        GenLedgerSetup: Record "General Ledger Setup";
        RespCenter: Record "Responsibility Center";
        DimMgt: Codeunit 408;
        NoSrsRel: Record "No. Series Relationship";
    begin
        EXIT(GetNoSeriesRelCode(NoSeriesCode));
        GenLedgerSetup.Get;
        case GenLedgerSetup."Base No. Series" of
            GenLedgerSetup."Base No. Series"::"Responsibility Center":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Responsibility Center");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 1":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Global Dimension 1 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 2":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 2 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 3":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 3 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            GenLedgerSetup."Base No. Series"::"Shortcut Dimension 4":
                begin
                    NoSrsRel.Reset;
                    NoSrsRel.SetRange(Code, NoSeriesCode);
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 4 Code");
                    if NoSrsRel.FindFirst then
                        exit(NoSrsRel."Series Code")
                end;
            else
                exit(NoSeriesCode);
        end;
    end;

    [Scope('OnPrem')]
    procedure ImpLinesExist(): Boolean
    begin
        ImpSurrLine.Reset;
        ImpSurrLine.SetRange("Surrender Doc No.", "No.");
        exit(ImpSurrLine.FindFirst);
    end;
}

