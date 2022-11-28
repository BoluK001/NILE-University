page 51534940 "Emplyee Classification"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Employee Class";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Employee Classification';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
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

