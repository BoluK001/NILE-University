page 51534657 "HR Canteen App List Self"
{
    Caption = 'HR Meal Ticket  List';
    CardPageID = "HR Canteen Application Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Hr Canteen Application";
    AdditionalSearchTerms = 'HR Meal Ticket  List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ticket No."; "Ticket No.")
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
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = all;
                }
                field("Visitor Name"; "Visitor Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetFilter("User ID", UserId);
    end;
}

