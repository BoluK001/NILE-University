page 51534720 "Tariff Codes"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Tariff Codes';
    SourceTable = "Tariff Codes";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = all;
                }
                field("Account No."; "Account No.")
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

