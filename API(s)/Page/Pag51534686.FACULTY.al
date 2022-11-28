page 51534686 FACULTY
{
    Caption = 'FACULTY';
    PageType = List;
    SourceTable = "dimension value";
    UsageCategory = None;
    SourceTableView = WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard),
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
