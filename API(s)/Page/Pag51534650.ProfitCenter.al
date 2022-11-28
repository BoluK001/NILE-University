page 51534650 "Profit Center"
{
    Caption = 'Profit Center';
    PageType = List;
    SourceTable = "Dimension Value";
    //UsageCategory = None;
    SourceTableView = WHERE("Global Dimension No." = CONST(1), "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the dimension value.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                }
            }
        }
    }
}
