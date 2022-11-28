page 51534350 "Bid Analysis"
{
    PageType = Document;
    SourceTable = "Purchase Quote Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(ItemNoFilter; ItemNoFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page 31;
                    begin
                        ItemList.LOOKUPMODE := TRUE;
                        IF ItemList.RUNMODAL = ACTION::LookupOK THEN
                            Text := ItemList.GetSelectionFilter
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        //ItemNoFilterOnAfterValidate;
                    end;
                }
            }
            part("Bid Analysis SubForm"; "Bid Analysis SubForm")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Vendor Quotations")
            {
                ApplicationArea = All;
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    InsertBidAnalysisLines;
                end;
            }
        }
    }

    var
        PurchHeader: Record 38;
        PurchLines: Record "Purchase Line";
        ItemNoFilter: Text[250];
        RFQNoFilter: Text[250];
        InsertCount: Integer;

    [Scope('OnPrem')]
    procedure InsertBidAnalysisLines()
    var
        BidAnalysisLines: Record "Bid Analysis";
    begin
        //insert the quotes from vendors
        //IF RFQNoFilter = '' THEN ERROR('Specify the RFQ No.');

        PurchHeader.SETRANGE("RFQ No.", "No.");
        PurchHeader.FINDSET;
        REPEAT
            PurchLines.RESET;
            PurchLines.SETRANGE("Document No.", PurchHeader."No.");
            IF PurchLines.FINDSET THEN
                REPEAT
                    INIT;
                    BidAnalysisLines."RFQ No." := PurchHeader."RFQ No.";
                    BidAnalysisLines."RFQ Line No." := PurchLines."Line No.";
                    BidAnalysisLines."Quote No." := PurchLines."Document No.";
                    BidAnalysisLines."Vendor No." := PurchLines."Buy-from Vendor No.";
                    BidAnalysisLines."Item No." := PurchLines."No.";
                    BidAnalysisLines.Description := PurchLines.Description;
                    BidAnalysisLines.Quantity := PurchLines.Quantity;
                    BidAnalysisLines."Unit Of Measure" := PurchLines."Unit of Measure";
                    BidAnalysisLines.Amount := PurchLines."Direct Unit Cost";
                    BidAnalysisLines."Line Amount" := BidAnalysisLines.Quantity * BidAnalysisLines.Amount;
                    BidAnalysisLines.INSERT(TRUE);
                    InsertCount := +1;
                UNTIL PurchLines.NEXT = 0;
        UNTIL PurchHeader.NEXT = 0;
    end;
}

