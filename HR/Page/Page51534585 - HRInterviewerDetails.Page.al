page 51534585 "HR Interviewer Details"
{
    PageType = ListPart;
    SourceTable = "HR Interviewer";

    layout
    {
        area(content)
        {
            field("Interview No."; "Interview No.")
            {
                    ApplicationArea = all;
                }
            field("Employee No."; "Employee No.")
            {
                    ApplicationArea = all;
                }
            field("First Name"; "First Name")
            {
                    ApplicationArea = all;
                }
            field("Middle Name"; "Middle Name")
            {
                    ApplicationArea = all;
                }
            field("Last Name"; "Last Name")
            {
                    ApplicationArea = all;
                }
            field(Stage; Stage)
            {
                    ApplicationArea = all;
                }
            field("ED/MD Recommendation"; "ED/MD Recommendation")
            {
                MultiLine = true;
            }
            repeater(Group)
            {
                }
        }
    }

    actions
    {
    }

    var
        HrEmployee: Record "HR-Employee";
}

