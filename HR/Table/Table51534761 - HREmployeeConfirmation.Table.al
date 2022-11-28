table 51534761 "HR Employee Confirmation"
{

    fields
    {
        field(2; "Employee No."; Code[20])
        {
            Editable = false;
        }
        field(3; "Employee Name"; Text[60])
        {
            Editable = false;
        }
        field(4; "Date of Employment"; Date)
        {
            Editable = false;
        }
        field(5; "Date of Review"; Date)
        {
        }
        field(6; Department; Code[20])
        {
            Editable = false;
        }
        field(7; Level; Code[20])
        {
            Editable = false;
        }
        field(8; "Start Date"; Date)
        {
        }
        field(9; "End Date"; Date)
        {
        }
        field(10; "Appraisal Type"; Option)
        {
            OptionCaption = '"",Confirmation,Probation';
            OptionMembers = "",Confirmation,Probation;

            trigger OnValidate()
            begin
                HREmployeeConfirmation.SetRange(HREmployeeConfirmation."Employee No.", "Employee No.");
                HREmployeeConfirmation.SetRange(HREmployeeConfirmation."Appraisal Type", "Appraisal Type");
                if HREmployeeConfirmation.FindFirst then
                    Error('Sorry,you can not create more than one document with the same appraisal type');
                /*
               IF "Appraisal Type" = "Appraisal Type"::Probation THEN BEGIN
                HrEmp.GET("Employee No.");
                HrEmp."Probation Form Filled":=TRUE;
                HrEmp.MODIFY;
                END
               ELSE IF "Appraisal Type" = "Appraisal Type"::Confirmation THEN BEGIN
                HrEmp.GET("Employee No.");
                HrEmp."Confirmation Form Filled":=TRUE;
                HrEmp.MODIFY;
               END;
                */

            end;
        }
        field(11; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(12; Score; Decimal)
        {
            CalcFormula = Sum("HR Employee Confirmation Line"."Supervisor Rating" WHERE("Application No." = FIELD("Application No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Application No."; Code[20])
        {
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; Status; Option)
        {
            OptionCaption = 'New,Supervisor,Approved,HR';
            OptionMembers = New,"Pending Approval",Approved,HR;
        }
        field(16; "Send to Hr"; Boolean)
        {
        }
        field(17; "KPI Score"; Decimal)
        {
            CalcFormula = Sum("HR Confirmation KPI".Weight WHERE("Document No." = FIELD("Application No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Supervisor; Code[50])
        {
        }
        field(19; Comment; Text[250])
        {
        }
        field(20; "Development Areas"; Text[250])
        {
        }
        field(21; "Training Ideas"; Text[250])
        {
        }
        field(22; "Employee Comment"; Text[250])
        {
        }
        field(23; "Second Line Supervisor"; Code[50])
        {
        }
        field(24; "Second Line Supervisor Comment"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error('Record cannot be deleted');
    end;

    trigger OnInsert()
    begin
        ApprovalSetup.Reset;
        ApprovalSetup.SetRange("User ID", UserId);
        if ApprovalSetup.FindFirst then
            //  MESSAGE('Approval Setup Exists')
            SupNo := 0
        else
            Error('Approval Setup Does not Exist. Please setup your First and(or) Second Line Approvers');


        if "Application No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Confirmation Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Confirmation Nos", xRec."No. Series", 0D, "Application No.", "No. Series");
        end;


        HrEmp.Reset;
        HrEmp.SetRange(HrEmp."User ID", UserId);
        if HrEmp.Find('-') then begin
            "Employee No." := HrEmp."No.";
            "Employee Name" := Format(HrEmp."First Name") + ' ' + Format(HrEmp."Middle Name") + ' ' + Format(HrEmp."Last Name");
            Department := HrEmp."Department Code";
            Level := HrEmp."Job Level";
            "User ID" := UserId;
        end
        else begin
            Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;


        ApprovalSetup.SetRange("User ID", UserId);
        ApprovalSetup.SetCurrentKey(ApprovalSetup."Sequence No.");
        ApprovalSetup.Ascending(true);

        SupNo := 0;
        if ApprovalSetup.FindFirst then begin
            ;
            repeat
                SupNo := SupNo + 1;
                if SupNo = 1 then
                    Supervisor := ApprovalSetup."Approver ID";
                "Second Line Supervisor" := ApprovalSetup."Approver ID";
            until ApprovalSetup.Next = 0;
            ApprovalSetup.Modify;

            "Date of Employment" := HrEmp."Date Of Joining the Company";

            GetDuties;

        end
    end;

    var
        HrEmp: Record "HR Employees";
        UserSetup: Record "User Setup";
        HRConfmProbationDuties: Record "HR Confm/Probation  Duties";
        HREmployeeConfirmationLine: Record "HR Employee Confirmation Line";
        HRSetup: Record "HR Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmployeeConfirmation: Record "HR Employee Confirmation";
        ApprovalSetup: Record "Approval User Setup";
        SupNo: Integer;

    local procedure GetDuties()
    var
        TotalWeight: Decimal;
    begin
        HRConfmProbationDuties.Reset;
        HRConfmProbationDuties.SetRange(HRConfmProbationDuties."Entry No.");
        if HRConfmProbationDuties.FindFirst then
            repeat
                HREmployeeConfirmationLine.Init;
                HREmployeeConfirmationLine."Employee No." := "Employee No.";
                //HREmployeeConfirmationLine."Appraisal Type":="Appraisal Type";
                HREmployeeConfirmationLine."Application No." := "Application No.";
                HREmployeeConfirmationLine."Line No." := 0;
                HREmployeeConfirmationLine.Responbilities := HRConfmProbationDuties.Duties;
                HREmployeeConfirmationLine."Available Rating" := HRConfmProbationDuties."Total Available Rating";
                HREmployeeConfirmationLine."Entry No." := HRConfmProbationDuties."Entry No.";
                HREmployeeConfirmationLine.Insert;
            until HRConfmProbationDuties.Next = 0;
    end;
}

