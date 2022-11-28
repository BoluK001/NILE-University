page 51534839 "Employee Transaction List"
{
    CardPageID = "Employee Transaction Header";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'Employee Transaction List';
    UsageCategory = Lists;
    SourceTable = "HR Emp. Transaction Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Salary step"; "Salary step")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

