page 51534895 "HR Leave Reliver SubForm"
{
    PageType = ListPart;
    SourceTable = "HR Leave Reliver";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; "Application No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reliver No."; "Reliver No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Employee.Get("Employee No");
                        Emp.SetFilter(Emp."No.", '<>%1', "Employee No");
                        Emp.SetRange(Emp."Department Code", Employee."Department Code");
                        Emp.SetRange(Emp."Global Dimension 2 Code", Employee."Global Dimension 2 Code");
                        if PAGE.RunModal(51534896, Emp) = ACTION::LookupOK then begin
                            "Reliver No." := Emp."No.";
                            Validate("Reliver No.");
                        end;
                    end;
                }
                field("Reliver Name"; "Reliver Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Employee: Record "HR Employees";
        Emp: Record "HR Employees";
}

