page 51534607 "prP.A.Y.E Setup"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = prPAYE;
    caption = 'P.A.Y.E Setup';
    AdditionalSearchTerms = 'P.A.Y.E Setup';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Tier Code"; "Tier Code")
                {
                    ApplicationArea = all;
                }
                field("PAYE Tier"; "PAYE Tier")
                {
                    ApplicationArea = all;
                }
                field(Rate; Rate)
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

