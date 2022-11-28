page 51534352 "Bid Analysis Worksheet"
{

    DeleteAllowed = false;
    PageType = Worksheet;
    UsageCategory = ReportsAndAnalysis;
    SourceTable = "Bid Analysis";

    layout
    {
        area(content)
        {
            group(New)
            {
                ShowCaption = false;
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Code Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendList: Page 27;
                    begin
                        BEGIN
                            VendList.LOOKUPMODE := TRUE;
                            IF VendList.RUNMODAL = ACTION::LookupOK THEN
                                Text := VendList.GetSelectionFilter
                            ELSE
                                Text := '';
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate;
                    end;
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
                        ItemNoFilterOnAfterValidate;
                    end;
                }
                field(Total; Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            repeater(Group)
            {

                field("RFQ No."; "RFQ No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("RFQ Line No."; "RFQ Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(VendorName; VendorName)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    Editable = false;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Of Measure"; "Unit Of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remarks; Remarks)
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
            action("Get Vendor Quotations")
            {
                ApplicationArea = All;
                Caption = 'Get Vendor Quotations';
                Image = GetSourceDoc;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    GetVendorQuotes;
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "Bid Analysis"; Dennis

                trigger OnAction()
                begin
                    BidAnalysis.RESET;
                    BidAnalysis.SETRANGE("RFQ No.", "RFQ No.");
                    //RFQ No.,RFQ Line No.,Quote No.,Vendor No.
                    IF BidAnalysis.FINDFIRST THEN
                        REPORT.RUN(39006002, TRUE, FALSE, BidAnalysis);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Vendor.GET("Vendor No.");
        VendorName := Vendor.Name;
        CalcTotals;
    end;

    var
        PurchHeader: Record 38;
        PurchLines: Record "Purchase Line";
        ItemNoFilter: Text[250];
        RFQNoFilter: Text[250];
        InsertCount: Integer;
        SalesCodeFilter: Text[250];
        VendorName: Text;
        Vendor: Record Vendor;
        Total: Decimal;
        BidAnalysis: Record "Bid Analysis";

    [Scope('OnPrem')]
    procedure SetRecFilters()
    begin
        IF SalesCodeFilter <> '' THEN
            SETFILTER("Vendor No.", SalesCodeFilter)
        ELSE
            SETRANGE("Vendor No.");

        IF ItemNoFilter <> '' THEN BEGIN
            SETFILTER("Item No.", ItemNoFilter);
        END ELSE
            SETRANGE("Item No.");

        CalcTotals;

        CurrPage.UPDATE(FALSE);
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    [Scope('OnPrem')]
    procedure GetVendorQuotes()
    begin
        //insert the quotes from vendors
        IF RFQNoFilter = '' THEN ERROR('Specify the RFQ No.');

        PurchHeader.SETRANGE("RFQ No.", RFQNoFilter);
        PurchHeader.FINDSET;
        REPEAT
            PurchLines.RESET;
            PurchLines.SETRANGE("Document No.", PurchHeader."No.");
            IF PurchLines.FINDSET THEN
                REPEAT
                    INIT;
                    "RFQ No." := PurchHeader."RFQ No.";
                    "RFQ Line No." := PurchLines."Line No.";
                    "Quote No." := PurchLines."Document No.";
                    "Vendor No." := PurchLines."Buy-from Vendor No.";
                    "Item No." := PurchLines."No.";
                    Description := PurchLines.Description;
                    Quantity := PurchLines.Quantity;
                    "Unit Of Measure" := PurchLines."Unit of Measure";
                    Amount := PurchLines."Direct Unit Cost";
                    "Line Amount" := Quantity * Amount;
                    INSERT(TRUE);
                    InsertCount := +1;
                UNTIL PurchLines.NEXT = 0;
        UNTIL PurchHeader.NEXT = 0;
        MESSAGE('%1 records have been inserted to the bid analysis');
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    [Scope('OnPrem')]
    procedure CalcTotals()
    var
        BidAnalysisRec: Record "Bid Analysis";
    begin
        BidAnalysisRec.SETRANGE("RFQ No.", "RFQ No.");
        IF SalesCodeFilter <> '' THEN
            BidAnalysisRec.SETRANGE("Vendor No.", SalesCodeFilter);
        IF ItemNoFilter <> '' THEN
            BidAnalysisRec.SETRANGE("Item No.", ItemNoFilter);
        BidAnalysisRec.FINDSET;
        BidAnalysisRec.CALCSUMS("Line Amount");
        Total := BidAnalysisRec."Line Amount";
    end;
}

