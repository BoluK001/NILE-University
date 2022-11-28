page 51534464 "HR Jobs Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            field("Job ID"; "Job ID")
            {
                ApplicationArea = all;
            }
            field("Job Title"; "Job Title")
            {
                ApplicationArea = all;
            }
            field("No of Posts"; "No of Posts")
            {
                ApplicationArea = all;
            }
            field("Position Reporting to"; "Position Reporting to")
            {
                ApplicationArea = all;
            }
            field("Occupied Positions"; "Occupied Positions")
            {
                ApplicationArea = all;
            }
            field("Vacant Positions"; "Vacant Positions")
            {
                ApplicationArea = all;
                Visible = false; //jj250222 remmed as it is not calculating correctly on fact box
            }
            field(Category; Category)
            {
                ApplicationArea = all;
            }
            field(Grade; Grade)
            {
                ApplicationArea = all;
            }
            field("Employee Requisitions"; "Employee Requisitions")
            {
                ApplicationArea = all;
            }
            field("Supervisor Name"; "Supervisor Name")
            {
                ApplicationArea = all;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
            }
            field("Responsibility Center"; "Responsibility Center")
            {
                ApplicationArea = all;
            }
            field("Date Created"; "Date Created")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }
}

