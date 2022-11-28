pageextension 51534401 UserSetupExt extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sales Resp. Ctr. Filter")
        {
            field("Post Voucher"; "Post Voucher")
            {
                ApplicationArea = All;
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                Caption = 'Global Dimension 1 Code';
                ApplicationArea = all;
            }

            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
                Caption = 'Shortcut Dimension 2 Code';
                ApplicationArea = all;
            }

            field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
            {
                Caption = 'Shortcut Dimension 3 Code';
                ApplicationArea = all;
            }

            field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
            {
                Caption = 'Shortcut Dimension 4 Code';
                ApplicationArea = all;
            }

            field("Staff Travel Account"; "Staff Travel Account")
            {
                Caption = 'Staff Travel Account';
                ApplicationArea = all;
            }

            field("Cash Advance Staff Account"; "Cash Advance Staff Account")
            {
                Caption = 'Staff Advance Account';
                ApplicationArea = all;
            }

            field("Employee No"; "Employee No")
            {
                Caption = 'Employee No';
                ApplicationArea = all;
            }
            field("Responsibility Center"; "Responsibility Center")   //jj170322
            {
                ApplicationArea = All;
            }

            field("Maximum Amount"; "Maximum Amount")
            {
                Caption = 'Maximum Amount';
                ApplicationArea = all;
            }

            field("Is In HR"; "Is In HR")
            {
                Caption = 'Is In HR';
                ApplicationArea = all;
            }
            field(HR; HR)
            {
                ApplicationArea = all;
            }
            field("HR Job"; "HR Job")
            {
                ApplicationArea = all;
            }

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
