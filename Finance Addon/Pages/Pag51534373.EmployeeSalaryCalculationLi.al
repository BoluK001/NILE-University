page 51534373 "Employee Salary Calculation Li"
{
    ApplicationArea = All;
    Caption = 'Employee Salary Calculation List';
    CardPageId = EmployeeSalaryDetails;
    PageType = List;
    SourceTable = SalaryDetailCal;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                    ApplicationArea = All;
                }
                field(Basic; Rec.Basic)
                {
                    ToolTip = 'Specifies the value of the Basic field.';
                    ApplicationArea = All;
                }
                field("Employer Pension"; Rec."Employer Pension")
                {
                    ToolTip = 'Specifies the value of the Employer Pension field.';
                    ApplicationArea = All;
                }
                field("Gross Annual Salary"; Rec."Gross Annual Salary")
                {
                    ToolTip = 'Specifies the value of the Gross Annual Salary field.';
                    ApplicationArea = All;
                }
                field(Housing; Rec.Housing)
                {
                    ToolTip = 'Specifies the value of the Housing field.';
                    ApplicationArea = All;
                }
                field("Monthly Gross"; Rec."Monthly Gross")
                {
                    ToolTip = 'Specifies the value of the Monthly Gross field.';
                    ApplicationArea = All;
                }
                field(NSITF; Rec.NSITF)
                {
                    ToolTip = 'Specifies the value of the NSITF field.';
                    ApplicationArea = All;
                }
                field(Others; Rec.Others)
                {
                    ToolTip = 'Specifies the value of the Other Allowance field.';
                    ApplicationArea = All;
                }
                field("Position Clinic Allowance"; Rec."Position Clinic Allowance")
                {
                    ToolTip = 'Specifies the value of the Position Clinic Allowance field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Transport; Rec.Transport)
                {
                    ToolTip = 'Specifies the value of the Transport field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
