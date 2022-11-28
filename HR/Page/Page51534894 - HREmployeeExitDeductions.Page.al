page 51534894 "HREmployee Exit Deductions"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HREmployee Exit Deductions';
    SourceTable = "HR Employee Exit Deductions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
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

