page 51534561 "Employee Log Entries"
{
    Caption = 'Change Log Entries';
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Change Log Entries';
    UsageCategory = Lists;
    SourceTable = "Change Log Entry";
    SourceTableView = SORTING("Table No.", "Date and Time")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Date and Time"; "Date and Time")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Table No."; "Table No.")
                {
                    Lookup = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Field No."; "Field No.")
                {
                    Lookup = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Field Caption"; "Field Caption")
                {
                    DrillDown = false;
                    ApplicationArea = all;
                }
                field("Type of Change"; "Type of Change")
                {
                    ApplicationArea = all;
                }
                field("Old Value"; "Old Value")
                {
                    ApplicationArea = all;
                }
                field("Old Value Local"; GetLocalOldValue)
                {
                    Caption = 'Old Value (Local)';
                    ApplicationArea = all;
                }
                field("New Value"; "New Value")
                {
                    ApplicationArea = all;
                }
                field("New Value Local"; GetLocalNewValue)
                {
                    Caption = 'New Value (Local)';
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ChangeLogEntriesRep: Report "Change Log Entries";
                begin
                    ChangeLogEntriesRep.SetTableView(Rec);
                    ChangeLogEntriesRep.Run;
                end;
            }
        }
    }
}

