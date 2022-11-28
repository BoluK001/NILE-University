report 51534747 "Payroll Year Ending"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollYearEnding.rdlc';

    dataset
    {
        dataitem(PayrollYearEndingBuffer; PayrollYearEndingBuffer)
        {
            RequestFilterHeading = 'Payroll Year Ending';
            column(EmployeeCode_PayrollYearEndingBuffer; PayrollYearEndingBuffer."Employee Code")
            {
            }
            column(TransactionCode_PayrollYearEndingBuffer; PayrollYearEndingBuffer."Transaction Code")
            {
            }
            column(TransactionName_PayrollYearEndingBuffer; PayrollYearEndingBuffer."Transaction Name")
            {
            }
            column(Amount_PayrollYearEndingBuffer; PayrollYearEndingBuffer.Amount)
            {
            }
            column(PeriodYear_PayrollYearEndingBuffer; PayrollYearEndingBuffer."Period Year")
            {
            }
            column(FullName; hremp."Full Name")
            {
            }
            column(FirstName; hremp."First Name")
            {
            }
            column(MiddleName; hremp."Middle Name")
            {
            }
            column(LastName; hremp."Last Name")
            {
            }
            column(Email; hremp."Personal E-Mail")
            {
            }
            column(Designation; hremp.Designation)
            {
            }
            column(Phone; hremp."Cell Phone Number")
            {
            }
            column(USERID; UserId)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(TransactionType_PayrollYearEndingBuffer; PayrollYearEndingBuffer."Transaction Type")
            {
            }
            column(TaxID; hremp."Social Security No.")
            {
            }
            column(SalaryGrade; hremp."Salary Grade")
            {
            }

            trigger OnAfterGetRecord()
            begin
                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then
                    //EmployeeName:=objEmp."First Name"+' '+objEmp."Middle Name"+' '+objEmp."Last Name";
                    BranchName := objEmp."Global Dimension 2 Code";

                //if hremp.Get(PayrollYearEndingBuffer."Employee Code") then
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Enter Payroll Year"; selectPeriod)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if selectPeriod = 0 then
            Error('Please specify payroll year');

        PopulateBuffer;
    end;

    var
        prTrans: Record "prPeriod Transactions";
        i: Integer;
        PayrollBuffer: Record PayrollYearEndingBuffer;
        PayBuffer: Record PayrollYearEndingBuffer;
        selectPeriod: Integer;
        G: Integer;
        PayPeriod: Date;
        hremp: Record "HR Employees";
        BranchName: Code[20];
        objEmp: Record "HR Employees";
        PayBuf: Record PayrollYearEndingBuffer;
        Emp: Record "HR Employees";
        TotInc: Decimal;
        TotDed: Decimal;
        GBuf: Record PayrollYearEndingBuffer;

    local procedure PopulateBuffer()
    var
        prtran: Record "prPeriod Transactions";
    begin
        if PayrollBuffer.FindFirst then
            PayrollBuffer.DeleteAll;

        G := 0;



        for G := 1 to 12 do begin
            PayPeriod := DMY2Date(1, G, selectPeriod);

            if G = 1 then begin
                prtran.Reset;
                prtran.SetRange(prtran."Payroll Period", PayPeriod);
                //prtran.SETFILTER(prtran."Post As",'<>%1',0);
                //prtran.SETRANGE(prtran."Employee Code",'LP/05/0002');
                if prtran.FindFirst then begin
                    repeat
                        if (prtran."Transaction Code" = 'GPAY') or (prtran."Post As" <> 0) then begin
                            PayrollBuffer.Init;
                            PayrollBuffer."Employee Code" := prtran."Employee Code";
                            PayrollBuffer."Transaction Code" := prtran."Transaction Code";
                            PayrollBuffer."Period Year" := selectPeriod;
                            if prtran."Transaction Code" = 'NPAY' then
                                PayrollBuffer."Transaction Name" := 'Z' + prtran."Transaction Name"
                            else
                                PayrollBuffer."Transaction Name" := prtran."Transaction Name";

                            PayrollBuffer.Amount := prtran.Amount;
                            //prtran.CALCFIELDS("Transaction Type");
                            //PayrollBuffer."Transaction Type":=prtran."Transaction Type";
                            PayrollBuffer."Entry No." := 0;
                            PayrollBuffer.Insert;
                        end;
                    until prtran.Next = 0;
                end;
            end else
                if G > 1 then begin
                    prtran.Reset;
                    prtran.SetRange(prtran."Payroll Period", PayPeriod);
                    //prtran.SETFILTER(prtran."Post As",'<>%1',0);
                    //prtran.SETRANGE(prtran."Employee Code",'LP/05/0002');
                    if prtran.FindFirst then begin
                        repeat
                            PayrollBuffer.Reset;
                            PayrollBuffer.SetRange(PayrollBuffer."Transaction Code", prtran."Transaction Code");
                            PayrollBuffer.SetRange(PayrollBuffer."Employee Code", prtran."Employee Code");
                            if not PayrollBuffer.FindFirst then begin
                                if (prtran."Transaction Code" = 'GPAY') or (prtran."Post As" <> 0) then begin
                                    PayBuffer.Init;
                                    PayBuffer."Employee Code" := prtran."Employee Code";
                                    PayBuffer."Transaction Code" := prtran."Transaction Code";
                                    PayBuffer."Period Year" := selectPeriod;
                                    //PayBuffer."Transaction Name":=prtran."Transaction Name";
                                    if prtran."Transaction Code" = 'NPAY' then
                                        PayBuffer."Transaction Name" := 'Z' + prtran."Transaction Name"
                                    else
                                        PayBuffer."Transaction Name" := prtran."Transaction Name";
                                    PayBuffer."Entry No." := 0;
                                    //prtran.CALCFIELDS("Transaction Type");
                                    //PayrollBuffer."Transaction Type":=prtran."Transaction Type";

                                    PayBuffer.Amount := prtran.Amount;
                                    PayBuffer.Insert;
                                end;
                            end else begin  //ELSE IF PayrollBuffer.FINDFIRST
                                PayrollBuffer.Amount += prtran.Amount;
                                PayrollBuffer.Modify;
                                //IF (prtran."Transaction Code" = 'GPAY') then
                                //MESSAGE('%1...GPAY',PayrollBuffer.Amount);
                            end;
                        until prtran.Next = 0;
                    end;
                end;
        end;


        if Emp.FindFirst then begin
            repeat
                TotDed := 0;
                TotInc := 0;

                PayBuf.Reset;
                PayBuf.SetRange(PayBuf."Employee Code", Emp."No.");
                if PayBuf.FindFirst then begin
                    repeat
                        PayBuf.CalcFields("Transaction Type");
                        if (PayBuf."Transaction Type" = PayBuf."Transaction Type"::Income) and (PayBuf."Transaction Code" <> 'NPAY') and (PayBuf."Transaction Code" <> 'GPAY') then
                            TotInc += PayBuf.Amount
                        else
                            if (PayBuf."Transaction Type" = PayBuf."Transaction Type"::Deduction) and (PayBuf."Transaction Code" <> 'NPAY') and (PayBuf."Transaction Code" <> 'GPAY') then
                                TotDed += PayBuf.Amount
                   until PayBuf.Next = 0;
                    GBuf.Reset;
                    GBuf.SetRange(GBuf."Employee Code", PayBuf."Employee Code");
                    GBuf.SetRange(GBuf."Transaction Code", 'GPAY');
                    if GBuf.FindFirst then
                        GBuf.Amount := TotInc;//-TotDed;
                    GBuf.Modify;
                    GBuf.Reset;
                    GBuf.SetRange(GBuf."Employee Code", PayBuf."Employee Code");
                    GBuf.SetRange(GBuf."Transaction Code", 'NPAY');
                    if GBuf.FindFirst then
                        GBuf.Amount := TotInc - TotDed;
                    GBuf.Modify;

                end;
            until Emp.Next = 0;
        end;
    end;
}

