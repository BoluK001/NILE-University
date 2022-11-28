page 51534502 "HR Employee Qualifications"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Qualification';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No."; "No.")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field(FullName; FullName)
                {
                    Caption = 'Name';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Postal Address"; "Postal Address")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
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
                    ApplicationArea = all;
                    StyleExpr = TRUE;
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
            part("Employee Qualifications"; "HR Employee Qualification Line")
            {
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No." = FIELD("No.");
                ApplicationArea = All;
            }
            systempart(Control1102755011; Outlook)
            {
            }
        }
        area(factboxes)
        {
            part(Control1102755012; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;
            }
            systempart(Control1102755010; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Q&ualification Overview")
                {
                    Caption = 'Q&ualification Overview';
                    Image = TaskQualityMeasure;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

