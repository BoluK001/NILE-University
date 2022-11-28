table 51534625 "Hr Canteen Application"
{

    fields
    {
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened" WHERE(Closed = CONST(false));

            trigger OnValidate()
            begin
                "Period Month" := Date2DMY("Payroll Period", 2);
                "Period Year" := Date2DMY("Payroll Period", 3);
            end;
        }
        field(10; "Ticket No."; Code[50])
        {
        }
        field(20; "Employee No."; Code[50])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREMp.Reset;
                if HREMp.Get("Employee No.") then begin
                    "Employee Name" := HREMp."First Name" + ' ' + HREMp."Middle Name" + ' ' + HREMp."Last Name";
                    Date := Today;
                    "Department Code" := HREMp."Department Code";
                end;
            end;
        }
        field(30; "Employee Name"; Text[100])
        {
        }
        field(40; Date; Date)
        {
            Editable = false;
        }
        field(50; Amount; Decimal)
        {
            Editable = false;
        }
        field(60; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center";
        }
        field(70; "Department Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DimVal.SetRange(Code, "Department Code");
                if DimVal.FindFirst then
                    "Department Name" := DimVal.Name;
            end;
        }
        field(80; "Department Name"; Text[100])
        {
        }
        field(90; "Request Type"; Option)
        {
            OptionMembers = Employee,Visitor;
        }
        field(100; "Visitor Name"; Text[100])
        {
        }
        field(110; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(120; "No series"; Code[20])
        {
        }
        field(130; Posted; Boolean)
        {
            Editable = false;
        }
        field(131; "Transaction Code"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if prTransactionCodes.Get("Transaction Code") then
                    "Transaction Name" := prTransactionCodes."Transaction Name";
            end;
        }
        field(132; "Transaction Name"; Text[30])
        {
            Editable = false;
        }
        field(133; "Start Date"; Date)
        {
        }
        field(134; "User ID"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Ticket No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Ticket No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Ticket Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Ticket Nos", xRec."No series", 0D, "Ticket No.", "No series");
        end;

        HREMp.Reset;
        HREMp.SetRange(HREMp."User ID", UserId);
        if HREMp.FindFirst then begin
            "Employee No." := HREMp."No.";
            "Employee Name" := Format(HREMp."First Name") + ' ' + Format(HREMp."Middle Name") + ' ' + Format(HREMp."Last Name");
            Validate("Employee No.");
            "Department Code" := HREMp."Department Code";
            Validate("Department Code");
            //"Job Level":=HrEmp."Job Level";
            "User ID" := UserId;
            //"Employment Type":=HrEmp."Employment Type";

        end
        else begin
            Error('User id' + ' ' + '[' + UserId + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
        end;

        prTransactionCodes.SetRange(prTransactionCodes.Meal, true);
        if prTransactionCodes.FindFirst then begin
            "Transaction Code" := prTransactionCodes."Transaction Code";
            Validate("Transaction Code");
        end;
        Amount := HRSetup."Meal Amount";
    end;

    var
        HRSetup: Record "HR Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        HREMp: Record "HR Employees";
        DimVal: Record "Dimension Value";
        prTransactionCodes: Record "prTransaction Codes";
}

