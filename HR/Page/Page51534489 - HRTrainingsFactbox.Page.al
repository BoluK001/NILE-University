page 51534489 "HR Trainings Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                ShowCaption = false;
                label(Control1102755019)
                {
                    CaptionClass = Text1;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Application No"; "Application No")
                {
                    ApplicationArea = all;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = all;
                }
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field("Duration Units"; "Duration Units")
                {
                    ApplicationArea = all;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = all;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
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
        Text1: Label 'Training Details';

}

