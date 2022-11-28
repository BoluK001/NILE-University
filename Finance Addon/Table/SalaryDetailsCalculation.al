/// <summary>
/// Table SalaryDetailCal (ID 50102).
/// </summary>
table 51534408 SalaryDetailCal
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee Code"; code[20])
        {
            Caption = 'Employee Code';
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Gross Annual Salary"; Decimal)
        {
            Caption = 'Gross Annual Salary';
            DataClassification = ToBeClassified;
        }
        field(3; "Position Clinic Allowance"; Decimal)
        {
            Caption = 'Position Clinic Allowance';
            DataClassification = ToBeClassified;
        }
        field(4; "Basic"; Decimal)
        {
            Caption = 'Basic';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(5; "Housing"; Decimal)
        {
            Caption = 'Housing';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; "Transport"; Decimal)
        {
            Caption = 'Transport';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(7; "Others"; Decimal)
        {
            Caption = 'Other Allowance';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Monthly Gross"; Decimal)
        {
            Caption = 'Monthly Gross';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; "Employer Pension"; Decimal)
        {
            Caption = 'Employer Pension';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(11; "NSITF"; Decimal)
        {
            Caption = 'NSITF';
            Editable = false;
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(pk; "Employee Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}