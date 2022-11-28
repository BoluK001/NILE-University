page 51534510 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Applicant Qualifications';
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; "Qualification Type")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = all;
                }
                field("Qualification Description"; "Qualification Description")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Course of Study"; "Course of Study")
                {
                    ApplicationArea = all;
                    Caption = 'Course of Study';
                }
                field("Class of Degree"; "Class of Degree")
                {
                    ApplicationArea = all;
                }
                field("Score ID"; "Score ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}

