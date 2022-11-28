page 51534762 "Staff Advance Request List"
{
    CardPageID = "Staff Advance Request";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Staff Advance Header";
    //SourceTableView = WHERE(Status = FILTER(<> Cancelled), Posted = CONST(false));
    SourceTableView = where(Posted = CONST(false));

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
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = "Currency CodeEditable";
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
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
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
                    Caption = 'Post Payment and Print';
                    Enabled = true;
                    ApplicationArea = All;
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
                        REPORT.Run(51534724, true, true, Rec);
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    visible = false;  //jj010722 I remmed as there was an error when tested. 

                    trigger OnAction()
                    begin
                        CurrPage.SetSelectionFilter(AdvHeader);
                        if AdvHeader.FindFirst then
                            repeat
                                if AdvHeader.Status <> AdvHeader.Status::Approved then
                                    Error('The document %1 has not been approved', AdvHeader."No.");
                            until AdvHeader.Next = 0;

                        PayModeOption := StrMenu('Cash,Cheque', 0, 'Select the pay mode option');

                        VoucherHeader.Init;
                        VoucherHeader."No." := '';
                        if PayModeOption = 1 then
                            VoucherHeader."Voucher Type" := VoucherHeader."Voucher Type"::CPV
                        else
                            if PayModeOption = 2 then
                                VoucherHeader."Voucher Type" := VoucherHeader."Voucher Type"::BPV;
                        VoucherHeader.Insert(true);
                        //add lines from multiple requests

                        CurrPage.SetSelectionFilter(AdvHeader);
                        if AdvHeader.FindFirst then begin
                            repeat
                                AdvLines.Reset;
                                AdvLines.SetRange(AdvLines."No.", AdvHeader."No.");
                                if AdvLines.FindFirst then
                                    repeat
                                        VouchLine.Init;
                                        //VouchLine.TRANSFERFIELDS( StfLines);
                                        VouchLine."Account Type" := AdvLines."Account Type";
                                        VouchLine."Account No." := AdvLines."Account No.";
                                        VouchLine."Account Name" := AdvLines."Account Name";
                                        //VouchLine."Transaction Name" := AdvLines.Purpose;
                                        VouchLine.Narration := AdvLines."Advance Narration";
                                        VouchLine.Amount := AdvLines.Amount;
                                        VouchLine."Document No." := VoucherHeader."No.";
                                        /* if PayModeOption = 1 then
                                             VouchLine."Pay Mode" := VouchLine."Pay Mode"::Cash
                                         else
                                             if PayModeOption = 2 then
                                                 VouchLine."Pay Mode" := VouchLine."Pay Mode"::Cheque;
                                                 */
                                        VouchLine."Shortcut Dimension 1 Code" := AdvHeader."Shortcut Dimension 1 Code";
                                        VouchLine.Validate("Shortcut Dimension 1 Code");
                                        VouchLine."Shortcut Dimension 2 Code" := AdvHeader."Shortcut Dimension 2 Code";
                                        VouchLine.Validate("Shortcut Dimension 2 Code");
                                        //VouchLine."Staff Advance No." := AdvHeader."No.";
                                        VouchLine."Line No." := 0;
                                        VouchLine.Insert;
                                    until AdvLines.Next = 0;
                                AdvHeader.Status := AdvHeader.Status::Posted;
                                AdvHeader.Posted := true;
                                AdvHeader."Date Posted" := Today;
                                AdvHeader."Time Posted" := Time;
                                AdvHeader.Modify;
                            until AdvHeader.Next = 0;
                        end;
                        if PayModeOption = 1 then
                            PAGE.Run(51534727, VoucherHeader)
                        else
                            PAGE.Run(51534730, VoucherHeader);
                    end;
                }
                action("Post Payment")
                {
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;
                    end;
                }
                separator(Action1102755026)
                {
                }
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                separator(Separator1102755026)
                {
                    Caption = 'Approvals';
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

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
                action(SendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = NOT OpenApprovalEntriesExist;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                        BudgetCheck: Codeunit "Posting Check FP";
                        BudgetApprove: Codeunit "Budget Approval";
                        StaffAdvance: Record "Staff Advance Header";
                        GeneSetUp: Record "General Ledger Setup";
                    begin
                        TESTFIELD(Status, Status::Open);

                        GeneSetUp.Get();

                        // if GeneSetUp.StaffAdvanceBudget then
                        // BudgetApprove.ActualBudgetstaffAdvance(Rec); //Dennis

                        IF EmployeeRec.GET("Account No.") THEN
                            EmployeeRec.CALCFIELDS(Balance);
                        IF EmployeeRec.Balance > 100 THEN
                            ERROR('Please check, you are still having outstanding to retire');

                        IF CONFIRM('Are you sure you want to send the request for approval?', TRUE) = FALSE THEN
                            EXIT;
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        IF NOT AllFieldsEntered THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                            ERROR('There are some lines that have not been committed');

                        //Release the Imprest for Approval

                        if ApprovalMgt.CheckStaffAdvanceApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendStaffAdvanceForApproval(Rec);
                        //EditNo
                        //Validate(Status);

                    end;
                }
                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = CanCancelApprovalForRecord;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        ApprovalMgt.OnCancelStaffAdvanceForApproval(Rec);
                    end;
                }
            }
            separator(Action1102755009)
            {
            }
            action("Check Budgetary Availability")
            {
                Caption = 'Check Budgetary Availability';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;   //jj010722 I made it not visible pending the time it has been worked on fully and good to use

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
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                    Commitments.SetRange(Commitments."Document No.", "No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        Commitments.DeleteAll;
                    end;

                    //    CheckBudgetAvail.CheckStaffAdvance(Rec); Lateef
                end;
            }
            action("Cancel Budget Commitment")
            {
                Caption = 'Cancel Budget Commitment';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;   //jj010722 I made it not visible pending the time it has been worked on fully and good to use

                trigger OnAction()
                begin
                    if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
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
                Visible = false;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('You can only print after the document is Approved');
                    Reset;
                    SetFilter("No.", "No.");
                    REPORT.Run(51534724, true, true, Rec);
                    Reset;
                end;
            }
            separator(Action1102756006)
            {
            }
            action("Cancel Document")
            {
                Caption = 'Cancel Document';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

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
        SetControlAppearance;
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


        "Payment Type" := "Payment Type"::Imprest;
        "Account Type" := "Account Type"::Employee;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        // "Shortcut Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        // Validate("Shortcut Dimension 1 Code");
        // "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        // Validate("Shortcut Dimension 2 Code");
        // "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        // Validate("Shortcut Dimension 3 Code");
        // "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        // Validate("Shortcut Dimension 4 Code");
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
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
       END;

       IF UserTemplate.GET(USERID) THEN BEGIN
         FILTERGROUP(2);
         CALCFIELDS("Total Payment Amount");
         SETFILTER("Total Payment Amount",'..%1',UserTemplate."Maximum Document Amount");
         FILTERGROUP(0);
       END;
        */
        // SetFilter(Cashier, UserId);
    end;

    var
        PayLine: Record 51534712;//"Staff Advance Lines";
        ////PVUsers: Record "CshMgt PV Steps Users";
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
        //PCheck: Codeunit "Posting Check FP";
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
        TravReqHeader: Record "Staff Advance Header";
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
        VoucherHeader: Record "Voucher Header";
        VouchLine: Record "Voucher Line";
        PayModeOption: Integer;
        StaffAdvanceHeader: Record "Staff Advance Header";
        StaffAdvanceLines: Record "Staff Advance Lines";
        AdvLines: Record "Staff Advance Lines";
        AdvHeader: Record "Staff Advance Header";
        UserTemplate: Record "Cash Office User Template";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EmployeeRec: Record Employee;

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

        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := "Payment Release Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := "Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Advance: ' + "Account No." + ':' + Payee;
        CalcFields("Total Net Amount");
        GenJnlLine.Amount := "Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := "Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := "Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" := "Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        /*
        GenJnlLine."Currency Factor":=Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        */
        GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
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
        //TestField("Account Type", "Account Type"::Employee);

        if Posted then begin
            Error('The Document has already been posted');
        end;

        TestField(Status, Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Advance Template";
        JBatch := Temp."Advance  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Staff Advance Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Staff Advance Batch is set up in the Cash Office Setup')
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
        StaffAdvLine: Record "Staff Advance Lines";
    begin
        HasLines := false;
        StaffAdvLine.Reset;
        StaffAdvLine.SetRange(StaffAdvLine."No.", "No.");
        if StaffAdvLine.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    [Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        StaffAdvLine: Record "Staff Advance Lines";
    begin
        AllKeyFieldsEntered := true;
        StaffAdvLine.Reset;
        StaffAdvLine.SetRange(StaffAdvLine."No.", "No.");
        if StaffAdvLine.Find('-') then begin
            repeat
                if (StaffAdvLine."Account No." = '') or (StaffAdvLine.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until StaffAdvLine.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
        SetControlAppearance;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    end;
}

