page 51534588 "HR Job Interview Areas"
{
    PageType = ListPart;
    SourceTable = "HR Job Evaluation Areas";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("ED of Requesting Dept"; "ED of Requesting Dept")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
    //HrJbIntArea: Record "Cash Office User Template";
}

