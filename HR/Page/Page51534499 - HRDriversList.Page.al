page 51534499 "HR Drivers List"
{
    CardPageID = "HR Drivers Card";
    InsertAllowed = true;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Drivers List';
    SourceTable = "HR Drivers";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Code)
               {
                    ApplicationArea = all;
                }
                field("Driver Name"; "Driver Name")
               {
                    ApplicationArea = all;
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
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

