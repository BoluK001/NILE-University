page 51534547 "HR Transport Requisition List"
{
    CardPageID = "Hr Trasnsport Requisition Card";
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Transport Requisition";
    AdditionalSearchTerms = 'HR Transport Requisition List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Supervisor Email"; "Supervisor Email")
                {
                    ApplicationArea = all;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Purpose of Trip"; "Purpose of Trip")
                {
                    ApplicationArea = all;
                }
                field("Transport type"; "Transport type")
                {
                    ApplicationArea = all;
                }
                field("Time of Trip"; "Time of Trip")
                {
                    ApplicationArea = all;
                }
                field("Pickup Point"; "Pickup Point")
                {
                    ApplicationArea = all;
                }
                field("From Destination"; "From Destination")
                {
                    ApplicationArea = all;
                }
                field("To Destination"; "To Destination")
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

