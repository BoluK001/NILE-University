page 51534957 "HR Exit Interview Template"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Exit Interview Template';
    SourceTable = "HR Exit Interview Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Question; Question)
                {
                    ApplicationArea = all;
                }
                field(Segment; Segment)
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

