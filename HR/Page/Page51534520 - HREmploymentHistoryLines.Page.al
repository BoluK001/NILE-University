page 51534520 "HR Employment History Lines"
{
    Caption = 'Employment History Lines';
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Employment History Lines';
    SourceTable = "HR Employment History";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = all;
                }
                field(From; From)
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Key Experience"; "Key Experience")
                {
                    ApplicationArea = all;
                }
                field("Salary On Leaving"; "Salary On Leaving")
                {
                    ApplicationArea = all;
                }
                field("Postal Address"; "Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = all;
                }
                field("Reason For Leaving"; "Reason For Leaving")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
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

