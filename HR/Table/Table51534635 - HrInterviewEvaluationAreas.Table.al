table 51534635 "Hr Interview Evaluation Areas"
{

    fields
    {
        field(10; "Evaluation Code"; Code[50])
        {
        }
        field(20; "Evaluation Description"; Text[250])
        {
        }
        field(30; "Evaluation Score"; Integer)
        {
        }
        field(40; Stage; Option)
        {
            BlankZero = true;
            OptionCaption = 'Stage1,Stage2,Stage3';
            OptionMembers = Stage1,Stage2,Stage3;
        }
        field(41; Ratings; Option)   //jj160322
        {
            OptionCaption = ' ,5-Excellent,4-Good,3-Average,2-Poor';
            OptionMembers = ,"5-Excellent","4-Good","3-Average","2-Poor";
        }
        field(42; "Interview No."; Code[20])
        {

        }
        field(50; Job; Code[30])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(51; "Employee Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if Emp.Get("Employee Code") then
                    "Employee Name" := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
            end;
        }

        field(52; "Employee Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Evaluation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record "HR Employees";
}

