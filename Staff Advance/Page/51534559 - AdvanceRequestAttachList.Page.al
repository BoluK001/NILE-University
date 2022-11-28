// page 51534559 "Advance Request Attach List"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Staff Advance Header";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; "No.")
//                 {
//                     Editable = false;
//                     ApplicationArea = All;
//                 }
//                 field(Date; Date)
//                 {
//                     ApplicationArea = All;
//                     Editable = DateEditable;
//                 }
//                 field("Account Type"; "Account Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Account No."; "Account No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Payee; Payee)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Currency Code"; "Currency Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = "Currency CodeEditable";
//                 }
//                 field("Paying Bank Account"; "Paying Bank Account")
//                 {
//                     ApplicationArea = All;
//                     Editable = "Paying Bank AccountEditable";
//                 }
//                 field("Bank Name"; "Bank Name")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Status; Status)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Total Net Amount"; "Total Net Amount")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Total Net Amount LCY"; "Total Net Amount LCY")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Responsibility Center"; "Responsibility Center")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("&Functions")
//             {
//                 Caption = '&Functions';
//                 action(aa)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Attachment';
//                     //RunObject = Page "Attachment Test";
//                     // RunPageLink = "Employee No" = FIELD(Cashier), "Application No" = FIELD("No."),
//                     //             "Folder Type" = CONST(Finance),
//                     //           "Document Type" = CONST(Finance);
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         /*
//        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
//          FILTERGROUP(2);
//          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
//          FILTERGROUP(0);
//        END;



//        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
//          FILTERGROUP(2);
//          SETRANGE("Shortcut Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
//          FILTERGROUP(0);
//        END;
//        */

//     end;

//     var
//         PayLine: Record "Staff Advance Lines";
//         ////PVUsers: Record "CshMgt PV Steps Users";
//         strFilter: Text[250];
//         IntC: Integer;
//         IntCount: Integer;
//         //Payments: Record "Payments Header";
//         RecPayTypes: Record "Receipts and Payment Types";
//         TarriffCodes: Record "Tariff Codes";
//         GenJnlLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         CashierLinks: Record "Cash Office User Template";
//         LineNo: Integer;
//         Temp: Record "Cash Office User Template";
//         JTemplate: Code[20];
//         JBatch: Code[20];
//         PCheck: Codeunit "Posting Check FP";
//         Post: Boolean;
//         strText: Text[100];
//         //PVHead: Record "Payments Header";
//         BankAcc: Record "Bank Account";
//         ////CheckBudgetAvail: Codeunit "Budgetary Control";
//         //Commitments: Record Committment;
//         UserMgt: Codeunit "User Setup Management BR";
//         JournlPosted: Codeunit "Journal Post Successful";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
//         HasLines: Boolean;
//         AllKeyFieldsEntered: Boolean;
//         Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
//         ////BudgetControl: Codeunit "Budgetary Control";
//         TravReqHeader: Record "Staff Advance Header";
//         [InDataSet]
//         "Payment Release DateEditable": Boolean;
//         [InDataSet]
//         "Paying Bank AccountEditable": Boolean;
//         [InDataSet]
//         "Pay ModeEditable": Boolean;
//         [InDataSet]
//         "Cheque No.Editable": Boolean;
//         [InDataSet]
//         GlobalDimension1CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension2CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension3CodeEditable: Boolean;
//         [InDataSet]
//         ShortcutDimension4CodeEditable: Boolean;
//         [InDataSet]
//         DateEditable: Boolean;
//         [InDataSet]
//         "Currency CodeEditable": Boolean;
//         //PaymentsHeader: Record "Payments Header";
//         PaymentsLines: Record "Voucher Line";
//         PayModeOption: Integer;
//         StaffAdvanceHeader: Record "Staff Advance Header";
//         StaffAdvanceLines: Record "Staff Advance Lines";
//         AdvLines: Record "Staff Advance Lines";
//         AdvHeader: Record "Staff Advance Header";

//     [Scope('OnPrem')]
//     procedure LinesCommitmentStatus() Exists: Boolean
//     var
//         BCsetup: Record "Budgetary Control Setup";
//     begin
//         if BCsetup.Get() then begin
//             if not BCsetup.Mandatory then begin
//                 Exists := false;
//                 exit;
//             end;
//         end else begin
//             Exists := false;
//             exit;
//         end;
//         Exists := false;
//         PayLine.Reset;
//         PayLine.SetRange(PayLine."No.", "No.");
//         PayLine.SetRange(PayLine.Committed, false);
//         PayLine.SetRange(PayLine."Budgetary Control A/C", true);
//         if PayLine.Find('-') then
//             Exists := true;
//     end;

//     [Scope('OnPrem')]
//     procedure PostImprest()
//     begin

//         if Temp.Get(UserId) then begin
//             GenJnlLine.Reset;
//             GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//             GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//             GenJnlLine.DeleteAll;
//         end;

//         LineNo := LineNo + 1000;
//         GenJnlLine.Init;
//         GenJnlLine."Journal Template Name" := JTemplate;
//         GenJnlLine."Journal Batch Name" := JBatch;
//         GenJnlLine."Line No." := LineNo;
//         GenJnlLine."Source Code" := 'PAYMENTJNL';
//         GenJnlLine."Posting Date" := "Payment Release Date";
//         GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
//         GenJnlLine."Document No." := "No.";
//         GenJnlLine."External Document No." := "Cheque No.";
//         GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
//         GenJnlLine."Account No." := "Account No.";
//         GenJnlLine.Validate(GenJnlLine."Account No.");
//         GenJnlLine.Description := 'Advance: ' + "Account No." + ':' + Payee;
//         CalcFields("Total Net Amount");
//         GenJnlLine.Amount := "Total Net Amount";
//         GenJnlLine.Validate(GenJnlLine.Amount);
//         GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
//         GenJnlLine."Bal. Account No." := "Paying Bank Account";
//         GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
//         //Added for Currency Codes
//         GenJnlLine."Currency Code" := "Currency Code";
//         GenJnlLine.Validate("Currency Code");
//         GenJnlLine."Currency Factor" := "Currency Factor";
//         GenJnlLine.Validate("Currency Factor");
//         /*
//         GenJnlLine."Currency Factor":=Payments."Currency Factor";
//         GenJnlLine.VALIDATE("Currency Factor");
//         */
//         GenJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//         GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//         GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
//         GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

//         if GenJnlLine.Amount <> 0 then
//             GenJnlLine.Insert;


//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//         CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

//         Post := false;
//         Post := JournlPosted.PostedSuccessfully();
//         if Post then begin
//             Posted := true;
//             "Date Posted" := Today;
//             "Time Posted" := Time;
//             "Posted By" := UserId;
//             Status := Status::Posted;
//             Modify;
//         end;

//     end;

//     [Scope('OnPrem')]
//     procedure CheckImprestRequiredItems()
//     begin

//         TestField("Payment Release Date");
//         TestField("Paying Bank Account");
//         TestField("Account No.");
//         //TestField("Account Type", "Account Type"::Employee);

//         if Posted then begin
//             Error('The Document has already been posted');
//         end;

//         TestField(Status, Status::Approved);

//         /*Check if the user has selected all the relevant fields*/

//         Temp.Get(UserId);
//         JTemplate := Temp."Advance Template";
//         JBatch := Temp."Advance  Batch";

//         if JTemplate = '' then begin
//             Error('Ensure the Staff Advance Template is set up in Cash Office Setup');
//         end;

//         if JBatch = '' then begin
//             Error('Ensure the Staff Advance Batch is set up in the Cash Office Setup')
//         end;

//         if not LinesExists then
//             Error('There are no Lines created for this Document');

//     end;

//     [Scope('OnPrem')]
//     procedure UpdateControls()
//     begin
//     end;

//     [Scope('OnPrem')]
//     procedure LinesExists(): Boolean
//     var
//         VouchLine: Record "Staff Advance Lines";
//     begin
//         HasLines := false;
//         VouchLine.Reset;
//         VouchLine.SetRange(VouchLine."No.", "No.");
//         if VouchLine.Find('-') then begin
//             HasLines := true;
//             exit(HasLines);
//         end;
//     end;

//     [Scope('OnPrem')]
//     procedure AllFieldsEntered(): Boolean
//     var
//         VouchLine: Record "Staff Advance Lines";
//     begin
//         AllKeyFieldsEntered := true;
//         VouchLine.Reset;
//         VouchLine.SetRange(VouchLine."No.", "No.");
//         if VouchLine.Find('-') then begin
//             repeat
//                 if (VouchLine."Account No." = '') or (VouchLine.Amount <= 0) then
//                     AllKeyFieldsEntered := false;
//             until VouchLine.Next = 0;
//             exit(AllKeyFieldsEntered);
//         end;
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         UpdateControls();
//     end;
// }

