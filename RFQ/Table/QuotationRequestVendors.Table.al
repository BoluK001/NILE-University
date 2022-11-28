table 51534354 "Quotation Request Vendors"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Vendor No."; Code[20])
        {
            TableRelation = Vendor WHERE("Vendor Type" = filter(<> "With Holding Tax"));
        }
        field(4; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
        field(5; "issued date"; Date)
        {
            Caption = 'Issued Date';
        }
        field(6; "Vendor Address"; Text[100])
        {
            CalcFormula = lookup(vendor.Address where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(7; "vendor Phone No."; Text[30])
        {
            CalcFormula = lookup(Vendor."Mobile Phone No." where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(8; "vendor Email"; Text[80])
        {
            CalcFormula = lookup(Vendor."E-Mail" where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(9; "vendor Website"; Text[80])
        {
            CalcFormula = lookup(Vendor."Home Page" where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

