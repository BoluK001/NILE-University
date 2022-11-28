page 51534423 "HR EntitleMent Template"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR EntitleMent Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                }
                field(Question; Question)
                {
                    ApplicationArea = all;
                }
                field("Question Header"; "Question Header")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

