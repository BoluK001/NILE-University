#pragma implicitwith disable
page 51534368 "Released Internal Requisitions"
{
    Caption = 'Approved Internal Requisitions';
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote),
                            "Purchase Type" = FILTER(Requisition),
                            Status = CONST(Released));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Procurement Type Code"; Rec."Procurement Type Code")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            part(PurchLines; 97)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group("Foreign Trade")
            {

                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(factboxes)
        {
            part("Vendor Details"; 9093)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part("Vendor Statistics FactBox"; 9094)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Hist. Buy-from FactBox"; 9095)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part("Vendor Hist. Pay-to FactBox"; 9096)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part("Approval FactBox"; 9092)
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part("Purchase Line FactBox"; 9100)
            {
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                            "No." = FIELD("No."),
                              "Line No." = FIELD("Line No.");
            }

            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
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
                        Rec.CalcInvDiscForHeader;
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

                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
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
                        DocType := DocType::Quote;
                        //WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordID, Database::"Purchase Header", Doctype.AsInteger(), Rec."No.");
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", 0, rec."No.");
                        ApprovalEntries.Run;
                    end;

                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    //IF LinesCommitted THEN
                    //ERROR('All Lines should be committed');
                    Rec.RESET;
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(51534931, TRUE, TRUE, Rec);
                    Rec.RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(v)
                {
                }
                action(Release1)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;
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
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(j)
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
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(e)
                {
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    visible = false;    //jj290522

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalMgt.CheckPurchaseApprovalPossible(rec) then
                            ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    visible = false;    //jj290522

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(f)
                {
                }
                action("Check Budget Availability")
                {
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        // BCSetup.GET;
                        // IF NOT BCSetup.Mandatory THEN
                        //     EXIT;

                        // IF Status = Status::Released THEN
                        //     ERROR('This document has already been released. This functionality is available for open documents only');
                        // IF NOT SomeLinesCommitted THEN BEGIN
                        //     IF NOT CONFIRM('Some or All the Lines Are already Committed do you want to continue', TRUE, "Document Type") THEN
                        //         ERROR('Budget Availability Check and Commitment Aborted');
                        //     DeleteCommitment.RESET;
                        //     DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        //     DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", "No.");
                        //     DeleteCommitment.DELETEALL;
                        // END;
                        // Commitment.CheckPurchase(Rec);
                        // MESSAGE('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        // IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE, "Document Type") THEN
                        //     ERROR('Budget Availability Check and Commitment Aborted');

                        // DeleteCommitment.RESET;
                        // DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        // DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", "No.");
                        // DeleteCommitment.DELETEALL;
                        // //Tag all the Purchase Line entries as Uncommitted
                        // PurchLine.RESET;
                        // PurchLine.SETRANGE(PurchLine."Document Type", "Document Type");
                        // PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                        // IF PurchLine.FIND('-') THEN BEGIN
                        //     REPEAT
                        //         PurchLine.Committed := FALSE;
                        //         PurchLine.MODIFY;
                        //     UNTIL PurchLine.NEXT = 0;
                        // END;

                        // MESSAGE('Commitments Cancelled Successfully for Doc. No %1', "No.");
                    end;
                }
            }
            group("Make Order1")
            {
                Caption = 'Make Order';
                Image = MakeOrder;
                action("Make Order")
                {
                    Caption = 'Make &Order';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        SalesHeader: Record 36;
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalMgt.PrePostApprovalCheckSales(SalesHeader) THEN
                            CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls;
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Purchase Type" := Rec."Purchase Type"::Requisition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        //Commitment: Codeunit 39005484;
        //BCSetup: Record 39005881;
        //DeleteCommitment: Record 39005882;
        PurchLine: Record 39;
        StatusEditable: Boolean;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                Rec.SETRANGE("Buy-from Vendor No.");
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
        PurchLines: Record 39;
    begin
        // IF BCSetup.GET() THEN BEGIN
        //     IF NOT BCSetup.Mandatory THEN BEGIN
        //         Exists := FALSE;
        //         EXIT;
        //     END;
        // END ELSE BEGIN
        //     Exists := FALSE;
        //     EXIT;
        // END;
        // IF BCSetup.GET THEN BEGIN
        //     Exists := FALSE;
        //     PurchLines.RESET;
        //     PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
        //     PurchLines.SETRANGE(PurchLines."Document No.", "No.");
        //     PurchLines.SETRANGE(PurchLines.Committed, FALSE);
        //     IF PurchLines.FIND('-') THEN
        //         Exists := TRUE;
        // END ELSE
        //     Exists := FALSE;
    end;

    [Scope('OnPrem')]
    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record 39;
    begin
        // IF BCSetup.GET THEN BEGIN
        //     Exists := FALSE;
        //     PurchLines.RESET;
        //     PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
        //     PurchLines.SETRANGE(PurchLines."Document No.", "No.");
        //     PurchLines.SETRANGE(PurchLines.Committed, TRUE);
        //     IF PurchLines.FIND('-') THEN
        //         Exists := TRUE;
        // END ELSE
        //     Exists := FALSE;
    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin
        IF Rec.Status = Rec.Status::Open THEN
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
}

#pragma implicitwith restore

