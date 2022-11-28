page 51534753 "Staff Advance Request"
{
    Caption = 'Staff Advance Request';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Approval,Report';
    ShowFilter = false;
    SourceTable = "Staff Advance Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Editable = true;
                //ShowCaption = false;
                Visible = true;

                field("No."; "No.")
                {
                    ApplicationArea = all;
                    //Editable = CreateVouch;
                    Editable = false;  //jj010722
                }
                field(Date; Date)
                {
                    //Editable = DateEditable;
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    //Caption = 'ECU to Approve';
                    Caption = 'Responsibility Center';
                    Editable = OthersEditable;
                    // visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = OthersEditable;
                    NotBlank = true;
                    ApplicationArea = all;
                    //Visible = false;
                    trigger OnValidate()
                    begin
                        Validate("Shortcut Dimension 1 Code", "Responsibility Center");
                    end;
                }
                field("Function Name"; "Function Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    //Visible = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = OthersEditable;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                    Editable = OthersEditable;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                    Editable = OthersEditable;
                }
                field("Account No."; "Account No.")
                {
                    Caption = 'Staff No.';
                    ApplicationArea = all;
                    Editable = AccountNoEditable;

                }
                field(Payee; Payee)
                {
                    Caption = 'Staff Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    Caption = 'Description';
                    Editable = false;
                    visible = false;
                    ApplicationArea = all;
                }
                field("Currency Code"; "Currency Code")
                {
                    //Editable = true; //jj121021
                    Visible = false;  //jj121021
                    ApplicationArea = all;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    Editable = PayModeEditable;
                    // ValuesAllowed = " ", Cash, Cheque, EFT;
                    Visible = PaymodeVisible;
                    ApplicationArea = all;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    Editable = PayingBankAccountEditable;
                    Visible = PayingBankVisible;
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    Caption = 'Paying Bank Name';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = all;
                }
                field(Purpose; Purpose)
                {
                    Editable = True; //jj121021
                    ApplicationArea = all;
                }
                field(Cashier; Cashier)
                {
                    Caption = 'Staff ID';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field("Total Net Amount"; "Total Net Amount")
                {
                    Caption = 'Total Amount';
                    ApplicationArea = all;
                }
                field("Total Net Amount LCY"; "Total Net Amount LCY")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    Caption = 'Posting Date';
                    //Editable = PaymentReleaseDateEditable;
                    //Visible = PostingDateVisible;
                    ApplicationArea = all;
                }
                field("Cheque No."; "Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    //Editable = ChequeNoEditable;
                    Visible = ChequeNoVisible;
                    ApplicationArea = all;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }

            }
            part("Staff Advance Lines"; "Staff Advance Lines")
            {
                Editable = LineEditable;
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534711), "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
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
                    ToolTip = 'View or add comments.';
                    // Visible = OpenApprovalEntriesExistForCurrUser;

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

                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        DocType := DocType::"Staff Advance";

                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Staff Advance Header", 51534352, "No.");
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
                        // Validate(Status);

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
                separator(Separator1102755009)
                {
                }
                separator(Separator1102755033)
                {
                }
                action(PrintPreview)
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = PageActionsVisible;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);
                        if "Pay Mode" = "Pay Mode"::" " then Error('Please Select A Pay Mode');
                        if (Status = Status::Open) or (Status = Status::Cancelled) or (Status = Status::"Pending Approval") then
                            Error('You can not print a document that is %1', Status);
                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(51534724, true, true, Rec);
                        Reset;
                    end;
                }
                separator(Separator1102756006)
                {
                }
                action(UploadDoc)
                {
                    Caption = 'Upload Document';
                    Image = Upload;
                    // Visible = PageActionsVisible;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        vartest: Variant;
                    begin
                        Upload('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest)
                        //UPLOADINTOSTREAM(DialogTitle, FromFolder, FromFilter, FromFile, NVInStream) 3
                    end;
                }
                action("Create Payment Voucher")
                {
                    Promoted = true;
                    //Visible = CreateVouch;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PVHeadEr: Record "Voucher Header";
                        StaffAdvLines: Record "Staff Advance Lines";
                        PaymentLines: Record "Voucher Line";
                        EntryNo: Integer;
                        ApprovalEntry: Record "Approval Entry";
                        AppEntry: Record "Approval Entry";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                        GLSetup: Record "General Ledger Setup";
                    begin
                        //TestField("Payment Release Date");
                        if "Payment Release Date" = 0D then
                            Error('The Posting Date field cannot be empty');

                        CheckImprestRequiredItems(Rec);


                        PVHeadEr.Reset;
                        PVHeadEr.SetRange(PVHeadEr."External Document No.", Rec."No.");
                        if PVHeadEr.Find('-') = true then
                            Error('Payment Voucher has already been created for Staff Adavance %1', PVHeadEr."No.");

                        TestField(Status, Status::Approved);
                        //TestField("Pay Mode");
                        TestField("Paying Bank Account");
                        if "Pay Mode" = "Pay Mode"::" " then
                            Error('Pay Mode must be in Staff Advance Header: No.=ST, %1', "No.");

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

                            PVHeadEr.Status := PVHeadEr.Status::Open;
                            PVHeadEr."Account Type" := PVHeadEr."Account Type"::"Bank Account";
                            PVHeadEr."Account No." := "Paying Bank Account";
                            PVHeadEr.VALIDATE("Account No.");
                            PVHeadEr."Teller / Cheque No." := "Cheque No.";
                            PVHeadEr."Currency Code" := "Currency Code";
                            PVHeadEr.Validate("Currency Code");
                            PVHeadEr."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                            PVHeadEr.Validate("Shortcut Dimension 1 Code");
                            PVHeadEr."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                            PVHeadEr.Validate("Shortcut Dimension 2 Code");
                            PVHeadEr."Responsibility Center" := "Responsibility Center";

                            //PVHeadEr."Payment Release Date" := "Payment Release Date";

                            PVHeadEr."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                            PVHeadEr.Validate("Shortcut Dimension 3 Code");
                            PVHeadEr."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                            PVHeadEr.Validate("Shortcut Dimension 4 Code");

                            PVHeadEr."Narration" := Purpose;
                            PVHeadEr."External Document No." := "No.";
                            PVHeadEr.Validate("External Document No.");
                            PVHeadEr.Modify(true);

                            StaffAdvLines.Reset;
                            StaffAdvLines.SetRange(StaffAdvLines."No.", "No.");
                            if StaffAdvLines.Find('-') then begin

                                EntryNo := 1;

                                repeat
                                    PaymentLines.Init;
                                    PaymentLines."Voucher Type" := PVHeadEr."Voucher Type";
                                    PaymentLines."Line No." += 10000;//EntryNo+1;
                                                                     //MESSAGE('%1',EntryNo);
                                    PaymentLines."Document No." := PVHeadEr."No.";
                                    PaymentLines."Account Type" := PaymentLines."Account Type"::Employee;
                                    PaymentLines."Account No." := "Account No.";
                                    PaymentLines."Account Name" := Payee;
                                    PaymentLines.Account := PaymentLines.Account::Employee;
                                    PaymentLines."Currency Code" := "Currency Code";
                                    PaymentLines."Currency Factor" := "Currency Factor";
                                    //PaymentLines."NetAmount LCY":=StaffAdvLines."Amount LCY";
                                    PaymentLines.Amount := StaffAdvLines.Amount;
                                    PaymentLines.Validate(Amount);
                                    //PaymentLines."Net Amount":=StaffAdvLines.Amount;
                                    if EmployeeRec.get("Account No.") then
                                        PaymentLines."Posting Group" := EmployeeRec."Employee Posting Group";
                                    PaymentLines."Shortcut Dimension 1 Code" := StaffAdvLines."Shortcut Dimension 1 Code";
                                    PaymentLines.Validate("Shortcut Dimension 1 Code");
                                    PaymentLines."Shortcut Dimension 2 Code" := StaffAdvLines."Shortcut Dimension 2 Code";
                                    PaymentLines.Validate("Shortcut Dimension 2 Code");
                                    PaymentLines."Shortcut Dimension 3 Code" := StaffAdvLines."Shortcut Dimension 3 Code";
                                    PaymentLines.Validate("Shortcut Dimension 3 Code");
                                    PaymentLines."Shortcut Dimension 4 Code" := StaffAdvLines."Shortcut Dimension 4 Code";
                                    PaymentLines.Validate("Shortcut Dimension 4 Code");
                                    PaymentLines.Narration := StaffAdvLines.Purpose;
                                    PaymentLines."Responsibility Center" := StaffAdvLines."Responsibility Center";
                                    PaymentLines.Insert(true);
                                until StaffAdvLines.Next = 0;
                            end;
                        end;


                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        "Posted By" := UserId;
                        "External Doc No." := PVHeadEr."No.";
                        Modify;

                        if "Pay Mode" = "Pay Mode"::Cash then
                            PAGE.Run(51534989, PVHeadEr) // jj300622 Changed from 50008
                        else
                            PAGE.Run(51534983, PVHeadEr);     // jj300622 Changed from 50003
                        CurrPage.Close();
                    end;
                }
                /*    action(Attachment)
                    {
                        Image = Attach;
                        Promoted = true;
                        //PromotedCategory = Attachment;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        //RunObject = Page Page39005911;
                        //RunPageLink = Field50002=FIELD("No.");

                        trigger OnAction()
                        var
                            vartest: Variant;
                        begin

                            UPLOAD('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest)
                        end;
                    }*/
                action(PostAdvance)
                {
                    Caption = 'Post Advance';
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        PostImprest(Rec);
                        CurrPage.Close();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;

        UpdateControls;
        CurrPageUpdate;

    end;

    trigger OnInit()
    begin
        UpdateControls;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //check if the documenent has been added while another one is still pending
        TravReqHeader.Reset;
        //TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
        TravReqHeader.SetRange(TravReqHeader.Status, Status::Open);
        //if TravReqHeader.Count > 0 then begin
        //  Error(Text001);
        //end;

        "Payment Type" := "Payment Type"::Imprest;
        "Account Type" := "Account Type"::Employee;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //"Responsibility Center" := UserMgt.GetPurchasesFilter();
        /*
      //Add dimensions if set by default here
      "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
      Validate("Global Dimension 1 Code");
      "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
      Validate("Shortcut Dimension 2 Code");
      "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
      Validate("Shortcut Dimension 3 Code");
      "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
      Validate("Shortcut Dimension 4 Code");
*/
        UpdateControls;

        //CurrPageUpdate;


    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls();
    end;

    var
        PayLine: Record "Staff Advance Lines";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        RecPayTypes: Record "Receipts and Payment Types";
        //TarriffCodes: Record "Tariff Codes2";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";

        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        Post: Boolean;
        strText: Text[100];
        //PVHead: Record "Cash Office Setup";
        BankAcc: Record "Bank Account";
        //Commitments: Record Committment1;
        //UserMgt: Codeunit "User Setup Management BR1";
        //JournlPosted: Codeunit "Journal Post Successful1";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        DocType: Enum "Approval Document Type";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
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
        PaymentReleaseDateEditable: boolean;
        PayingBankAccountEditable: boolean;
        PayModeEditable: boolean;
        ChequeNoEditable: boolean;
        AccountNoEditable: boolean;
        LineEditable: boolean;
        OthersEditable: boolean;
        OthersVisible: boolean;
        AccountEditable: Boolean;
        PurposeEditable: Boolean;
        PayingBankVisible: Boolean;
        PayingBankNameVisible: Boolean;
        PostingDateVisible: Boolean;
        PaymodeVisible: Boolean;
        ChequeNoVisible: Boolean;
        PageActionsVisible: Boolean;
        CreateVouch: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        AttachmentRec: Record Attachment;
        Text001: Label 'There are still some pending document(s) on your account or you have not retired an existing staff advance.Please list & select the pending document to use.';
        EmployeeRec: Record Employee;
        GLentry: Record "G/L Entry";

        //ApproovedPost: Codeunit "Tax Calculation1";
        ApproovedToPost: Boolean;

    procedure LinesCommitmentStatus() Exists: Boolean
    begin
    end;

    procedure JournlPosted() Posted: Boolean
    var
    //ValPost: Record "Value Posting";
    begin
        // Posted := false;
        // ValPost.SetRange(ValPost.UserID, UserId);
        // ValPost.SetRange(ValPost."Value Posting", 1);
        // if ValPost.Find('-') then
        Posted := true;
    end;

    procedure PostImprest(rec: Record "Staff Advance Header")
    begin
        LineNo := 1000;
        //if Temp.Get(UserId) then begin
        JTemplate := 'BPV';//Temp."Advance Template";
        JBatch := 'BPV';// Temp."Advance  Batch";
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll;
        //end;

        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Date;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := "Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Employee;
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

        //Post := false;
        Post := JournlPosted;//.PostedSuccessfully();
        if Post then begin
            Posted := true;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            Status := Status::Posted;
            Modify;
        end;

        GLentry.SetFilter(GLentry."Document No.", "No.");
        if GLentry.FindFirst then begin
            Posted := true;
            Modify;
        end;

    end;

    procedure CheckImprestRequiredItems(rec: Record "Staff Advance Header")
    begin
        //TESTFIELD("Payment Release Date");
        TestField("Paying Bank Account");
        TestField("Account No.");
        TestField("Account Type", "Account Type"::Employee);

        if Posted then begin
            Error('The Document has already been posted');
        end;

        TestField(Status, Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        // Temp.Get(UserId);
        JTemplate := Temp."Advance Template";
        JBatch := Temp."Advance  Batch";
        /*
                if JTemplate = '' then begin
                    Error('Ensure the Staff Advance Template is set up in Cash Office Setup');
                end;

                if JBatch = '' then begin
                    Error('Ensure the Staff Advance Batch is set up in the Cash Office Setup')
                end;

                if not LinesExists then
                    Error('There are no Lines created for this Document');
        */
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
                    OthersEditable := false;
                    OthersVisible := false;
                    PaymodeVisible := TRUE;
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
                    OthersEditable := false;
                    OthersVisible := false;
                    PaymodeVisible := FALSE;
                END;
            Status::Open:
                BEGIN
                    PaymentReleaseDateEditable := FALSE;
                    PayingBankAccountEditable := FALSE;
                    PayModeEditable := FALSE;
                    ChequeNoEditable := FALSE;
                    PayingBankVisible := FALSE;
                    AccountNoEditable := True;
                    PaymodeVisible := FALSE;
                    LineEditable := true;
                    OthersEditable := true;
                    OthersVisible := true;
                END
        END;
    end;



    procedure LinesExists(): Boolean
    var
        PayLines: Record "Staff Advance Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."No.", "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Staff Advance Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines."No.", "No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines.Amount <= 0) then   //Modify by Gbenga 4/23/2018
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        //xRec := Rec;
        //UpdateControls();
    end;

    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
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


