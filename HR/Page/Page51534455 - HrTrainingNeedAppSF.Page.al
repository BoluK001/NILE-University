page 51534455 "Hr Training Need App SF"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "HR Training Need Participant";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Code"; "Employee Code")
                {
                    LookupPageID = "HR Employee List";
                    ApplicationArea = all;  //jj270422
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270422
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270422
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270422
                }
                field(Selected; Selected)
                {
                    ApplicationArea = all;
                }
                field("Staff Course Title"; "Staff Course Title")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj280922
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270422
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270422
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj280922
                }
            }
        }
    }

    actions
    {
    }
}

