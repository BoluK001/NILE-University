table 51534504 "Leave Group"
{
    Caption = 'Leave Group';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "No. of Days"; Integer)
        {
            Caption = 'No. of Days';
            DataClassification = ToBeClassified;
        }
        field(4; "Leave Type"; Code[20])
        {
            Caption = 'Leave Type';
            //DataClassification = ToBeClassified;
            tablerelation = "HR Leave Types";
        }
        field(5; "Employee Type"; Option)
        {
            Caption = 'Employee Type';
            OptionMembers = ,Permanent,Associates;
        }
    }
    keys
    {
        key(PK; Code, "Leave Type")
        {
            Clustered = true;
        }
    }

}
