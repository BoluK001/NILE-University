page 51534439 "Approver User Setup List"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = 51534730;
    SourceTableView = SORTING("Sequence No.");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Approval Type"; "Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; "Approver ID")
                {
                    LookupPageID = "Approval User Setup N";
                    ApplicationArea = All;
                }
                field("Approver Name"; "Approver Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sequence No."; "Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        FILTERGROUP(2);
        SETRANGE("User ID", USERID);
        FILTERGROUP(0);
    end;
}

