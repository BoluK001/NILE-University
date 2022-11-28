page 51534418 "HR Confirmation Lines"
{
    Caption = 'HR Confirmation Lines';
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Employee Confirmation Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'S/N';
                    ApplicationArea = all;
                }
                field(Responbilities; Rec.Responbilities)
                {
                    ApplicationArea = all;
                }
                field("Available Rating"; Rec."Available Rating")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Employee Rating"; Rec."Employee Rating")
                {
                    Editable = EmpEditable;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*IF HREmployeeConfirmation.GET("Application No.") THEN BEGIN   //SupEditable
         IF (USERID = HREmployeeConfirmation.Supervisor) OR (USERID = HREmployeeConfirmation."Second Line Supervisor") THEN BEGIN
           SupEditable:=TRUE;
           EmpEditable:=FALSE;
          END
         ELSE IF USERID = HREmployeeConfirmation."User ID" THEN BEGIN
           EmpEditable:=TRUE;
           SupEditable:=FALSE;
          END;
         END;
         */


        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Application No.");
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", USERID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            SupEditable := TRUE;
            EmpEditable := FALSE;
        END ELSE BEGIN
            EmpEditable := TRUE;
            SupEditable := FALSE;
        END;

    end;

    trigger OnOpenPage()
    begin
        /*IF HREmployeeConfirmation.GET("Application No.") THEN BEGIN   //SupEditable
         IF (USERID = HREmployeeConfirmation.Supervisor) OR (USERID = HREmployeeConfirmation."Second Line Supervisor")  THEN BEGIN
           SupEditable:=TRUE;
           EmpEditable:=FALSE;
          END
         ELSE IF USERID = HREmployeeConfirmation."User ID" THEN BEGIN
           EmpEditable:=TRUE;
           SupEditable:=FALSE;
          END;
         END;
        
         */
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Application No.");
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", USERID);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            SupEditable := TRUE;
            EmpEditable := FALSE;
        END ELSE BEGIN
            EmpEditable := TRUE;
            SupEditable := FALSE;
        END;

    end;

    var
        HREmployeeConfirmation: Record "HR Employee Confirmation";
        EmpEditable: Boolean;
        SupEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
}

