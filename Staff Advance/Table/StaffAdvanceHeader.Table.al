table 51534711 "Staff Advance Header"
{
    //DrillDownPageID = "Staff Advance Request List";
    //LookupPageID = "Staff Advance Request List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //  GenLedgerSetup.GET;
                    NoSeriesMgt.TestManual("No. Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                // /UpdateHeaderToLine;
                UpdateAdvanceLines(FIELDNO(Date));
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            Editable = true;
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                UpdateHeaderToLine;
                UpdateAdvanceLines(FIELDNO("Currency Code"));
            end;
        }
        field(9; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11; Cashier; Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(16; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
            trigger OnValidate()
            begin
                UpdateAdvanceLines(FIELDNO("Date Posted"));
            end;
        }
        field(18; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
            trigger OnValidate()
            begin
                //UpdateAdvanceLines(FIELDNO(Da));
            end;
        }
        field(19; "Posted By"; Code[50])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            CalcFormula = Sum("Voucher Line".Amount WHERE("Document No." = FIELD("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;

        }
        field(28; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = IF ("Pay Mode" = CONST(Cash)) "Bank Account"."No." WHERE("Bank Type" = CONST(Cash))
            ELSE
            IF ("Pay Mode" = CONST(Cheque)) "Bank Account"."No." WHERE("Bank Type" = FILTER(<> Cash));  //jj010722  to be added "Pay Mode" = CONST(EFT)

            trigger OnValidate()
            begin
                BankAcc.Reset;
                "Bank Name" := '';
                if BankAcc.Get("Paying Bank Account") then begin
                    "Bank Name" := BankAcc.Name;
                    // "Currency Code":=BankAcc."Currency Code";   //Currency Being determined first before document is released for approval
                    // VALIDATE("Currency Code");
                end;
            end;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;

                UpdateHeaderToLine;
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                UpdateAdvanceLines(FIELDNO("Shortcut Dimension 1 Code"));
            end;
        }
        field(35; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Open,"Pending Approval",Posted,Approved,Cancelled;
            trigger OnValidate()
            begin
                UpdateAdvanceLines(FIELDNO(Status));
            end;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Imprest;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            //NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                //UpdateHeaderToLine;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                UpdateAdvanceLines(FIELDNO("Shortcut Dimension 2 Code"));
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[150])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            //CalcFormula = Sum("Voucher Line"."VAT Amount" WHERE("No." = FIELD("No.")));RBS
            //Editable = false;
            //FieldClass = FlowField;
        }
        field(63; "Total Witholding Tax Amount"; Decimal)
        {
            // CalcFormula = Sum("Voucher Line"."Withholding Tax Amount" WHERE("No." = FIELD("No.")));
            //Editable = false;
            // FieldClass = FlowField;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            CalcFormula = Sum("Staff Advance Lines".Amount WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {
        }
        field(67; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT;
        }
        field(68; "Payment Release Date"; Date)
        {

            trigger OnValidate()
            begin
                /*
                  //Changed to ensure Release date is not less than the Date entered
                  IF "Payment Release Date"<Date THEN
                     ERROR('The Payment Release Date cannot be lesser than the Document Date');
                 */

            end;
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(70; "VAT Base Amount"; Decimal)
        {
        }
        field(71; "Exchange Rate"; Decimal)
        {
        }
        field(72; "Currency Reciprical"; Decimal)
        {
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
        }
        field(75; "Register Number"; Integer)
        {
        }
        field(76; "From Entry No."; Integer)
        {
        }
        field(77; "To Entry No."; Integer)
        {
        }
        field(78; "Invoice Currency Code"; Code[20])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = Sum("Staff Advance Lines"."Amount LCY" WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Option)
        {
            OptionMembers = "Payment Voucher","Petty Cash";
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
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;

                // UpdateHeaderToLine;
                UpdateAdvanceLines(FIELDNO("Shortcut Dimension 3 Code"));
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
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                // UpdateHeaderToLine;
                UpdateAdvanceLines(FIELDNO("Shortcut Dimension 4 Code"));
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                // if not UserMgt.CheckRespCenter(1, "Shortcut Dimension 3 Code") then
                //     Error(
                //       Text001,
                //       RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
                UpdateAdvanceLines(FIELDNO("Responsibility Center"));
            end;
        }
        field(86; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = true;
            OptionCaption = 'G/L Account,Employee,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Employee,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(87; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = Employee where(Status = filter(Active));

            trigger OnValidate()
            var
                Employ: Record Employee;
            begin
                Employ.Reset;
                if Employ.Get("Account No.") then begin
                    Employ.TestField("Employee Posting Group");
                    Employ.TestField(Status, Employ.Status::Active);
                    //Employ.TestField(Blocked, Cust.Blocked::" ");
                    Payee := Employ."First Name" + ' ' + Employ."Middle Name" + ' ' + Employ."Last Name";

                    "On Behalf Of" := Employ."First Name" + ' ' + Employ."Middle Name" + ' ' + Employ."Last Name";

                    //Check CreditLimit Here In cases where you have a credit limit set for employees
                    //Cust.CalcFields(Cust."Balance (LCY)");
                    //  IF Cust."Credit Limit (LCY)" > 0 THEN
                    //  IF Cust."Balance (LCY)">Cust."Credit Limit (LCY)" THEN
                    //   ERROR('The allowable unaccounted balance of %1 has been exceeded',Cust."Credit Limit (LCY)");

                    //Check Unretired staff Advances Here In cases where you have a limit set for employees
                    // StaffAdvances.Reset;
                    // StaffAdvances.SetRange(StaffAdvances."Account No.", "Account No.");
                    // StaffAdvances.SetRange(StaffAdvances."Surrender Status", StaffAdvances."Surrender Status"::" ");
                    // if StaffAdvances.FindSet then begin
                    //     if Cust."Advance Limit" = 0 then exit;
                    //     if StaffAdvances.Count > Cust."Advance Limit" then
                    //         if not Confirm('You have exceeded the allowable number of %1 unretired staff advances, You currently have %2 unretired staff advances of %3, Do you want to continue ?',
                    //         false, Cust."Advance Limit", StaffAdvances.Count, Cust."Balance (LCY)") then
                    //             Error('Current operation has been halted');
                    // end
                end;
            end;
        }

        field(88; "Surrender Status"; Option)
        {
            OptionMembers = " ",Full,Partial;
        }
        field(89; Purpose; Text[250])
        {
        }
        field(90; "Commitment Status"; Boolean)
        {
        }
        field(91; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 5 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                //UpdateHeaderToLine;
                UpdateAdvanceLines(FIELDNO("Shortcut Dimension 5 Code"));
            end;
        }
        field(100; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(101; "Responsibility Center Filter"; Code[20])
        {
            FieldClass = FlowFilter;
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
        field(481; "External Doc No."; Code[20])
        {
            CalcFormula = Lookup("Posted Voucher Header"."No." WHERE("External Document No." = FIELD("No.")));
            FieldClass = FlowField;
            trigger OnValidate()
            begin
                UpdateAdvanceLines(FIELDNO("External Doc No."));
            end;

        }
        field(482; "Staff Advance Retire No."; Code[20])
        {
            CalcFormula = Lookup("Staff Advance Surrender Header"."No." WHERE("Imprest Issue Doc. No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(483; "BPV Status"; Option)
        {
            CalcFormula = Lookup("Voucher Header".Status WHERE("No." = FIELD("External Doc No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Open,Posted,"Pending Approval",Approved;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //    IF (Status=Status::Approved) OR (Status=Status::Posted) OR (Status=Status::"Pending Approval")THEN
        Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    begin


        if "No." = '' then begin
            GenLedgerSetup.Get;
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
            //     NoSeriesMgt.InitSeries(GenLedgerSetup."Other Staff Advance No.",xRec."No. Series",0D,"No.","No. Series");
        end;

        /*
        UserTemplate.RESET;
        UserTemplate.SETRANGE(UserTemplate.UserID,USERID);
        IF UserTemplate.FINDFIRST THEN
          BEGIN
            "Paying Bank Account":=UserTemplate."Default Payment Bank";
            VALIDATE("Paying Bank Account");
          END;
           */

        Date := Today;
        Cashier := UserId;
        Validate(Cashier);

        //
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Cash Advance Staff Account");
            "Account Type" := "Account Type"::Employee;
            "Account No." := UserSetup."Cash Advance Staff Account";
            Validate("Account No.");
        end else
            Error('User must be setup under User Setup and their respective Account Entered');

    end;

    trigger OnModify()
    begin
        if Status = Status::Open then
            UpdateHeaderToLine;

        /* IF (Status=Status::Approved) OR (Status=Status::Posted)OR (Status=Status::"Pending Approval") THEN
            ERROR('You Cannot Modify this record its status is not Pending');*/

    end;

    var
        CStatus: Code[20];
        ////PVUsers: Record "CshMgt PV Steps Users";
        UserTemplate: Record "Cash Office User Template";
        GLAcc: Record "G/L Account";
        Cust: Record Employee;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Cash Office Setup";
        RecPayTypes: Record "Receipts and Payment Types";
        //CashierLinks: Record "Cashier Link";
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
        GenLedSetup: Record "General Ledger Setup";
        "Total Budget": Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        //PVSteps: Record "CshMgt PV Process Road";
        RespCenter: Record "Responsibility Center";
        UserMgt: Codeunit "User Setup Management";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        //Pline: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        //ImpLines: Record "Imprest Lines";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit 408;
        StaffAdvances: Record "Staff Advance Header";

    [Scope('OnPrem')]
    procedure UpdateHeaderToLine()
    var
        PayLine: Record "Imprest Lines";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", "No.");
        if PayLine.Find('-') then begin
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PayLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify;
            until PayLine.Next = 0;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    [Scope('OnPrem')]
    procedure ImpLinesExist(): Boolean
    var
        ImpLines: Record "Staff Advance Lines";
    begin
        ImpLines.Reset;
        ImpLines.SetRange("No.", "No.");
        exit(ImpLines.FindFirst);
    end;

    local procedure TestNoSeries(): Boolean
    begin
        if "Payment Type" = "Payment Type"::Imprest then
            GenLedgerSetup.TestField(GenLedgerSetup."Other Staff Advance No.")
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSrsRel: Record "No. Series Relationship";
        NoSeriesCode: Code[20];
    begin
        if "Payment Type" = "Payment Type"::Imprest then
            NoSeriesCode := GenLedgerSetup."Other Staff Advance No.";

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
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Staff Advance', "No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
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
        //EXIT(GetNoSeriesRelCode(NoSeriesCode));
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
                    NoSrsRel.SetRange("Series Filter", "Shortcut Dimension 1 Code");
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

    local procedure UpdateAdvanceLines(FieldRef: Integer)
    var
        AdvanceLine: Record "Staff Advance Lines";
    begin
        AdvanceLine.LOCKTABLE;
        AdvanceLine.SETRANGE("No.", "No.");
        IF AdvanceLine.FIND('-') THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO(Date):
                        AdvanceLine.VALIDATE("Date Taken", Date);
                    FIELDNO(Status):
                        AdvanceLine.VALIDATE(Status, Status);
                    FIELDNO("Shortcut Dimension 1 Code"):
                        AdvanceLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                    FIELDNO("Shortcut Dimension 2 Code"):
                        AdvanceLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                    FIELDNO("Shortcut Dimension 3 Code"):
                        AdvanceLine.VALIDATE("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                    FIELDNO("Shortcut Dimension 4 Code"):
                        AdvanceLine.VALIDATE("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                    FIELDNO("Shortcut Dimension 5 Code"):
                        AdvanceLine.VALIDATE("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                    // FIELDNO("Shortcut Dimension 6 Code"):
                    //     AdvanceLine.VALIDATE("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
                    // FIELDNO("Shortcut Dimension 7 Code"):
                    //     AdvanceLine.VALIDATE("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
                    // FIELDNO("Shortcut Dimension 8 Code"):
                    //     AdvanceLine.VALIDATE("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
                    FIELDNO("Currency Code"):
                        AdvanceLine.VALIDATE("Currency Code", "Currency Code");
                    FIELDNO("Currency Factor"):
                        AdvanceLine.VALIDATE("Currency Factor", "Currency Factor");
                    FIELDNO("Responsibility Center"):
                        AdvanceLine.VALIDATE("Responsibility Center", "Responsibility Center");
                    FIELDNO("External Doc No."):
                        AdvanceLine.VALIDATE("External Doc No.", "External Doc No.");

                END;
                AdvanceLine.MODIFY(TRUE);
            UNTIL AdvanceLine.NEXT = 0;
        END;
    end;
}

