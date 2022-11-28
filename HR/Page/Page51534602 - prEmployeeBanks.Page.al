page 51534402 "prEmployee Banks"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prEmployee Banks";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Employee Banks';

    layout
    {
        area(content)
        {
            repeater(new)
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = all;
                }
                field(Default; Default)
                {
                    ApplicationArea = all;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = all;
                }
                field(Percentage; Percentage)
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

