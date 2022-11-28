table 51534602 "HR Applicant Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";
    //DrillDownPageID = 39003960;
    //LookupPageID = 39003960;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
            TableRelation = "HR Job Applications"."Application No";
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
        }
        field(3; "Qualification Description"; Code[80])
        {
            Caption = 'Qualification Description';
            NotBlank = true;

            trigger OnValidate()
            begin
                /*
                Qualifications.RESET;
                Qualifications.SETRANGE(Qualifications.Code,"Qualification Description");
                IF Qualifications.FIND('-') THEN
                "Qualification Code":=Qualifications.Description;
                */

            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(14; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Qualification Type"));
        }
        field(15; "Qualification Code"; Text[200])
        {
            NotBlank = true;
            TableRelation = "HR Qualifications".Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(16; "Score ID"; Decimal)
        {
        }
        field(17; "Class of Degree"; Option)
        {
            OptionMembers = " ",Distinction,"First Class","Second Class Upper","Second Class Lower","Third Class",Pass;
        }
        field(18; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(19; "Course of Study"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Application No", "Qualification Type", "Qualification Code", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Qualifications";
        Applicant: Record "HR Job Applications";
        Position: Code[20];
        JobReq: Record "HR Job Requirements";
}

