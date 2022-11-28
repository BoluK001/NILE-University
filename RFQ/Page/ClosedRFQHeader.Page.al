page 51534353 "Closed RFQ Header"
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
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Expected Opening Date"; "Expected Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Closing Date"; "Expected Closing Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
            }
            part("RFQ Subform"; "RFQ Subform")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(New)
            {

                //Showcaption = false;
                action("Assign Vendor(s)")
                {
                    ApplicationArea = All;
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "Quotation Request Vendors";
                    begin

                        Vends.RESET;
                        Vends.SETRANGE(Vends."Document Type", "Document Type");
                        Vends.SETRANGE(Vends."Document No.", "No.");

                        PAGE.RUN(PAGE::"Quotation Request Vendors", Vends);
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = All;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        PQH.SETRECFILTER;
                        PQH.SETFILTER(PQH."Document Type", '%1', "Document Type");
                        PQH.SETFILTER("No.", "No.");
                        // repvend.SETTABLEVIEW(PQH);
                        // repvend.RUN; Dennis
                    end;
                }
            }
            group(Status)
            {

                Caption = 'Status';
                action(Cancel)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Cancel Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Cancelled;
                        MODIFY;

                    end;
                }
                action(Stop)
                {
                    ApplicationArea = All;
                    Caption = 'Stop';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Closed;
                        MODIFY;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Closed;
                        MODIFY;

                    end;
                }
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Release document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        //check if the document has any lines
                        Lines.RESET;
                        Lines.SETRANGE(Lines."Document Type", "Document Type");
                        Lines.SETRANGE(Lines."Document No.", "No.");
                        IF Lines.FINDFIRST THEN BEGIN
                            REPEAT
                                Lines.TESTFIELD(Lines.Quantity);
                                //Lines.TESTFIELD(Lines."Direct Unit Cost");
                                Lines.TESTFIELD("No.");
                            UNTIL Lines.NEXT = 0;
                        END
                        ELSE BEGIN
                            ERROR('Document has no lines');
                        END;
                        Status := Status::Released;
                        MODIFY;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                        //PurchHeader.SETRANGE(purchheader."request for quote no","No.");
                        IF PurchHeader.FINDFIRST THEN BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                        END;

                        IF CONFIRM('Reopen Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Open;
                        MODIFY;
                    end;
                }
            }
        }
    }

    var
        PurchHeader: Record 38;
        PParams: Record "Purchase Quote Params";
        Lines: Record "Purchase Quote Line";
        PQH: Record "Purchase Quote Header";
    //repvend: Report "Purchase Quote Request Report";  Dennis
}

