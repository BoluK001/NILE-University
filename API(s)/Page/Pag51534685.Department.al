page 51534685 Department
{
    Caption = 'Department';
    PageType = List;
    SourceTable = "dimension value";
    UsageCategory = None;
    SourceTableView = WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard),
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
