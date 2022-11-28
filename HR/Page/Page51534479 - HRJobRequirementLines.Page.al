page 51534479 "HR Job Requirement Lines"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Job Requirement Lines';
    SourceTable = "HR Job Requirements";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Type"; "Qualification Type")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Qualification Description"; "Qualification Description")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = all;
                }
                field("Class of Degree"; "Class of Degree")
                {
                    ApplicationArea = all;
                }
                field("Desired Score"; "Desired Score")
                {
                    ApplicationArea = all;
                }
                field("Total (Stage)Desired Score"; "Total (Stage)Desired Score")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Mandatory; Mandatory)
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

