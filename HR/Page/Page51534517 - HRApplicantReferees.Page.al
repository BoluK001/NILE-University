page 51534517 "HR Applicant Referees"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Applicant Referees";
    AdditionalSearchTerms = 'HR Applicant Referees';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Names; Names)
                {
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                }
                field(Institution; Institution)
                {
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                }
                field("Telephone No"; "Telephone No")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
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

