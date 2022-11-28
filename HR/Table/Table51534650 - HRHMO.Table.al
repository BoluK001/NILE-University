table 51534650 "HR HMO"
{

    fields
    {
        field(2; "Employee No."; Code[20])
        {
            Editable = True;  //jj290922 
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                IF HrEmp.GET("Employee No.") THEN BEGIN
                    "Employee Name" := FORMAT(HrEmp."First Name") + ' ' + FORMAT(HrEmp."Middle Name") + ' ' + FORMAT(HrEmp."Last Name");
                    Department := HrEmp."Department Code";
                    "Job Level" := HrEmp."Job Level";
                    "HMO Level" := HrEmp."Job Level";
                    "Employment Type" := HrEmp."Employment Type";
                    HrLookUp.SETRANGE(HrLookUp.Type, HrLookUp.Type::"Employment Type");
                    HrLookUp.SETRANGE(HrLookUp.Code, HrEmp."Employment Type");
                    IF HrLookUp.FINDFIRST THEN
                        "Number of Beneficiaries" := HrLookUp."HMO Beneficiaries";
                    "Medical Scheme Plan" := HrLookUp."HMO Plan";

                END;
                // jj290922  I unremmed this block of code

            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; Department; Code[30])
        {
        }
        field(5; "Job Level"; Code[30])
        {
            Editable = false;
        }
        field(6; "HMO Level"; Code[20])
        {
        }
        field(7; "Number of Beneficiaries"; Integer)
        {
            Editable = false;
        }
        field(8; "Employment Type"; Code[20])
        {
            Editable = false;
        }
        field(9; "HMO Card Number"; Code[20])
        {
        }
        field(10; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(11; "No of Active"; Integer)
        {
            CalcFormula = Count("HR HMO Beneficiary" WHERE("Staff No." = FIELD("Employee No."),
                                                            Active = CONST(true)));
            FieldClass = FlowField;
        }
        field(12; "User ID"; Code[50])
        {
        }
        field(13; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(14; "Medical Scheme Plan"; Option)
        {
            OptionCaption = '  ,High Lite, High Value';
            OptionMembers = "  ","High Lite","High Value";
        }
        field(15; "Medical Scheme Hospital"; Text[100])
        {
        }
        field(51050; "Medical Sch. Hospital Code"; Code[20])
        {
            TableRelation = "HR HMO Hospital";

            trigger OnValidate()
            begin
                if HRHMOHospital.Get("Medical Sch. Hospital Code") then begin
                    "Medical Scheme Hospital" := HRHMOHospital.Name;
                    "Hospital Address" := HRHMOHospital.Address;
                end;
            end;
        }
        field(51051; "Hospital Address"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
        key(Key2; "HMO Level")
        {
        }
        key(Key3; "Employment Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Record can not be deleted');
    end;

    trigger OnInsert()
    begin
        //"User ID":=USERID;
        /*  HrEmp.Reset;
          HrEmp.SetRange(HrEmp."User ID", UserId);
          if HrEmp.Find('-') then begin
              "Employee No." := HrEmp."No.";
              "Employee Name" := Format(HrEmp."First Name") + ' ' + Format(HrEmp."Middle Name") + ' ' + Format(HrEmp."Last Name");
              Department := HrEmp."Department Code";
              "Job Level" := HrEmp."Job Level";
              "HMO Level" := HrEmp."Job Level";
              "User ID" := UserId;
              "Employment Type" := HrEmp."Employment Type";
              HrLookUp.SetRange(HrLookUp.Type, HrLookUp.Type::"Employment Type");
              HrLookUp.SetRange(HrLookUp.Code, HrEmp."Employment Type");
              if HrLookUp.FindFirst then
                  "Number of Beneficiaries" := HrLookUp."HMO Beneficiaries";
              "Medical Scheme Plan" := HrLookUp."HMO Plan";
          end
          else begin
              Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
      end;   */   //jj290922  I remmed
    end;

    var
        HrEmp: Record "HR Employees";
        HrLookUp: Record "HR Lookup Values";
        UserSetup: Record "User Setup";
        Hmo: Record "HR HMO";
        HmoBen: Record "HR HMO Beneficiary";
        HRHMOHospital: Record "HR HMO Hospital";
        HRHMOLines: Record "HR HMO Beneficiary";

    local procedure CheckActive()
    begin
        /*IF Hmo.GET(Rec."Employee No.") THEN BEGIN
         HmoBen.SETRANGE( HmoBen."Staff No.",Hmo."Employee No.");
         HmoBen.SETRANGE( HmoBen.Active,TRUE);
         IF HmoBen.FINDSET THEN BEGIN
          IF HmoBen.COUNT >= Hmo."Number of Beneficiaries" THEN
          ERROR('Number of active beneficiaries must not be greater than the number of beneficiaries on the Hmo Card %1',HmoBen.COUNT);
          END;
        END;
         */

    end;

    procedure CheckHRHMOLines(): Boolean
    begin
        HRHMOLines.Reset;
        HRHMOLines.SetRange("Staff No.", "Employee No.");
        exit(not HRHMOLines.IsEmpty);
    end;
}

