page 51534614 "Payroll Posting Group Header"
{
    PageType = Card;
    SourceTable = "Payroll Posting Group Header";
    //AdditionalSearchTerms = 'Payroll Posting Group';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
            }
            part("Payroll Posting Group Line"; "Payroll Posting Group Line")
            {
                SubPageLink = "Group Code" = FIELD("Group Code");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }
}


