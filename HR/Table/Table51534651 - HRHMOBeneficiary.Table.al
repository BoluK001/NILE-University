table 51534651 "HR HMO Beneficiary"
{

    fields
    {
        field(2; "Staff No."; Code[20])
        {
            TableRelation = "HR Employees";
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(4; "First Name"; Text[30])
        {
        }
        field(5; "Middle Name"; Text[30])
        {
        }
        field(6; "Last Name"; Text[30])
        {
        }
        field(7; Active; Boolean)
        {

            trigger OnValidate()
            begin
                //CheckActive;
            end;
        }
        field(8; "Phone No."; Code[20])
        {
        }
        field(9; Relationship; Option)
        {
            OptionCaption = ' ,Daughter,Son,Spouse';
            OptionMembers = " ",Daughter,Son,Spouse;
        }
        field(10; Gender; Option)
        {
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(11; "Active Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Date of Birth"; Date)
        {
        }
        field(13; "Picture 1"; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "Picture 2"; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Hmo: Record "HR HMO";
        HmoBen: Record "HR HMO Beneficiary";

    [Scope('OnPrem')]
    procedure CheckActive()
    begin
        if Hmo.Get("Staff No.") then begin
            HmoBen.SetRange(HmoBen."Staff No.", Rec."Staff No.");
            HmoBen.SetRange(HmoBen.Active, true);
            if HmoBen.FindSet then begin
                if HmoBen.Count > Hmo."Number of Beneficiaries" then
                    Error('Number of active beneficiaries must not be greater than the number of beneficiaries on the Hmo Card %1', HmoBen.Count);
            end;
        end;
    end;
}

