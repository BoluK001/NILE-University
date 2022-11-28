page 51534943 "HR Training Application Self"
{
    CardPageID = "HR Training Application Card";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Training Applications";
    SourceTableView = WHERE(Type = CONST(Staff));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Application No"; "Application No")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Course Title"; "Course Title")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Reason for Training"; "Reason for Training")
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
                field("Cost Of Training"; "Cost Of Training")
                {
                    Caption = 'Estimated Cost';
                    ApplicationArea = All;
                }
                field("Approved Cost"; "Approved Cost")
                {
                    ApplicationArea = all;
                }
                field(Provider; "Provider Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = FIELD("Application No");
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Training Applications List")
            {
                Caption = 'Training Applications List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Training Applications List";
                ApplicationArea = All;
            }
            action("Training Applications")
            {
                Caption = 'Training Applications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Payroll Components Variance";
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetFilter("User ID", UserId);
        FilterGroup(0);
    end;
}

