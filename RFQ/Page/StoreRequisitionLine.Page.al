page 51534371 "Store Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Store Requisition Line";

    layout
    {
        area(content)
        {
            repeater(j)
            {

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Master Description';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specification field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    //Caption = 'Specification';
                    ApplicationArea = All;
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    ApplicationArea = All;
                    Caption = 'Qty in store(Dynamic)';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Qty in Iss. Str."; Rec."Qty in Iss. Str.")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    TableRelation = "Gen. Business Posting Group";
                }
                // field("Shortcut Dimension 4"; Rec."Shortcut Dimension 4")
                // {
                //     ApplicationArea = All;
                // }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        QtyStore: Record item;
}

