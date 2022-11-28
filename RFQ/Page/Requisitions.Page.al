page 51534364 Requisitions
{
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageID = "Internal Requisitions";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budget,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), "Purchase Type" = FILTER(Requisition));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Procurement Type Code"; "Procurement Type Code")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action59>")
            {
                Caption = '&Quote';
                action("<Action61>")
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }

                action("<Action111>")
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("<Action152>")
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
            group("<Action104>")
            {
                Caption = '&Line';
                group("<Action105>")
                {
                    Caption = 'Item Availability by';
                    action("<Action109>")
                    {
                        Caption = 'Variant';
                    }
                    action("<Action106>")
                    {
                        Caption = 'Location';
                    }
                }
                action("<Action112>")
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("<Action168>")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                }
                action("<Action5800>")
                {
                    Caption = 'Item Charge &Assignment';
                }
                action("<Action6500>")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                }
            }
        }
        area(processing)
        {
            action("<Action69>")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    ApprovalMgt: Codeunit 1535;
                begin
                    //IF LinesCommitted THEN
                    //ERROR('All Lines should be committed');

                    IF ApprovalMgt.PrePostApprovalCheckSales(SalesHeader) THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
            group("<Action64>")
            {
                Caption = 'F&unctions';
                action("<Action65>")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(f)
                {
                }
                action("<Action67>")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                }
                action("<Action18>")
                {
                    Caption = 'Insert &Ext. Texts';
                }
                separator(e)
                {
                }
                action("<Action143>")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record 175;
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(r)
                {
                }
                action("<Action66>")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("<Action138>")
                {
                    Caption = 'Archi&ve Document';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(u)
                {
                }
                action("<Action153>")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        // IF LinesCommitted THEN
                        //ERROR('All Lines should be committed');

                        IF ApprovalMgt.CheckPurchaseApprovalPossible(Rec) THEN
                            ApprovalMgt.OnSendPurchaseDocForApproval(rec);
                    end;
                }
                action("<Action154>")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(v)
                {
                }
                // action("<Action1102755002>")
                // {
                //     Caption = 'Check Budget Availability';
                //     Image = Balance;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     var
                //         BCSetup: Record "39005881";
                //     begin

                //         BCSetup.GET;
                //         IF NOT BCSetup.Mandatory THEN
                //            EXIT;

                //         IF Status=Status::Released THEN
                //           ERROR('This document has already been released. This functionality is available for open documents only');
                //         IF NOT SomeLinesCommitted THEN BEGIN
                //            IF NOT CONFIRM( 'Some or All the Lines Are already Committed do you want to continue',TRUE, "Document Type") THEN
                //                 ERROR('Budget Availability Check and Commitment Aborted');
                //           DeleteCommitment.RESET;
                //           DeleteCommitment.SETRANGE(DeleteCommitment."Document Type",DeleteCommitment."Document Type"::LPO);
                //           DeleteCommitment.SETRANGE(DeleteCommitment."Document No.","No.");
                //           DeleteCommitment.DELETEALL;
                //         END;
                //            Commitment.CheckPurchase(Rec);
                //            MESSAGE('Budget Availability Checking Complete');
                //     end;
                // }
                // action("<Action1102755003>")
                // {
                //     Caption = 'Cancel Budget Commitment';
                //     Image = Reject;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;

                //     trigger OnAction()
                //     begin
                //         IF NOT CONFIRM('Are you sure you want to Cancel All Commitments Done for this document', TRUE, "Document Type") THEN
                //             ERROR('Budget Availability Check and Commitment Aborted');

                //         DeleteCommitment.RESET;
                //         DeleteCommitment.SETRANGE(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                //         DeleteCommitment.SETRANGE(DeleteCommitment."Document No.", "No.");
                //         DeleteCommitment.DELETEALL;
                //         //Tag all the Purchase Line entries as Uncommitted
                //         PurchLine.RESET;
                //         PurchLine.SETRANGE(PurchLine."Document Type", "Document Type");
                //         PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                //         IF PurchLine.FIND('-') THEN BEGIN
                //             REPEAT
                //                 PurchLine.Committed := FALSE;
                //                 PurchLine.MODIFY;
                //             UNTIL PurchLine.NEXT = 0;
                //         END;

                //         MESSAGE('Commitments Cancelled Successfully for Doc. No %1', "No.");
                //     end;
                // }
                separator(k)
                {
                }
                action("<Action118>")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        //IF LinesCommitted THEN
                        //ERROR('All Lines should be committed');

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("<Action119>")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        //IF LinesCommitted THEN
                        //  ERROR('All Lines should be committed');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(p)
                {
                }
                action("<Action135>")
                {
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Purchase Header";
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //  BizTalkManagement.SendReqforPurchQuote(Rec);
                    end;
                }
            }
            action("<Action70>")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //IF LinesCommitted THEN
                    //  ERROR('All Lines should be committed');
                    RESET;
                    SETRANGE("No.", "No.");
                    //REPORT.RUN(39005563, TRUE, TRUE, Rec);
                    RESET;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                //ApplicationArea = All;
                Caption = 'Purchase H&istory';
                Visible = PurchHistoryBtnVisible;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end;
            }
            action("<Action158>")
            {
                Caption = '&Contacts';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupContacts(Rec);
                end;
            }
            action("<Action159>")
            {
                Caption = 'Order &Addresses';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    var
        PurchSetup: Record 312;
        CopyPurchDoc: Report 492;//39005487;
        ArchiveManagement: Codeunit 5063;
        PurchInfoPaneMgmt: Codeunit 7181;
        //Commitment: Codeunit 39005484;
        //BCSetup: Record 39005881;
        //DeleteCommitment: Record 39005882;
        PurchLine: Record 39;
        [InDataSet]

        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchLinesEditable: Boolean;
        ApprovalEntries:Page "Approval Entries";

    local procedure ApproveCalcInvDisc()
    begin
    end;

    // local procedure UpdateInfoPanel()
    // var
    //     DifferBuyFromPayTo: Boolean;
    // begin
    //     DifferBuyFromPayTo := "Buy-from Vendor No." <> "Pay-to Vendor No.";
    //     PurchHistoryBtnVisible := DifferBuyFromPayTo;
    //     PayToCommentPictVisible := DifferBuyFromPayTo;
    //     PayToCommentBtnVisible := DifferBuyFromPayTo;
    //     PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, "Buy-from Vendor No.");
    //     IF DifferBuyFromPayTo THEN
    //         PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, "Pay-to Vendor No.")
    // end;

    // [Scope('Internal')]
    // procedure LinesCommitted() Exists: Boolean
    // var
    //     PurchLines: Record "Purchase Line";
    // begin
    //     IF BCSetup.GET() THEN BEGIN
    //         IF NOT BCSetup.Mandatory THEN BEGIN
    //             Exists := FALSE;
    //             EXIT;
    //         END;
    //     END ELSE BEGIN
    //         Exists := FALSE;
    //         EXIT;
    //     END;
    //     IF BCSetup.GET THEN BEGIN
    //         Exists := FALSE;
    //         PurchLines.RESET;
    //         PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
    //         PurchLines.SETRANGE(PurchLines."Document No.", "No.");
    //         PurchLines.SETRANGE(PurchLines.Committed, FALSE);
    //         IF PurchLines.FIND('-') THEN
    //             Exists := TRUE;
    //     END ELSE
    //         Exists := FALSE;
    // end;

    //[Scope('Internal')]
    // procedure SomeLinesCommitted() Exists: Boolean
    // var
    //     PurchLines: Record "39";
    // begin
    //     IF BCSetup.GET THEN BEGIN
    //         Exists := FALSE;
    //         PurchLines.RESET;
    //         PurchLines.SETRANGE(PurchLines."Document Type", "Document Type");
    //         PurchLines.SETRANGE(PurchLines."Document No.", "No.");
    //         PurchLines.SETRANGE(PurchLines.Committed, TRUE);
    //         IF PurchLines.FIND('-') THEN
    //             Exists := TRUE;
    //     END ELSE
    //         Exists := FALSE;
    // end;

    [Scope('Internal')]
    procedure UpdateControls()
    begin
        IF Status <> Status::Open THEN BEGIN
            PurchLinesEditable := FALSE;
        END ELSE
            PurchLinesEditable := TRUE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}

