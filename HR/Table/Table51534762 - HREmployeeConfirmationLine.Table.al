table 51534762 "HR Employee Confirmation Line"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
        }
        field(3; Responbilities; Text[250])
        {
        }
        field(4; "Supervisor Rating"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5; "Available Rating"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(6; "Appraisal Type"; Option)
        {
            OptionCaption = ' ,Confirmation,Probation';
            OptionMembers = " ",Confirmation,Probation;
        }
        field(7; "Entry No."; Integer)
        {
        }
        field(8; "Application No."; Code[20])
        {
        }
        field(9; "Employee Rating"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

