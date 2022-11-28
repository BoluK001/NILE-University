page 51534606 "HR Particpant Group"
{
    PageType = Card;
    SourceTable = "HR Participant Group";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'No.';
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(BU; BU)
                {
                    ApplicationArea = all;
                }
            }
            part(Control6; "HR Particpant Line")
            {
                SubPageLink = "Doc No" = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

