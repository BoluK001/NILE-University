page 51534500 "HR Drivers Card"
{
    PageType = Card;
    SourceTable = "HR Drivers";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field("Driver Name"; "Driver Name")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270922
                }
                field("Driver License Number"; "Driver License Number")
                {
                    ApplicationArea = all;
                }
                field("Last License Renewal"; "Last License Renewal")
                {
                    ApplicationArea = all;
                }
                field("Renewal Interval"; "Renewal Interval")
                {
                    ApplicationArea = all;
                }
                field("Renewal Interval Value"; "Renewal Interval Value")
                {
                    ApplicationArea = all;
                }
                field("Next License Renewal"; "Next License Renewal")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj270922
                }
                field("Year Of Experience"; "Year Of Experience")
                {
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Control1102755014; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

