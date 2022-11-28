table 51534402 "Interview Stages"
{
    Caption = 'Interview Stages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Evaluation Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Hr Interview Evaluation Areas";
        }
        field(3; "Evaluation Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Evaluation Score"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Stage; Option)
        {
            BlankZero = true;
            OptionCaption = 'Stage1,Stage2,Stage3,Stage4';
            OptionMembers = Stage1,Stage2,Stage3,Stage4;
        }
        field(6; Ratings; Option)   //jj160322
        {
            Caption = 'Ratings 1';
            OptionCaption = ' ,5-Excellent,4-Good,3-Average,2-Poor';
            OptionMembers = " ","5-Excellent","4-Good","3-Average","2-Poor";
        }
        field(7; "Interview No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Job; Code[30])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(9; "Employee Code"; Code[20])
        {

            trigger OnValidate()
            var
                Emp: record "HR Employees";
            begin
                if Emp.Get("Employee Code") then
                    "Employee Name" := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
            end;
        }
        field(11; Ratings2; Option)   //jj160322
        {
            Caption = 'Ratings 2';
            OptionCaption = ' ,5-Excellent,4-Good,3-Average,2-Poor';
            OptionMembers = " ","5-Excellent","4-Good","3-Average","2-Poor";
        }
        field(12; Ratings3; Option)   //jj160322
        {
            Caption = 'Ratings 3';
            OptionCaption = ' ,5-Excellent,4-Good,3-Average,2-Poor';
            OptionMembers = " ","5-Excellent","4-Good","3-Average","2-Poor";
        }

        field(10; "Employee Name"; Text[100])
        {
        }

    }
    keys
    {
        key(PK; "Line No.", "Interview No.")
        {
            Clustered = true;
        }
    }
}
