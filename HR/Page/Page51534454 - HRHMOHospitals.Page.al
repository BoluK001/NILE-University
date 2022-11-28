page 51534454 "HR HMO Hospitals"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR HMO Hospitals';
    SourceTable = "HR HMO Hospital";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hospital Code"; "Hospital Code")
                { 
                    ApplicationArea = all; 
                }
                field(Name; Name)
                { 
                    ApplicationArea = all; 
                }
                field(Address; Address)
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

