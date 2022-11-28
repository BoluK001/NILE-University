table 51534618 "HR Transport Requisition Pass"
{

    fields
    {
        field(1; "Req No"; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmp.Get("Employee No") then begin
                    "Passenger/s Full Name/s" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    Dept := HREmp."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; "Passenger/s Full Name/s"; Text[70])
        {
        }
        field(4; Dept; Text[70])
        {
        }
        field(5; "Daily Work Ticket"; Code[20])
        {
        }
        field(6; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Req No", EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
}

