page 51534512 "HR Training Application List"
{
    CardPageID = "HR Training Application Card";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Training Applications";
    SourceTableView = WHERE(Type = CONST(Staff));
    AdditionalSearchTerms = 'HR Training Application List';
    UsageCategory = Lists;

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
                    Visible = false;  //jj280922
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                    Visible = false;  //280922
                }
                field("Course Title"; "Course Title")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
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
                field("Total Amount"; "Total Amount")
                {

                    ApplicationArea = all;
                }
                field("Approved Cost"; "Approved Cost")
                {
                    ApplicationArea = all;
                    Visible = false; //jj280922
                }
                field(Provider; "Provider Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
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
            }
            action("Training Applications")
            {
                Caption = 'Training Applications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Payroll Components Variance";
            }
        }
    }
}

