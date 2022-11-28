page 51534465 "HR Deductions Account"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Deductions Account';
    SourceTable = "HR Deduction Account";
    UsageCategory = Lists;

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
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = all;
                }
                field(NetPay; NetPay)
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

