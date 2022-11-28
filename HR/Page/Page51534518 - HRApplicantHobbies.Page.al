page 51534518 "HR Applicant Hobbies"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Applicant Hobbies";
    AdditionalSearchTerms = 'HR Applicant Hobbies';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Hobby; Hobby)
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

