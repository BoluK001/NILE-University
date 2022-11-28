table 51534554 "Salary Notch"
{

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(2; "Salary Notch"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees"."No.";  //jj22092022 changed from HR-Employee
            trigger OnValidate()
            var
                Emp: Record "HR Employees"; //jj22092022 changed from HR-Employee
            begin
                if emp.Get("Salary Notch") then
                    emp.SetRange("No.", "Salary Notch");
                if emp.Find('-') then
                    Description := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;

        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Basic  Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                "Annual Salary Amount" := "Basic  Pay" * 12;
            end;
        }
        field(5; "Hourly Rate"; Decimal)
        {
        }
        field(6; "Annual Salary Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Annual Salary Amount" > 0 then
                    "Basic  Pay" := "Annual Salary Amount" / 12;
            end;
        }
        field(7; "Gross Annual Salary"; Decimal)
        {
            trigger OnValidate()
            var
                HREMP: Record "HR Employees";   //jj22092022 changed from HR-Employee
            begin
                if HREMP.get("Salary Notch") then begin
                    HREMP.SetRange("No.", "Salary Notch");
                    // if HREMP."Posting Group" = 'PERMANENT' THEN   //JJ04102022 I Remmed
                    if (HREMP."Posting Group" = 'LOCAL ACADEMIC') OR (HREMP."Posting Group" = 'LOCAL NON ACADEMIC') OR (HREMP."Posting Group" = 'EXPERT ACADEMIC') OR (HREMP."Posting Group" = 'EXPERT NON ACADEMIC') THEN     //JJ04102022 I added
                        "Basic  Pay" := (("Gross Annual Salary" - ("Position Clinic Allowance" * 12)) * 0.1) / 12
                    ELSE
                        "Basic  Pay" := ("Gross Annual Salary" / 12);
                End;
            end;


        }
        field(8; "Position Clinic Allowance"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Salary Grade", "Salary Notch")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

