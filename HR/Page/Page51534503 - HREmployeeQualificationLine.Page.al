page 51534503 "HR Employee Qualification Line"
{
    Caption = 'Employee Qualification Lines';
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Employee Qualification Lines';
    SourceTable = "HR Employee Qualifications";
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
                    ApplicationArea = all;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = all;
                }
                field("Qualification Description"; "Qualification Description")
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    ApplicationArea = all;
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = all;
                }
                field("Course Grade"; "Course Grade")
                {
                    Caption = 'Year';
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
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Qualification"),
                                  "No." = FIELD("Employee No."),
                                  "Table Line No." = FIELD("Line No.");
                }
                separator(Action1102755021)
                {

                }
                action("Q&ualification Overview")
                {
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

