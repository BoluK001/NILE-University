page 51534421 "HR Confirmation List (HR)"
{
    Caption = 'HR Confirmation List (HR)';
    CardPageID = "HR Confirmation Header";
    DeleteAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Confirmation";
    SourceTableView = WHERE("Send to Hr" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; "Application No.")
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
                field("Date of Employment"; "Date of Employment")
                { 
                    ApplicationArea = all; 
                }
                field("Appraisal Type"; "Appraisal Type")
                { 
                    ApplicationArea = all; 
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SETRANGE("Send to Hr", TRUE);
    end;
}

