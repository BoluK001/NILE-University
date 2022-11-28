page 51534473 "HR Leave Types"
{
    CardPageID = "HR Leave Types Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Leave Types';
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Code"; Code)
                {
                    Style = StandardAccent;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Days; Days)
                {
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field("Max Carry Forward Days"; "Max Carry Forward Days")
                {
                    ApplicationArea = all;
                }
                field("Inclusive of Non Working Days"; "Inclusive of Non Working Days")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
                ApplicationArea = All;
            }
            systempart(Control1102755004; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

