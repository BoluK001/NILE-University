page 51534441 "With-Holding Tax Setup"
{
    ApplicationArea = All;
    Caption = 'With-Holding Tax Setup';
    PageType = List;
    SourceTable = "With-Holding Tax Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;


                }
                field(Discription; Rec.Discription)
                {
                    ToolTip = 'Specifies the value of the Discription field.';
                    ApplicationArea = All;
                }
                field("W/Tax Rate"; Rec."W/Tax Rate")
                {
                    ToolTip = 'Specifies the value of the Rate field.';
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
            }
        }
    }
}
