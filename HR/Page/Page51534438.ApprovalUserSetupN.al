page 51534438 "Approval User Setup N"
{
    Caption = 'Approval User Setup N';
    PageType = List;
    SourceTable = "User Setup";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the value of the Full Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
