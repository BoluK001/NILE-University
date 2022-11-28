page 51534761 "Staff Claims List"
{
    CardPageID = "Staff Claim";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Claims Header";
    SourceTableView = WHERE(Status = FILTER(<> Cancelled),
                            Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    Editable = DateEditable;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Function Name"; "Function Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Profit & Cost Name';
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department Name';
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = ShortcutDimension2CodeEditable;
                }
                field("Account No."; "Account No.")
                {
                    Caption = 'Staff No/Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Editable = "Currency CodeEditable";
                    Visible = false;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    ApplicationArea = All;
                    Editable = "Paying Bank AccountEditable";
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;
                    Caption = 'Claim Description';
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = All;
                    Caption = 'Requestor ID';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Net Amount"; "Total Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Net Amount LCY"; "Total Net Amount LCY")
                {
                    ApplicationArea = All;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = All;
                    Editable = "Pay ModeEditable";
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Payment and Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post Payment and Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;

                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(39005882, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Action1102755021)
                {
                }
                action("Convert Multiple Lines to PV")
                {
                    Image = CreateLinesFromJob;
                    Promoted = true;
                    Visible = false;
                    ApplicationArea = All;
                    //PromotedCategory = Process;
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(StfHeader);
                        if StfHeader.FindFirst then
                            repeat
                                if StfHeader.Status <> StfHeader.Status::Approved then
                                    Error('The document %1 has not been approved', StfHeader."No.");
                            until StfHeader.Next = 0;

                        PayModeOption := StrMenu('Cash,Cheque', 0, 'Select the pay mode option');

                        PaymentsHeader.Init;
                        PaymentsHeader."No." := '';
                        if PayModeOption = 1 then
                            PaymentsHeader."voucher type" := PaymentsHeader."voucher type"::CPV
                        else
                            if PayModeOption = 2 then
                                PaymentsHeader."voucher type" := PaymentsHeader."voucher type"::BPV;
                        PaymentsHeader.Insert(true);
                        //add lines from multiple requests

                        CurrPage.SetSelectionFilter(StfHeader);
                        if StfHeader.FindFirst then begin
                            repeat
                                StfLines.Reset;
                                StfLines.SetRange(StfLines."No.", StfHeader."No.");
                                if StfLines.FindFirst then
                                    repeat
                                        PaymentsLines.Init;
                                        //PaymentsLines.TRANSFERFIELDS( StfLines);
                                        PaymentsLines."Line No." := 0;
                                        PaymentsLines."Account Type" := StfLines."Account type";
                                        PaymentsLines."Account No." := StfLines."Account No.";
                                        PaymentsLines."Account Name" := StfLines."Account Name";
                                        PaymentsLines."Narration" := StfLines.Purpose;
                                        // PaymentsLines."Transaction Name" := StfLines.Purpose;
                                        PaymentsLines."shortcut Dimension 1 Code" := StfLines."Global Dimension 1 Code";
                                        PaymentsLines.Validate("shortcut Dimension 1 Code");
                                        PaymentsLines."Shortcut Dimension 2 Code" := StfLines."Shortcut Dimension 2 Code";
                                        PaymentsLines.Validate("Shortcut Dimension 2 Code");
                                        PaymentsLines."shortcut Dimension 3 Code" := StfLines."Global Dimension 1 Code";
                                        PaymentsLines.Validate("shortcut Dimension 3 Code");
                                        PaymentsLines.Amount := StfLines.Amount;
                                        PaymentsLines."Document No." := PaymentsHeader."No.";
                                        /* if PayModeOption = 1 then
                                            PaymentsLines."Pay Mode" := PaymentsLines."Pay Mode"::Cash
                                         else
                                             if PayModeOption = 2 then
                                                 PaymentsLines."Pay Mode" := PaymentsLines."Pay Mode"::Cheque;
                                         PaymentsLines."Staff Claim No." := StfHeader."No.";
                                         */
                                        PaymentsLines.Insert;
                                    until StfLines.Next = 0;

                                StfHeader.Status := StfHeader.Status::Posted;
                                StfHeader.Posted := true;
                                StfHeader."Date Posted" := Today;
                                StfHeader."Time Posted" := Time;
                                StfHeader.Modify;
                            until StfHeader.Next = 0;
                        end;
                        if PayModeOption = 1 then
                            PAGE.Run(39005902, PaymentsHeader)
                        else
                            PAGE.Run(39005905, PaymentsHeader);
                    end;
                }
                separator(Action1102755026)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        // ApprovalEntries: Page 658;
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Staff Advance";
                        // ApprovalEntries.Setfilters(DATABASE::"Staff Advance Header", DocumentType, "No.");
                        // ApprovalEntries.Run;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Staff Advance Header", DocType.AsInteger(), "No.");
                    end;

                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the Imprest for Approval
                        // IF ApprovalMgt.SendClaimApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelClaimApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755009)
                {
                }
                action("Check Budgetary Availability")
                {
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    ApplicationArea = All;
                    Visible = false;
                    //Promoted = true;
                    // PromotedCategory = Category5;
                    //PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                            Commitments.SetRange(Commitments."Document No.", "No.");
                            Commitments.DeleteAll;
                        end;

                        //CheckBudgetAvail.CheckStaffClaim(Rec);  Lateef
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    ApplicationArea = All;
                    Visible = false;
                    //Promoted = true;
                    //PromotedCategory = Category5;
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        Commitments.DeleteAll;

                        PayLine.Reset;
                        PayLine.SetRange(PayLine."No.", "No.");
                        if PayLine.Find('-') then begin
                            repeat
                                PayLine.Committed := false;
                                PayLine.Modify;
                            until PayLine.Next = 0;
                        end;
                    end;
                }
                separator(Action1102755033)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('You can only print after the document is Approved');
                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(51534726, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Action1102756006)
                {
                }
                action("Cancel Document")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                    begin


                        //TESTFIELD(Status,Status::Approved);
                        if (Status = Status::Approved) or (Status = Status::Open) then begin
                            if Confirm(Text000, true) then begin
                                //Post Committment Reversals
                                Doc_Type := Doc_Type::Imprest;
                                //BudgetControl.ReverseEntries(Doc_Type, "No.");
                                Status := Status::Cancelled;
                                Modify;
                            end else
                                Error(Text001);

                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Cheque No.Editable" := true;
        "Pay ModeEditable" := true;
        "Paying Bank AccountEditable" := true;
        "Payment Release DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Status::Open);

        if TravReqHeader.Count > 0 then begin
            Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        end;
        //*********************************END ****************************************//


        "Payment type" := "Payment type"::Imprest;
        "Account Type" := "Account Type"::Customer;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        
        
        
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;         */

        // FilterGroup(2);
        // SetFilter(Cashier, UserId);
        // FilterGroup(0);
        UpdateControls;

    end;

    var
        PayLine: Record "Staff Claim Lines";
        //PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Voucher Header";
        RecPayTypes: Record "Receipts and Payment Types";

        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Voucher Header";
        BankAcc: Record "Bank Account";
        //CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        //BudgetControl: Codeunit "Budgetary Control";
        TravReqHeader: Record "Staff Claims Header";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        StfLines: Record "Staff Claim Lines";
        StfHeader: Record "Staff Claims Header";
        PaymentsHeader: Record "Voucher Header";
        PaymentsLines: Record "Voucher Line";
        PayModeOption: Integer;
        StaffClaimHeader: Record "Staff Claims Header";
        StaffClaimLines: Record "Staff Claim Lines";

    [Scope('OnPrem')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", "No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;

    [Scope('OnPrem')]
    procedure PostImprest()
    begin

        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;

        //CREDIT BANK
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";
        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := "Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := Purpose;
        CalcFields("Total Net Amount");
        GenJnlLine."Credit Amount" := "Total Net Amount";
        GenJnlLine.Validate(GenJnlLine."Credit Amount");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := "Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" := "Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;



        //DEBIT RESPECTIVE G/L ACCOUNT(S)
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", "No.");
        if PayLine.Find('-') then begin
            repeat
                LineNo := LineNo + 1000;
                GenJnlLine.Init;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Posting Date" := "Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
                GenJnlLine."Document No." := "No.";
                GenJnlLine."External Document No." := "Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine.Description := Purpose;
                GenJnlLine."Debit Amount" := PayLine.Amount;
                GenJnlLine.Validate(GenJnlLine."Debit Amount");
                //Added for Currency Codes
                GenJnlLine."Currency Code" := "Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := "Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

            until PayLine.Next = 0
        end;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        Post := false;
        Post := JournlPosted.PostedSuccessfully();
        if Post then begin
            Posted := true;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            Status := Status::Posted;
            Modify;
        end;
    end;

    [Scope('OnPrem')]
    procedure CheckImprestRequiredItems()
    begin

        TestField("Payment Release Date");
        TestField("Paying Bank Account");
        TestField("Account No.");
        TestField("Account Type", "Account Type"::Customer);

        if Posted then begin
            Error('The Document has already been posted');
        end;

        TestField(Status, Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Claim Template";
        JBatch := Temp."Claim  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');

    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin
    end;

    [Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        StaffADVLine: Record "Staff Claim Lines";
    begin
        HasLines := false;
        StaffADVLine.Reset;
        StaffADVLine.SetRange("No.", "No.");
        if StaffADVLine.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    [Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        VouchLine: Record "Staff Claim Lines";
    begin
        AllKeyFieldsEntered := true;
        VouchLine.Reset;
        VouchLine.SetRange(VouchLine."No.", "No.");
        if VouchLine.Find('-') then begin
            repeat
                if (VouchLine."Account No." = '') or (VouchLine.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until VouchLine.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}

