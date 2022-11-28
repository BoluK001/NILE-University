page 51534442 "Collection Distribution Setup"
{
    ApplicationArea = All;
    Caption = 'Collection Distribution Setup';
    PageType = List;
    SourceTable = "Collection Dist. Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                    ApplicationArea = All;
                }
                field("Distribution Percentage"; Rec."Distribution Percentage")
                {
                    ToolTip = 'Specifies the value of the Distribution Percentage field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
