table 51534776 "HR Emp. Transaction Header"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee";

            trigger OnValidate()
            begin
                if HrEmp.Get("Employee No.") then begin
                    "Employee Name" := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
                    "Salary Grade" := HrEmp."Salary Grade";
                    "Salary step" := HrEmp."Salary Notch/Step";
                    Department := HrEmp."Department Code";
                end;
            end;
        }
        field(3; "Salary Grade"; Code[20])
        {
            Editable = false;
        }
        field(4; Department; Code[20])
        {
            Editable = false;
        }
        field(5; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Salary step"; Code[20])
        {
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Updated';
            OptionMembers = Open,"Pending Approval",Approved,Updated;
        }
        field(9; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(10; "Created By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(11; "Current Period"; Date)
        {
            TableRelation = "prPayroll Periods";
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Transaction Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Transaction Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
    end;

    var
        HrEmp: Record "HR-Employee";
        HRSetup: Record "HR Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeTrans: Record "prEmployee Transactions";
        HREmpTransactionLine: Record "HR Emp Transaction Line";

    [Scope('OnPrem')]
    procedure UpdateEmployeeTrans()
    begin
        TestField(Status, Status::Approved);

        HREmpTransactionLine.SetRange(HREmpTransactionLine."Document No.", "Document No.");
        if HREmpTransactionLine.FindFirst then begin
            repeat
                EmployeeTrans.SetRange(EmployeeTrans."Employee Code", "Employee No.");
                //EmployeeTrans.SETRANGE(EmployeeTrans."Payroll Period","Current Period");
                EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", HREmpTransactionLine.Transaction);
                if EmployeeTrans.FindFirst then begin
                    EmployeeTrans.Amount := HREmpTransactionLine.Amount;
                    EmployeeTrans.Modify;
                end else begin
                    EmployeeTrans.Init;
                    EmployeeTrans."Employee Code" := "Employee No.";
                    EmployeeTrans."Transaction Code" := HREmpTransactionLine.Transaction;
                    EmployeeTrans."Entry No" := 0;
                    EmployeeTrans.Amount := HREmpTransactionLine.Amount;
                    EmployeeTrans.Validate("Transaction Code");
                    EmployeeTrans.Insert;
                end;
            until HREmpTransactionLine.Next = 0;
            Status := Status::Updated;
            Modify;
        end;
    end;
}

