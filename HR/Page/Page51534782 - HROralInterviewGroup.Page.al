page 51534782 "HR Oral Interview Group"
{
    CardPageID = "HR Oral Interview Grp Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Oral Interview Group';
    SourceTable = "HR Oral Interview Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Oral Interview Category"; "Oral Interview Category")
                {
                    ApplicationArea = All;
                }
                field("Oral Interview Description"; "Oral Interview Description")
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

