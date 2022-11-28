page 51534362 "RFQ Subform"
{
    PageType = ListPart;
    SourceTable = "Purchase Quote Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; "Expense No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Master Description';
                }
                field("Description 2"; "Description 2")
                {
                    Caption = 'Specification';
                    ApplicationArea = All;

                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Specification")
            {
                Caption = 'Set Specification';
                ApplicationArea = All;
                Visible = false; //jj290522

                trigger OnAction()
                var
                    PParams: Record "Purchase Quote Params";
                begin
                    PParams.RESET;
                    PParams.SETRANGE(PParams."Document Type", "Document Type");
                    PParams.SETRANGE(PParams."Document No.", "Document No.");
                    PParams.SETRANGE(PParams."Line No.", "Line No.");
                    PAGE.RUN(51534353, PParams);
                end;
            }
        }
    }
}

