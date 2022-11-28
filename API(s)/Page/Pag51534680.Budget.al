page 51534680 BudgetDimension
{
    Caption = 'Budget';
    PageType = List;
    SourceTable = "dimension value";
    UsageCategory = None;
    SourceTableView = WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = CONST(Standard),
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
