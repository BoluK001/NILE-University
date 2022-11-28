page 51534363 "Internal Requisitions"  //page 39005882
{
    Caption = 'Purchase Requisition';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Category5_caption,Category6_caption,Print/Send,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), "Purchase Type" = FILTER(Requisition));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                    Importance = Standard;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                    Importance = Additional;
                }
                field("Procurement Type Code"; "Procurement Type Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Editable = EditNo;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = EditNo;
                    Importance = Additional;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            part(PurchLines; "Purchase Quote Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                Editable = EditNo;
            }
            // group("Foreign Trade")
            // {ApplicationArea = All;
            //     Caption = 'Foreign Trade';
            //     field("Currency Code"; "Currency Code")
            //     {ApplicationArea = All;
            //         Importance = Promoted;

            //         trigger OnAssistEdit()
            //         begin
            //             CLEAR(ChangeExchangeRate);
            //             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
            //             IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
            //                 VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
            //                 CurrPage.UPDATE;
            //             END;
            //             CLEAR(ChangeExchangeRate);
            //         end;

            //         trigger OnValidate()
            //         begin
            //             CurrencyCodeOnAfterValidate;
            //         end;
            //     }

            /*    //jj I remmed 280522
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = All;
            }
            field("Transaction Specification"; "Transaction Specification")
            {
                ApplicationArea = All;
            }
            field("Transport Method"; "Transport Method")
            {
                ApplicationArea = All;
            }
            field("Entry Point"; "Entry Point")
            {
                ApplicationArea = All;
            }
            field(Area1; Area)
            {
                ApplicationArea = All;
            }  */
        }
        area(factboxes)
        {

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;

                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(38),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {

                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                // action("Co&mments")
                // {ApplicationArea = All;
                //     Caption = 'Co&mments';
                //     Image = ViewComments;
                //     RunObject = Page 66;
                //                     RunPageLink = "Document Type"=FIELD("Document Type"),
                //                   No.=FIELD("No."),
                //                   Document Line No.=CONST(0);
                // }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
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
                        DocType := doctype::Requisition;

                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Purchase Header", DocType.AsInteger(), Rec."No.");
                    end;

                }
            }
        }
        area(processing)
        {
            action(MakeOrder)
            {
                ApplicationArea = Suite;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Convert the purchase quote to a purchase order.';
                Visible = false;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                begin
                    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                        CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
            action("Get Operatn Lea&se(Purchase)")
            {
                ApplicationArea = All;
                Caption = 'Get (Purchase)';
                Description = 'Get Operation(Purchase)';
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = XMLport 51534350;
                Visible = false;

                trigger OnAction()
                begin
                    //   RESET;
                    //       SETFILTER("No.","No.");
                    //       XMLPORT.RUN(51534350,TRUE,TRUE,Rec);
                    //     RESET;

                    // TempPerm.GET(USERID);
                    // IF TempPerm."Allow  Operational Leasing" = FALSE THEN
                    //     ERROR('you do not have permission to do this operation, contact the administrator');

                    SETRANGE("Document Type", "Document Type");
                    SETRANGE("No.", "No.");
                    SETRANGE("Buy-from Vendor No.", "Buy-from Vendor No.");
                    //REPORT.RUNMODAL(REPORT::Report39006106, TRUE, FALSE, Rec); Dennis
                    SETRANGE("No.");

                    /*
                    //Use with the Integar report
                    REPORT.RUNMODAL(REPORT::"upload P&L ENTRIES",TRUE,FALSE,Rec);
                    */
                end;
            }

            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    IF LinesCommitted THEN
                        ERROR('All Lines should be committed');
                    RESET;
                    SETRANGE("No.", "No.");
                    REPORT.RUN(51534931, TRUE, TRUE, Rec);
                    RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(f)
                {
                }
                /* action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                } */
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {

                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(g)
                {

                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record 175;
                    begin
                        Setrange(Status, Status::Released);
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(S)
                {

                }
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        // CopyPurchDoc.SetPurchHeader(Rec);
                        // CopyPurchDoc.RUNMODAL;
                        // CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        Setrange(Status, Status::Released);
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(u)
                {

                }
                group("Request Approval")
                {

                    Caption = 'Request Approval';
                    Image = "Action";
                    action(SendApprovalRequest)
                    {

                        ApplicationArea = Basic, Suite;
                        Caption = 'Send A&pproval Request';
                        Enabled = NOT OpenApprovalEntriesExist;
                        Image = SendApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Request approval of the document.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                                ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval Re&quest';
                        Enabled = CanCancelApprovalForRecord;
                        Image = CancelApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category4;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Cancel the approval request.';

                        trigger OnAction()
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        end;
                    }
                }
                separator(k)
                {

                }
                action("Check Budget Availability")
                {
                    ApplicationArea = All;
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;

                        IF Status = Status::Released THEN
                            ERROR('This document has already been released. This functionality is available for open documents only');
                        IF NOT SomeLinesCommitted THEN BEGIN
                            IF NOT CONFIRM('Some or All the Lines Are already Committed do you want to continue', TRUE, "Document Type") THEN
                                ERROR('Budget Availability Check and Commitment Aborted');
                            DeleteCommitment.RESET;
                            DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                            DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", "No.");
                            DeleteCommitment.DELETEALL;
                        END;
                        Commitment.CheckPurchase(Rec);
                        MESSAGE('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = All;
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = False;

                    trigger OnAction()
                    begin

                        IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE, "Document Type") THEN
                            ERROR('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.RESET;
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", "No.");
                        DeleteCommitment.DELETEALL;
                        //Tag all the Purchase Line entries as Uncommitted
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document Type", "Document Type");
                        PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                        IF PurchLine.FIND('-') THEN BEGIN
                            REPEAT
                                PurchLine.Committed := FALSE;
                                PurchLine.MODIFY;
                            UNTIL PurchLine.NEXT = 0;
                        END;

                        MESSAGE('Commitments Cancelled Successfully for Doc. No %1', "No.");
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Purchase Type" := "Purchase Type"::Requisition;
        "Buy-from Vendor No." := 'INT001';
        Validate("Buy-from Vendor No.");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        SetSecurityFilterOnRespCenter;

        CopyBuyFromVendorFilter;

        EditNo := true;
        if Status <> Status::Open
        then
            EditNo := false;
    end;

    var
        DocPrint: Codeunit "Document-Print";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    [Scope('OnPrem')]
    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        IF BCSetup.GET() THEN BEGIN
            IF NOT BCSetup.Mandatory THEN BEGIN
                Exists := FALSE;
                EXIT;
            END;
        END ELSE BEGIN
            Exists := FALSE;
            EXIT;
        END;
        IF BCSetup.GET THEN BEGIN
            Exists := FALSE;
            PurchLines.RESET;
            PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
            PurchLines.SETRANGE(PurchLines."Document No.", "No.");
            PurchLines.SETRANGE(PurchLines.Committed, FALSE);
            IF PurchLines.FIND('-') THEN
                Exists := TRUE;
        END ELSE
            Exists := FALSE;
    end;

    [Scope('OnPrem')]
    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        IF BCSetup.GET THEN BEGIN
            Exists := FALSE;
            PurchLines.RESET;
            PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
            PurchLines.SETRANGE(PurchLines."Document No.", "No.");
            PurchLines.SETRANGE(PurchLines.Committed, TRUE);
            IF PurchLines.FIND('-') THEN
                Exists := TRUE;
        END ELSE
            Exists := FALSE;
    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin
        IF Status = Status::Open THEN
            StatusEditable := TRUE
        ELSE
            StatusEditable := FALSE;
    end;

    [Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.UPDATE;
    end;


    var
        ChangeExchangeRate: Page 511;
        EditNo: Boolean;
        CopyPurchDoc1: Report 492;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "Budgetary Control Setup";
        DeleteCommitment: Record Committment;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
}

