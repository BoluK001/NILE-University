page 51534649 "HR Ratings List"
{
    ApplicationArea = All;
    Caption = 'HR Ratings List';
    PageType = List;
    SourceTable = "HR Ratings";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rating field.';
                }
            }
        }
    }
}
