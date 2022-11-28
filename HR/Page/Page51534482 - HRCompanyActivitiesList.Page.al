page 51534482 "HR Company Activities List"
{
    CardPageID = "HR Company Activities Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Company Activities List';
    SourceTable = "HR Company Activities";
    SourceTableView = WHERE("Activity Type" = CONST(Company));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
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
                field(Costs; Costs)
                {
                    ApplicationArea = all;
                }
                field("Employee Responsible"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = all;
                }
                field("Activity  Status>"; Status)
                {
                    Caption = 'Activity  Status';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Company Activities Factbox")
            {
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Company Activities")
            {
                Caption = 'Company Activities';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 4";
            }
        }
    }
}

