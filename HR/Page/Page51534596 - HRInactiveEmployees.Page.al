page 51534596 "HR Inactive Employees"
{
    ApplicationArea = all;
    PageType = List;
    CardPageId = "HR Employee Card (Inactive)";
    Editable = False;
    AdditionalSearchTerms = 'HR Inactive Employees';
    UsageCategory = Lists;
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = CONST(Inactive));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Full / Part Time"; "Full / Part Time")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = all;
                }
                field(Age; Age)
                {
                    ApplicationArea = all;
                }
                field("Length Of Service"; "Length Of Service")
                {
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Date"; "Exit Interview Date")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Done by"; "Exit Interview Done by")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

