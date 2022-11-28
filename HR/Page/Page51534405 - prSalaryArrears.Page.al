page 51534405 prSalaryArrears
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "prSalary Arrears";

    layout
    {
        area(content)
        {
            repeater(new)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field("Salary Arrears"; Rec."Salary Arrears")
                {
                    ApplicationArea = all;
                }
                field("PAYE Arrears"; Rec."PAYE Arrears")
                {
                    ApplicationArea = all;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = all;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = all;
                }
                field("Current Basic"; Rec."Current Basic")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; Rec."Payroll Period")
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

