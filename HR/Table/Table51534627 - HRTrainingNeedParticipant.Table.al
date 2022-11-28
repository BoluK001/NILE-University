table 51534627 "HR Training Need Participant"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                HREmp.Get("Employee Code");
                "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                "Job Title" := HREmp."Job Title";
                Department := HREmp."Department Code";

                TrainingApp.SetRange(TrainingApp."Application No", "Document No.");
                if TrainingApp.FindFirst then begin
                    "Staff Course Title" := TrainingApp."Staff Course Title";
                    "From Date" := TrainingApp."From Date";
                    "To Date" := TrainingApp."To Date";
                    "Course Title" := TrainingApp."Course Title";
                end;
            end;
        }
        field(2; "Employee Name"; Text[100])
        {
        }
        field(3; Department; Code[20])
        {
        }
        field(4; "Job Title"; Code[20])
        {
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(6; "Document No."; Code[20])
        {
        }
        field(7; Selected; Boolean)
        {
        }
        field(8; "Staff Course Title"; Code[30])
        {
        }
        field(9; "From Date"; Date)
        {
        }
        field(10; "To Date"; Date)
        {
        }
        field(11; "Course Title"; Code[30])
        {
        }
        field(12; Amount; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(13; Status; Option)
        {
            CalcFormula = Lookup("HR Training Applications".Status WHERE("Application No" = FIELD("Document No.")));
            FieldClass = FlowField;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.", "Employee Code")
        {
            Clustered = true;
        }
        key(Key2; Department)
        {
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
        TrainingApp: Record "HR Training Applications";
}

