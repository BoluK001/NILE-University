table 51534564 "HR Employee Kin"
{
    // Caption = 'Employee Relative';
    DrillDownPageId = "HR Employee Kin SF";
    LookupPageId = "HR Employee Kin SF";

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees"."No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = IF (Type = CONST("Next of Kin")) "HR Lookup Values".Code WHERE(Type = CONST("Next of Kin"))
            ELSE
            IF (Type = CONST(Beneficiary)) "HR Lookup Values".Code
            ELSE
            IF (Type = CONST(Gurantor)) "HR Lookup Values".Code;
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(12; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary,Gurantor;
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Relative"),
                                                                     "No." = FIELD("Employee Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "E-mail"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", Type, Relationship, SurName, "Other Names", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;
}

