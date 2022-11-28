page 51534416 "HR Confirmation List"
{
    Caption = 'Staff Probation/Confirmation';
    CardPageID = "HR Confirmation Header";
    DeleteAllowed = true;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Confirmation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                { 
                    ApplicationArea = all; 
                }
                field("Employee No."; Rec."Employee No.")
                { 
                    ApplicationArea = all; 
                }
                field("Employee Name"; Rec."Employee Name")
                { 
                    ApplicationArea = all; 
                }
                field("Date of Employment"; Rec."Date of Employment")
                { 
                    ApplicationArea = all; 
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                { 
                    ApplicationArea = all; 
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("User ID",USERID);

        FILTERGROUP(2);
        SETFILTER("User ID", USERID);
        FILTERGROUP(0);
    end;
}

