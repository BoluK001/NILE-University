table 51534557 prAssignEmployeeLoan
{

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmp.Get("Employee Code") then
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name"
                else
                    "Employee Name" := '';
            end;
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                objPeriod.Reset;
                objPeriod.SetRange(objPeriod.Closed, false);
                if objPeriod.Find('-') then begin
                    CurrentYr := objPeriod."Period Year";
                    CurrentMonth := objPeriod."Period Month";
                end;



                if Transcode.Get("Transaction Code") then begin
                    "Transaction Name" := Transcode."Transaction Name";
                    "Nominal Interest Rate" := Transcode."Nominal Interest Rate";
                    "Effective Interest Rate" := Transcode."Effective Interest Loan";
                end;
                //IF Transcode."Leave Allowance" = TRUE THEN BEGIN
                /*
                EmployeeTrans.RESET;
                EmployeeTrans.SETRANGE(EmployeeTrans."Employee Code","Employee Code");
                EmployeeTrans.SETRANGE(EmployeeTrans."Transaction Code","Transaction Code");
                IF EmployeeTrans.FIND('-') THEN BEGIN
                REPEAT
                IF EmployeeTrans."Period Year" = CurrentYr THEN BEGIN
                MonthName:=FORMAT(EmployeeTrans."Payroll Period",0,'<Month Text>');
                //ERROR(MonthName);
                ERROR('Employee has already been paid leave allowance in the period of %1.- %2',EmployeeTrans."Payroll Period",
                       EmployeeTrans."Employee Code");
                END;
                UNTIL EmployeeTrans.NEXT = 0;
                END;
                */
                //END;
                //END;

            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                CheckLoan;
                // if (Balance > 0) and (Amount > 0) then   Dennis
                //"#of Repayments":=Balance/Amount;
            end;
        }
        field(5; Balance; Decimal)
        {

            trigger OnValidate()
            begin

                "Interest Amount" := ("Nominal Interest Rate" / 100) * Balance;
                "#of Repayments" := 0;
                //IF (Balance > 0) AND ("#of Repayments" > 0) THEN
                //Amount:=Balance/"#of Repayments"
            end;
        }
        field(6; "Original Amount"; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";

            trigger OnValidate()
            begin
                "Period Month" := Date2DMY("Payroll Period", 2);
                "Period Year" := Date2DMY("Payroll Period", 3);
            end;
        }
        field(10; "#of Repayments"; Integer)
        {

            trigger OnValidate()
            begin
                if (Balance > 0) and ("#of Repayments" > 0) then
                    Amount := Balance / "#of Repayments";
                Validate(Amount);
                "Interest Monthly Deduction" := "Interest Amount" / "#of Repayments";
                //"End Date":="Start Date"+"#of Repayments";
                "End Date" := CalcDate(Format("#of Repayments") + 'M', "Start Date");
            end;
        }
        field(11; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(12; "Reference No"; Text[100])
        {
        }
        field(13; integera; Integer)
        {
        }
        field(14; "Employer Amount"; Decimal)
        {
        }
        field(15; "Employer Balance"; Decimal)
        {
        }
        field(16; "Stop for Next Period"; Boolean)
        {
        }
        field(17; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(18; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                //"End Date":="Start Date"+"#of Repayments";
                "Start Date Month" := Date2DMY("Start Date", 2);
                if "Start Date Month" = CurrentMonth then
                    Validate("Payroll Period", objPeriod."Date Opened");
            end;
        }
        field(19; "End Date"; Date)
        {
        }
        field(20; "Loan Number"; Code[20])
        {
        }
        field(21; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(22; "No of Units"; Decimal)
        {

            trigger OnValidate()
            begin
                if Transcode.Get("Transaction Code") then begin
                    if (Transcode."Transaction Category" = Transcode."Transaction Category"::Overtime) or
                       (Transcode."Transaction Category" = Transcode."Transaction Category"::Entertainment) then begin
                        Amount := 0;
                        Transcode.TestField(Transcode."Overtime Type");
                        if SalCard.Get("Employee Code") then begin
                            if SalaryNotches.Get(SalCard."Salary Grade", SalCard."Salary Notch") then begin
                                if Transcode."Overtime Type" = Transcode."Overtime Type"::"Double OT" then
                                    Amount := SalaryNotches."Hourly Rate" * 2 * "No of Units"
                                else
                                    if Transcode."Overtime Type" = Transcode."Overtime Type"::"Triple OT" then
                                        Amount := SalaryNotches."Hourly Rate" * 3 * "No of Units"
                                    else
                                        Amount := SalaryNotches."Hourly Rate" * 1.5 * "No of Units";

                            end;
                        end;
                    end;
                end;
            end;
        }
        field(23; Suspended; Boolean)
        {
        }
        field(24; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(38; "IsCoop/LnRep"; Boolean)
        {
            CalcFormula = Lookup("prTransaction Codes"."IsCoop/LnRep" WHERE("Transaction Code" = FIELD("Transaction Code")));
            Description = 'to be able to report the different coop contributions -Dennis';
            FieldClass = FlowField;
        }
        field(101; Status; Option)
        {
            OptionCaption = 'Pending,Pending Approval,Released,Processed,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Posted,Cancelled;
        }
        field(102; "Employee Name"; Text[100])
        {
        }
        field(103; "Start Date Month"; Integer)
        {
        }
        field(323; "Payroll Type"; Option)
        {
            CalcFormula = Lookup("HR-Employee"."Payroll Type" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(324; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(325; "Document No."; Code[20])
        {
        }
        field(326; "No. Series"; Code[20])
        {
        }
        field(327; "Nominal Interest Rate"; Decimal)
        {
        }
        field(328; "Effective Interest Rate"; Decimal)
        {
        }
        field(329; "Interest Monthly Deduction"; Decimal)
        {
        }
        field(330; "Interest Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
        key(Key2; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key3; "Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Loan Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Loan Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;
    end;

    var
        Transcode: Record "prTransaction Codes";
        EmployeeTrans: Record "prEmployee Transactions";
        MonthName: Text[100];
        SalCard: Record "prSalary Card";
        SalaryNotches: Record "Salary Notch";
        CurrentYr: Integer;
        objPeriod: Record "prPayroll Periods";
        HREmp: Record "HR-Employee";
        CurrentMonth: Integer;
        HRSetup: Record "HR Setup";
    //NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure CheckLoan()
    var
        PeriodTrans: Record "prPeriod Transactions";
        HrSetup: Record "HR Setup";
        text001: Label 'Sorry,Loan amount can not exceed %1 % of your Netpay';
        ExtEmp: Record "HR Employee Loan Ext";
        PeriodAmount: Decimal;
    begin
        HrSetup.Get;
        HrSetup.TestField("Loan Amount %");
        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
        PeriodTrans.SetRange(PeriodTrans."Payroll Period", "Payroll Period");                               //CALCDATE('-1M',"Payroll Period"));
        PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NPAY');
        if PeriodTrans.FindFirst then begin
            PeriodAmount := PeriodTrans.Amount;
            ExtEmp.SetRange(ExtEmp."Employee No.", "Employee Code");
            ExtEmp.SetRange(ExtEmp.Current, true);
            if ExtEmp.FindFirst then begin
                //Message('%1',PeriodAmount);
                PeriodAmount := PeriodAmount - ExtEmp."Monthly Repayment";
                if Amount > (PeriodAmount * (HrSetup."Loan Amount %" / 100)) then
                    Error(text001, HrSetup."Loan Amount %");
            end else begin
                if Amount > (PeriodAmount * (HrSetup."Loan Amount %" / 100)) then
                    Error(text001, HrSetup."Loan Amount %");
            end;
        end;
    end;

    [Scope('OnPrem')]
    procedure GeneratePV()
    var
        VouchHeader: Record "Voucher Header";
        VouchLine: Record "Voucher Line";
        text001: Label 'Loan Payment  %1';
        PostingGroup: Code[20];
        PayHead: Record "Voucher Header";
        PostedApprovalEntry: Record "Posted Approval Entry";
        AppEntry: Record "Approval Entry";
        Customer: Record Customer;
        UserSetup: Record "User Setup";
        Emp: Record "HR Employees";
        EmpName: Text[100];
    begin
        VouchHeader.Reset;
        VouchHeader.SetRange(VouchHeader."External Document No.", Rec."Document No.");
        if VouchHeader.Find('-') = true then
            Error('Payment Voucher has already been created for this document,Payment Voucher No: %1', VouchHeader."No.");

        if Emp.Get("Employee Code") then
            EmpName := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + CopyStr(Emp."Middle Name", 1, 1);

        UserSetup.Get(UserId);
        //UserSetup.TestField("Staff Travel Account");
        begin
            VouchHeader.Init;
            VouchHeader."Document Date" := WorkDate;
            //VouchHeader.Payee := EmpName;
            //VouchHeader."On Behalf Of":="Employee Name";
            //VouchHeader.Cashier:=Cashier;
            VouchHeader.Status := VouchHeader.Status::"Pending Approval";
            VouchHeader."Voucher Type" := VouchHeader."Voucher Type"::BPV;
            // VouchHeader."Pay Mode" := VouchHeader."Pay Mode"::Cheque;
            // VouchHeader."Document Type" := VouchHeader."Document Type"::"Payment Voucher";
            //VouchHeader."Leave Payment" := true;
            // VouchHeader."Payment Type" := VouchHeader."Payment Type"::Normal;
            //VouchHeader."Global Dimension 1 Code":="Global Dimension 1 Code";
            //VouchHeader.VALIDATE("Global Dimension 1 Code");
            //VouchHeader."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
            //VouchHeader.VALIDATE("Shortcut Dimension 2 Code");
            VouchHeader."Responsibility Center" := "Responsibility Center";
            //VouchHeader."Payment Release Date":="Payment Release Date";
            //VouchHeader."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
            //VouchHeader.VALIDATE("Shortcut Dimension 3 Code");
            //VouchHeader."Shortcut Dimension 4 Code":="Shortcut Dimension 4 Code";
            //VouchHeader.VALIDATE("Shortcut Dimension 4 Code");
            VouchHeader.Narration := StrSubstNo(text001, "Employee Code");
            VouchHeader."External Document No." := "Document No.";
            VouchHeader."Created By" := UserId;
            VouchHeader.Insert(true);

            //create Line
            VouchLine.Init;
            VouchLine."Line No." := 10000;
            VouchLine."Document No." := VouchHeader."No.";
            //add Vendor to Type
            if Customer.Get(UserSetup."Staff Travel Account") then   //Get users staff travel account
                PostingGroup := Customer."Customer Posting Group";
            VouchLine."Posting Group" := PostingGroup;
            //VouchLine.Type := 'CASHVENDOR';
            VouchLine."Account Type" := VouchLine."Account Type"::Customer;
            VouchLine."Account No." := UserSetup."Staff Travel Account";
            VouchLine.Validate("Account No.");
            //VouchLine."Account Name":= "Provider Name";
            VouchLine."Voucher Type" := VouchHeader."Voucher Type"::BPV;
            VouchLine.Amount := Balance;
            //VouchLine."Net Amount" := Balance;

            //VouchLine."Pay Mode" := VouchHeader."Pay Mode";
            //VouchLine."Global Dimension 1 Code":=Rec."Global Dimension 1 Code";
            //VouchLine.VALIDATE("Global Dimension 1 Code");
            //VouchLine."Shortcut Dimension 2 Code":=Rec."Global Dimension 2 Code";
            //VouchLine.VALIDATE("Shortcut Dimension 2 Code");
            /*VouchLine."Shortcut Dimension 3 Code":=PurchLine."Shortcut Dimension 3 Code";
            VouchLine.VALIDATE("Shortcut Dimension 3 Code");
            VouchLine."Shortcut Dimension 4 Code":=PurchLine."Shortcut Dimension 4 Code";
            VouchLine.VALIDATE("Shortcut Dimension 4 Code");*/
            VouchLine.Insert(true);
        end;
        /*
     //move approval entrie
      PostedApprovalEntry.SETRANGE("Document No.",Rec."Application No");
      PostedApprovalEntry.SETRANGE(Status,PostedApprovalEntry.Status::Approved);
      IF PostedApprovalEntry.FINDSET THEN BEGIN
       REPEAT
       AppEntry.INIT;
       AppEntry.TRANSFERFIELDS(PostedApprovalEntry);
       AppEntry."Document No.":=PayHead."No.";
       AppEntry."Document Type":=AppEntry."Document Type"::"24";
       AppEntry."Table ID":=39005589;
       AppEntry.INSERT;
       UNTIL PostedApprovalEntry.NEXT = 0;
      END; */
        Message('Payment Voucher created successfully');

        //NotifyApplicant;

    end;
}

