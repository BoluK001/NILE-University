page 51534488 "HR Company Activities Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Company Activities";

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
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Venue; Venue)
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Responsible';
                }
                field("Email Message"; "Email Message")
                {
                    ApplicationArea = all;
                }
                label(Control1102755020)
                {
                    CaptionClass = Text2;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Costs; Costs)
                {
                    ApplicationArea = all;
                }
                field("Contribution Amount (If Any)"; "Contribution Amount (If Any)")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No"; "G/L Account No")
                {
                    ApplicationArea = all;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No"; "Bal. Account No")
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
                label(Control1102755012)
                {
                    CaptionClass = Text3;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Closed; Closed)
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
        Text1: Label 'Activity Description';
        Text2: Label 'Activity Cost';
        Text3: Label 'Activity Status';
}

