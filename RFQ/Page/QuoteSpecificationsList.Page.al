page 51534359 "Quote Specifications List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Quote Specifications";
    //UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Value/Weight"; "Value/Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

