page 51534519 "HR Employment History"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employmee Details")
            {
                Caption = 'Employmee Details';
                Editable = false;
                field("No."; "No.")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field(FullName; FullName)
                {
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Postal Address"; "Postal Address")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                    Enabled = false;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Personal E-Mail"; "Personal E-Mail")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
            }
            part("Employment History Details"; "HR Employment History Lines")
            {
                Caption = 'Employment History Details';
                SubPageLink = "Employee No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(Control1102755010; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1102755009; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        HREmp.Reset;
        if HREmp.Get("No.") then begin
            EmpNames := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            EmpNames := '';
        end;
    end;

    var
        EmpNames: Text[30];
        HREmp: Record "HR Employees";
        Text19034996: Label 'Employment History';
}

