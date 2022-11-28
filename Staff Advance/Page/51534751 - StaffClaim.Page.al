page 51534751 "Staff Claim"
{
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Staff Claims Header";
    Caption = 'Staff Claim Card';
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';

    layout
    {
        area(content)
        {
            group(Control1)
            {
                Editable = true;
                Enabled = true;
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
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Function Name"; "Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ECU Code Description"; "ECU Code Description")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    Caption = 'Account No';
                    Editable = AccountNoEditable;
                    ApplicationArea = All;
                }
                field(Payee; Payee)
                {
                    Caption = 'Account Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    //Editable = Pay ModeEditable"; //DD
                    Editable = PayingBankAccountEditable;
                    Visible = payingbankvisible;

                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        "Rebursehandler ID" := UserId;
                    end;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    Editable = PayingBankAccountEditable;
                    Visible = payingbankvisible;
                    ApplicationArea = All;
                }
                field("Bank Name"; "Bank Name")
                {
                    Caption = 'Paying Bank Name';
                    Editable = false;
                    Visible = payingbankvisible;
                    //Visible = true;
                    ApplicationArea = All;
                }
                field(Purpose; Purpose)
                {
                    Caption = 'Reimbursement  Description';
                    ApplicationArea = All;
                }
                field(Cashier; Cashier)
                {
                    Caption = 'Creator ID';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdateControls;
                        CurrPage.Update();
                    end;
                }
                field("Total Net Amount"; "Total Net Amount")
                {
                    Caption = 'Total Amount';
                    ApplicationArea = All;
                }
                field("Total Net Amount LCY"; "Total Net Amount LCY")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    //Caption = 'Payment  Date';
                    Editable = PaymentReleaseDateEditable;
                    ApplicationArea = All;
                }
                field("Cheque No."; "Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = ChequeNoEditable;
                    Visible = payingbankvisible;
                    ApplicationArea = All;
                }
                field(Attachment; Attachment)
                {
                    Editable = false;
                    visible = false;
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ApplicationArea = All;
                }
                field("Group Head to Approve"; "Group Head to Approve")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Rebursehandler ID"; "Rebursehandler ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part(PVLines; "Staff Claim Lines")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
                Editable = LineEditable;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534709), "No." = FIELD("No.");
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
                        REPORT.Run(51534726, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Separator1102755021)
                {
                }
                action("Post Payment")
                {
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;
                    end;
                }
                separator(Separator1102755026)
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
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := doctype::"Staff Claim";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Staff Claims Header", DocType.AsInteger(), Rec."No.");
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
                    //ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);

                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = NOT OpenApprovalEntriesExist;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                        BudgetApproval: Codeunit "Budget Approval";
                        GeneSetUp: Record "General Ledger Setup";
                    begin
                        // if GeneSetUp.StaffClaimBudget then
                        //     BudgetApproval.ActualBudgetStaffClaims(Rec);

                        GeneSetUp.Get();

                        // if GeneSetUp.StaffClaimBudget then
                        //     BudgetApproval.ActualBudgetStaffClaims(Rec);
                        if Confirm('Are you sure you want to send the request for approval?', true) = false then
                            exit;

                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if not AllFieldsEntered then
                            Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        // if LinesCommitmentStatus then ///blocked by Deji
                        ///   Error('There are some lines that have not been committed'); // Blocked by Deji

                        //Release the Imprest for Approval
                        //BudgetCheck.ActualBudgetClaimpayment(Rec);
                        IF ApprovalMgt.CheckStaffClaimApprovalsWorkflowEnable(Rec) THEN
                            ApprovalMgt.OnSendStaffClaimForApproval(Rec);

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    //Visible = CanCancelApprovalForRecord;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        ApprovalMgt.OnCancelStaffClaimForApproval(Rec);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                separator(Separator1102755009)
                {
                }

                separator(Separator1102755033)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('You can only print after the document is Approved');
                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(51534726, true, true, Rec); //Staff Claims Voucher
                        Reset;
                    end;
                }
                separator(Separator1102756006)
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
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                        Doc_Type: Option "Imprest","staff Claim";
                        ApprovalsMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        // TESTFIELD(Status, Status::"Pending Approval");

                        // if (Status = Status::Approved) or (Status = Status::Open) then begin
                        //     if Confirm(Text000, true) then begin
                        //         //Post Committment Reversals
                        //         Doc_Type := Doc_Type::Imprest;
                        //         //BudgetControl.ReverseEntries(Doc_Type,"No.");
                        //         //Status := Status::Cancelled;
                        //         Modify;
                        //     end else
                        //         Error(Text001);

                        // end;
                        ApprovalsMgt.OnCancelStaffClaimForApproval(Rec);
                    end;
                }
                action("Create Payment Voucher")
                {
                    Promoted = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PVHeadEr: Record "Voucher Header";
                        PaymentLines: Record "Voucher Line";
                        EntryNo: Integer;
                        STClaimLines: Record "Staff Claim Lines";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        GLSetup: Record "General Ledger Setup";
                    begin
                        CheckImprestRequiredItems;

                        PVHeadEr.Reset;
                        PVHeadEr.SetRange(PVHeadEr."External Document No.", "No.");
                        if PVHeadEr.Find('-') = true then
                            Error('Payment Voucher has already been created for Staff claim %1', PVHeadEr."No.");


                        TestField(Status, Status::Approved);
                        TestField("Pay Mode");
                        TestField("Payment Release Date");

                        if not Confirm('Are you sure you want to create a Payment Voucher for %1', false, "No.") then
                            Error('Creation of Payment Voucher Stopped') else begin

                            PVHeadEr.Init;
                            PVHeadEr."Document Date" := Date;
                            GLSetup.Get();
                            if "Pay Mode" = "Pay Mode"::Cash then begin
                                PVHeadEr."Voucher Type" := PVHeadEr."Voucher Type"::CPV;
                                PVHeadEr.Validate("Voucher Type");
                                PVHeadEr."No." := NoSeriesMgt.GetNextNo(GLSetup."Cash Payment Voucher No", TODAY, TRUE);
                                PVHeadEr.Insert(true);
                            end else BEGIN
                                //"Pay Mode" = "Pay Mode"::Cheque then
                                PVHeadEr."Voucher Type" := PVHeadEr."Voucher Type"::BPV;
                                PVHeadEr.Validate("Voucher Type");
                                PVHeadEr."No." := NoSeriesMgt.GetNextNo(GLSetup."Bank Payment Voucher No", TODAY, TRUE);
                                PVHeadEr.Insert(true);
                            END;
                            if "Pay Mode" = "Pay Mode"::Cash then
                                PVHeadEr."Voucher Type" := PVHeadEr."Voucher Type"::CPV
                            else
                                //if "Pay Mode" = "Pay Mode"::Cheque then
                                    PVHeadEr."Voucher Type" := PVHeadEr."Voucher Type"::BPV;
                            PVHeadEr."Account Type" := PVHeadEr."Account Type"::"Bank Account";
                            PVHeadEr."Account No." := "Paying Bank Account";
                            PVHeadEr.Validate("Account No.");
                            PVHeadEr."Teller / Cheque No." := "Cheque No.";
                            PVHeadEr."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                            PVHeadEr.Validate("Shortcut Dimension 1 Code");
                            PVHeadEr."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            PVHeadEr.Validate("Shortcut Dimension 2 Code");
                            PVHeadEr."Responsibility Center" := "Responsibility Center";
                            PVHeadEr."Document Date" := "Payment Release Date";
                            PVHeadEr."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                            PVHeadEr.Validate("Shortcut Dimension 3 Code");
                            PVHeadEr."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                            PVHeadEr.Validate("Shortcut Dimension 4 Code");
                            PVHeadEr.Narration := Purpose;
                            PVHeadEr."External Document No." := "No.";
                            PVHeadEr.Insert(true);

                            /*
                            //Removed for now since its inserting to a new document
                            PaymentLines.RESET;
                            IF PaymentLines.FIND('+') THEN BEGIN
                            EntryNo:=PaymentLines."Line No.";
                            END;
                            */
                            EntryNo := 1;
                            STClaimLines.Reset;
                            STClaimLines.SetRange(STClaimLines."No.", "No.");
                            if STClaimLines.Find('-') then
                                repeat

                                    PaymentLines.Init;
                                    PaymentLines."Line No." := 0;
                                    PaymentLines."Document No." := PVHeadEr."No.";
                                    PaymentLines."Account No." := STClaimLines."Account No.";
                                    PaymentLines."Account Name" := STClaimLines."Account Name";
                                    PaymentLines.Amount := STClaimLines.Amount;
                                    PaymentLines.Amount := STClaimLines.Amount;
                                    PaymentLines."Shortcut Dimension 1 Code" := STClaimLines."Global Dimension 1 Code";
                                    PaymentLines.Validate("Shortcut Dimension 1 Code");
                                    PaymentLines."Shortcut Dimension 2 Code" := STClaimLines."Shortcut Dimension 2 Code";
                                    PaymentLines.Validate("Shortcut Dimension 2 Code");
                                    PaymentLines."Shortcut Dimension 3 Code" := STClaimLines."Shortcut Dimension 3 Code";
                                    PaymentLines.Validate("Shortcut Dimension 3 Code");
                                    PaymentLines."Shortcut Dimension 4 Code" := STClaimLines."Shortcut Dimension 4 Code";
                                    PaymentLines.Validate("Shortcut Dimension 4 Code");
                                    PaymentLines.Insert(true);

                                until STClaimLines.Next = 0;
                        end;

                        Status := Status::Posted;
                        Modify;

                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        Modify;


                        if "Pay Mode" = "Pay Mode"::Cash then
                            PAGE.Run(50008, PVHeadEr)
                        else
                            PAGE.Run(50003, PVHeadEr);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
        SetControlAppearance;
        CurrPageUpdate;
    end;

    trigger OnInit()
    begin
        CurrencyCodeEditable := true;
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        ChequeNoEditable := true;
        PayModeEditable := true;
        PayingBankAccountEditable := true;
        PaymentReleaseDateEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SetRange(Cashier, UserId);
        TravReqHeader.SetRange(Status, Status::Open);

        // if TravReqHeader.Count > 0 then begin
        //     Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        // end;  //Dennis
        //*********************************END ****************************************//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    //UserMgt22: Codeunit "User Setup Management BR1";
    begin
        // "Responsibility Center" := UserMgt22.GetPurchasesFilter();
        // //Add dimensions if set by default here
        // "Global Dimension 1 Code" := UserMgt22.GetSetDimensions(UserId, 1);
        // Validate("Global Dimension 1 Code");
        // "Shortcut Dimension 2 Code" := UserMgt22.GetSetDimensions(UserId, 2);
        // Validate("Shortcut Dimension 2 Code");
        // "Shortcut Dimension 3 Code" := UserMgt22.GetSetDimensions(UserId, 3);
        // Validate("Shortcut Dimension 3 Code");
        // "Shortcut Dimension 4 Code" := UserMgt22.GetSetDimensions(UserId, 4);
        // Validate("Shortcut Dimension 4 Code");
        UpdateControls;

        "Payment Type" := "Payment Type"::Imprest;
        "Account Type" := "Account Type"::Employee;
        //Validate("Account No.");
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    var
    // UserMgt36: Codeunit "User Setup Management BR1";
    begin
        /* EditNo:=TRUE;
         IF Status<>Status::Open THEN
           EditNo:= FALSE;
         */

        // if UserMgt36.GetPurchasesFilter() <> '' then begin
        //     FilterGroup(2);
        //     SetRange("Responsibility Center", UserMgt36.GetPurchasesFilter());
        //     FilterGroup(0);
        // end;
        UpdateControls;

        if Status = Status::Open then begin
            payingbankvisible := false;
        end else begin
            payingbankvisible := true;
        end;

    end;

    var
        PayLine: Record "Staff Claim Lines";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Voucher Header";
        RecPayTypes: Record "Receipts and Payment Types";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Voucher Header";
        BankAcc: Record "Bank Account";
        //Commitments: Record Committment1;
        // UserMgt: Codeunit "User Setup Management BR1";
        //JournlPosted: Codeunit "Journal Post Successful1";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher","Petty Cash",Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Express Pv",Requisition,JV," ";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        TravReqHeader: Record "Staff Claims Header";
        //  AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        PaymentReleaseDateEditable: Boolean;
        [InDataSet]
        PayingBankAccountEditable: Boolean;
        [InDataSet]
        PayModeEditable: Boolean;
        [InDataSet]
        ChequeNoEditable: Boolean;
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
        CurrencyCodeEditable: Boolean;
        StatusEditable: Boolean;
        PaymentLine: Record "Voucher Line";
        PVHeadNo: Code[20];
        payingbankvisible: Boolean;
        GLEntry: Record "G/L Entry";
        EditNo: Boolean;
        AttachmentRec: Record Attachment;
        LineEditable: Boolean;
        AccountNoEditable: Boolean;

    local procedure LinesCommitmentStatus() Exists: Boolean
    begin
        // IF BCsetup.GET() THEN  BEGIN
        //    IF NOT BCsetup.Mandatory THEN BEGIN
        //       Exists:=FALSE;
        //       EXIT;
        //    END;
        // END ELSE BEGIN
        //       Exists:=FALSE;
        //       EXIT;
        // END;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", "No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;

    procedure PostImprest()
    var
        //JournlPosted: Codeunit "Journal Post Successful1";
        AdjustGenJnl35: Codeunit "Adjust Gen. Journal Balance";
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
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert;

            until PayLine.Next = 0
        end;


        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl35.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        Post := false;
        // Post := JournlPosted.PostedSuccessfully();
        Post := True;
        GLEntry.SetRange("Document No.", "No.");
        if GLEntry.FindFirst then begin
            Posted := true;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            Status := Status::Posted;
            Modify;
        end;
    end;

    procedure CheckImprestRequiredItems()
    begin

        TestField("Payment Release Date");
        TestField("Paying Bank Account");
        TestField("Account No.");
        TestField("Account Type", "Account Type"::Employee);

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

    procedure UpdateControls()
    begin
        CASE Status OF
            Status::Approved:
                BEGIN
                    PaymentReleaseDateEditable := TRUE;
                    PayingBankAccountEditable := TRUE;
                    PayModeEditable := TRUE;
                    PayingBankVisible := TRUE;
                    if "Pay Mode" <> "Pay Mode"::Cash then
                        ChequeNoEditable := TRUE;
                    AccountNoEditable := false;
                    LineEditable := False;
                    //PaymodeVisible := TRUE;
                END;
            Status::"Pending Approval":
                BEGIN
                    PaymentReleaseDateEditable := FALSE;
                    PayingBankAccountEditable := FALSE;
                    PayModeEditable := FALSE;
                    ChequeNoEditable := FALSE;
                    PayingBankVisible := FALSE;
                    AccountNoEditable := false;
                    LineEditable := False;
                    //PaymodeVisible := FALSE;
                END;
            Status::Open:
                BEGIN
                    PaymentReleaseDateEditable := FALSE;
                    PayingBankAccountEditable := FALSE;
                    PayModeEditable := FALSE;
                    ChequeNoEditable := FALSE;
                    PayingBankVisible := FALSE;
                    AccountNoEditable := True;
                    //PaymodeVisible := FALSE;
                    LineEditable := true;
                END
        END;
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."No.", "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    local procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines."No.", "No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines.Amount <= 0) then //IF (PayLines."Account No."='') OR (PayLines.Amount<=0) THEN
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    end;

}

