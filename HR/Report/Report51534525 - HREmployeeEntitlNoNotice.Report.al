report 51534525 "HR Employee Entitl No Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeEntitlNoNotice.rdlc';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            column(EmployeeNo_HREmployeeExitInterviews; "Employee No.")
            {
            }
            column(NoticePeriod_HREmployeeExitInterviews; "Notice Period")
            {
            }
            column(DateOfLeaving_HREmployeeExitInterviews; Format("Date Of Leaving", 0, 4))
            {
            }
            column(NoticePeriod; "Notice Period")
            {
            }
            column(NoticePeriodServed_HREmployeeExitInterviews; "Notice Period Served")
            {
            }
            column(AnnualLeaveOwed_HREmployeeExitInterviews; "Annual Leave Owed")
            {
            }
            column(Duration_HREmployeeExitInterviews; Duration)
            {
            }
            column(EmployeeName_HREmployeeExitInterviews; "Employee Name")
            {
            }
            column(DateOfJoin; Format(DateofJoin, 0, 4))
            {
            }
            column(SuperviserName; Supervisor)
            {
            }
            column(JobLevel; JobLevel)
            {
            }
            column(Department; Dept)
            {
            }
            column(EmploYERdays; EmployerDays)
            {
            }
            column(EmploYEEDays; EmployeeDays)
            {
            }
            column(BEmployeeDays; BEmployeeDays)
            {
            }
            column(BEmployerDays; BEmployerDays)
            {
            }
            column(MonthlyTakeHome; netPay)
            {
            }
            column(UserName; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(LeaveRepayment; LeaveRepay)
            {
            }
            column(LeaveIndebt; LeaveIndebt)
            {
            }
            column(LeaveDaysRepay; LeaveInd)
            {
            }
            column(PassageIndebt; Passage)
            {
            }
            column(PassageEnt; PassageEnt)
            {
            }
            column(Paye; PAYE)
            {
            }
            column(Nhf; NHF)
            {
            }
            dataitem(EmployeeAllowan; "prEmployee Transactions")
            {
                CalcFields = "Transaction Category";
                DataItemLink = "Employee Code" = FIELD("Employee No.");
                DataItemTableView = WHERE("Transaction Category" = CONST(Income), Annual = CONST(false));
                column(EmployeeCode_EmployeeAllowan; EmployeeAllowan."Employee Code")
                {
                }
                column(EmployeeAmount; EmployeeAllw)
                {
                }
                column(EmployerAmount; EmployerAllw)
                {
                }
                column(TransactionCode_EmployeeAllowan; EmployeeAllowan."Transaction Code")
                {
                }
                column(TransactionName_EmployeeAllowan; EmployeeAllowan."Transaction Name")
                {
                }
                column(BasicPay; BayPay)
                {
                }
                column(BasicPayEmployee; BPayee)
                {
                }
                column(BasicPayEmployer; Bpayer)
                {
                }
                column(ByeeDaysText; BYeeDaysText)
                {
                }
                column(ByerDaysText; ByerDaysText)
                {
                }
                column(IncYerDaysText; IncYerDaysText)
                {
                }
                column(IncYeeDaysText; IncDaysText)
                {
                }
                column(Aamount; Aamount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EmployeeAllw := 0;
                    EmployerAllw := 0;
                    Aamount := 0;
                    if TransCode.Get(EmployeeAllowan."Transaction Code") then begin
                        EmployeeAllw := (Amount / NoOfMonthDays) * EmployeeDays;
                        EmployerAllw := (Amount / NoOfMonthDays) * EmployerDays;
                        IncYerDaysText := Format(EmployerDays) + ' ' + 'Days';
                        IncDaysText := Format(EmployeeDays) + ' ' + 'Days';
                        Aamount := EmployeeAllowan.Amount;
                        //IF TransCode."Transaction Code" = 'PENS-INC' THEN
                        //EmployeeAllw:=0;

                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(EmployeeAllowan."Payroll Period", PrevMonth);
                end;
            }
            dataitem(AnnualPay; "prEmployee Transactions")
            {
                CalcFields = Annual;
                DataItemLink = "Employee Code" = FIELD("Employee No.");
                DataItemTableView = WHERE(Annual = FILTER(true));
                column(EmployeeCode_AnnualPay; AnnualPay."Employee Code")
                {
                }
                column(TransactionCode_AnnualPay; AnnualPay."Transaction Code")
                {
                }
                column(TransactionName_AnnualPay; AnnualPay."Transaction Name")
                {
                }
                column(AnnualAmount; AnnualAmount)
                {
                }
                column(YeeDaysText; YeeDaysText)
                {
                }
                column(yerDaysText; yerDaysText)
                {
                }
                column(Amount_AnnualPay; AnnualPay.Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AnnualAmount := 0;
                    if TransCode.Get(AnnualPay."Transaction Code") then begin
                        AnnualAmount := FnCheckSalGrade(AnnualPay."Employee Code", curPeriod, TransCode.Formula, TransCode."Transaction Code", "HR Employee Exit Interviews"."Date Of Leaving");
                        EmployerDays := MonthsSpent;
                        EmployerAllw := AnnualAmount;
                        yerDaysText := Format(EmployerDays) + ' ' + 'Months';
                        YeeDaysText := '';
                    end;


                    if TransCode.Get(AnnualPay."Transaction Code") then begin
                        if (TransCode."Leave Allowance") or (TransCode.Passage) then begin
                            if ("HR Employee Exit Interviews"."Leave Allowance Paid") then
                                AnnualAmount := 0;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(AnnualPay."Period Year", Date2DMY(PrevMonth, 3));
                end;
            }
            dataitem(EmployeeDeductions; "prEmployee Transactions")
            {
                CalcFields = "Transaction Category";
                DataItemLink = "Employee Code" = FIELD("Employee No.");
                DataItemTableView = WHERE("Transaction Category" = FILTER(Deduction));
                column(TransactionCode_EmployeeDeductions; EmployeeDeductions."Transaction Code")
                {
                }
                column(EmployeeCode_EmployeeDeductions; EmployeeDeductions."Employee Code")
                {
                }
                column(Amount_EmployeeDeductions; EmployeeDeductions.Amount)
                {
                }
                column(EmpDeduction; EmployerDed)
                {
                }
                column(yerDaysDedText; yerDaysDedText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EmployerDed := (EmployeeDeductions.Amount / NoOfMonthDays) * EmployerDedDay;
                    yerDaysDedText := Format(EmployerDedDay) + ' ' + 'Days';
                end;

                trigger OnPreDataItem()
                begin
                    SetRange(EmployeeDeductions."Payroll Period", PrevMonth);
                    EmployerDedDay := DedDays;
                    EmployerDed := 0;
                end;
            }
            dataitem("HR Employee Exit Deductions"; "HR Employee Exit Deductions")
            {
                DataItemLink = "Employee Code" = FIELD("Employee No.");
                column(EmployeeCode_HREmployeeExitDeductions; "HR Employee Exit Deductions"."Employee Code")
                {
                }
                column(Description_HREmployeeExitDeductions; "HR Employee Exit Deductions".Description)
                {
                }
                column(Amount_HREmployeeExitDeductions; "HR Employee Exit Deductions".Amount)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if Employee.Get("HR Employee Exit Interviews"."Employee No.") then begin
                    DateofJoin := Employee."Date Of Joining the Company";
                    Supervisor := Employee."Supervisor/Manager";
                    JobLevel := Employee."Job Level";
                    Dept := Employee."Department Code";
                end;
                TodayDate := "HR Employee Exit Interviews"."Date Of Leaving";
                RemainingDays := CalcDate('-1D', CalcDate('1M', DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3)))) -
                            DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3));

                TDate := DMY2Date(1, Date2DMY("HR Employee Exit Interviews"."Date Of Leaving", 2), Date2DMY("HR Employee Exit Interviews"."Date Of Leaving", 3));

                repeat
                    i := i + 1;
                    if (Date2DWY(TDate, 1) <> 6) and (Date2DWY(TDate, 1) <> 7) then   //exclude weekend
                        NoOfMonthDays := NoOfMonthDays + 1;

                    TDate := CalcDate('1D', TDate);
                until i = RemainingDays + 1;



                NoticePeriod := NoOfMonthDays;  //"HR Employee Exit Interviews"."Notice Period";
                NoticePeriodServed := 0; //"HR Employee Exit Interviews"."Notice Period Served";
                                         //EmployeeDays:=NoticePeriod-NoticePeriodServed;
                                         //EmployerDays:=22-EmployeeDays;



                EmployeeDays := NoticePeriod - "HR Employee Exit Interviews"."No. of Days Worked";
                if NoticePeriod > NoticePeriodServed then begin
                    EmployerDays := "HR Employee Exit Interviews"."No. of Days Worked";
                    EmployeeDays := NoticePeriod - "HR Employee Exit Interviews"."No. of Days Worked";
                    DedDays := EmployeeDays;
                end;
                /* ELSE IF  NoticePeriod = NoticePeriodServed THEN BEGIN
                EmployerDays:="HR Employee Exit Interviews"."No. of Days Worked";//NoticePeriodServed - NoticePeriod;
                DedDays:=EmployerDays;
                EmployeeDays:=0;
                END;
                 */
                EmployerDedDay := EmployerDays;
                MonthsSpent := "HR Employee Exit Interviews"."Months Spent";

                PrevMonth := DMY2Date(1, MonthsSpent, Date2DMY("Date Of Leaving", 3));
                curPeriod := DMY2Date(1, Date2DMY("Date Of Leaving", 2), Date2DMY("Date Of Leaving", 3));

                /*prPeriodTrans.SETCURRENTKEY("Employee Code","Transaction Code","Payroll Period");
                prPeriodTrans.SETRANGE(prPeriodTrans."Employee Code","HR Employee Exit Interviews"."Employee No.");
                prPeriodTrans.SETRANGE(prPeriodTrans."Payroll Period",CALCDATE('-1M',curPeriod));
                prPeriodTrans.SETRANGE(prPeriodTrans."Transaction Code",'NPAY');
                IF prPeriodTrans.FINDFIRST THEN
                */
                netPay := "HR Employee Exit Interviews"."Monthly Take Home";



                if ("HR Employee Exit Interviews"."Leave Allowance Paid") and ("HR Employee Exit Interviews"."Annual Leave Owed" = 0) then begin
                    LeaveRate := 22 / 12;
                    LeaveIndebt := ("HR Employee Exit Interviews"."Leave Allowance" / 22) * ((12 - MonthsSpent) * LeaveRate);
                    LeaveInd := (netPay / 22) * "HR Employee Exit Interviews"."No. of Leave Days to Deduct";
                    LeaveIndebt += LeaveInd;
                    prPeriodTrans.Reset;
                    prPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                    prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "HR Employee Exit Interviews"."Employee No.");
                    prPeriodTrans.SetRange(prPeriodTrans."Period Year", Date2DMY(PrevMonth, 3));
                    prPeriodTrans.SetFilter(prPeriodTrans."Transaction Code", '%1|%2', 'PSG', 'PSG2');
                    if prPeriodTrans.FindFirst then
                        Passage := prPeriodTrans.Amount;

                    Passage := (Passage / 22) * ((12 - MonthsSpent) * LeaveRate);


                end;

                if ("HR Employee Exit Interviews"."Leave Allowance Paid" = true) and ("HR Employee Exit Interviews"."Annual Leave Owed" > 0) then begin

                    LeaveRate := 22 / 12;
                    LeaveIndebt := ("HR Employee Exit Interviews"."Leave Allowance" / 22) * ((12 - MonthsSpent) * LeaveRate);
                    prPeriodTrans.Reset;
                    prPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                    prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "HR Employee Exit Interviews"."Employee No.");
                    prPeriodTrans.SetRange(prPeriodTrans."Period Year", Date2DMY(PrevMonth, 3));
                    prPeriodTrans.SetFilter(prPeriodTrans."Transaction Code", '%1|%2', 'PSG', 'PSG2');
                    if prPeriodTrans.FindFirst then
                        Passage := prPeriodTrans.Amount;

                    //Message('%1..',Passage);
                    Passage := (Passage / 22) * ((12 - MonthsSpent) * LeaveRate);

                    //PassageEnt:=(netPay/22)*"HR Employee Exit Interviews"."Annual Leave Owed";

                    LeaveRepay := (netPay / 22) * "HR Employee Exit Interviews"."Annual Leave Owed";
                end;

                if ("HR Employee Exit Interviews"."Leave Allowance Paid" = false) and ("HR Employee Exit Interviews"."Annual Leave Owed" > 0) then begin
                    LeaveRate := 22 / 12;
                    /*//LeaveIndebt:=("HR Employee Exit Interviews"."Leave Allowance"/22) * ((12-MonthsSpent) * LeaveRate);
                      prPeriodTrans.RESET;
                      prPeriodTrans.SETCURRENTKEY("Employee Code","Transaction Code","Payroll Period");
                      prPeriodTrans.SETRANGE(prPeriodTrans."Employee Code","HR Employee Exit Interviews"."Employee No.");
                      prPeriodTrans.SETRANGE(prPeriodTrans."Period Year",DATE2DMY(PrevMonth,3));
                      prPeriodTrans.SETFILTER(prPeriodTrans."Transaction Code",'%1|%2','PSG','PSG2');
                      IF prPeriodTrans.FINDFIRST THEN
                          Passage:=prPeriodTrans.Amount;

                     Passage:=(Passage/22) * ((12-MonthsSpent) * LeaveRate);
                     */
                    //Message('%1..net',NetPay);
                    LeaveRepay := (netPay / 22) * "HR Employee Exit Interviews"."Annual Leave Owed";
                end;


                //Message('%1..aa',EmployeeDays);
                //LeaveRepay:=(netPay/22)*"HR Employee Exit Interviews"."Annual Leave Owed";  96,852.32
                BEmployeeDays := EmployeeDays;
                BEmployerDays := EmployerDays;


                prPeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "HR Employee Exit Interviews"."Employee No.");
                prPeriodTrans.SetRange(prPeriodTrans."Payroll Period", PrevMonth);
                prPeriodTrans.SetRange(prPeriodTrans."Transaction Code", 'BPAY');
                if prPeriodTrans.FindFirst then begin
                    BayPay := prPeriodTrans.Amount;
                    BPayee := (BayPay / NoOfMonthDays) * BEmployeeDays;
                    Bpayer := (BayPay / NoOfMonthDays) * BEmployerDays;
                    ByerDaysText := Format(BEmployerDays) + ' ' + 'Days';
                    BYeeDaysText := Format(BEmployeeDays) + ' ' + 'Days';
                end;



                if "HR Employee Exit Interviews"."Pay NHF/PAYE" then begin
                    //IF EmployerDedDay >= 15 THEN BEGIN
                    PeriodTrans.Reset;
                    PeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                    PeriodTrans.SetRange("Transaction Code", 'PAYE');
                    PeriodTrans.SetRange("Employee Code", "HR Employee Exit Interviews"."Employee No.");
                    PeriodTrans.SetRange("Payroll Period", PrevMonth);
                    if PeriodTrans.FindFirst then begin
                        PAYE := (PeriodTrans.Amount / NoOfMonthDays) * (NoticePeriod - "HR Employee Exit Interviews"."No. of Days Worked");
                    end;

                    PeriodTrans.Reset;
                    PeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                    PeriodTrans.SetRange("Transaction Code", 'NHF');
                    PeriodTrans.SetRange("Employee Code", "HR Employee Exit Interviews"."Employee No.");
                    PeriodTrans.SetRange("Payroll Period", PrevMonth);
                    if PeriodTrans.FindFirst then begin
                        NHF := (PeriodTrans.Amount / NoOfMonthDays) * (NoticePeriod - "HR Employee Exit Interviews"."No. of Days Worked");
                    end;

                    //END;
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        Employee: Record "HR Employees";
        LeaveInd: Decimal;
        EmpTrans: Record "prEmployee Transactions";
        PeriodTrans: Record "prPeriod Transactions";
        DateofJoin: Date;
        Supervisor: Code[100];
        JobLevel: Code[20];
        Dept: Code[30];
        EmployerAmount: Decimal;
        EmployeeAmount: Decimal;
        i: Integer;
        Trans: array[30] of Code[20];
        NoticePeriod: Integer;
        NoticePeriodServed: Integer;
        EmployerDays: Integer;
        EmployeeDays: Integer;
        TransCode: Record "prTransaction Codes";
        EmployeeAllw: Decimal;
        EmployerAllw: Decimal;
        EmployerDed: Decimal;
        MonthsSpent: Integer;
        EmployerDedDay: Integer;
        yerDaysText: Text[30];
        YeeDaysText: Text[30];
        yerDaysDedText: Text[30];
        CompInfo: Record "Company Information";
        prPeriodTrans: Record "prPeriod Transactions";
        netPay: Decimal;
        PrevMonth: Date;
        LeaveRepay: Decimal;
        BayPay: Decimal;
        BPayee: Decimal;
        Bpayer: Decimal;
        ToWords: Codeunit Library;
        AnnualAmount: Decimal;
        ByerDaysText: Text[30];
        BYeeDaysText: Text[30];
        BEmployerDays: Integer;
        BEmployeeDays: Integer;
        HRLeaveApplication: Record "HR Leave Application";
        LeaveRate: Decimal;
        LeaveIndebt: Decimal;
        Aamount: Decimal;
        IncDaysText: Text[30];
        IncYerDaysText: Text[30];
        checkk: Text;
        objPeriod: Record "prPayroll Periods";
        NoOfMonthDays: Integer;
        DedDays: Integer;
        PAYE: Decimal;
        NHF: Decimal;
        Passage: Decimal;
        PassageEnt: Decimal;
        RemainingDays: Integer;
        TDate: Date;
        TodayDate: Date;
        curPeriod: Date;

    [Scope('OnPrem')]
    procedure FnCheckSalGrade(EmpCode: Code[30]; SelectedPeriod: Date; pFormlua: Code[30]; TransCode: Code[20]; ExitDate: Date): Decimal
    var
        PeriodTrans: Record "prPeriod Transactions";
        HREmp: Record "HR-Employee";
        SalaryGrade: Code[20];
        Yearly: Integer;
        StartPeriod: Date;
        PTrans: Record "prPeriod Transactions";
        cntMnths: Integer;
        intMonth: Integer;
        intYear: Integer;
        strExtractedFrml: Text[250];
        oldTransAmt: Decimal;
        curTransAmount: Decimal;
        TransSetup: Record "prTransaction Codes";
        NewAmount: Decimal;
        strExtractedFrml2: Text[250];
        intMonthold: Integer;
        intYearold: Integer;
        SalaryNotch: Code[20];
        OldMnths: Integer;
        MonthBegin: Integer;
        ExitMonth: Integer;
    begin
        cntMnths := 0;
        intMonth := 0;
        intYear := 0;
        intMonthold := 0;
        intYearold := 0;

        if HREmp.Get(EmpCode) then begin
            SalaryGrade := HREmp."Salary Grade";
            SalaryNotch := HREmp."Salary Notch/Step";
        end;
        Yearly := Date2DMY(SelectedPeriod, 3);
        StartPeriod := DMY2Date(1, 1, Yearly);

        intMonth := Date2DMY(SelectedPeriod, 2);
        intYear := Date2DMY(SelectedPeriod, 3);

        PeriodTrans.Reset;
        PeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
        PeriodTrans.SetRange("Transaction Code", 'NPAY');
        PeriodTrans.SetRange("Employee Code", EmpCode);
        PeriodTrans.SetFilter("Payroll Period", '%1..%2', StartPeriod, SelectedPeriod);
        PeriodTrans.SetFilter("Salary Grade", '<>%1', SalaryGrade);
        if PeriodTrans.FindLast then begin
            PTrans.Reset;
            PTrans.SetRange("Employee Code", EmpCode);
            PTrans.SetRange("Salary Grade", PeriodTrans."Salary Grade");
            PTrans.SetFilter("Payroll Period", '%1..%2', StartPeriod, SelectedPeriod);
            if PTrans.FindFirst then begin
                intMonthold := Date2DMY(PTrans."Payroll Period", 2);
                intYearold := Date2DMY(PTrans."Payroll Period", 3);

            end;

            OldMnths := PeriodTrans.Count;
            ExitMonth := Date2DMY(ExitDate, 2);
            cntMnths := ExitMonth - OldMnths;
            //Message('%1..2',OldMnths);

            if TransSetup.Get(TransCode) then;

            strExtractedFrml := fnPureFormula(EmpCode, intMonthold, intYearold, TransSetup.Formula);
            //Message('%1..%2',strExtractedFrml,TransSetup.Formula);

            oldTransAmt := Round(fnFormulaResult(strExtractedFrml));
            //Message('%1...Amount',oldTransAmt );

            strExtractedFrml2 := fnPureFormula(EmpCode, intMonth, intYear, pFormlua);
            curTransAmount := Round(fnFormulaResult(strExtractedFrml2));

            oldTransAmt := (oldTransAmt / 12) * OldMnths;
            curTransAmount := (curTransAmount / 12) * cntMnths;

            //MESSAGE('%1..New..%2..oldTran........%3',curTransAmount,oldTransAmt,TransSetup."Transaction Code");
            NewAmount := oldTransAmt + curTransAmount;

            exit(NewAmount);

        end else begin
            PeriodTrans.Reset;
            PeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
            PeriodTrans.SetRange("Employee Code", EmpCode);
            PeriodTrans.SetRange("Transaction Code", 'NPAY');
            PeriodTrans.SetFilter("Payroll Period", '%1..%2', StartPeriod, SelectedPeriod);
            PeriodTrans.SetFilter("Salary Notch", '<>%1', SalaryNotch);
            if PeriodTrans.FindLast then begin
                PTrans.Reset;
                PTrans.SetRange("Employee Code", EmpCode);
                PTrans.SetRange("Salary Notch", PeriodTrans."Salary Notch");
                PTrans.SetFilter("Payroll Period", '%1..%2', StartPeriod, SelectedPeriod);
                if PTrans.FindFirst then begin
                    intMonthold := Date2DMY(PTrans."Payroll Period", 2);
                    intYearold := Date2DMY(PTrans."Payroll Period", 3);
                end;

                OldMnths := PeriodTrans.Count;
                ExitMonth := Date2DMY(ExitDate, 2);
                cntMnths := ExitMonth - OldMnths;

                if TransSetup.Get(TransCode) then;

                strExtractedFrml := fnPureFormula(EmpCode, intMonthold, intYearold, TransSetup.Formula);
                oldTransAmt := Round(fnFormulaResult(strExtractedFrml));

                strExtractedFrml2 := fnPureFormula(EmpCode, intMonth, intYear, pFormlua);
                curTransAmount := Round(fnFormulaResult(strExtractedFrml2));

                oldTransAmt := (oldTransAmt / 12) * OldMnths;
                curTransAmount := (curTransAmount / 12) * cntMnths;

                NewAmount := oldTransAmt + curTransAmount;
                exit(NewAmount);
            end else begin
                if TransSetup.Get(TransCode) then;
                PeriodTrans.Reset;
                PeriodTrans.SetCurrentKey("Employee Code", "Transaction Code", "Payroll Period");
                PeriodTrans.SetRange("Transaction Code", TransCode);
                PeriodTrans.SetRange("Employee Code", EmpCode);
                PeriodTrans.SetFilter("Payroll Period", '%1..%2', StartPeriod, SelectedPeriod);
                if PeriodTrans.FindLast then begin
                    if TransSetup."Is Formula" then begin
                        strExtractedFrml := fnPureFormula(EmpCode, intMonth, intYear, pFormlua);
                        curTransAmount := Round(fnFormulaResult(strExtractedFrml));
                        // curTransAmount:=(curTransAmount* (365-(PeriodTrans."Period Month"-1)*30))/365;
                        curTransAmount := (curTransAmount / 12) * MonthsSpent;
                    end else begin
                        curTransAmount := (PeriodTrans.Amount / 12) * MonthsSpent;
                    end;
                    /*
                    IF ("HR Employee Exit Interviews"."Leave Allowance Paid") AND ("HR Employee Exit Interviews"."Annual Leave Owed" = 0 )THEN BEGIN
                      LeaveRate:=22/12;
                      LeaveIndebt:=("HR Employee Exit Interviews"."Leave Allowance"/22) * ((12-MonthsSpent) * LeaveRate);
                      curTransAmount:=0;
                    END;
                    */
                    exit(curTransAmount);
                end;
            end;
        end;

    end;

    [Scope('OnPrem')]
    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);
            if Char = '[' then StartCopy := true;

            if StartCopy then TransCode := TransCode + Char;
            //Copy Characters as long as is not within []
            if not StartCopy then
                FinalFormula := FinalFormula + Char;
            if Char = ']' then begin
                StartCopy := false;
                //Get Transcode
                Where := '=';
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //Get TransCodeAmount
                TransCodeAmount := fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);
                //Reset Transcode
                TransCode := '';
                //Get Final Formula
                FinalFormula := FinalFormula + Format(TransCodeAmount);
                //End Get Transcode
            end;
        end;
        Formula := FinalFormula;
    end;

    [Scope('OnPrem')]
    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        // AccSchedMgt: Codeunit AccSchedManagement;
        AccSchedMgt: Codeunit AccSchedManagementPayroll;
    begin
        Results :=
         AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;

    [Scope('OnPrem')]
    procedure fnGetTransAmount(strEmpCode: Code[20]; strTransCode: Code[20]; intMonth: Integer; intYear: Integer) TransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
    begin
        if CopyStr(strTransCode, 1, 1) = '#' then begin  //PKK
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", DelChr(strTransCode, '=', '#'));
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
            if prEmployeeTransactions.FindFirst then begin
                TransAmount := prEmployeeTransactions."No of Units";
                //PKKIF prEmployeeTransactions."No of Units"<>0 THEN
                //PKK   TransAmount:=prEmployeeTransactions."No of Units";
            end;

        end else begin

            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", strTransCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
            if prEmployeeTransactions.FindFirst then begin
                TransAmount := prEmployeeTransactions.Amount;
                //PKKIF prEmployeeTransactions."No of Units"<>0 THEN
                //PKK   TransAmount:=prEmployeeTransactions."No of Units";
            end;
            /*
            IF TransAmount=0 THEN BEGIN
            prEmployeeTransactions.RESET;
            prEmployeeTransactions.SETCURRENTKEY("Employee Code","Transaction Code","Period Month","Period Year",Suspended);
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Employee Code",strEmpCode);
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code",strTransCode);
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
            prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
            IF prEmployeeTransactions.FINDFIRST THEN
              TransAmount:=prEmployeeTransactions.Amount;
            END;
            */

            if TransAmount = 0 then begin
                prPeriodTransactions.Reset;
                prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", strEmpCode);
                prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", strTransCode);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                if prPeriodTransactions.FindFirst then
                    TransAmount := prPeriodTransactions.Amount;
            end;

        end;

    end;
}

