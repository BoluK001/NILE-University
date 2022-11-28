page 51534850 "All Staff Advance Retirement"
{
    Caption = 'Cash Advance Retire List';
    CardPageID = "Staff Advance Accounting";
    PageType = List;
    AdditionalSearchTerms = 'Cash Advance Retire List';
    SourceTable = "Staff Advance Surrender Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(No; "No.")
                {
                    ApplicationArea = All;
                }
                field("Imprest Issue Doc. No"; "Imprest Issue Doc. No")
                {
                    ApplicationArea = All;
                }
                field("Surrender Date"; "Surrender Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Surrendered; Surrendered)
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
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    ApplicationArea = All;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries:Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Retirement";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Staff Advance Surrender Header", DocType.AsInteger(), "No.");
                    end;

                }
                separator(Action1102755025)
                {
                }
                action(Post)
                {
                    Caption = 'Post';
                    ApplicationArea = All;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Txt0001: Label 'Actual Spent and the Cash Receipt Amount should be equal to the amount Issued';
                    begin
                        TestField(Status, Status::Approved);
                        TestField("Surrender Posting Date");


                        if Posted then
                            Error('The transaction has already been posted.');

                        //Ensure actual spent does not exceed the amount on original document
                        CalcFields("Actual Spent", "Cash Receipt Amount");
                        if ("Actual Spent" + "Cash Receipt Amount") < Amount then
                            Error('Please select the receipt used to receipt money not actually spent');

                        //test that any modifications to the document do not exceed the amount on original document
                        CalcFields("Actual Spent");
                        //IF "Actual Spent"<>"Amount on Original Document" THEN ERROR('The amount on the original document differs from the current actual amount spent by  %1',("Actual Spent"-"Amount on Original Document"));

                        //Get the Cash office user template
                        Temp.Get(UserId);
                        SurrBatch := Temp."Advance Surr Batch";
                        SurrTemplate := Temp."Advance Surr Template";


                        //HOW ABOUT WHERE ONE RETURNS ALL THE AMOUNT??
                        //THERE SHOULD BE NO GENJNL ENTRIES BUT REVERSE THE COMMITTMENTS
                        CalcFields("Actual Spent");
                        if "Actual Spent" = 0 then
                            if Confirm(Text000, true) then
                                UpdateforNoActualSpent
                            else
                                Error(Text001);

                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        if GenledSetup.Get then begin
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", SurrTemplate);
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", SurrBatch);
                            GenJnlLine.DeleteAll;
                        end;

                        if DefaultBatch.Get(SurrTemplate, SurrBatch) then begin
                            DefaultBatch.Delete;
                        end;

                        DefaultBatch.Reset;
                        DefaultBatch."Journal Template Name" := SurrTemplate;
                        DefaultBatch.Name := SurrBatch;
                        DefaultBatch.Insert;
                        LineNo := 0;

                        ImprestDetails.Reset;
                        ImprestDetails.SetRange(ImprestDetails."Surrender Doc No.", "No.");
                        if ImprestDetails.Find('-') then begin
                            repeat
                                //Post Surrender Journal
                                //Compare the amount issued =amount on cash reciecied.
                                //Created new field for zero spent
                                //

                                //ImprestDetails.TESTFIELD("Actual Spent");
                                //ImprestDetails.TESTFIELD("Actual Spent");
                                /*
                                IF (ImprestDetails."Cash Receipt Amount"+ImprestDetails."Actual Spent")<>ImprestDetails.Amount THEN
                                   ERROR(Txt0001);
                                       */
                                TestField("Global Dimension 1 Code");


                                LineNo := LineNo + 1000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := SurrTemplate;
                                GenJnlLine."Journal Batch Name" := SurrBatch;
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                RecPayTypes.Get(ImprestDetails."Imprest Type", RecPayTypes.Type::Advance);
                                //GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account Type" := RecPayTypes."Account Type";
                                GenJnlLine."Account No." := ImprestDetails."Account No.";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //Set these fields to blanks
                                GenJnlLine."Posting Date" := "Surrender Posting Date";
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine.Validate("Gen. Posting Type");
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Bus. Posting Group");
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Prod. Posting Group");
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine.Validate("VAT Bus. Posting Group");
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine.Validate("VAT Prod. Posting Group");
                                GenJnlLine."Document No." := "No.";
                                GenJnlLine.Amount := ImprestDetails."Actual Spent";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
                                //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
                                GenJnlLine.Description := CopyStr('Advance Surrendered ' + ImprestDetails."Account Name", 1, 50);
                                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Currency Code" := "Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                //Take care of Currency Factor
                                GenJnlLine."Currency Factor" := "Currency Factor";
                                GenJnlLine.Validate("Currency Factor");

                                GenJnlLine."Shortcut Dimension 1 Code" := ImprestDetails."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ImprestDetails."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, ImprestDetails."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, ImprestDetails."Shortcut Dimension 4 Code");

                                //Application of Surrender entries
                                if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then begin
                                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := "Imprest Issue Doc. No";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := "Apply to ID";
                                end;

                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;

                                //insert balancing customer Entries

                                LineNo := LineNo + 1000;
                                GenJnlLine.Init;
                                GenJnlLine."Journal Template Name" := SurrTemplate;
                                GenJnlLine."Journal Batch Name" := SurrBatch;
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                GenJnlLine."Account No." := ImprestDetails."Advance Holder";
                                ;
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //Set these fields to blanks
                                GenJnlLine."Posting Date" := "Surrender Posting Date";
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine.Validate("Gen. Posting Type");
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Bus. Posting Group");
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Prod. Posting Group");
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine.Validate("VAT Bus. Posting Group");
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine.Validate("VAT Prod. Posting Group");
                                GenJnlLine."Document No." := "No.";
                                CalcFields(Difference);
                                if Difference < 0 then
                                    GenJnlLine.Amount := -ImprestDetails.Amount
                                else
                                    GenJnlLine.Amount := -ImprestDetails."Actual Spent";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
                                //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
                                GenJnlLine.Description := CopyStr('Advance Surrendered ' + ImprestDetails."Account Name", 1, 50);
                                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Currency Code" := "Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                //Take care of Currency Factor
                                GenJnlLine."Currency Factor" := "Currency Factor";
                                GenJnlLine.Validate("Currency Factor");

                                GenJnlLine."Shortcut Dimension 1 Code" := ImprestDetails."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ImprestDetails."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, ImprestDetails."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, ImprestDetails."Shortcut Dimension 4 Code");

                                //Application of Surrender entries
                                if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
                                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := "Imprest Issue Doc. No";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := "Apply to ID";
                                end;

                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert;

                            until ImprestDetails.Next = 0;

                            //insert balancing bank Entries
                            CalcFields(Difference);
                            if Difference < 0 then
                                InsertBankBalancing;

                            //Post Entries
                            GenJnlLine.Reset;
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", SurrTemplate);
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", SurrBatch);
                            //Adjust Gen Jnl Exchange Rate Rounding Balances
                            AdjustGenJnl.Run(GenJnlLine);
                            //End Adjust Gen Jnl Exchange Rate Rounding Balances

                            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                        end;

                        if JournalPostSuccessful.PostedSuccessfully then begin
                            Posted := true;
                            Status := Status::Posted;
                            "Date Posted" := Today;
                            "Time Posted" := Time;
                            "Posted By" := UserId;
                            Modify;
                            //Tag the Source Imprest Requisition as Surrendered
                            ImprestReq.Reset;
                            ImprestReq.SetRange(ImprestReq."No.", "Imprest Issue Doc. No");
                            if ImprestReq.Find('-') then begin
                                ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
                                ImprestReq.Modify;
                            end;

                            //End Tag
                            //Post Committment Reversals
                            Doc_Type := Doc_Type::StaffSurrender;
                            //BudgetControl.ReverseEntries(Doc_Type,"No.");
                        end;

                    end;
                }
                separator(Action1102755022)
                {
                }
                action("Check Budgetary Availability")
                {
                    ApplicationArea = All;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Ensure actual spent does not exceed the amount on original document
                        CalcFields("Actual Spent", "Cash Receipt Amount");
                        if "Actual Spent" + "Cash Receipt Amount" > Amount then
                            Error('The actual Amount spent should not exceed the amount issued ');

                        //Post Committment Reversals of the Staff Advance if it had not been reversed
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                        Commitments.SetRange(Commitments."Document No.", "Imprest Issue Doc. No");
                        Commitments.SetRange(Commitments.Committed, false);
                        if not Commitments.Find('-') then begin
                            Doc_Type := Doc_Type::StaffAdvance;
                            //BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
                        end;

                        //First Check whether other lines are already committed.
                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffSurrender);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then begin exit end;
                            Commitments.Reset;
                            Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffSurrender);
                            Commitments.SetRange(Commitments."Document No.", "No.");
                            Commitments.DeleteAll;
                        end;

                        //Check the Budget here
                        //    CheckBudgetAvail.CheckStaffAdvSurr(Rec); Lateef
                    end;
                }
                action("Cancel Budgetary Allocation")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Budgetary Allocation';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then begin exit end;

                        Commitments.Reset;
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::StaffSurrender);
                        Commitments.SetRange(Commitments."Document No.", "No.");
                        Commitments.DeleteAll;

                        Payline.Reset;
                        Payline.SetRange(Payline."Surrender Doc No.", "No.");
                        if Payline.Find('-') then begin
                            repeat
                                Payline.Committed := false;
                                Payline.Modify;
                            until Payline.Next = 0;
                        end;
                    end;
                }
                separator(Action1102755018)
                {
                }
                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                        Txt0001: Label 'Actual Spent and the Cash Receipt Amount should be equal to the amount Issued';
                    begin
                        //Ensure actual spent does not exceed the amount on original document
                        CalcFields("Actual Spent", "Cash Receipt Amount", Difference);

                        "Amount on Original Document" := "Actual Spent";
                        Modify;

                        if Difference <> 0 then//"Actual Spent"+"Cash Receipt Amount" > Amount THEN
                            if not Confirm('The actual Amount spent differs with the amount issued by %1 ,do you want to continue ', false, Difference) then exit;
                        /*
                              IF "Actual Spent"+"Cash Receipt Amount" > Amount THEN
                              ERROR('The actual Amount spent should not exceed the amount issued ');
                        */
                        /*
                        //First Check whether all amount entered tally
                        ImprestDetails.RESET;
                        ImprestDetails.SETRANGE(ImprestDetails."Surrender Doc No.",No);
                        IF ImprestDetails.FIND('-') THEN BEGIN
                        REPEAT
                          IF (ImprestDetails."Cash Receipt Amount"+ImprestDetails."Actual Spent")<>ImprestDetails.Amount THEN
                              ERROR(Txt0001);
                        
                        UNTIL ImprestDetails.NEXT = 0;
                        END;
                        */
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                            Error('There are some lines that have not been committed');

                        //Release the ImprestSurrender for Approval

                        if ApprovalsMgmt.CheckAdvanceSurrenderApprovalsWorkflowEnable(Rec) then
                            ApprovalsMgmt.OnSendAdvanceSurrenderForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Mgmt. ExtCal";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        //IF ApprovalMgt.CancelAdvanceSUApprovalRequest(Rec,TRUE,TRUE) THEN;

                        ApprovalsMgmt.OnCancelAdvanceSurrenderForApproval(Rec); //Dennsi!
                        WorkflowWebhookMgt.FindAndCancel(RecordId);
                    end;
                }
                separator(Action1102755012)
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

                    trigger OnAction()
                    begin
                        //Post Committment Reversals
                        TestField(Status, Status::Approved);
                        if Confirm(Text002, true) then begin
                            Doc_Type := Doc_Type::Imprest;
                            //BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
                            Status := Status::Cancelled;
                            Modify;
                        end;
                    end;
                }
                separator(Action1102755008)
                {
                }
                action("Open for OverExpenditure")
                {
                    ApplicationArea = All;
                    Caption = 'Open for OverExpenditure';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Opening should only be for Pending Documents
                        //TESTFIELD(Status,Status::Open);
                        //Open for Overexpenditure
                        "Allow Overexpenditure" := true;
                        "Open for Overexpenditure by" := UserId;
                        "Date opened for OvExpenditure" := Today;
                        Modify;
                        //Open lines
                        Payline.Reset;
                        Payline.SetRange(Payline."Surrender Doc No.", "No.");
                        if Payline.Find('-') then begin
                            repeat
                                Payline."Allow Overexpenditure" := true;
                                Payline."Open for Overexpenditure by" := UserId;
                                Payline."Date opened for OvExpenditure" := Today;
                                Payline.Modify;
                            until Payline.Next = 0;
                        end;
                        //End open for Overexpenditure
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(51534753, true, true, Rec);
                        Reset;
                    end;
                }
                action(Upload)
                {
                    ApplicationArea = All;
                    // Image = TransmitElectronicDoc;

                    // trigger OnAction()
                    // var
                    //     vartest: Variant;
                    //     TestFile: File;
                    //     FilePath: Text;
                    //     FileName: Text;
                    //     DocNo: Code[20];
                    //     varLink: Text;
                    //     DocRecRef: RecordRef;
                    //     MyFieldRef: FieldRef;
                    //     LinkId: Integer;
                    //     CopyFrom: Text;
                    //     CopyTo: Text;
                    // begin
                    //     if Upload('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|EXCEL File(*.xlsx)|*.xlsx|WORD File(*.docx)|*.docx|ALL Files(*.*)|*.*', 'Upload.txt', vartest) then begin
                    //         Message('File successfully uploaded to the server', vartest);
                    //         //TestFile.OPEN(vartest);
                    //         //FileName:=TestFile.NAME;
                    //         //MESSAGE('%1',FileName);

                    //         DocNo := "No.";
                    //         DocRecRef.Open(DATABASE::"Staff Advance Surrender Header");
                    //         MyFieldRef := DocRecRef.Field(1);
                    //         MyFieldRef.Value := DocNo;
                    //         if DocRecRef.Find('=') then begin
                    //             LinkId := DocRecRef.AddLink(vartest);
                    //             RecordLinks.Get(LinkId);
                    //             RecordLinks.Validate(Type);
                    //             //  MESSAGE('link %1 added successfully',LinkId);
                    //             /*
                    //             //taken to record links table for server side processing
                    //             RecordLinks.GET(LinkId);
                    //             CopyFrom:=RecordLinks.URL1;
                    //             FileName:=GetFileName(RecordLinks.URL1);
                    //             CopyTo:='C:\NavAttachments\'+FileName;
                    //             FILE.COPY(CopyFrom,CopyTo);
                    //             RecordLinks.URL1:=CopyTo;
                    //             RecordLinks.Description:=FileName;
                    //             RecordLinks.MODIFY;
                    //             */
                    //         end
                    //         else
                    //             Message('Link not added');

                    //     end
                    //     else
                    //         Error('File not Successfully uploaded');

                    // end;
                }
            }
        }
    }

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
        END;
        */
        // if Usertemplate.Get(UserId) then begin
        //     if Usertemplate."Maximum Document Amount" > 0 then begin
        //         FilterGroup(2);
        //         //CALCFIELDS("Total Payment Amount");
        //         SetFilter(Amount, '..%1', Usertemplate."Maximum Document Amount");
        //         FilterGroup(0);
        //     end;
        // end;

    end;

    var
        Text000: Label 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        Text001: Label 'Document Not Posted';
        Text002: Label 'Are you sure you want to Cancel this Document?';
        Text19053222: Label 'Enter Advance Accounting Details below';
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        NextEntryNo: Integer;
        CommitNo: Integer;
        ImprestDetails: Record "Staff Advanc Surrender Details";
        Usertemplate: Record "Cash Office User Template";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        IsImprest: Boolean;
        //ImprestRequestDet: Record "Payments-Users";
        GenledSetup: Record "Cash Office Setup";
        ImprestAmt: Decimal;
        DimName1: Text[60];
        DimName2: Text[60];
        //CashPaymentLine: Record "Cash Voucher Line";
        PaymentLine: Record "Staff Advance Lines";
        CurrSurrDocNo: Code[20];
        JournalPostSuccessful: Codeunit "Journal Post Successful";
        Commitments: Record Committment;
        BCSetup: Record "Budgetary Control Setup";
        //BudgetControl: Codeunit "Budgetary Control";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender;
        ImprestReq: Record "Staff Advance Header";
        UserMgt: Codeunit "User Setup Management BR";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        DocumentType: enum "Approval Document Type";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AccountName: Text[100];
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        TravAccHeader: Record "Staff Advance Surrender Header";
        //CheckBudgetAvail: Codeunit "Budgetary Control";
        Payline: Record "Staff Advanc Surrender Details";
        Temp: Record "Cash Office User Template";
        SurrBatch: Code[20];
        SurrTemplate: Code[20];
        [InDataSet]
        "Surrender DateEditable": Boolean;
        [InDataSet]
        "Account No.Editable": Boolean;
        [InDataSet]
        "Imprest Issue Doc. NoEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Surrender Posting DateEditable": Boolean;
        [InDataSet]
        ImprestLinesEditable: Boolean;
        StatusEditable: Boolean;
        RecRef: RecordRef;
        RecordLinks: Record "Record Link";
        FileName: Text;

    [Scope('OnPrem')]
    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin
        if Status <> Status::Open then begin
            "Surrender DateEditable" := false;
            "Account No.Editable" := false;
            "Imprest Issue Doc. NoEditable" := false;
            "Responsibility CenterEditable" := true;
            "Surrender Posting DateEditable" := true;
            //   ImprestLinesEditable :=FALSE;
        end else begin
            "Surrender DateEditable" := true;
            "Account No.Editable" := true;
            "Imprest Issue Doc. NoEditable" := true;
            "Responsibility CenterEditable" := true;
            "Surrender Posting DateEditable" := false;
            //   ImprestLinesEditable :=TRUE;

        end;
    end;

    [Scope('OnPrem')]
    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Customer;
    begin
        Name := '';
        if Cust.Get("No.") then
            Name := Cust.Name;
        exit(Name);
    end;

    [Scope('OnPrem')]
    procedure UpdateforNoActualSpent()
    begin
        Posted := true;
        Status := Status::Posted;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        //Tag the Source Imprest Requisition as Surrendered
        ImprestReq.Reset;
        ImprestReq.SetRange(ImprestReq."No.", "Imprest Issue Doc. No");
        if ImprestReq.Find('-') then begin
            ImprestReq."Surrender Status" := ImprestReq."Surrender Status"::Full;
            ImprestReq.Modify;
        end;
        //End Tag
        //Post Committment Reversals
        Doc_Type := Doc_Type::StaffSurrender;
        //BudgetControl.ReverseEntries(Doc_Type, "Imprest Issue Doc. No");
    end;

    [Scope('OnPrem')]
    procedure CompareAllAmounts()
    begin
    end;

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
        Payline.Reset;
        Payline.SetRange(Payline."Surrender Doc No.", "No.");
        Payline.SetRange(Payline.Committed, false);
        Payline.SetRange(Payline."Budgetary Control A/C", true);
        if Payline.Find('-') then
            Exists := true;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        /*
        xRec := Rec;
        //Update Controls as necessary
        //SETFILTER(Status,'<>Cancelled');
        UpdateControl;
        DimName1:=GetDimensionName("Global Dimension 1 Code",1);
        DimName2:=GetDimensionName("Shortcut Dimension 2 Code",2);
        AccountName:=GetCustName("Account No.");
        */

    end;

    [Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        AccountName := GetCustName("Account No.");
        DimName1 := GetDimensionName("Global Dimension 1 Code", 1);
        DimName2 := GetDimensionName("Shortcut Dimension 2 Code", 2);
        CurrPage.Update;
    end;

    [Scope('OnPrem')]
    procedure InsertBalancing()
    begin
        //insert customer balancing
        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := SurrTemplate;
        GenJnlLine."Journal Batch Name" := SurrBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := "Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //Set these fields to blanks
        GenJnlLine."Posting Date" := "Surrender Posting Date";
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
        GenJnlLine.Validate("Gen. Posting Type");
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine.Validate("Gen. Bus. Posting Group");
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine.Validate("Gen. Prod. Posting Group");
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine.Validate("VAT Bus. Posting Group");
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.Validate("VAT Prod. Posting Group");
        GenJnlLine."Document No." := "No.";
        //Rec.CALCFIELDS(Difference);
        GenJnlLine.Amount := -Amount;//ImprestDetails."Actual Spent";
        GenJnlLine.Validate(GenJnlLine.Amount);
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
        //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
        GenJnlLine.Description := 'Advance Surrendered by staff';
        //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Currency Code" := "Currency Code";
        GenJnlLine.Validate("Currency Code");
        //Take care of Currency Factor
        GenJnlLine."Currency Factor" := "Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

        //Application of Surrender entries
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := "Imprest Issue Doc. No";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID" := "Apply to ID";
        end;

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
    end;

    [Scope('OnPrem')]
    procedure InsertBankBalancing()
    begin

        LineNo := LineNo + 1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name" := SurrTemplate;
        GenJnlLine."Journal Batch Name" := SurrBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := "Bank Code";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        //Set these fields to blanks
        GenJnlLine."Posting Date" := "Surrender Posting Date";
        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
        GenJnlLine.Validate("Gen. Posting Type");
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine.Validate("Gen. Bus. Posting Group");
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine.Validate("Gen. Prod. Posting Group");
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine.Validate("VAT Bus. Posting Group");
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.Validate("VAT Prod. Posting Group");
        GenJnlLine."Document No." := "No.";
        GenJnlLine."External Document No." := ImprestDetails."Cash Receipt No";
        Rec.CalcFields(Difference);
        GenJnlLine.Amount := Difference;
        GenJnlLine.Validate(GenJnlLine.Amount);
        //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Customer;
        //GenJnlLine."Bal. Account No.":=ImprestDetails."Advance Holder";
        GenJnlLine.Description := 'Advance Surrendered by staff';
        //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Currency Code" := "Currency Code";
        GenJnlLine.Validate("Currency Code");
        //Take care of Currency Factor
        GenJnlLine."Currency Factor" := "Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

        //Application of Surrender entries
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then begin
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            GenJnlLine."Applies-to Doc. No." := "Imprest Issue Doc. No";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID" := "Apply to ID";
        end;

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert;
    end;
}

