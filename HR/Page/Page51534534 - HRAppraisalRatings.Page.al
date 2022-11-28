page 51534534 "HR Appraisal Ratings"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Appraisal Ratings';
    SourceTable = "HR Appraisal Career Dev";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Appraisal Code"; "Appraisal Code")
                {
                    ApplicationArea = all;
                }
                field(Question; Question)
                {
                    ApplicationArea = all;
                }
                field(Answer; Answer)
                {
                    ApplicationArea = all;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Half"; "Appraisal Half")
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

