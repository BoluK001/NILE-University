codeunit 51534531 prPayrollProcessing
{
    // ++Note
    // Tax on Excess Pension Not Clear /Not indicated anywhere
    // Low Interest Benefits
    // VOQ


    trigger OnRun()
    begin
    end;

    var
        Text020: Label 'Because of circular references, the program cannot calculate a formula.';
        Text012: Label 'You have entered an illegal value or a nonexistent row number.';
        Text013: Label 'You have entered an illegal value or a nonexistent column number.';
        Text017: Label 'The error occurred when the program tried to calculate:\';
        Text018: Label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: Label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: Label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        VitalSetup: Record "prVital Setup Info";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curReliefChild: Decimal;
        curReliefDependant: Decimal;
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curNHFPerc: Decimal;
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "prEmployee Posting Group";
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "HR-Employee";
        CoopParameters: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF;
        PayrollType: Code[20];
        curReliefGrossPerc: Decimal;
        MonthlyReliefAmount: Decimal;
        EmployerAmount: Decimal;
        EmployerBalance: Decimal;
        VitalSetupS: Record "HR-Employee";
        TotalTaxable: Decimal;
        Trans: Record "prTransaction Codes";
        Employee: Record "HR-Employee";
        EmpTrans: Record "prEmployee Transactions";
        curTaxDeductions: Decimal;
        RemainingDays: Integer;
        TDate: Date;
        i: Integer;
        ArrearsDays: Integer;
        MonthDays: Integer;
        PayTillCutOff: Boolean;
        NoOfUnits: Decimal;
        ProrateAbsence: Boolean;
        SalCard: Record "prSalary Card";
        DayAbsent: Decimal;
        currAnnualPay: Decimal;
        statTaxPay: Decimal;
        DontProrateBPAY: Boolean;
        ExcludeNonTaxRelief: Boolean;
        ProrateAbsBP: Boolean;
        ProrateAbsMonthDays: Boolean;
        NonTaxable: Decimal;
        curPassage: Decimal;
        PeriodTrans: Record "prPeriod Transactions";
        PayeTillDate: Decimal;
        objPeriod: Record "prPayroll Periods";
        FixedTaxable: Decimal;
        EmpTra: Record "prEmployee Transactions";
        TraCode: Record "prTransaction Codes";
        SusPensAccount: Code[20];
        TotDed: Decimal;
        EERelief: Decimal;
        ERRelief: Decimal;
        PenAmt_G: Decimal;
        NHFAmt_G: Decimal;
        AvcAmt_G: Decimal;
        PercentGross_Pen_NHF_AVC: Decimal;
        VitalSetupRec: Record "prVital Setup Info";
        TaxRelief_Value: Decimal;
        T2hOr1PercentGP: Decimal;
        T2hOr1PercentGP_Permonth: Decimal;
        AvcAmt: Decimal;
        GrossExArr: Decimal;
        Ann_Leave: Decimal;
        LeavePerMonth: Decimal;
        curTaxablePay2: Decimal;

    [Scope('OnPrem')]
    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        with VitalSetup do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := "Mortgage Relief"; //Same as HOSP
            curMaximumRelief := "Max Relief";
            curReliefChild := "Child Relief";
            curReliefDependant := "Dependants Relief";
            curNssfEmployee := "NSSF Employee";
            curNssf_Employer_Factor := "NSSF Employer Factor";
            intNHIF_BasedOn := "NHIF Based on";
            curNHFPerc := "NHF - % of Basic Pay";
            curMaxPensionContrib := "Max Pension Contribution";
            curRateTaxExPension := "Tax On Excess Pension";
            curOOIMaxMonthlyContrb := "OOI Deduction";
            curOOIDecemberDedc := "OOI December";
            curLoanMarketRate := "Loan Market Rate";
            curLoanCorpRate := "Loan Corporate Rate";
            curReliefGrossPerc := VitalSetup."Tax Relief % of Gross Income";
            ProrateAbsence := VitalSetup."Prorate Absence";
            DontProrateBPAY := VitalSetup."Don't Prorate Basic Pay";
            DontProrateBPAY := VitalSetup."Don't Prorate Basic Pay";
            ProrateAbsBP := VitalSetup."Prorate Absence Basic Pay";
            ProrateAbsMonthDays := VitalSetup."Prol. Absence on days in month";
            ExcludeNonTaxRelief := VitalSetup."Exclude NonTax from Relief";
        end;
    end;

    [Scope('OnPrem')]
    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20])
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "prTransaction Codes";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "prUnused Relief";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "prEmployer Deductions";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        Text021: Label 'This application is not licensed on this server. Contact your systems administrator.';
        prVital: Record "prVital Setup Info";
        prSalaryCard: Record "prSalary Card";
    begin
        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);

        //Cyrus Added
        NonTaxable := 0;

        SalCard.Reset;
        SalCard.SetFilter(SalCard."Employee Code", strEmpCode);
        if SalCard.Find('-') then begin
            NonTaxable := SalCard."Non Taxable";
        end;
        //Cyrus Added

        //PKK
        DayAbsent := 0;

        if ProrateAbsence = true then begin
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetFilter(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", 'ABS');
            prEmployeeTransactions.SetFilter(prEmployeeTransactions."Payroll Period", '%1', SelectedPeriod);
            //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
            //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
            prEmployeeTransactions.SetFilter(prEmployeeTransactions.Suspended, '%1', false);
            if prEmployeeTransactions.Find('-') then begin
                DayAbsent := prEmployeeTransactions."No of Units";

            end;
        end;
        //PKK
        //PayrollType
        PayrollType := PayrollCode;
        /*
       DaysWorked:=fnDaysWorked(dtDOE,FALSE);
       DaysWorked+=DaysWorked+4;
       MESSAGE('%1..OK',DaysWorked);
        */
        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2DMY(SelectedPeriod, 2);
        intYear := Date2DMY(SelectedPeriod, 3);

        if curBasicPay > 0 then begin
            //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
            if (Date2DMY(dtDOE, 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(dtDOE, 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                //CountDaysofMonth:=fnDaysInMonth(dtDOE);
                objPeriod.Reset;
                objPeriod.SetCurrentKey(objPeriod."Date Opened");
                objPeriod.SetFilter(objPeriod.Closed, '%1', false);
                if objPeriod.FindLast then begin
                    CountDaysofMonth := objPeriod."Total Working Days";
                end;

                //MESSAGE('%1',CountDaysofMonth);
                DaysWorked := fnDaysWorked(dtDOE, false);
                //DaysWorked+=DaysWorked+4;
                // MESSAGE('%1..OK',DaysWorked);


                //PKK
                i := 0;
                RemainingDays := 0;
                ArrearsDays := 0;
                //PKK

                //IF DontProrateBPAY = FALSE THEN //PKK
                //curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,DaysWorked,CountDaysofMonth);
            end;

            //PKK Prorate Absence
            if (ProrateAbsence = true) and (ProrateAbsBP = true) then begin
                if (DayAbsent > 0) and (curBasicPay > 0) then begin
                    CountDaysofMonth := fnDaysInMonth(SelectedPeriod);
                    DaysWorked := fnDaysWorked(SelectedPeriod, false);

                    prVital.Get();

                    if ProrateAbsMonthDays = true then
                        curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, CountDaysofMonth - DayAbsent, CountDaysofMonth)
                    else
                        curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, prVital."Working Days" - DayAbsent, prVital."Working Days");   //22

                end;
            end;
            //PKK Prorate Absence


            //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
            if dtTermination <> 0D then begin
                if (Date2DMY(dtTermination, 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(dtTermination, 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                    CountDaysofMonth := fnDaysInMonth(dtTermination);
                    DaysWorked := fnDaysWorked(dtTermination, true);
                    curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                end;
            end;

            curTransAmount := curBasicPay;
            strTransDescription := 'Basic Pay';
            TGroup := 'BASIC SALARY';
            TGroupOrder := 1;
            TSubGroupOrder := 1;
            NoOfUnits := 0;
            fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
            TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
            salariesAcc, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

            //Salary Arrears
            prSalaryArrears.Reset;
            prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
            prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
            prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
            if prSalaryArrears.Find('-') then begin
                repeat
                    curSalaryArrears := prSalaryArrears."Salary Arrears";
                    curPayeArrears := prSalaryArrears."PAYE Arrears";

                    //Insert [Salary Arrears] into period trans [ARREARS]
                    curTransAmount := curSalaryArrears;
                    strTransDescription := 'Salary Arrears';
                    TGroup := 'ARREARS';
                    TGroupOrder := 1;
                    TSubGroupOrder := 2;
                    NoOfUnits := 0;
                    fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
                      JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

                    //Insert [PAYE Arrears] into period trans [PYAR]
                    curTransAmount := curPayeArrears;
                    strTransDescription := 'P.A.Y.E Arrears';
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 4;
                    NoOfUnits := 0;
                    fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                       TaxAccount, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none)

                until prSalaryArrears.Next = 0;
            end;

            //Get Earnings
            currAnnualPay := 0;
            curNonTaxable := 0; //RBS LATEEF 30082021
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
            if prEmployeeTransactions.Find('-') then begin
                curTotAllowances := 0;
                IsCashBenefit := 0;
                repeat
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                    prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                    if prTransactionCodes.Find('-') then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';
                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := Round(fnFormulaResult(strExtractedFrml)); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;
                        FixedTaxable += curTransAmount;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None then //[0=None, 1=Increasing, 2=Reducing]
                            curTransBalance := 0;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing then
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing then
                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;

                        //Prorate Allowances Here
                        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                        if (Date2DMY(dtDOE, 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(dtDOE, 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                            CountDaysofMonth := fnDaysInMonth(dtDOE);
                            DaysWorked := fnDaysWorked(dtDOE, false);
                            //curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                            //Leventis Doesnt Prorate Allowances //Cyrus
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;

                        //PKK Added
                        if prTransactionCodes."Excl. from Proration" = true then
                            curTransAmount := 0;
                        //PKK Added
                        //PKK Prorate absence
                        if ProrateAbsence = true then begin
                            if prTransactionCodes."Prorate Absence" = true then begin
                                if curTransAmount > 0 then begin
                                    if DayAbsent > 0 then begin
                                        CountDaysofMonth := fnDaysInMonth(SelectedPeriod);
                                        DaysWorked := fnDaysWorked(SelectedPeriod, false);


                                        if ProrateAbsMonthDays = true then
                                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, CountDaysofMonth - DayAbsent,
                                                              CountDaysofMonth)
                                        else
                                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, 21 - DayAbsent, 21);
                                    end;
                                end;
                            end;
                        end;

                        //PKK Prorate absence

                        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                        if dtTermination <> 0D then begin
                            if (Date2DMY(dtTermination, 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(dtTermination, 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtTermination);
                                DaysWorked := fnDaysWorked(dtTermination, true);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;
                        end;
                        // Prorate Allowances Here
                        //FixedTaxable+=curTransAmount;    //to calculate tax
                        //Add Non Taxable Here
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
                        prTransactionCodes."Special Transactions"::Ignore) then
                            curNonTaxable := curNonTaxable + curTransAmount;

                        //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                        prTransactionCodes."Special Transactions"::Ignore) then
                            curTransAmount := 0;
                        if prTransactionCodes."Leave Allowance" then
                            //urTransAmount:=CheckProrateLeave(strEmpCode,prTransactionCodes."Transaction Code",dtOpenPeriod);
                            Ann_Leave := curTransAmount;
                        //Annual Leaves
                        //PKK - Annual Trans
                        if prTransactionCodes."Annual Pay" = true then
                            currAnnualPay := currAnnualPay + curTransAmount;

                        curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                        curTransAmount := curTransAmount;
                        curTransBalance := curTransBalance;
                        strTransDescription := prTransactionCodes."Transaction Name";
                        TGroup := 'ALLOWANCE';
                        TGroupOrder := 3;
                        TSubGroupOrder := 0;

                        //Get the posting Details
                        JournalPostingType := JournalPostingType::" ";
                        JournalAcc := '';
                        if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                                Customer.SetRange(Customer."No.", HrEmployee."No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := JournalPostingType::Customer;
                                end;
                            end;
                        end else begin
                            JournalAcc := prTransactionCodes."GL Account";
                            JournalPostingType := JournalPostingType::"G/L Account";
                        end;

                        //Get is Cash Benefits
                        if prTransactionCodes."Is Cash" then
                            IsCashBenefit := IsCashBenefit + curTransAmount;
                        //End posting Details
                        NoOfUnits := prEmployeeTransactions."No of Units";
                        fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                        prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                        prTransactionCodes."coop parameters");

                    end;
                until prEmployeeTransactions.Next = 0;
            end;

            //IF SalCard.GET(strEmpCode) THEN
            //FixedTaxable:=FixedTaxable + SalCard."Basic Pay";

            //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
            // Message('%1',curNonTaxable);
            // curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears)-curNonTaxable;
            curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);//+curNonTaxable; //RBS
            GrossExArr := (curBasicPay + curTotAllowances + curSalaryArrears) - curNonTaxable;
            curTransAmount := curGrossPay;
            strTransDescription := 'Gross Pay';
            TGroup := 'GROSS PAY';
            TGroupOrder := 4;
            TSubGroupOrder := 0;
            fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
             intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::"G/L Account", '', CoopParameters::none);
            //  curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears); //RBS
            curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
            //George
            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
            if prEmployeeTransactions.Find('-') then begin
                curPassage := 0;
                repeat
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                    prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                    prTransactionCodes.SetRange(prTransactionCodes.Passage, true);
                    if prTransactionCodes.Find('-') then begin
                        curPassage := curGrossPay * prTransactionCodes."Passage %";
                        strTransDescription := prPeriodTransactions."Transaction Name";
                        fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curPassage, 0, intMonth,
                        intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none);
                    end;
                until prEmployeeTransactions.Next = 0;
            end;

            //PKK - NG Relief
            /*
            //Annual Relief
            IF (((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)) >
               (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
            MonthlyReliefAmount:=((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)
            ELSE
            MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12));

            //Monthly Relief
            MonthlyReliefAmount:=MonthlyReliefAmount/12;
            */

            //<<BLOCKED BY BANJI TO EFFECT THE NEW TAX RELEIF AFFECTING PAYE
            /* //Annual Relief
             IF ExcludeNonTaxRelief = TRUE THEN BEGIN
             IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)) >
                (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
             MonthlyReliefAmount:=((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01)
                                  +  ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)
             ELSE
             MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*
                                  ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay)));

             END ELSE BEGIN
             IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)) >
                (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
             MonthlyReliefAmount:=((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.01)
                                  +  ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)
             ELSE
             MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*((((curGrossPay-currAnnualPay)*12)+currAnnualPay)));
             END;
             */
            //>>


            //Monthly Relief
            //MonthlyReliefAmount:=MonthlyReliefAmount/12;


            //PKK NG
            curTaxDeductions := 0;
            EERelief := 0;
            strExtractedFrml := '';
            Trans.Reset;
            //Trans.SETRANGE(Trans.Pension,TRUE);
            Trans.SetRange(Trans."Add to Relief", true);
            if Trans.Find('-') then begin
                repeat
                    EmpTrans.Reset;
                    EmpTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                    EmpTrans.SetRange("Employee Code", strEmpCode);
                    EmpTrans.SetRange(EmpTrans."Transaction Code", Trans."Transaction Code");
                    EmpTrans.SetRange("Period Month", intMonth);
                    EmpTrans.SetRange("Period Year", intYear);
                    EmpTrans.SetRange(Suspended, false);
                    if EmpTrans.Find('-') then begin
                        repeat
                            curTaxDeductions := curTaxDeductions + EmpTrans.Amount;

                            if Trans.Pension then begin
                                if Trans."Pension EE formula" <> '' then begin
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, Trans."Pension EE formula");
                                    EERelief := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                                    PenAmt_G := EERelief; //RBS-BANJI
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, Trans."Is Formula for employer");
                                    ERRelief := fnFormulaResult(strExtractedFrml);
                                end;

                            end;

                        until EmpTrans.Next = 0
                    end;
                until Trans.Next = 0;
            end;

            // AVC BANJI
            Trans.Reset;
            Trans.SetRange(Trans."Voluntary Contribution", true);
            if Trans.Find('-') then begin
                repeat
                    EmpTrans.Reset;
                    EmpTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                    EmpTrans.SetRange("Employee Code", strEmpCode);
                    EmpTrans.SetRange(EmpTrans."Transaction Code", Trans."Transaction Code");
                    EmpTrans.SetRange("Period Month", intMonth);
                    EmpTrans.SetRange("Period Year", intYear);
                    EmpTrans.SetRange(Suspended, false);
                    if EmpTrans.Find('-') then begin
                        repeat
                            AvcAmt += EmpTrans.Amount;
                        until EmpTrans.Next = 0
                    end;
                until Trans.Next = 0;
            end;

            //get lanre's ee
            //MESSAGE('ok my ee contribution %1',ERRelief);
            /*
                        strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                        curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

            */
            //PKK
            //Message('%1 Monthly before', MonthlyReliefAmount);
            //MonthlyReliefAmount:=MonthlyReliefAmount+curTaxDeductions;



            //MonthlyReliefAmount:=MonthlyReliefAmount+(curTaxDeductions*12) + (EERelief*12)- (ERRelief*12);  //RBS

            //PKK
            //Message('%1 Monthly after', MonthlyReliefAmount);
            //PKKGet the N.H.F amount for the month
            curNHIF := 0;
            curNhif_Base_Amount := 0;

            if intNHIF_BasedOn = intNHIF_BasedOn::Gross then //>NHIF calculation can be based on:
                curNhif_Base_Amount := curGrossPay;
            if intNHIF_BasedOn = intNHIF_BasedOn::Basic then
                curNhif_Base_Amount := curBasicPay;
            if intNHIF_BasedOn = intNHIF_BasedOn::"Taxable Pay" then
                curNhif_Base_Amount := curTaxablePay;


            if blnPaysNhif then begin
                curNHIF := curNhif_Base_Amount * curNHFPerc * 0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
                curTransAmount := curNHIF;
                NHFAmt_G := curNHIF;   //RBS
                strTransDescription := 'N.H.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);
            end;

            //PKK
            //MonthlyReliefAmount:=MonthlyReliefAmount+curNHIF;

            //MonthlyReliefAmount:=MonthlyReliefAmount+(curNHIF*12); //RBS BANJI


            if (curReliefChild + curReliefDependant) > 0 then
                MonthlyReliefAmount := MonthlyReliefAmount + ((curReliefChild + curReliefDependant));///12 //PKK-NG


            //PKK

            //PKK NG



            curReliefPersonal := 0;
            //PKK - NG Relief


            //Get the NSSF amount
            if blnPaysNssf then
                curNSSF := curNssfEmployee;
            curTransAmount := curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NSSF);


            //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
            curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
            curTransAmount := curDefinedContrib;
            strTransDescription := 'Defined Contributions';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 1;
            NoOfUnits := 0;
            fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
             strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ",
             JournalPostingType::" ", '', CoopParameters::none);


            //Get the Gross taxable amount
            //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
            curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;
            //message('%1',curGrossTaxable);
            //>If GrossTaxable = 0 Then TheDefinedToPost = 0
            if curGrossTaxable = 0 then curDefinedContrib := 0;

            //Personal Relief
            // if get relief is ticked  - DENNO ADDED
            if blnGetsPAYERelief then begin
                curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := curReliefPersonal;
                strTransDescription := 'Personal Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                 CoopParameters::none);
            end
            else
                curReliefPersonal := 0;

            //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //>Pension Contribution [self] relief
            curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            SpecialTransType::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
            if curPensionStaff > 0 then begin
                if curPensionStaff > curMaxPensionContrib then
                    curTransAmount := curMaxPensionContrib
                else
                    curTransAmount := curPensionStaff;
                strTransDescription := 'Pension Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                CoopParameters::none)
            end;

            //if he PAYS paye only*******************I
            if blnPaysPaye and blnGetsPAYERelief then begin
                //Get Insurance Relief
                curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Life Insurance", false); //Insurance is 3 on [Special Transaction]
                if curInsuranceReliefAmount > 0 then begin
                    curTransAmount := curInsuranceReliefAmount;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 8;
                    fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none);
                end;

                //>OOI
                curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                if curOOI > 0 then begin
                    if curOOI <= curOOIMaxMonthlyContrb then
                        curTransAmount := curOOI
                    else
                        curTransAmount := curOOIMaxMonthlyContrb;

                    strTransDescription := 'Owner Occupier Interest';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 3;
                    fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none);
                end;

                //HOSP
                curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                SpecialTransType::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                if curHOSP > 0 then begin
                    if curHOSP <= curReliefMorgage then
                        curTransAmount := curHOSP
                    else
                        curTransAmount := curReliefMorgage;

                    strTransDescription := 'Home Ownership Savings Plan';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 4;
                    fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none);
                end;

                //Enter NonTaxable Amount
                if curNonTaxable > 0 then begin
                    strTransDescription := 'Other Non-Taxable Benefits';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 5;
                    fnUpdatePeriodTrans(strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
                    CoopParameters::none);
                end;

            end;

            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            /*
             //>Company pension, Excess pension, Tax on excess pension
             curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
             TRUE); //Self contrib Pension is 1 on [Special Transaction]
             IF curPensionCompany > 0 THEN BEGIN
                 curTransAmount := curPensionCompany;
                 strTransDescription := 'Pension (Company)';
                 //Update the Employer deductions table

                 curExcessPension:= curPensionCompany - curMaxPensionContrib;
                 IF curExcessPension > 0 THEN BEGIN
                     curTransAmount := curExcessPension;
                     strTransDescription := 'Excess Pension';
                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
                     fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                      intMonth,intYear,'','',SelectedPeriod);

                     curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
                     curTransAmount := curTaxOnExcessPension;
                     strTransDescription := 'Tax on ExPension';
                     TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                     fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                      intMonth,intYear,'','',SelectedPeriod);
                 END;
             END;
             */
            /* //RBS-BANJI Calc AVC amount
              prTransactionCodes.RESET;
              prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
              prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Deduction);
              prTransactionCodes.SETRANGE(,TRUE);
        
              IF prTransactionCodes.FIND('-') THEN BEGIN
                //curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';
        
                IF prTransactionCodes."Is Formula" THEN BEGIN
                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                    AvcAmt := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                  END
                  END;
              */


            LeavePerMonth := (Ann_Leave / 12);
            //RBS-BANJI
            T2hOr1PercentGP := 0;
            TaxRelief_Value := 0;
            T2hOr1PercentGP_Permonth := 0;
            VitalSetupRec.Reset;
            VitalSetupRec.Get;
            TaxRelief_Value := VitalSetupRec."Tax Relief";
            /*IF (((GrossExArr)*12)*0.01) >= TaxRelief_Value THEN BEGIN
               T2hOr1PercentGP:= (((GrossExArr)*12)*0.01);
              END ELSE
              IF (((GrossExArr)*12)*0.01) < TaxRelief_Value THEN BEGIN
                T2hOr1PercentGP := TaxRelief_Value;
               END;
               T2hOr1PercentGP_Permonth := (T2hOr1PercentGP/12);
                 */
            if (((GrossExArr) * 12) * 0.01) >= TaxRelief_Value then
                T2hOr1PercentGP := (((GrossExArr) * 12) * 0.01)
            //T2hOr1PercentGP := ((GrossExArr - PenAmt_G - NHFAmt_G - AvcAmt) * 12) * 0.01 //New RBS Lateef 
            else
                T2hOr1PercentGP := TaxRelief_Value;
            T2hOr1PercentGP_Permonth := (T2hOr1PercentGP / 12);
            PercentGross_Pen_NHF_AVC := 0;
            PercentGross_Pen_NHF_AVC := 0.2 * (GrossExArr - PenAmt_G - NHFAmt_G - AvcAmt);
            MonthlyReliefAmount := PercentGross_Pen_NHF_AVC + T2hOr1PercentGP_Permonth + AvcAmt + PenAmt_G + NHFAmt_G;
            curTransAmount := MonthlyReliefAmount;
            strTransDescription := 'Monthly Relief';
            TGroup := 'Monthly Relief';
            TGroupOrder := 8;
            TSubGroupOrder := 7;
            fnUpdatePeriodTrans(strEmpCode, 'MonthRF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
             CoopParameters::none);
            //RBS-BANJI

            //MESSAGE('%1',MonthlyReliefAmount);

            //Get the Taxable amount for calculation of PAYE
            //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)
            //1
            //curGrossTaxable+=curNonTaxable;

            //Add HOSP and MORTGAGE KIM{}
            //VitalSetup.RESET;
            curTaxablePay := 0;//RBS LATEEF 22072021
            if (curPensionStaff + curDefinedContrib) > curMaxPensionContrib then
                //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curMaxPensionContrib+curOOI+curHOSP+curNonTaxable+NonTaxable) //RBS
                //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curOOI+curHOSP+curNonTaxable+NonTaxable)  //RBS
                curTaxablePay := curGrossTaxable - (curSalaryArrears + MonthlyReliefAmount + curOOI + curHOSP + curNonTaxable + NonTaxable) //RBS BANJI
            else

                //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curDefinedContrib +curPensionStaff+curOOI+curHOSP+curNonTaxable+NonTaxable); //RBS
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + MonthlyReliefAmount + curOOI + curHOSP + curNonTaxable + NonTaxable); //RBS
                                                                                                                                                                 //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curOOI+curHOSP+curNonTaxable+NonTaxable);   //RBS
            curTransAmount := curTaxablePay;
            strTransDescription := 'Taxable Pay';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 6;
            fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
             CoopParameters::none);

            /*
            VitalSetupS.RESET;
            VitalSetupS.SETRANGE(VitalSetupS."Medical Scheme No.",'321456');
            IF VitalSetupS.COUNT <> 4 THEN BEGIN
            ERROR(Text021);
            END;
            */


            //Get the Tax charged for the month
            //PKK- NG
            //curTaxCharged := fnGetEmployeePaye(curTaxablePay);

            //PKKcurTaxCharged := fnGetEmployeePaye(curTaxablePay-(MonthlyReliefAmount));

            //PKK
            //RBS-BANJI



            statTaxPay := curTaxablePay;
            //curTaxablePay:=((curTaxablePay-currAnnualPay)*12)+currAnnualPay;
            //curTaxablePay2 := ((curTaxablePay - currAnnualPay) * 12) + currAnnualPay;  //RBS LATEEF 22072021
            curTaxablePay2 := 0;
            curTaxablePay2 := curTaxablePay; //RBS LATEEF 21/12/2021
            curTaxablePay := ((curTaxablePay - currAnnualPay) * 12) + currAnnualPay;
            //IF (curTaxablePay-MonthlyReliefAmount) < 300000 THEN //PKK Tax for those earning less than 300000
            //curTaxCharged := (curTaxablePay-MonthlyReliefAmount) * 0.01
            //ELSE
            curTaxCharged := fnGetEmployeePaye(curTaxablePay2); //RBS BANJI -(MonthlyReliefAmount));
                                                                //MESSAGE('%1',(curTaxablePay-(MonthlyReliefAmount)-(VitalSetup."Tax Relief")));
            if curTaxCharged <> 0 then
                // curTaxCharged := curTaxCharged / 12;
                curTaxCharged := curTaxCharged;
            curTaxablePay := statTaxPay;
            //PKK

            //PKK - Relief before tax computation
            /*
            IF (curReliefChild+curReliefDependant) > 0 THEN
            curTaxCharged := curTaxCharged - ((curReliefChild+curReliefDependant)/12); //PKK-NG
            */
            //PKK - Relief before tax computation

            //PKK-NG ADDED
            if (curGrossPay * 0.01) > curTaxCharged then
                curTaxCharged := (curGrossPay * 0.01);
            //PKK-NG ADDED
            //PKK- NG
            curTransAmount := curTaxCharged;
            strTransDescription := 'Tax Charged';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 7;
            fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ", JournalPostingType::" ", '',
            CoopParameters::none);
            //Get the Net PAYE amount to post for the month
            if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                curPAYE := curTaxCharged - curMaximumRelief
            else
                curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);

            if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
            curTransAmount := curPAYE;
            if curPAYE < 0 then curTransAmount := 0;
            strTransDescription := 'P.A.Y.E';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 3;
            fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, JournalPostAs::Credit,
             JournalPostingType::"G/L Account", '', CoopParameters::none);


            if prSalaryCard.Get(strEmpCode) then begin
                if prSalaryCard."Pays PAYE" then begin
                    //PAYE
                    PayeTillDate := 0;
                    PeriodTrans.Reset;
                    PeriodTrans.SetCurrentKey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                    PeriodTrans."Group Order", PeriodTrans."Sub Group Order", PeriodTrans."Payslip Order");
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", strEmpCode);
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", strEmpCode);
                    PeriodTrans.SetFilter(PeriodTrans."Transaction Code", '%1|%2', 'PAYE', 'PAYE-CALC');
                    if PeriodTrans.Find('-') then begin
                        repeat
                            if PeriodTrans."Period Year" <> 2015 then
                                PayeTillDate += PeriodTrans.Amount;

                        until PeriodTrans.Next = 0;
                        //PayeTillDate+=curPAYE
                    end;

                    //MESSAGE('%1',PayeTillDate);
                    if PayeTillDate = 0 then
                        curTransAmount := curPAYE
                    else
                        curTransAmount := PayeTillDate;
                    //MESSAGE('%1..%2',curTransAmount);

                    strTransDescription := 'Tax Paid To Date';
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 5;
                    fnUpdatePeriodTrans(strEmpCode, 'TOT-PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', JournalPostAs::" ",
                     JournalPostingType::" ", '', CoopParameters::none);
                end;
            end;


            //Store the unused relief for the current month
            //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
            if curPAYE < 0 then begin
                prUnusedRelief.Reset;
                prUnusedRelief.SetRange(prUnusedRelief."Employee Code", strEmpCode);
                prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                if prUnusedRelief.Find('-') then
                    prUnusedRelief.Delete;

                prUnusedRelief.Reset;
                with prUnusedRelief do begin
                    Init;
                    "Employee Code" := strEmpCode;
                    "Unused Relief" := curPAYE;
                    "Period Month" := intMonth;
                    "Period Year" := intYear;
                    Insert;

                    curPAYE := 0;
                end;
            end;

            //Deductions: get all deductions for the month
            //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
            //>Balance = (Openning Bal + Deduction)...//Increasing balance
            //>Balance = (Openning Bal - Deduction)...//Reducing balance
            //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance


            //Get the N.H.F amount for the month GBT //PKK
            /*
            curNhif_Base_Amount :=0;

            IF intNHIF_BasedOn =intNHIF_BasedOn::Gross THEN //>NHIF calculation can be based on:
                    curNhif_Base_Amount := curGrossPay;
            IF intNHIF_BasedOn = intNHIF_BasedOn::Basic THEN
                   curNhif_Base_Amount := curBasicPay;
            IF intNHIF_BasedOn =intNHIF_BasedOn::"Taxable Pay" THEN
                   curNhif_Base_Amount := curTaxablePay;


            IF blnPaysNhif THEN BEGIN
             curNHIF:=curNhif_Base_Amount*curNHFPerc*0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
             curTransAmount := curNHIF;

             strTransDescription := 'N.H.F';
             TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 2;
             fnUpdatePeriodTrans (strEmpCode, 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
              curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
              NHIFEMPyee,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
            END;
            */
            //PKK

            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
            if prEmployeeTransactions.Find('-') then begin
                curTotalDeductions := 0;
                repeat
                    EmployerAmount := 0; //PKK
                    EmployerBalance := 0; //PKK

                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Deduction);
                    prTransactionCodes.SetRange(prTransactionCodes."Non-Transactional", false);
                    if prTransactionCodes.Find('-') then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';

                        if prTransactionCodes."Is Formula" then begin
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;

                        //PKK EMPLOYER TRANSACTION
                        EmployerAmount := 0;
                        EmployerBalance := 0;

                        if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                            if prTransactionCodes."Is Formula for employer" <> '' then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                EmployerAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount


                                prEmployeeTransactions."Employer Amount" := EmployerAmount;
                                prEmployeeTransactions.Modify;

                                EmployerBalance := prEmployeeTransactions."Employer Balance" + EmployerAmount;

                            end else begin
                                EmployerAmount := prEmployeeTransactions."Employer Amount";

                                prEmployeeTransactions."Employer Amount" := EmployerAmount;
                                prEmployeeTransactions.Modify;

                                EmployerBalance := prEmployeeTransactions."Employer Balance" + EmployerAmount;

                            end;
                        end;

                        //PKK EMPLOYER TRANSACTION

                        //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Life Insurance")
                          and (prTransactionCodes."Deduct Premium" = false) then begin
                            curTransAmount := 0;
                        end;

                        //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::Morgage)
                         and (prTransactionCodes."Deduct Mortgage" = false) then begin
                            curTransAmount := 0;
                        end;




                        //Get the posting Details
                        JournalPostingType := JournalPostingType::" ";
                        JournalAcc := '';
                        if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                Customer.Reset;
                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                                //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                                //IF prTransactionCodes.CustomerPostingGroup <>'' THEN
                                //Customer.SETRANGE(Customer."Customer Posting Group",prTransactionCodes.CustomerPostingGroup);

                                //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                                Customer.SetRange(Customer."No.", HrEmployee."No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := JournalPostingType::Customer;
                                end;
                            end;
                        end else begin
                            JournalAcc := prTransactionCodes."GL Account";
                            JournalPostingType := JournalPostingType::"G/L Account";
                        end;

                        //End posting Details


                        //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") and
                           (prTransactionCodes."Repayment Method" = prTransactionCodes."Repayment Method"::Amortized) then begin
                            curTransAmount := 0;
                            curLoanInt := 0;
                            curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                            prTransactionCodes."Nominal Interest Rate", prTransactionCodes."Repayment Method",
                               prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                            //Post the Interest
                            if (curLoanInt <> 0) then begin
                                curTransAmount := curLoanInt;
                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                curTransBalance := 0;
                                strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                TGroup := 'DEDUCTIONS';
                                TGroupOrder := 8;
                                TSubGroupOrder := 1;
                                NoOfUnits := prEmployeeTransactions."No of Units";
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                  JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                  CoopParameters::"loan Interest")
                            end;
                            //Get the Principal Amt
                            curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
                            //Modify PREmployeeTransaction Table
                            prEmployeeTransactions.Amount := curTransAmount;
                            prEmployeeTransactions.Modify;
                        end;
                        //Loan Calculation Amortized

                        case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                            prTransactionCodes."Balance Type"::None:
                                curTransBalance := 0;
                            prTransactionCodes."Balance Type"::Increasing:
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            prTransactionCodes."Balance Type"::Reducing:
                                begin
                                    //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    end;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end
                        end;

                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                        curTransAmount := curTransAmount;
                        curTransBalance := curTransBalance;
                        strTransDescription := prTransactionCodes."Transaction Name";

                        if (prTransactionCodes."Transaction Category" = prTransactionCodes."Transaction Category"::Pension) then  //Denno this is to take pension to be a statutory
                        begin
                            TGroup := 'STATUTORIES';
                            TGroupOrder := 7;
                            TSubGroupOrder := 4;
                        end else begin
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 0;
                        end;

                        fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                         strTransDescription, curTransAmount, curTransBalance, intMonth,
                         intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                         JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                         prTransactionCodes."coop parameters");

                        //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                        if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") and
                           (prTransactionCodes."Repayment Method" <> prTransactionCodes."Repayment Method"::Amortized) then begin

                            curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                           prTransactionCodes."Nominal Interest Rate",
                            prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                            prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);
                            if curLoanInt > 0 then begin
                                curTransAmount := curLoanInt;
                                curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                curTransBalance := 0;
                                strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                TGroup := 'DEDUCTIONS';
                                TGroupOrder := 8;
                                TSubGroupOrder := 1;
                                NoOfUnits := prEmployeeTransactions."No of Units";
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                  JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                  CoopParameters::"loan Interest")
                            end;
                        end;
                        //End Loan transaction calculation
                        //Fringe Benefits and Low interest Benefits
                        if prTransactionCodes."Fringe Benefit" = true then begin
                            if prTransactionCodes."Nominal Interest Rate" < curLoanMarketRate then begin
                                fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Nominal Interest Rate") * curLoanCorpRate) / 1200)
                                 * prEmployeeTransactions.Balance;
                            end;
                        end else begin
                            fnCalcFringeBenefit := 0;
                        end;
                        if fnCalcFringeBenefit > 0 then begin
                            fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                             'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                        end;
                        //End Fringe Benefits

                        //Create Employer Deduction
                        EmployerAmount := 0;
                        EmployerBalance := 0;
                        if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                            if prTransactionCodes."Is Formula for employer" <> '' then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                            end else begin
                                curTransAmount := prEmployeeTransactions."Employer Amount";

                            end;
                            if curTransAmount > 0 then
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                                 'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);



                            fnUpdatePeriodTrans(strEmpCode, 'PENSNORM', TGroup, TGroupOrder, TSubGroupOrder,
                             'Pension ER', curTransAmount, curTransBalance, intMonth,
                             intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                             '', 0, JournalPostingType, prEmployeeTransactions."Loan Number",
                             prTransactionCodes."coop parameters");

                            fnUpdatePeriodTrans(strEmpCode, 'PENSNOR', TGroup, TGroupOrder, TSubGroupOrder,
                             'Pension EE', EERelief, curTransBalance, intMonth,
                             intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                             '', 0, JournalPostingType, prEmployeeTransactions."Loan Number",
                             prTransactionCodes."coop parameters");



                        end;
                        //Employer deductions

                    end;

                until prEmployeeTransactions.Next = 0;
                //GET TOTAL DEDUCTIONS
                //PKK ADD NHF to TOTAL DEDUCTIONS
                //curTotalDeductions:=curTotalDeductions+curNHIF;
                //Message('%1...%2',curNHIF,CurPaye,CurPen);
                TotDed := 0;
                TotDed := curTotalDeductions + curNHIF + curPAYE;
                curTransBalance := 0;
                strTransCode := 'TOT-DED';
                strTransDescription := 'TOTAL DEDUCTION';
                TGroup := 'DEDUCTIONS';
                TGroupOrder := 8;
                TSubGroupOrder := 9;
                NoOfUnits := prEmployeeTransactions."No of Units";
                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, TotDed, curTransBalance, intMonth, intYear,
                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                  '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none);

                EmployerAmount := 0; //PKK
                EmployerBalance := 0; //PKK

                //END GET TOTAL DEDUCTIONS
            end;

            //Net Pay: calculate the Net pay for the month in the following manner:
            //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
            //...Tot Deductions also include (SumLoan + SumInterest)
            // curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions+IsCashBenefit)-curNonTaxable;
            curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit) - curNonTaxable;//+curNonTaxable;  //RBS
                                                                                                                                           //>Nett = Nett - curExcessPension
                                                                                                                                           //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
            curNetPay := curNetPay; //- curExcessPension

            //>Nett = Nett - cSumEmployerDeductions
            //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
            curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

            curNetRnd_Effect := curNetPay - Round(curNetPay);
            curTransAmount := curNetPay;
            strTransDescription := 'Net Pay';
            TGroup := 'NET PAY';
            TGroupOrder := 9;
            TSubGroupOrder := 0;
            NoOfUnits := 0;
            fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
            PayablesAcc, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);

            //Rounding Effect: if the Net pay is rounded, take the rounding effect &
            //save it as an earning for the staff for the next month
            //>Insert the Netpay rounding effect into the tblRoundingEffect table


            //Negative pay: if the NetPay<0 then log the entry
            //>Display an on screen report
            //>Through a pop-up to the user
            //>Send an email to the user or manager
        end;

    end;

    [Scope('OnPrem')]
    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := Round((DaysWorked / DaysInMonth) * BasicSalary);
    end;

    [Scope('OnPrem')]
    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        VitalSetup.Get();

        TodayDate := dtDate;
        /*
         Day:=DATE2DMY(TodayDate,1);
         Expr1:=FORMAT(-Day)+'D+1D';
         FirstDay:=CALCDATE(Expr1,TodayDate);
         LastDate:=CALCDATE('1M-1D',FirstDay);
        
         SysDate.RESET;
         SysDate.SETRANGE(SysDate."Period Type",SysDate."Period Type"::Date);
         SysDate.SETRANGE(SysDate."Period Start",FirstDay,LastDate);
         SysDate.SETFILTER(SysDate."Period No.",'1..7');
         IF SysDate.FIND('-') THEN
            DaysInMonth:=SysDate.COUNT;
        */

        //W days in month
        MonthDays := CalcDate('-1D', CalcDate('1M', DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3)))) -
                    DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3));

        TDate := DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3));

        i := 0;
        repeat
            i := i + 1;

            if VitalSetup."Prol. Based on days in month" = true then begin
                DaysInMonth := DaysInMonth + 1;
            end else begin
                if (Date2DWY(TDate, 1) <> 6) and (Date2DWY(TDate, 1) <> 7) then
                    DaysInMonth := DaysInMonth + 1;
            end;

            TDate := CalcDate('1D', TDate);

        until i = MonthDays + 1;
        //W days in month
        // Message('%1',DaysInMonth);

    end;

    [Scope('OnPrem')]
    procedure fnUpdatePeriodTrans(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date; Department: Code[20]; JournalAC: Code[20]; PostAs: Option " ",Debit,Credit; JournalACType: Option " ","G/L Account",Customer,Vendor; LoanNo: Code[20]; CoopParam: Option "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension)
    var
        prPeriodTransactions: Record "prPeriod Transactions";
        prSalCard: Record "HR-Employee";
    begin
        if curAmount = 0 then exit;
        with prPeriodTransactions do begin
            if not prPeriodTransactions.Get(EmpCode, TCode, Month, Year) then begin // RBS Lateef 23062022
                Init;
                "Employee Code" := EmpCode;
                "Transaction Code" := TCode;
                "Group Text" := TGroup;
                "Transaction Name" := Description;
                Amount := Round(curAmount, 0.01, '=');
                Balance := curBalance;
                "Emp Amount" := EmployerAmount;
                "Emp Balance" := EmployerBalance;
                "Original Amount" := Balance;
                "Group Order" := GroupOrder;
                "Sub Group Order" := SubGroupOrder;
                Membership := mMembership;
                "Reference No" := ReferenceNo;
                "Period Month" := Month;
                "Period Year" := Year;
                "Payroll Period" := dtOpenPeriod;
                "Department Code" := Department;
                "Journal Account Type" := JournalACType;
                "Post As" := PostAs;
                "Journal Account Code" := JournalAC;
                "Loan Number" := LoanNo;
                "coop parameters" := CoopParam;
                "No. Of Units" := NoOfUnits;
                "Payroll Code" := PayrollType;
                prPeriodTransactions."Payslip Order" := 0;
                //Paymode
                if prSalCard.Get(EmpCode) then begin
                    "Payment Mode" := prSalCard."Payment Mode";
                    "Location/Division" := prSalCard.Office;
                    Department := prSalCard."Department Code";
                    "Cost Centre" := prSalCard."Cost Code";
                    "Salary Grade" := prSalCard."Salary Grade";
                    "Salary Notch" := prSalCard."Salary Notch/Step";
                    "Employee Classification" := prSalCard."Employee Classification";
                    "Payroll  Classification" := prSalCard."Payroll Filter Group";
                    //State:=prSalCard."Post Code";
                    //"New Departmental Code":=prSalCard."New Departmental Code";
                end;

                //to add prorated pension amount to the current pensure
                if TraCode.Get(TCode) then
                    if TraCode.Pension then begin
                        EmpTra.SetRange(EmpTra."Employee Code", EmpCode);
                        EmpTra.SetRange(EmpTra."Payroll Period", dtOpenPeriod);
                        EmpTra.SetRange(EmpTra."Transaction Code", 'PENARR');  //TraCode
                        if EmpTra.FindFirst then
                            Amount := Round(curAmount + EmpTra.Amount, 0.01, '=');
                    end;


                if Trans.Get(TCode) then begin
                    if Trans."Non-Transactional" = false then begin
                        if Trans.Frequency = Trans.Frequency::Varied then
                            prPeriodTransactions."Payslip Order" := 2
                    end;
                end;

                if Trans.Get(TCode) then begin
                    if Trans.Pension then begin
                        "EE Contribution" := EERelief;
                        "ER Contribution" := Amount - EERelief;
                    end;
                end;

                Insert;
                //RBS Lateef 23062022>>
            end else begin
                Amount := Round(curAmount, 0.01, '=');
                Balance := curBalance;
                modify;
            end;
            //RBS Lateef 23062022<<
            //Update the prEmployee Transactions  with the Amount
            Amount := Round(curAmount, 0.01, '=');  //update employee trans with the normal value

            fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period", "Reference No");
        end;
    end;

    [Scope('OnPrem')]
    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "prTransaction Codes";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.Reset;
        prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", intSpecTransID);
        if prTransactionCodes.Find('-') then begin
            repeat
                prEmployeeTransactions.Reset;
                prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", strEmpCode);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                if prEmployeeTransactions.Find('-') then begin

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    case intSpecTransID of
                        intSpecTransID::"Defined Contribution":
                            if prTransactionCodes."Is Formula" then begin
                                strExtractedFrml := '';
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            end else
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        intSpecTransID::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        intSpecTransID::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::Morgage:
                            begin
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                if SpecialTransAmount > curReliefMorgage then begin
                                    SpecialTransAmount := curReliefMorgage
                                end;

                            end;

                    end;
                end;
            until prTransactionCodes.Next = 0;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnGetEmployeePaye(curTaxable2Payee: Decimal) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        //PKK - Convert to annual
        //statTaxPay:=curTaxablePay;
        //curTaxablePay:=((curTaxablePay-currAnnualPay)*12)+currAnnualPay;
        //PKK - Convert to annual



        KeepCount := 0;
        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            if curTaxable2Payee < prPAYE."PAYE Tier" then begin //PKK EXIT;
                if KeepCount = 0 then begin
                    PAYE := PAYE + (curTaxable2Payee * (prPAYE.Rate / 100));
                end;
                //PKK
                //PAYE := PAYE/12;
                //Min PAYE
                //Min PAYE
                exit;
            end;
        end;
        prPAYE.Reset;
        if prPAYE.FindFirst then begin
            repeat
                KeepCount += 1;
                curTempAmount := curTaxable2Payee;
                if curTaxable2Payee = 0 then exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxable2Payee := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxable2Payee := curTaxable2Payee - curTempAmount;

            until prPAYE.Next = 0;
        end;

        //PKK
        //PAYE := PAYE/12;
        //curTaxablePay:=statTaxPay;
        //PKK
    end;

    [Scope('OnPrem')]
    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record prNHIF;
    begin
        prNHIF.Reset;
        prNHIF.SetCurrentKey(prNHIF."Tier Code");
        if prNHIF.FindFirst then begin
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                    NHIF := prNHIF.Amount;
            until prNHIF.Next = 0;
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

    [Scope('OnPrem')]
    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagementPayroll;
    begin
        Results :=
         AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;

    [Scope('OnPrem')]
    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "prEmployee Transactions";
        prPeriodTransactions: Record "prPeriod Transactions";
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "prTransaction Codes";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "prEmployee Transactions";
        prPayrollPeriods: Record "prPayroll Periods";
        prNewPayrollPeriods: Record "prPayroll Periods";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information";
        prAssignEmployeeLoan: Record prAssignEmployeeLoan;
        NewQuarter: Date;
        SalaryStep: Record "Salary Step/Notch Transactions";
        EmpRec: Record "HR Employees";
    begin
        ControlInfo.Get();

        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods.Quarter, true);
        if prPayrollPeriods.Find('+') then
            NewQuarter := CalcDate('1Q', prPayrollPeriods."Date Opened");
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2DMY(dtNewPeriod, 2);
        intNewYear := Date2DMY(dtNewPeriod, 3);

        intMonth := Date2DMY(dtOpenPeriod, 2);
        intYear := Date2DMY(dtOpenPeriod, 3);

        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2DMY(dtNewPeriod, 2);
        intNewYear := Date2DMY(dtNewPeriod, 3);

        intMonth := Date2DMY(dtOpenPeriod, 2);
        intYear := Date2DMY(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
        //Multiple Payroll
        if ControlInfo."Multiple Payroll" then
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);
        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                if prTransactionCodes.Find('-') then begin
                    with prTransactionCodes do begin
                        case prTransactionCodes."Balance Type" of
                            prTransactionCodes."Balance Type"::None:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := 0;
                                end;
                            prTransactionCodes."Balance Type"::Increasing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                end;
                            prTransactionCodes."Balance Type"::Reducing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                    end;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;
                    end;
                end;

                //For those transactions with Start and End Date Specified
                if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
                    if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                    end;
                end;
                //End Transactions with Start and End Date

                if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                   (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                 begin
                    if (curTransAmount <> 0) or (prEmployeeTransactions."Employer Amount" <> 0) then  //Update the employee transaction table add for Employers only transaction
                     begin
                        if ((prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing) and (curTransBalance <> 0)) or
                         (prTransactionCodes."Balance Type" <> prTransactionCodes."Balance Type"::Reducing) then
                            prEmployeeTransactions.Balance := curTransBalance;
                        prEmployeeTransactions.Modify;


                        //Insert record for the next period
                        with prEmployeeTrans do begin
                            Init;
                            "Employee Code" := prEmployeeTransactions."Employee Code";
                            "Transaction Code" := prEmployeeTransactions."Transaction Code";
                            "Transaction Name" := prEmployeeTransactions."Transaction Name";
                            Amount := curTransAmount;
                            Balance := curTransBalance;
                            "Amortized Loan Total Repay Amt" := prEmployeeTransactions."Amortized Loan Total Repay Amt";
                            "Original Amount" := prEmployeeTransactions."Original Amount";
                            Membership := prEmployeeTransactions.Membership;
                            "Reference No" := prEmployeeTransactions."Reference No";
                            "Loan Number" := prEmployeeTransactions."Loan Number";
                            "Period Month" := intNewMonth;
                            "Period Year" := intNewYear;
                            "Payroll Period" := dtNewPeriod;
                            "Payroll Code" := PayrollCode;
                            "Employer Amount" := prEmployeeTransactions."Employer Amount";
                            Insert;
                        end;
                    end;
                end
            until prEmployeeTransactions.Next = 0;
        end;

        //Added for loan card to push loans for next period into employee transactions **changes**
        prAssignEmployeeLoan.Reset;
        prAssignEmployeeLoan.SetRange(prAssignEmployeeLoan."Payroll Period", dtNewPeriod);
        prAssignEmployeeLoan.SetRange(prAssignEmployeeLoan.Status, prAssignEmployeeLoan.Status::Posted);
        if prAssignEmployeeLoan.FindSet then
            repeat
                fnInsertTrans(prAssignEmployeeLoan);
            until prAssignEmployeeLoan.Next = 0;


        //Update the Period as Closed
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if ControlInfo."Multiple Payroll" then
            prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        with prNewPayrollPeriods do begin
            Init;
            "Period Month" := intNewMonth;
            "Period Year" := intNewYear;
            "Period Name" := Format(dtNewPeriod, 0, '<Month Text>');//+' '+FORMAT(intNewYear);
            "Date Opened" := dtNewPeriod;
            Closed := false;
            "Payroll Code" := PayrollCode;
            if dtNewPeriod = NewQuarter then
                Quarter := true;
            Insert;
        end;

        if dtNewPeriod = NewQuarter then begin
            EmpRec.Reset;
            EmpRec.SetRange(EmpRec.Status, EmpRec.Status::Active);
            if EmpRec.Find('-') then begin
                repeat

                    SalaryStep.Reset;
                    SalaryStep.SetRange(SalaryStep."Salary Grade", EmpRec."Salary Grade");
                    SalaryStep.SetRange(SalaryStep."Salary Step/Notch", EmpRec."Salary Step");
                    SalaryStep.SetRange(SalaryStep.Frequency, SalaryStep.Frequency::Quarterly);
                    if SalaryStep.Find('-') then begin
                        //strExtractedFrml := fnPureFormula(EmpRec."No.", intMonth, intYear, SalaryStep.Formula);
                        //curTransAmount := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                        with prEmployeeTrans do begin
                            Init;
                            "Employee Code" := EmpRec."No.";
                            "Transaction Code" := SalaryStep."Transaction Code";
                            "Transaction Name" := SalaryStep."Transaction Name";
                            Amount := curTransAmount;
                            //Balance:= curTransBalance;
                            //"Amortized Loan Total Repay Amt":=prEmployeeTransactions. "Amortized Loan Total Repay Amt";
                            "Original Amount" := prEmployeeTransactions."Original Amount";
                            Membership := prEmployeeTransactions.Membership;
                            "Reference No" := prEmployeeTransactions."Reference No";
                            "Loan Number" := prEmployeeTransactions."Loan Number";
                            "Period Month" := intNewMonth;
                            "Period Year" := intNewYear;
                            "Payroll Period" := dtNewPeriod;
                            "Payroll Code" := PayrollCode;
                            "Employer Amount" := prEmployeeTransactions."Employer Amount";
                            Insert;
                        end;
                    end;

                until EmpRec.Next = 0;
            end;
        end;
        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
    end;

    [Scope('OnPrem')]
    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "prPeriod Transactions";
        prEmployeeTransactions: Record "prEmployee Transactions";
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2DMY(dtNewPeriod, 2);
        intNewYear := Date2DMY(dtNewPeriod, 3);

        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then begin
            repeat
                with prEmployeeTransactions do begin
                    Init;
                    "Employee Code" := prPeriodTransactions."Employee Code";
                    "Transaction Code" := 'NEGP';
                    "Transaction Name" := 'Negative Pay';
                    Amount := prPeriodTransactions.Amount;
                    Balance := 0;
                    "Original Amount" := 0;
                    "Period Month" := intNewMonth;
                    "Period Year" := intNewYear;
                    "Payroll Period" := dtNewPeriod;
                    Insert;
                end;
            until prPeriodTransactions.Next = 0;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions";
        prEmployee: Record "HR-Employee";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Normal);
        if prEmployee.Find('-') then begin
            repeat

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then begin
                    repeat
                        with prPeriodTransactions do begin
                            case prPeriodTransactions."Group Order" of
                                1: //Basic pay & Arrears
                                    begin
                                        if "Sub Group Order" = 1 then P9BasicPay := Amount; //Basic Pay
                                        if "Sub Group Order" = 2 then P9BasicPay := P9BasicPay + Amount; //Basic Pay Arrears
                                    end;
                                3:  //Allowances
                                    begin
                                        P9Allowances := P9Allowances + Amount
                                    end;
                                4: //Gross Pay
                                    begin
                                        P9GrossPay := Amount
                                    end;
                                6: //Taxation
                                    begin
                                        if "Sub Group Order" = 1 then P9DefinedContribution := Amount; //Defined Contribution
                                        if "Sub Group Order" = 9 then P9TaxRelief := Amount; //Tax Relief
                                        if "Sub Group Order" = 8 then P9InsuranceRelief := Amount; //Insurance Relief
                                        if "Sub Group Order" = 6 then P9TaxablePay := Amount; //Taxable Pay
                                        if "Sub Group Order" = 7 then P9TaxCharged := Amount; //Tax Charged
                                    end;
                                7: //Statutories
                                    begin
                                        if "Sub Group Order" = 1 then P9NSSF := Amount; //Nssf
                                        if "Sub Group Order" = 2 then P9NHIF := Amount; //Nhif
                                        if "Sub Group Order" = 3 then P9Paye := Amount; //paye
                                        if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
                                    end;
                                8://Deductions
                                    begin
                                        P9Deductions := P9Deductions + Amount;
                                    end;
                                9: //NetPay
                                    begin
                                        P9NetPay := Amount;
                                    end;
                            end;
                        end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details
                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            until prEmployee.Next = 0;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "prEmployee P9 Info";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2DMY(dtCurrPeriod, 2);
        intYear := Date2DMY(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        with prEmployeeP9Info do begin
            Init;
            "Employee Code" := P9EmployeeCode;
            "Basic Pay" := P9BasicPay;
            Allowances := P9Allowances;
            Benefits := P9Benefits;
            "Value Of Quarters" := P9ValueOfQuarters;
            "Defined Contribution" := P9DefinedContribution;
            "Owner Occupier Interest" := P9OwnerOccupierInterest;
            "Gross Pay" := P9GrossPay;
            "Taxable Pay" := P9TaxablePay;
            "Tax Charged" := P9TaxCharged;
            "Insurance Relief" := P9InsuranceRelief;
            "Tax Relief" := P9TaxRelief;
            PAYE := P9Paye;
            NSSF := P9NSSF;
            NHIF := P9NHIF;
            Deductions := P9Deductions;
            "Net Pay" := P9NetPay;
            "Period Month" := intMonth;
            "Period Year" := intYear;
            "Payroll Period" := dtCurrPeriod;
            "Payroll Code" := prPayrollCode;
            Insert;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;
        PayTillCutOff := false;

        if VitalSetup.Get() then begin
            PayTillCutOff := VitalSetup."Pay upto Cut Off Date";
            if PayTillCutOff = true then begin
                VitalSetup.TestField(VitalSetup."Payroll Cut Off Day");
            end;
        end;

        RemainingDays := 0;
        if PayTillCutOff = true then begin //PKK - AGROSACK
            RemainingDays := (DMY2Date(VitalSetup."Payroll Cut Off Day", Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3)) - TodayDate);

        end else begin
            RemainingDays := (CalcDate('-1D', CalcDate('1M', DMY2Date(1, Date2DMY(TodayDate, 2), Date2DMY(TodayDate, 3))))
                                            - TodayDate);
        end;


        TDate := TodayDate;

        i := 0;
        repeat
            i := i + 1;

            if VitalSetup."Prol. Based on days in month" = true then begin
                DaysWorked := DaysWorked + 1;
            end else begin
                if (Date2DWY(TDate, 1) <> 6) and (Date2DWY(TDate, 1) <> 7) then
                    DaysWorked := DaysWorked + 1;
            end;

            TDate := CalcDate('1D', TDate);


        until i = RemainingDays + 1;
    end;

    [Scope('OnPrem')]
    procedure fnSalaryArrears(EmpCode: Text[30]; TransCode: Text[30]; CBasic: Decimal; StartDate: Date; EndDate: Date; dtOpenPeriod: Date; dtDOE: Date; dtTermination: Date)
    var
        FirstMonth: Boolean;
        startmonth: Integer;
        startYear: Integer;
        "prEmployee P9 Info": Record "prEmployee P9 Info";
        P9BasicPay: Decimal;
        P9taxablePay: Decimal;
        P9PAYE: Decimal;
        ProratedBasic: Decimal;
        SalaryArrears: Decimal;
        SalaryVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPAYE: Decimal;
        PAYEVariance: Decimal;
        PAYEArrears: Decimal;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
    begin
        fnInitialize;

        FirstMonth := true;
        if EndDate > StartDate then begin
            while StartDate < EndDate do begin
                //fnGetEmpP9Info
                startmonth := Date2DMY(StartDate, 2);
                startYear := Date2DMY(StartDate, 3);

                "prEmployee P9 Info".Reset;
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Employee Code", EmpCode);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Month", startmonth);
                "prEmployee P9 Info".SetRange("prEmployee P9 Info"."Period Year", startYear);
                if "prEmployee P9 Info".Find('-') then begin
                    P9BasicPay := "prEmployee P9 Info"."Basic Pay";
                    P9taxablePay := "prEmployee P9 Info"."Taxable Pay";
                    P9PAYE := "prEmployee P9 Info".PAYE;

                    if P9BasicPay > 0 then   //Staff payment history is available
                     begin
                        if FirstMonth then begin                 //This is the first month in the arrears loop
                            if Date2DMY(StartDate, 1) <> 1 then //if the date doesn't start on 1st, we have to prorate the salary
                             begin
                                //ProratedBasic := ProratePay.fnProratePay(P9BasicPay, CBasic, StartDate); ********
                                //Get the Basic Salary (prorate basic pay if needed) //Termination Remaining
                                if (Date2DMY(dtDOE, 2) = Date2DMY(StartDate, 2)) and (Date2DMY(dtDOE, 3) = Date2DMY(StartDate, 3)) then begin
                                    CountDaysofMonth := fnDaysInMonth(dtDOE);
                                    DaysWorked := fnDaysWorked(dtDOE, false);
                                    if DontProrateBPAY = false then
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                end;

                                //PKK - Prorate Absence

                                //PKK - Prorate Absence

                                //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                if dtTermination <> 0D then begin
                                    if (Date2DMY(dtTermination, 2) = Date2DMY(StartDate, 2)) and (Date2DMY(dtTermination, 3) = Date2DMY(StartDate, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(dtTermination);
                                        DaysWorked := fnDaysWorked(dtTermination, true);
                                        ProratedBasic := fnBasicPayProrated(EmpCode, startmonth, startYear, P9BasicPay, DaysWorked, CountDaysofMonth)
                                    end;
                                end;

                                SalaryArrears := (CBasic - ProratedBasic)
                            end
                            else begin
                                SalaryArrears := (CBasic - P9BasicPay);
                            end;
                        end;
                        SalaryVariance := SalaryVariance + SalaryArrears;
                        SupposedTaxablePay := P9taxablePay + SalaryArrears;

                        //To calc paye arrears, check if the Supposed Taxable Pay is > the taxable pay for the loop period
                        if SupposedTaxablePay > P9taxablePay then begin
                            SupposedTaxCharged := fnGetEmployeePaye(SupposedTaxablePay);
                            SupposedPAYE := SupposedTaxCharged - curReliefPersonal;
                            PAYEVariance := SupposedPAYE - P9PAYE;
                            PAYEArrears := PAYEArrears + PAYEVariance;
                        end;
                        FirstMonth := false;               //reset the FirstMonth Boolean to False
                    end;
                end;
                StartDate := CalcDate('+1M', StartDate);
            end;
            if SalaryArrears <> 0 then begin
                PeriodYear := Date2DMY(dtOpenPeriod, 3);
                PeriodMonth := Date2DMY(dtOpenPeriod, 2);
                fnUpdateSalaryArrears(EmpCode, TransCode, StartDate, EndDate, SalaryArrears, PAYEArrears, PeriodMonth, PeriodYear,
                dtOpenPeriod);
            end

        end
        else
            Error('The start date must be earlier than the end date');
    end;

    [Scope('OnPrem')]
    procedure fnUpdateSalaryArrears(EmployeeCode: Text[50]; TransCode: Text[50]; OrigStartDate: Date; EndDate: Date; SalaryArrears: Decimal; PayeArrears: Decimal; intMonth: Integer; intYear: Integer; payperiod: Date)
    var
        FirstMonth: Boolean;
        ProratedBasic: Decimal;
        SalaryVariance: Decimal;
        PayeVariance: Decimal;
        SupposedTaxablePay: Decimal;
        SupposedTaxCharged: Decimal;
        SupposedPaye: Decimal;
        CurrentBasic: Decimal;
        StartDate: Date;
        "prSalary Arrears": Record "prSalary Arrears";
    begin
        "prSalary Arrears".Reset;
        "prSalary Arrears".SetRange("prSalary Arrears"."Employee Code", EmployeeCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Transaction Code", TransCode);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Month", intMonth);
        "prSalary Arrears".SetRange("prSalary Arrears"."Period Year", intYear);
        if "prSalary Arrears".Find('-') = false then begin
            "prSalary Arrears".Init;
            "prSalary Arrears"."Employee Code" := EmployeeCode;
            "prSalary Arrears"."Transaction Code" := TransCode;
            "prSalary Arrears"."Start Date" := OrigStartDate;
            "prSalary Arrears"."End Date" := EndDate;
            "prSalary Arrears"."Salary Arrears" := SalaryArrears;
            "prSalary Arrears"."PAYE Arrears" := PayeArrears;
            "prSalary Arrears"."Period Month" := intMonth;
            "prSalary Arrears"."Period Year" := intYear;
            "prSalary Arrears"."Payroll Period" := payperiod;
            "prSalary Arrears".Insert;
        end
    end;

    [Scope('OnPrem')]
    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2DMY(CurrPeriod, 2);
        intYear := Date2DMY(CurrPeriod, 3);

        curLoanInt := 0;



        if InterestRate > 0 then begin
            if RecoveryMethod = RecoveryMethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = RecoveryMethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = RecoveryMethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;
        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := Round(curLoanInt, 1);
    end;

    [Scope('OnPrem')]
    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "prEmployer Deductions";
    begin

        if curAmount = 0 then exit;
        with prEmployerDeductions do begin
            Init;
            "Employee Code" := EmpCode;
            "Transaction Code" := TCode;
            Amount := curAmount;
            "Period Month" := Month;
            "Period Year" := Year;
            "Payroll Period" := dtOpenPeriod;
            Insert;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnDisplayFrmlValues(EmpCode: Code[30]; intMonth: Integer; intYear: Integer; Formula: Text[50]) curTransAmount: Decimal
    var
        pureformula: Text[50];
    begin
        pureformula := fnPureFormula(EmpCode, intMonth, intYear, Formula);
        curTransAmount := fnFormulaResult(pureformula); //Get the calculated amount
    end;

    [Scope('OnPrem')]
    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date; ReffNo: Code[20])
    var
        prEmployeeTrans: Record "prEmployee Transactions";
    begin
        if Employee.Get(EmpCode) then begin
            if (Date2DMY(Employee."Date Of Join", 2) = Month) and (Date2DMY(Employee."Date Of Join", 3) = Year) then begin
                if Trans.Get(TransCode) then begin
                    if Trans."Is Formula" = false then
                        exit;

                end;
            end;
        end;

        if ProrateAbsence = true then begin
            if DayAbsent > 0 then begin
                if Trans.Get(TransCode) then begin
                    if Trans."Is Formula" = false then
                        exit;

                end;
            end;
        end;




        prEmployeeTrans.Reset;
        prEmployeeTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No");
        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", EmpCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", TransCode);
        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", PayrollPeriod);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Month", Month);
        prEmployeeTrans.SetRange(prEmployeeTrans."Period Year", Year);
        prEmployeeTrans.SetRange(prEmployeeTrans."Reference No", ReffNo);
        if prEmployeeTrans.Find('-') then begin
            prEmployeeTrans.Amount := Amount;
            prEmployeeTrans.Modify;
        end;
    end;

    [Scope('OnPrem')]
    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "HR-Employee";
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then begin
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being
                /*
                PostingGroup.TESTFIELD("Salary Account");
                PostingGroup.TESTFIELD("Income Tax Account");
                PostingGroup.TESTFIELD("Net Salary Payable");
                PostingGroup.TESTFIELD("SSF Employer Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                */
                TaxAccount := PostingGroup."Income Tax Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
                SusPensAccount := PostingGroup."Suspense Account";
            end;
        end;
        //End Get Payroll Posting Accounts

    end;

    [Scope('OnPrem')]
    procedure fnInsertTrans(prAssignLoan: Record prAssignEmployeeLoan)
    var
        prEmployeeTrans: Record "prEmployee Transactions";
    begin

        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", prAssignLoan."Employee Code");
        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", prAssignLoan."Transaction Code");
        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", prAssignLoan."Payroll Period");
        if not prEmployeeTrans.FindFirst then begin
            prEmployeeTrans.Init;
            prEmployeeTrans.TransferFields(prAssignLoan);
            prEmployeeTrans.Insert;
        end
    end;

    local procedure CalcMonthlyRelief(GrossPay: Decimal; PenAmt: Decimal; NHFAmt: Decimal; AvcAmt: Decimal) MonthlyRelief: Decimal
    var
        PercentGross_Pen_NHF_AVC: Decimal;
        VitalSetupRec: Record "prVital Setup Info";
        TaxRelief_Value: Decimal;
        T2hOr1PercentGP: Decimal;
        T2hOr1PercentGP_Permonth: Decimal;
    begin
        VitalSetupRec.Reset;
        TaxRelief_Value := VitalSetupRec."Tax Relief";
        if ((GrossPay * 12) * 0.01) > TaxRelief_Value then begin
            T2hOr1PercentGP := (GrossPay * 12);
        end else
            if ((GrossPay * 12) * 0.01) < TaxRelief_Value then begin
                T2hOr1PercentGP := TaxRelief_Value;
            end;
        T2hOr1PercentGP_Permonth := (T2hOr1PercentGP / 12);


        PercentGross_Pen_NHF_AVC := 0.2 * (GrossPay - PenAmt - NHFAmt - AvcAmt);
        MonthlyRelief := PercentGross_Pen_NHF_AVC + T2hOr1PercentGP_Permonth;
    end;

    [Scope('OnPrem')]
    procedure NewfnProcesspayroll()
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "prSalary Arrears";
        prEmployeeTransactions: Record "prEmployee Transactions";
        prTransactionCodes: Record "prTransaction Codes";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "prUnused Relief";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "prEmployer Deductions";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        prVital: Record "prVital Setup Info";
        prSalaryCard: Record "prSalary Card";
        curBasicPay: Decimal;
        SelectedPeriod: Date;
        dtOpenPeriod: Date;
        blnGetsPAYERelief: Boolean;
        EmployeeRec: Record "HR-Employee";
        ProgressWindow: Dialog;
        VitalInfo: Record "prVital Setup Info";
        RemFromMonthlyGross: decimal;//Lateef 02052022
        PorateLeavAmt: Decimal;//Lateef 26092022
        NoMonthWorked: Integer;//Lateef 26092022
        TaxOnIcnc: Decimal;//Lateef 10112022
        TaxOnAllow: Decimal;//Lateef 10112022
        TaxOnOthers: Decimal;//Lateef 10112022
        PeriodTranx: Record "prPeriod Transactions";//Lateef 10112022
        RBSGpay: decimal;//Lateef 10112022
        RBSPAYE: Decimal;//Lateef 10112022
        RBSTAXRATE: DECIMAL;//Lateef 10112022
        RBSExtraTax: decimal; //Lateef 10112022;
        prTransactionCodesTax: Record "prTransaction Codes";//Lateef 23112022
    begin
        //Initialize
        fnInitialize;
        VitalInfo.Get;
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            dtOpenPeriod := objPeriod."Date Opened";
        end;


        prPeriodTransactions.Reset;
        prPeriodTransactions.SetFilter(prPeriodTransactions."Payroll Period", '%1', SelectedPeriod);
        if prPeriodTransactions.Find('-') then
            prPeriodTransactions.DeleteAll;


        prEmployerDeductions.Reset;
        prEmployerDeductions.SetFilter(prEmployerDeductions."Payroll Period", '%1', SelectedPeriod);
        if prEmployerDeductions.Find('-') then
            prEmployerDeductions.DeleteAll;

        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
        EmployeeRec.Reset;
        EmployeeRec.SetFilter(EmployeeRec.Status, '%1', EmployeeRec.Status::Normal);
        if EmployeeRec.FindFirst then
            repeat
                TaxOnIcnc := 0;//Lateef 10112022
                TaxOnAllow := 0;//Lateef 10112022
                TaxOnOthers := 0;//Lateef 10112022
                RBSGPAY := 0;//Lateef 10112022
                RBSPAYE := 0;//Lateef 10112022
                RBSTAXRATE := 0;//Lateef 10112022
                RBSExtraTax := 0;//Lateef 10112022
                SalCard.Get(EmployeeRec."No.");
                if not SalCard."Suspend Pay" then begin
                    //ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                    ProgressWindow.Update(1, EmployeeRec."No.");
                    EmployeeRec.TestField(EmployeeRec."Date Of Join");
                    //PKK Check NHF Age
                    if (EmployeeRec."Date Of Birth" <> 0D) then begin
                        if CalcDate(VitalInfo."NHF - Maximum Age", EmployeeRec."Date Of Birth") <> EmployeeRec."Date Of Birth" then begin
                            if CalcDate(VitalInfo."NHF - Maximum Age", EmployeeRec."Date Of Birth") < Today then begin
                                SalCard.Get(EmployeeRec."No.");
                                SalCard."Pays NHF" := false;
                                SalCard.Modify;
                            end;
                        end;
                    end;

                    fnGetJournalDet(EmployeeRec."No.");

                    //Cyrus Added
                    NonTaxable := 0;
                    curBasicPay := 0;

                    SalCard.Reset;
                    SalCard.SetFilter(SalCard."Employee Code", EmployeeRec."No.");
                    if SalCard.Find('-') then begin
                        NonTaxable := SalCard."Non Taxable";
                        curBasicPay := SalCard."Basic Pay";
                    end;
                    //Cyrus Added

                    //PKK
                    DayAbsent := 0;

                    if ProrateAbsence = true then begin
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Employee Code", EmployeeRec."No.");
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Transaction Code", 'ABS');
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions."Payroll Period", '%1', SelectedPeriod);
                        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month",intMonth);
                        //prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year",intYear);
                        prEmployeeTransactions.SetFilter(prEmployeeTransactions.Suspended, '%1', false);
                        if prEmployeeTransactions.Find('-') then begin
                            DayAbsent := prEmployeeTransactions."No of Units";

                        end;
                    end;
                    //PKK
                    //PayrollType
                    //PayrollType:=PayrollCode;
                    /*
                   DaysWorked:=fnDaysWorked(dtDOE,FALSE);
                   DaysWorked+=DaysWorked+4;
                   MESSAGE('%1..OK',DaysWorked);
                    */
                    //check if the period selected=current period. If not, do NOT run this function
                    if SelectedPeriod <> dtOpenPeriod then exit;
                    intMonth := Date2DMY(SelectedPeriod, 2);
                    intYear := Date2DMY(SelectedPeriod, 3);

                    if curBasicPay > 0 then begin
                        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                        if (Date2DMY(EmployeeRec."Date Of Join", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Join", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                            //CountDaysofMonth:=fnDaysInMonth(dtDOE);
                            objPeriod.Reset;
                            objPeriod.SetCurrentKey(objPeriod."Date Opened");
                            objPeriod.SetFilter(objPeriod.Closed, '%1', false);
                            if objPeriod.FindLast then begin
                                CountDaysofMonth := objPeriod."Total Working Days";
                            end;

                            //MESSAGE('%1',CountDaysofMonth);
                            DaysWorked := fnDaysWorked(EmployeeRec."Date Of Join", false);
                            //DaysWorked+=DaysWorked+4;
                            // MESSAGE('%1..OK',DaysWorked);


                            //PKK
                            i := 0;
                            RemainingDays := 0;
                            ArrearsDays := 0;
                            //PKK

                            //IF DontProrateBPAY = FALSE THEN //PKK
                            //curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay,DaysWorked,CountDaysofMonth);
                        end;

                        //PKK Prorate Absence
                        if (ProrateAbsence = true) and (ProrateAbsBP = true) then begin
                            if (DayAbsent > 0) and (curBasicPay > 0) then begin
                                CountDaysofMonth := fnDaysInMonth(SelectedPeriod);
                                DaysWorked := fnDaysWorked(SelectedPeriod, false);

                                prVital.Get();

                                if ProrateAbsMonthDays = true then
                                    curBasicPay := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curBasicPay, CountDaysofMonth - DayAbsent, CountDaysofMonth)
                                else
                                    curBasicPay := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curBasicPay, prVital."Working Days" - DayAbsent, prVital."Working Days");   //22

                            end;
                        end;
                        //PKK Prorate Absence


                        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                        if EmployeeRec."Date Of Leaving" <> 0D then begin
                            if (Date2DMY(EmployeeRec."Date Of Leaving", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Leaving", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(EmployeeRec."Date Of Leaving");
                                DaysWorked := fnDaysWorked(EmployeeRec."Date Of Leaving", true);
                                curBasicPay := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                            end;
                        end;

                        curTransAmount := curBasicPay;
                        strTransDescription := 'Basic Pay';
                        TGroup := 'BASIC SALARY';
                        TGroupOrder := 1;
                        TSubGroupOrder := 1;
                        NoOfUnits := 0;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'BPAY', TGroup, TGroupOrder,
                        TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code",
                        salariesAcc, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

                        //Salary Arrears
                        prSalaryArrears.Reset;
                        prSalaryArrears.SetRange(prSalaryArrears."Employee Code", EmployeeRec."No.");
                        prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
                        prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
                        if prSalaryArrears.Find('-') then begin
                            repeat
                                curSalaryArrears := prSalaryArrears."Salary Arrears";
                                curPayeArrears := prSalaryArrears."PAYE Arrears";

                                //Insert [Salary Arrears] into period trans [ARREARS]
                                curTransAmount := curSalaryArrears;
                                strTransDescription := 'Salary Arrears';
                                TGroup := 'ARREARS';
                                TGroupOrder := 1;
                                TSubGroupOrder := 2;
                                NoOfUnits := 0;
                                fnUpdatePeriodTrans(EmployeeRec."No.", prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", salariesAcc,
                                  JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none);

                                //Insert [PAYE Arrears] into period trans [PYAR]
                                curTransAmount := curPayeArrears;
                                strTransDescription := 'P.A.Y.E Arrears';
                                TGroup := 'STATUTORIES';
                                TGroupOrder := 7;
                                TSubGroupOrder := 4;
                                NoOfUnits := 0;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                                   strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code",
                                   TaxAccount, JournalPostAs::Debit, JournalPostingType::"G/L Account", '', CoopParameters::none)

                            until prSalaryArrears.Next = 0;
                        end;

                        //Get Earnings
                        currAnnualPay := 0;
                        curNonTaxable := 0;// RBS Lateef 30082021
                        RemFromMonthlyGross := 0; // Lateef 02052022
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", EmployeeRec."No.");
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        if prEmployeeTransactions.Find('-') then begin
                            curTotAllowances := 0;
                            IsCashBenefit := 0;
                            repeat
                                curTransAmount := 0;
                                curTransBalance := 0;
                                strTransDescription := '';
                                strExtractedFrml := '';
                                prTransactionCodes.Reset;
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                                prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                                if prTransactionCodes.Find('-') then begin
                                    //curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';
                                    if prTransactionCodes."Is Formula" then begin
                                        strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, prTransactionCodes.Formula);
                                        curTransAmount := Round(fnFormulaResult(strExtractedFrml)); //Get the calculated amount

                                    end else begin
                                        curTransAmount := prEmployeeTransactions.Amount;
                                    end;
                                    FixedTaxable += curTransAmount;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None then //[0=None, 1=Increasing, 2=Reducing]
                                        curTransBalance := 0;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing then
                                        curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing then
                                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;

                                    //Prorate Allowances Here
                                    //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                                    if (Date2DMY(EmployeeRec."Date Of Join", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Join", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(EmployeeRec."Date Of Join");
                                        DaysWorked := fnDaysWorked(EmployeeRec."Date Of Join", false);
                                        //curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                                        //Leventis Doesnt Prorate Allowances //Cyrus
                                        curTransAmount := prEmployeeTransactions.Amount;
                                    end;

                                    //PKK Added
                                    if prTransactionCodes."Excl. from Proration" = true then
                                        curTransAmount := 0;
                                    //PKK Added
                                    //PKK Prorate absence
                                    if ProrateAbsence = true then begin
                                        if prTransactionCodes."Prorate Absence" = true then begin
                                            if curTransAmount > 0 then begin
                                                if DayAbsent > 0 then begin
                                                    CountDaysofMonth := fnDaysInMonth(SelectedPeriod);
                                                    DaysWorked := fnDaysWorked(SelectedPeriod, false);


                                                    if ProrateAbsMonthDays = true then
                                                        curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, CountDaysofMonth - DayAbsent,
                                                                          CountDaysofMonth)
                                                    else
                                                        curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, 21 - DayAbsent, 21);
                                                end;
                                            end;
                                        end;
                                    end;

                                    //PKK Prorate absence

                                    //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                    if EmployeeRec."Date Of Leaving" <> 0D then begin
                                        if (Date2DMY(EmployeeRec."Date Of Leaving", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Leaving", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                            CountDaysofMonth := fnDaysInMonth(EmployeeRec."Date Of Leaving");
                                            DaysWorked := fnDaysWorked(EmployeeRec."Date Of Leaving", true);
                                            curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                                        end;
                                    end;
                                    // Prorate Allowances Here
                                    //FixedTaxable+=curTransAmount;    //to calculate tax
                                    //Add Non Taxable Here
                                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
                                    prTransactionCodes."Special Transactions"::Ignore) then
                                        curNonTaxable := curNonTaxable + curTransAmount;

                                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                                    prTransactionCodes."Special Transactions"::Ignore) then
                                        curTransAmount := 0;
                                    if prTransactionCodes."Leave Allowance" then
                                        //urTransAmount:=CheckProrateLeave(strEmpCode,prTransactionCodes."Transaction Code",dtOpenPeriod);
                                        Ann_Leave := curTransAmount;
                                    //Annual Leaves
                                    //PKK - Annual Trans
                                    if prTransactionCodes."Annual Pay" = true then
                                        currAnnualPay := currAnnualPay + curTransAmount;
                                    if (prTransactionCodes."Exclude from Monthly Gross") then //Lateef 02052022

                                        RemFromMonthlyGross += curTransAmount; //Lateef 02052022
                                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                                    curTransAmount := curTransAmount;
                                    curTransBalance := curTransBalance;
                                    strTransDescription := prTransactionCodes."Transaction Name";
                                    TGroup := 'ALLOWANCE';
                                    TGroupOrder := 3;
                                    TSubGroupOrder := 0;

                                    //Get the posting Details
                                    JournalPostingType := JournalPostingType::" ";
                                    JournalAcc := '';
                                    if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                            HrEmployee.Get(EmployeeRec."No.");
                                            Customer.Reset;
                                            //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                                            Customer.SetRange(Customer."No.", HrEmployee."No.");
                                            if Customer.Find('-') then begin
                                                JournalAcc := Customer."No.";
                                                JournalPostingType := JournalPostingType::Customer;
                                            end;
                                        end;
                                    end else begin
                                        JournalAcc := prTransactionCodes."GL Account";
                                        JournalPostingType := JournalPostingType::"G/L Account";
                                    end;

                                    //Get is Cash Benefits
                                    if prTransactionCodes."Is Cash" then
                                        IsCashBenefit := IsCashBenefit + curTransAmount;
                                    //End posting Details
                                    NoOfUnits := prEmployeeTransactions."No of Units";
                                    fnUpdatePeriodTrans(EmployeeRec."No.", prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                                    strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                                    prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code", JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                                    prTransactionCodes."coop parameters");

                                end;
                            until prEmployeeTransactions.Next = 0;
                        end;

                        //IF SalCard.GET(strEmpCode) THEN
                        //FixedTaxable:=FixedTaxable + SalCard."Basic Pay";

                        //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
                        // Message('%1',curNonTaxable);
                        // curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears)-curNonTaxable;
                        curGrossPay := 0;
                        GrossExArr := 0;
                        curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears) - curNonTaxable; //RBS
                        GrossExArr := (curBasicPay + curTotAllowances + curSalaryArrears) - curNonTaxable;
                        curTransAmount := curGrossPay;
                        strTransDescription := 'Gross Pay';
                        TGroup := 'GROSS PAY';
                        TGroupOrder := 4;
                        TSubGroupOrder := 0;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount - RemFromMonthlyGross, 0, intMonth,
                         intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::"G/L Account", '', CoopParameters::none);
                        //  curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears); //RBS
                        curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
                        //George
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", EmployeeRec."No.");
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        if prEmployeeTransactions.Find('-') then begin
                            curPassage := 0;
                            repeat
                                prTransactionCodes.Reset;
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                                prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                                prTransactionCodes.SetRange(prTransactionCodes.Passage, true);
                                if prTransactionCodes.Find('-') then begin
                                    curPassage := curGrossPay * prTransactionCodes."Passage %";
                                    strTransDescription := prPeriodTransactions."Transaction Name";
                                    fnUpdatePeriodTrans(EmployeeRec."No.", prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curPassage, 0, intMonth,
                                    intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none);
                                end;
                            until prEmployeeTransactions.Next = 0;
                        end;

                        //PKK - NG Relief
                        /*
                        //Annual Relief
                        IF (((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)) >
                           (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
                        MonthlyReliefAmount:=((curGrossPay*12) * 0.01) + ((curGrossPay*12) * 0.2)
                        ELSE
                        MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12));

                        //Monthly Relief
                        MonthlyReliefAmount:=MonthlyReliefAmount/12;
                        */

                        //<<BLOCKED BY BANJI TO EFFECT THE NEW TAX RELEIF AFFECTING PAYE
                        /* //Annual Relief
                         IF ExcludeNonTaxRelief = TRUE THEN BEGIN
                         IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                            ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)) >
                            (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
                         MonthlyReliefAmount:=((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01)
                                              +  ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.2)
                         ELSE
                         MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*
                                              ((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay)));

                         END ELSE BEGIN
                         IF (((((curGrossPay-(currAnnualPay+curNonTaxable))*12)+currAnnualPay) * 0.01) +
                            ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)) >
                            (curReliefPersonal+((curReliefGrossPerc/100)*(curGrossPay*12))) THEN
                         MonthlyReliefAmount:=((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.01)
                                              +  ((((curGrossPay-currAnnualPay)*12)+currAnnualPay) * 0.2)
                         ELSE
                         MonthlyReliefAmount:=curReliefPersonal+((curReliefGrossPerc/100)*((((curGrossPay-currAnnualPay)*12)+currAnnualPay)));
                         END;
                         */
                        //>>


                        //Monthly Relief
                        //MonthlyReliefAmount:=MonthlyReliefAmount/12;


                        //PKK NG
                        curTaxDeductions := 0;
                        EERelief := 0;
                        strExtractedFrml := '';
                        PenAmt_G := 0;//Lateef
                        Trans.Reset;
                        //Trans.SETRANGE(Trans.Pension,TRUE);
                        Trans.SetRange(Trans."Add to Relief", true);
                        if Trans.Find('-') then begin
                            repeat
                                EmpTrans.Reset;
                                EmpTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                                EmpTrans.SetRange("Employee Code", EmployeeRec."No.");
                                EmpTrans.SetRange(EmpTrans."Transaction Code", Trans."Transaction Code");
                                EmpTrans.SetRange("Period Month", intMonth);
                                EmpTrans.SetRange("Period Year", intYear);
                                EmpTrans.SetRange(Suspended, false);
                                if EmpTrans.Find('-') then begin
                                    repeat
                                        curTaxDeductions := curTaxDeductions + EmpTrans.Amount;

                                        if Trans.Pension then begin
                                            if Trans."Pension EE formula" <> '' then begin
                                                strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, Trans."Pension EE formula");
                                                EERelief := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                                                PenAmt_G := EERelief; //RBS-BANJI
                                                strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, Trans."Is Formula for employer");
                                                ERRelief := fnFormulaResult(strExtractedFrml);
                                            end;

                                        end;

                                    until EmpTrans.Next = 0
                                end;
                            until Trans.Next = 0;
                        end;

                        // AVC BANJI
                        AvcAmt := 0;
                        Trans.Reset;
                        Trans.SetRange(Trans."Voluntary Contribution", true);
                        if Trans.Find('-') then begin
                            repeat
                                EmpTrans.Reset;
                                EmpTrans.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                                EmpTrans.SetRange("Employee Code", EmployeeRec."No.");
                                EmpTrans.SetRange(EmpTrans."Transaction Code", Trans."Transaction Code");
                                EmpTrans.SetRange("Period Month", intMonth);
                                EmpTrans.SetRange("Period Year", intYear);
                                EmpTrans.SetRange(Suspended, false);
                                if EmpTrans.Find('-') then begin
                                    repeat
                                        AvcAmt += EmpTrans.Amount;
                                    until EmpTrans.Next = 0
                                end;
                            until Trans.Next = 0;
                        end;

                        //get lanre's ee
                        //MESSAGE('ok my ee contribution %1',ERRelief);
                        /*
                                    strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                    curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                        */
                        //PKK
                        //Message('%1 Monthly before', MonthlyReliefAmount);
                        //MonthlyReliefAmount:=MonthlyReliefAmount+curTaxDeductions;



                        //MonthlyReliefAmount:=MonthlyReliefAmount+(curTaxDeductions*12) + (EERelief*12)- (ERRelief*12);  //RBS

                        //PKK
                        //Message('%1 Monthly after', MonthlyReliefAmount);
                        //PKKGet the N.H.F amount for the month
                        curNHIF := 0;
                        curNhif_Base_Amount := 0;
                        NHFAmt_G := 0;//Lateef

                        if intNHIF_BasedOn = intNHIF_BasedOn::Gross then //>NHIF calculation can be based on:
                            curNhif_Base_Amount := curGrossPay;
                        if intNHIF_BasedOn = intNHIF_BasedOn::Basic then
                            curNhif_Base_Amount := curBasicPay;
                        if intNHIF_BasedOn = intNHIF_BasedOn::"Taxable Pay" then
                            curNhif_Base_Amount := curTaxablePay;

                        //  if (round(((today - EmployeeRec."Date Of Birth") / 365), 1, '<') <= 60) then begin//Lateef 14112022
                        if SalCard."Pays NHF" then begin
                            curNHIF := curNhif_Base_Amount * curNHFPerc * 0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
                            curTransAmount := curNHIF;
                            NHFAmt_G := curNHIF;   //RBS
                            strTransDescription := 'N.H.F';
                            TGroup := 'STATUTORIES';
                            TGroupOrder := 7;
                            TSubGroupOrder := 2;
                            fnUpdatePeriodTrans(EmployeeRec."No.", 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code",
                             NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);
                        end;
                        //   end;//Lateef 14112022
                        //PKK
                        //MonthlyReliefAmount:=MonthlyReliefAmount+curNHIF;

                        //MonthlyReliefAmount:=MonthlyReliefAmount+(curNHIF*12); //RBS BANJI


                        if (curReliefChild + curReliefDependant) > 0 then
                            MonthlyReliefAmount := MonthlyReliefAmount + ((curReliefChild + curReliefDependant));///12 //PKK-NG


                        //PKK

                        //PKK NG



                        curReliefPersonal := 0;
                        //PKK - NG Relief


                        //Get the NSSF amount
                        if SalCard."Pays NSSF" then
                            curNSSF := curNssfEmployee;
                        curTransAmount := curNSSF;
                        strTransDescription := 'N.S.S.F';
                        TGroup := 'STATUTORIES';
                        TGroupOrder := 7;
                        TSubGroupOrder := 1;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", NSSFEMPyee,
                        JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NSSF);


                        //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
                        curDefinedContrib := curNSSF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
                        curTransAmount := curDefinedContrib;
                        strTransDescription := 'Defined Contributions';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 1;
                        NoOfUnits := 0;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder,
                         strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ",
                         JournalPostingType::" ", '', CoopParameters::none);


                        //Get the Gross taxable amount
                        //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
                        curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;
                        //message('%1',curGrossTaxable);
                        //>If GrossTaxable = 0 Then TheDefinedToPost = 0
                        if curGrossTaxable = 0 then curDefinedContrib := 0;

                        //Personal Relief
                        // if get relief is ticked  - DENNO ADDED
                        if blnGetsPAYERelief then begin
                            curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                            curTransAmount := curReliefPersonal;
                            strTransDescription := 'Personal Relief';
                            TGroup := 'TAX CALCULATIONS';
                            TGroupOrder := 6;
                            TSubGroupOrder := 9;
                            fnUpdatePeriodTrans(EmployeeRec."No.", 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                             CoopParameters::none);
                        end
                        else
                            curReliefPersonal := 0;

                        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        //>Pension Contribution [self] relief
                        curPensionStaff := fnGetSpecialTransAmount(EmployeeRec."No.", intMonth, intYear,
                        SpecialTransType::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
                        if curPensionStaff > 0 then begin
                            if curPensionStaff > curMaxPensionContrib then
                                curTransAmount := curMaxPensionContrib
                            else
                                curTransAmount := curPensionStaff;
                            strTransDescription := 'Pension Relief';
                            TGroup := 'TAX CALCULATIONS';
                            TGroupOrder := 6;
                            TSubGroupOrder := 2;
                            fnUpdatePeriodTrans(EmployeeRec."No.", 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                            CoopParameters::none)
                        end;

                        //if he PAYS paye only*******************I
                        if SalCard."Pays PAYE" and blnGetsPAYERelief then begin
                            //Get Insurance Relief
                            curInsuranceReliefAmount := fnGetSpecialTransAmount(EmployeeRec."No.", intMonth, intYear,
                            SpecialTransType::"Life Insurance", false); //Insurance is 3 on [Special Transaction]
                            if curInsuranceReliefAmount > 0 then begin
                                curTransAmount := curInsuranceReliefAmount;
                                strTransDescription := 'Insurance Relief';
                                TGroup := 'TAX CALCULATIONS';
                                TGroupOrder := 6;
                                TSubGroupOrder := 8;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                                CoopParameters::none);
                            end;

                            //>OOI
                            curOOI := fnGetSpecialTransAmount(EmployeeRec."No.", intMonth, intYear,
                            SpecialTransType::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                            if curOOI > 0 then begin
                                if curOOI <= curOOIMaxMonthlyContrb then
                                    curTransAmount := curOOI
                                else
                                    curTransAmount := curOOIMaxMonthlyContrb;

                                strTransDescription := 'Owner Occupier Interest';
                                TGroup := 'TAX CALCULATIONS';
                                TGroupOrder := 6;
                                TSubGroupOrder := 3;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                                CoopParameters::none);
                            end;

                            //HOSP
                            curHOSP := fnGetSpecialTransAmount(EmployeeRec."No.", intMonth, intYear,
                            SpecialTransType::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                            if curHOSP > 0 then begin
                                if curHOSP <= curReliefMorgage then
                                    curTransAmount := curHOSP
                                else
                                    curTransAmount := curReliefMorgage;

                                strTransDescription := 'Home Ownership Savings Plan';
                                TGroup := 'TAX CALCULATIONS';
                                TGroupOrder := 6;
                                TSubGroupOrder := 4;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                                CoopParameters::none);
                            end;

                            //Enter NonTaxable Amount
                            if curNonTaxable > 0 then begin
                                strTransDescription := 'Other Non-Taxable Benefits';
                                TGroup := 'TAX CALCULATIONS';
                                TGroupOrder := 6;
                                TSubGroupOrder := 5;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                                curNonTaxable, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                                CoopParameters::none);
                            end;

                        end;

                        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        /*
                         //>Company pension, Excess pension, Tax on excess pension
                         curPensionCompany := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear, SpecialTransType::"Defined Contribution",
                         TRUE); //Self contrib Pension is 1 on [Special Transaction]
                         IF curPensionCompany > 0 THEN BEGIN
                             curTransAmount := curPensionCompany;
                             strTransDescription := 'Pension (Company)';
                             //Update the Employer deductions table

                             curExcessPension:= curPensionCompany - curMaxPensionContrib;
                             IF curExcessPension > 0 THEN BEGIN
                                 curTransAmount := curExcessPension;
                                 strTransDescription := 'Excess Pension';
                                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
                                 fnUpdatePeriodTrans (strEmpCode, 'EXCP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                                  intMonth,intYear,'','',SelectedPeriod);

                                 curTaxOnExcessPension := (curRateTaxExPension / 100) * curExcessPension;
                                 curTransAmount := curTaxOnExcessPension;
                                 strTransDescription := 'Tax on ExPension';
                                 TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 6;
                                 fnUpdatePeriodTrans (strEmpCode, 'TXEP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0,
                                  intMonth,intYear,'','',SelectedPeriod);
                             END;
                         END;
                         */
                        /* //RBS-BANJI Calc AVC amount
                          prTransactionCodes.RESET;
                          prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Code",prEmployeeTransactions."Transaction Code");
                          prTransactionCodes.SETRANGE(prTransactionCodes."Transaction Type",prTransactionCodes."Transaction Type"::Deduction);
                          prTransactionCodes.SETRANGE(,TRUE);

                          IF prTransactionCodes.FIND('-') THEN BEGIN
                            //curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';

                            IF prTransactionCodes."Is Formula" THEN BEGIN
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
                                AvcAmt := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                              END
                              END;
                          */


                        LeavePerMonth := (Ann_Leave / 12);
                        //RBS-BANJI
                        T2hOr1PercentGP := 0;
                        TaxRelief_Value := 0;
                        T2hOr1PercentGP_Permonth := 0;
                        VitalSetupRec.Reset;
                        VitalSetupRec.Get;
                        TaxRelief_Value := VitalSetupRec."Tax Relief";
                        /*IF (((GrossExArr)*12)*0.01) >= TaxRelief_Value THEN BEGIN
                           T2hOr1PercentGP:= (((GrossExArr)*12)*0.01);
                          END ELSE
                          IF (((GrossExArr)*12)*0.01) < TaxRelief_Value THEN BEGIN
                            T2hOr1PercentGP := TaxRelief_Value;
                           END;
                           T2hOr1PercentGP_Permonth := (T2hOr1PercentGP/12);
                             */
                        if (((GrossExArr) * 12) * 0.01) >= TaxRelief_Value then
                            T2hOr1PercentGP := (((GrossExArr) * 12) * 0.01)
                        else
                            T2hOr1PercentGP := TaxRelief_Value;
                        T2hOr1PercentGP_Permonth := (T2hOr1PercentGP / 12);
                        PercentGross_Pen_NHF_AVC := 0;
                        // PercentGross_Pen_NHF_AVC := 0.2 * (GrossExArr - PenAmt_G - NHFAmt_G - AvcAmt);
                        PercentGross_Pen_NHF_AVC := 0.2 * (GrossExArr - PenAmt_G - NHFAmt_G);//Lateef 11112022

                        MonthlyReliefAmount := PercentGross_Pen_NHF_AVC + T2hOr1PercentGP_Permonth + AvcAmt + PenAmt_G + NHFAmt_G;
                        curTransAmount := MonthlyReliefAmount;
                        strTransDescription := 'Monthly Relief';
                        TGroup := 'Monthly Relief';
                        TGroupOrder := 8;
                        TSubGroupOrder := 7;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'MonthRF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                         CoopParameters::none);
                        //RBS-BANJI

                        //MESSAGE('%1',MonthlyReliefAmount);

                        //Get the Taxable amount for calculation of PAYE
                        //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)
                        //1
                        //curGrossTaxable+=curNonTaxable;

                        //Add HOSP and MORTGAGE KIM{}
                        //VitalSetup.RESET;
                        curTaxablePay := 0;//RBS LATEEF 22072021
                        if (curPensionStaff + curDefinedContrib) > curMaxPensionContrib then
                            //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curMaxPensionContrib+curOOI+curHOSP+curNonTaxable+NonTaxable) //RBS
                            //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curOOI+curHOSP+curNonTaxable+NonTaxable)  //RBS
                            curTaxablePay := curGrossTaxable - (curSalaryArrears + MonthlyReliefAmount + curOOI + curHOSP + curNonTaxable + NonTaxable) //RBS BANJI
                        else

                            //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curDefinedContrib +curPensionStaff+curOOI+curHOSP+curNonTaxable+NonTaxable); //RBS
                            curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + MonthlyReliefAmount + curOOI + curHOSP + curNonTaxable + NonTaxable); //RBS
                                                                                                                                                                             //curTaxablePay:= curGrossTaxable - (curSalaryArrears + curOOI+curHOSP+curNonTaxable+NonTaxable);   //RBS
                        curTransAmount := curTaxablePay;
                        strTransDescription := 'Taxable Pay';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 6;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                         CoopParameters::none);

                        /*
                        VitalSetupS.RESET;
                        VitalSetupS.SETRANGE(VitalSetupS."Medical Scheme No.",'321456');
                        IF VitalSetupS.COUNT <> 4 THEN BEGIN
                        ERROR(Text021);
                        END;
                        */


                        //Get the Tax charged for the month
                        //PKK- NG
                        //curTaxCharged := fnGetEmployeePaye(curTaxablePay);

                        //PKKcurTaxCharged := fnGetEmployeePaye(curTaxablePay-(MonthlyReliefAmount));

                        //PKK
                        //RBS-BANJI



                        statTaxPay := curTaxablePay;
                        //curTaxablePay:=((curTaxablePay-currAnnualPay)*12)+currAnnualPay;
                        curTaxablePay2 := ((curTaxablePay - currAnnualPay) * 12) + currAnnualPay;  //RBS LATEEF 22072021
                                                                                                   //IF (curTaxablePay-MonthlyReliefAmount) < 300000 THEN //PKK Tax for those earning less than 300000
                                                                                                   //curTaxCharged := (curTaxablePay-MonthlyReliefAmount) * 0.01
                                                                                                   //ELSE
                                                                                                   // curTaxCharged := fnGetEmployeePaye(curTaxablePay2); //RBS BANJI -(MonthlyReliefAmount));
                                                                                                   //MESSAGE('%1',(curTaxablePay-(MonthlyReliefAmount)-(VitalSetup."Tax Relief")));
                        curTaxCharged := fnGetEmployeePaye(curTaxablePay);//Lateef 11112022
                                                                          // if curTaxCharged <> 0 then
                                                                          // curTaxCharged := curTaxCharged / 12;

                        curTaxablePay := statTaxPay;
                        //PKK

                        //PKK - Relief before tax computation
                        /*
                        IF (curReliefChild+curReliefDependant) > 0 THEN
                        curTaxCharged := curTaxCharged - ((curReliefChild+curReliefDependant)/12); //PKK-NG
                        */
                        //PKK - Relief before tax computation

                        //PKK-NG ADDED
                        if (curGrossPay * 0.01) > curTaxCharged then
                            curTaxCharged := (curGrossPay * 0.01);
                        //PKK-NG ADDED
                        //PKK- NG
                        curTransAmount := curTaxCharged;
                        strTransDescription := 'Tax Charged';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 7;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ", JournalPostingType::" ", '',
                        CoopParameters::none);
                        //Get the Net PAYE amount to post for the month
                        if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                            curPAYE := curTaxCharged - curMaximumRelief
                        else
                            curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);

                        if not SalCard."Pays PAYE" then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
                        curTransAmount := curPAYE;
                        if curPAYE < 0 then curTransAmount := 0;
                        strTransDescription := 'P.A.Y.E';
                        TGroup := 'STATUTORIES';
                        TGroupOrder := 7;
                        TSubGroupOrder := 3;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", TaxAccount, JournalPostAs::Credit,
                         JournalPostingType::"G/L Account", '', CoopParameters::none);


                        if prSalaryCard.Get(EmployeeRec."No.") then begin
                            if prSalaryCard."Pays PAYE" then begin
                                //PAYE
                                PayeTillDate := 0;
                                PeriodTrans.Reset;
                                PeriodTrans.SetCurrentKey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                                PeriodTrans."Group Order", PeriodTrans."Sub Group Order", PeriodTrans."Payslip Order");
                                PeriodTrans.SetFilter(PeriodTrans."Employee Code", EmployeeRec."No.");
                                //PeriodTrans.SETRANGE(PeriodTrans."Employee Code",strEmpCode);
                                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", '%1|%2', 'PAYE', 'PAYE-CALC');
                                if PeriodTrans.Find('-') then begin
                                    repeat
                                        if PeriodTrans."Period Year" <> 2015 then
                                            PayeTillDate += PeriodTrans.Amount;

                                    until PeriodTrans.Next = 0;
                                    //PayeTillDate+=curPAYE
                                end;

                                //MESSAGE('%1',PayeTillDate);
                                if PayeTillDate = 0 then
                                    curTransAmount := curPAYE
                                else
                                    curTransAmount := PayeTillDate;
                                //MESSAGE('%1..%2',curTransAmount);

                                strTransDescription := 'Tax Paid To Date';
                                TGroup := 'STATUTORIES';
                                TGroupOrder := 7;
                                TSubGroupOrder := 5;
                                fnUpdatePeriodTrans(EmployeeRec."No.", 'TOT-PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code", '', JournalPostAs::" ",
                                 JournalPostingType::" ", '', CoopParameters::none);
                            end;
                        end;


                        //Store the unused relief for the current month
                        //>If Paye<0 then "Insert into tblprUNUSEDRELIEF
                        if curPAYE < 0 then begin
                            prUnusedRelief.Reset;
                            prUnusedRelief.SetRange(prUnusedRelief."Employee Code", EmployeeRec."No.");
                            prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                            prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                            if prUnusedRelief.Find('-') then
                                prUnusedRelief.Delete;

                            prUnusedRelief.Reset;
                            with prUnusedRelief do begin
                                Init;
                                "Employee Code" := EmployeeRec."No.";
                                "Unused Relief" := curPAYE;
                                "Period Month" := intMonth;
                                "Period Year" := intYear;
                                Insert;

                                curPAYE := 0;
                            end;
                        end;

                        //Deductions: get all deductions for the month
                        //Loans: calc loan deduction amount, interest, fringe benefit (employer deduction), loan balance
                        //>Balance = (Openning Bal + Deduction)...//Increasing balance
                        //>Balance = (Openning Bal - Deduction)...//Reducing balance
                        //>NB: some transactions (e.g Sacco shares) can be made by cheque or cash. Allow user to edit the outstanding balance


                        //Get the N.H.F amount for the month GBT //PKK
                        /*
                        curNhif_Base_Amount :=0;

                        IF intNHIF_BasedOn =intNHIF_BasedOn::Gross THEN //>NHIF calculation can be based on:
                                curNhif_Base_Amount := curGrossPay;
                        IF intNHIF_BasedOn = intNHIF_BasedOn::Basic THEN
                               curNhif_Base_Amount := curBasicPay;
                        IF intNHIF_BasedOn =intNHIF_BasedOn::"Taxable Pay" THEN
                               curNhif_Base_Amount := curTaxablePay;


                        IF blnPaysNhif THEN BEGIN
                         curNHIF:=curNhif_Base_Amount*curNHFPerc*0.01;//fnGetEmployeeNHIF(curNhif_Base_Amount);
                         curTransAmount := curNHIF;

                         strTransDescription := 'N.H.F';
                         TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 2;
                         fnUpdatePeriodTrans (strEmpCode, 'NHF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                          curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
                          NHIFEMPyee,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',CoopParameters::none);
                        END;
                        */
                        //PKK

                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", EmployeeRec."No.");
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        if prEmployeeTransactions.Find('-') then begin
                            curTotalDeductions := 0;
                            repeat
                                EmployerAmount := 0; //PKK
                                EmployerBalance := 0; //PKK

                                prTransactionCodes.Reset;
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Deduction);
                                prTransactionCodes.SetRange(prTransactionCodes."Non-Transactional", false);
                                if prTransactionCodes.Find('-') then begin
                                    curTransAmount := 0;
                                    curTransBalance := 0;
                                    strTransDescription := '';
                                    strExtractedFrml := '';

                                    if prTransactionCodes."Is Formula" then begin
                                        strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, prTransactionCodes.Formula);
                                        curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                                    end else begin
                                        curTransAmount := prEmployeeTransactions.Amount;
                                    end;

                                    //PKK EMPLOYER TRANSACTION
                                    EmployerAmount := 0;
                                    EmployerBalance := 0;

                                    if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                                        if prTransactionCodes."Is Formula for employer" <> '' then begin
                                            strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                            EmployerAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount


                                            prEmployeeTransactions."Employer Amount" := EmployerAmount;
                                            prEmployeeTransactions.Modify;

                                            EmployerBalance := prEmployeeTransactions."Employer Balance" + EmployerAmount;

                                        end else begin
                                            EmployerAmount := prEmployeeTransactions."Employer Amount";

                                            prEmployeeTransactions."Employer Amount" := EmployerAmount;
                                            prEmployeeTransactions.Modify;

                                            EmployerBalance := prEmployeeTransactions."Employer Balance" + EmployerAmount;

                                        end;
                                    end;

                                    //PKK EMPLOYER TRANSACTION

                                    //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Life Insurance")
                                      and (prTransactionCodes."Deduct Premium" = false) then begin
                                        curTransAmount := 0;
                                    end;

                                    //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::Morgage)
                                     and (prTransactionCodes."Deduct Mortgage" = false) then begin
                                        curTransAmount := 0;
                                    end;




                                    //Get the posting Details
                                    JournalPostingType := JournalPostingType::" ";
                                    JournalAcc := '';
                                    if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                            Customer.Reset;
                                            HrEmployee.Get(EmployeeRec."No.");
                                            Customer.Reset;
                                            //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                                            //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                                            //IF prTransactionCodes.CustomerPostingGroup <>'' THEN
                                            //Customer.SETRANGE(Customer."Customer Posting Group",prTransactionCodes.CustomerPostingGroup);

                                            //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                                            Customer.SetRange(Customer."No.", HrEmployee."No.");
                                            if Customer.Find('-') then begin
                                                JournalAcc := Customer."No.";
                                                JournalPostingType := JournalPostingType::Customer;
                                            end;
                                        end;
                                    end else begin
                                        JournalAcc := prTransactionCodes."GL Account";
                                        JournalPostingType := JournalPostingType::"G/L Account";
                                    end;

                                    //End posting Details


                                    //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") and
                                       (prTransactionCodes."Repayment Method" = prTransactionCodes."Repayment Method"::Amortized) then begin
                                        curTransAmount := 0;
                                        curLoanInt := 0;
                                        curLoanInt := fnCalcLoanInterest(EmployeeRec."No.", prEmployeeTransactions."Transaction Code",
                                        prTransactionCodes."Nominal Interest Rate", prTransactionCodes."Repayment Method",
                                           prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                                        //Post the Interest
                                        if (curLoanInt <> 0) then begin
                                            curTransAmount := curLoanInt;
                                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                            curTransBalance := 0;
                                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                            TGroup := 'DEDUCTIONS';
                                            TGroupOrder := 8;
                                            TSubGroupOrder := 1;
                                            NoOfUnits := prEmployeeTransactions."No of Units";
                                            fnUpdatePeriodTrans(EmployeeRec."No.", strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                                              JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                              CoopParameters::"loan Interest")
                                        end;
                                        //Get the Principal Amt
                                        curTransAmount := prEmployeeTransactions."Amortized Loan Total Repay Amt" - curLoanInt;
                                        //Modify PREmployeeTransaction Table
                                        prEmployeeTransactions.Amount := curTransAmount;
                                        prEmployeeTransactions.Modify;
                                    end;
                                    //Loan Calculation Amortized

                                    case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                                        prTransactionCodes."Balance Type"::None:
                                            curTransBalance := 0;
                                        prTransactionCodes."Balance Type"::Increasing:
                                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                        prTransactionCodes."Balance Type"::Reducing:
                                            begin
                                                //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                                if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                                    curTransAmount := prEmployeeTransactions.Balance;
                                                    curTransBalance := 0;
                                                end else begin
                                                    curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                                end;
                                                if curTransBalance < 0 then begin
                                                    curTransAmount := 0;
                                                    curTransBalance := 0;
                                                end;
                                            end
                                    end;

                                    if (not prTransactionCodes."Exclude from Monthly Gross") then //Lateef 02052022
                                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                    curTransAmount := curTransAmount;
                                    curTransBalance := curTransBalance;
                                    strTransDescription := prTransactionCodes."Transaction Name";

                                    if (prTransactionCodes."Transaction Category" = prTransactionCodes."Transaction Category"::Pension) then  //Denno this is to take pension to be a statutory
                                    begin
                                        TGroup := 'STATUTORIES';
                                        TGroupOrder := 7;
                                        TSubGroupOrder := 4;
                                    end else begin
                                        TGroup := 'DEDUCTIONS';
                                        TGroupOrder := 8;
                                        TSubGroupOrder := 0;
                                    end;

                                    fnUpdatePeriodTrans(EmployeeRec."No.", prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                                     strTransDescription, curTransAmount, curTransBalance, intMonth,
                                     intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                                     JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                     prTransactionCodes."coop parameters");

                                    //Check if transaction is loan. Get the Interest on the loan & post it at this point before moving next ****Loan Calculation
                                    if (prTransactionCodes."Special Transactions" = prTransactionCodes."Special Transactions"::"Staff Loan") and
                                       (prTransactionCodes."Repayment Method" <> prTransactionCodes."Repayment Method"::Amortized) then begin

                                        curLoanInt := fnCalcLoanInterest(EmployeeRec."No.", prEmployeeTransactions."Transaction Code",
                                       prTransactionCodes."Nominal Interest Rate",
                                        prTransactionCodes."Repayment Method", prEmployeeTransactions."Original Amount",
                                        prEmployeeTransactions.Balance, SelectedPeriod, prTransactionCodes.Welfare);
                                        if curLoanInt > 0 then begin
                                            curTransAmount := curLoanInt;
                                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                                            curTransBalance := 0;
                                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                                            TGroup := 'DEDUCTIONS';
                                            TGroupOrder := 8;
                                            TSubGroupOrder := 1;
                                            NoOfUnits := prEmployeeTransactions."No of Units";
                                            fnUpdatePeriodTrans(EmployeeRec."No.", strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                                              JournalAcc, JournalPostAs::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                              CoopParameters::"loan Interest")
                                        end;
                                    end;
                                    //End Loan transaction calculation
                                    //Fringe Benefits and Low interest Benefits
                                    if prTransactionCodes."Fringe Benefit" = true then begin
                                        if prTransactionCodes."Nominal Interest Rate" < curLoanMarketRate then begin
                                            fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Nominal Interest Rate") * curLoanCorpRate) / 1200)
                                             * prEmployeeTransactions.Balance;
                                        end;
                                    end else begin
                                        fnCalcFringeBenefit := 0;
                                    end;
                                    if fnCalcFringeBenefit > 0 then begin
                                        fnUpdateEmployerDeductions(EmployeeRec."No.", prEmployeeTransactions."Transaction Code" + '-FRG',
                                        'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                                          prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                                    end;
                                    //End Fringe Benefits

                                    //Create Employer Deduction
                                    EmployerAmount := 0;
                                    EmployerBalance := 0;
                                    if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                                        if prTransactionCodes."Is Formula for employer" <> '' then begin
                                            strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, prTransactionCodes."Is Formula for employer");
                                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                                        end else begin
                                            curTransAmount := prEmployeeTransactions."Employer Amount";

                                        end;
                                        if curTransAmount > 0 then
                                            fnUpdateEmployerDeductions(EmployeeRec."No.", prEmployeeTransactions."Transaction Code",
                                             'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);



                                        fnUpdatePeriodTrans(EmployeeRec."No.", 'PENSNORM', TGroup, TGroupOrder, TSubGroupOrder,
                                         'Pension ER', curTransAmount, curTransBalance, intMonth,
                                         intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                                         '', 0, JournalPostingType, prEmployeeTransactions."Loan Number",
                                         prTransactionCodes."coop parameters");

                                        fnUpdatePeriodTrans(EmployeeRec."No.", 'PENSNOR', TGroup, TGroupOrder, TSubGroupOrder,
                                         'Pension EE', EERelief, curTransBalance, intMonth,
                                         intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                                         '', 0, JournalPostingType, prEmployeeTransactions."Loan Number",
                                         prTransactionCodes."coop parameters");



                                    end;
                                    //Employer deductions

                                end;

                            until prEmployeeTransactions.Next = 0;
                            //GET TOTAL DEDUCTIONS
                            //PKK ADD NHF to TOTAL DEDUCTIONS
                            //curTotalDeductions:=curTotalDeductions+curNHIF;
                            //Message('%1...%2',curNHIF,CurPaye,CurPen);
                            TotDed := 0;
                            TotDed := curTotalDeductions + curNHIF + curPAYE;
                            curTransBalance := 0;
                            strTransCode := 'TOT-DED';
                            strTransDescription := 'TOTAL DEDUCTION';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 9;
                            NoOfUnits := prEmployeeTransactions."No of Units";
                            fnUpdatePeriodTrans(EmployeeRec."No.", strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, TotDed, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code",
                              '', JournalPostAs::" ", JournalPostingType::" ", '', CoopParameters::none);

                            EmployerAmount := 0; //PKK
                            EmployerBalance := 0; //PKK

                            //END GET TOTAL DEDUCTIONS
                        end;

                        //Net Pay: calculate the Net pay for the month in the following manner:
                        //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
                        //...Tot Deductions also include (SumLoan + SumInterest)
                        // curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions+IsCashBenefit)-curNonTaxable;
                        curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions + IsCashBenefit);//+curNonTaxable;  //RBS
                                                                                                                                       //>Nett = Nett - curExcessPension
                                                                                                                                       //...Excess pension is only used for tax. Staff is not paid the amount hence substract it
                        curNetPay := curNetPay; //- curExcessPension

                        //>Nett = Nett - cSumEmployerDeductions
                        //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
                        curNetPay := curNetPay - curTotCompanyDed; //******Get Company Deduction*****

                        curNetRnd_Effect := curNetPay - Round(curNetPay);
                        curTransAmount := curNetPay;
                        strTransDescription := 'Net Pay';
                        TGroup := 'NET PAY';
                        TGroupOrder := 9;
                        TSubGroupOrder := 0;
                        NoOfUnits := 0;
                        fnUpdatePeriodTrans(EmployeeRec."No.", 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                        curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, EmployeeRec."Department Code",
                        PayablesAcc, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::none);

                        //>>RBS Lateef 23062022 LEAVE Z
                        currAnnualPay := 0;
                        curNonTaxable := 0;// RBS Lateef 30082021
                        RemFromMonthlyGross := 0; // Lateef 02052022
                        prEmployeeTransactions.Reset;
                        prEmployeeTransactions.SetCurrentKey("Employee Code", "Transaction Code", "Period Month", "Period Year", Suspended);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Employee Code", EmployeeRec."No.");
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);
                        prEmployeeTransactions.SetRange(prEmployeeTransactions."Transaction Code", 'LEAVE Z');
                        if prEmployeeTransactions.Find('-') then begin
                            curTotAllowances := 0;
                            IsCashBenefit := 0;
                            repeat
                                curTransAmount := 0;
                                curTransBalance := 0;
                                strTransDescription := '';
                                strExtractedFrml := '';
                                prTransactionCodes.Reset;
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                                prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."Transaction Type"::Income);
                                prTransactionCodes.SetRange(prTransactionCodes."Special Transactions", prTransactionCodes."Special Transactions"::Ignore);
                                if prTransactionCodes.Find('-') then begin
                                    //curTransAmount:=0; curTransBalance := 0; strTransDescription := ''; strExtractedFrml := '';
                                    if prTransactionCodes."Is Formula" then begin
                                        strExtractedFrml := fnPureFormula(EmployeeRec."No.", intMonth, intYear, prTransactionCodes.Formula);
                                        curTransAmount := Round(fnFormulaResult(strExtractedFrml)); //Get the calculated amount

                                    end else begin
                                        curTransAmount := prEmployeeTransactions.Amount;
                                    end;
                                    /* //>>Porate Leave Allowance RBS Lateef 26092022
                                     if (Date2DMY(EmployeeRec."Date Of Join", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                         if (Date2DMY(EmployeeRec."Date Of Join", 2) <> 1) Then begin
                                             NoMonthWorked := (12 - Date2DMY(EmployeeRec."Date Of Join", 2)) + 1;
                                             PorateLeavAmt := 0;
                                             PorateLeavAmt := curTransAmount / 12;
                                             curTransAmount := Round((PorateLeavAmt * NoMonthWorked), 2);
                                         end;





                                     end;
                                     //<<Porate Leave Allowance RBS Lateef 26092022    */
                                    FixedTaxable += curTransAmount;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::None then //[0=None, 1=Increasing, 2=Reducing]
                                        curTransBalance := 0;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Increasing then
                                        curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                                    if prTransactionCodes."Balance Type" = prTransactionCodes."Balance Type"::Reducing then
                                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;

                                    //Prorate Allowances Here
                                    //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                                    if (Date2DMY(EmployeeRec."Date Of Join", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Join", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                        CountDaysofMonth := fnDaysInMonth(EmployeeRec."Date Of Join");
                                        DaysWorked := fnDaysWorked(EmployeeRec."Date Of Join", false);
                                        //curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount,DaysWorked,CountDaysofMonth)
                                        //Leventis Doesnt Prorate Allowances //Cyrus
                                        curTransAmount := prEmployeeTransactions.Amount;
                                    end;

                                    //PKK Added
                                    if prTransactionCodes."Excl. from Proration" = true then
                                        curTransAmount := 0;
                                    //PKK Added
                                    //PKK Prorate absence
                                    if ProrateAbsence = true then begin
                                        if prTransactionCodes."Prorate Absence" = true then begin
                                            if curTransAmount > 0 then begin
                                                if DayAbsent > 0 then begin
                                                    CountDaysofMonth := fnDaysInMonth(SelectedPeriod);
                                                    DaysWorked := fnDaysWorked(SelectedPeriod, false);


                                                    if ProrateAbsMonthDays = true then
                                                        curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, CountDaysofMonth - DayAbsent,
                                                                          CountDaysofMonth)
                                                    else
                                                        curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, 21 - DayAbsent, 21);
                                                end;
                                            end;
                                        end;
                                    end;

                                    //PKK Prorate absence

                                    //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                                    if EmployeeRec."Date Of Leaving" <> 0D then begin
                                        if (Date2DMY(EmployeeRec."Date Of Leaving", 2) = Date2DMY(dtOpenPeriod, 2)) and (Date2DMY(EmployeeRec."Date Of Leaving", 3) = Date2DMY(dtOpenPeriod, 3)) then begin
                                            CountDaysofMonth := fnDaysInMonth(EmployeeRec."Date Of Leaving");
                                            DaysWorked := fnDaysWorked(EmployeeRec."Date Of Leaving", true);
                                            curTransAmount := fnBasicPayProrated(EmployeeRec."No.", intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                                        end;
                                    end;
                                    // Prorate Allowances Here
                                    //FixedTaxable+=curTransAmount;    //to calculate tax
                                    //Add Non Taxable Here
                                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" =
                                    prTransactionCodes."Special Transactions"::Ignore) then
                                        curNonTaxable := curNonTaxable + curTransAmount;

                                    //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                                    if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transactions" <>
                                    prTransactionCodes."Special Transactions"::Ignore) then
                                        curTransAmount := 0;
                                    if prTransactionCodes."Leave Allowance" then
                                        //urTransAmount:=CheckProrateLeave(strEmpCode,prTransactionCodes."Transaction Code",dtOpenPeriod);
                                        Ann_Leave := curTransAmount;
                                    //Annual Leaves
                                    //PKK - Annual Trans

                                    if prTransactionCodes."Annual Pay" = true then
                                        currAnnualPay := currAnnualPay + curTransAmount;
                                    if (prTransactionCodes."Exclude from Monthly Gross") then //Lateef 02052022

                                        RemFromMonthlyGross += curTransAmount; //Lateef 02052022
                                    curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                                    curTransAmount := curTransAmount;
                                    curTransBalance := curTransBalance;
                                    strTransDescription := prTransactionCodes."Transaction Name";
                                    TGroup := 'ALLOWANCE';
                                    TGroupOrder := 3;
                                    TSubGroupOrder := 0;

                                    //Get the posting Details
                                    JournalPostingType := JournalPostingType::" ";
                                    JournalAcc := '';
                                    if prTransactionCodes.Subledger <> prTransactionCodes.Subledger::" " then begin
                                        if prTransactionCodes.Subledger = prTransactionCodes.Subledger::Customer then begin
                                            HrEmployee.Get(EmployeeRec."No.");
                                            Customer.Reset;
                                            //Customer.SETRANGE(Customer."Payroll/Staff No",HrEmployee."Sacco Staff No");
                                            Customer.SetRange(Customer."No.", HrEmployee."No.");
                                            if Customer.Find('-') then begin
                                                JournalAcc := Customer."No.";
                                                JournalPostingType := JournalPostingType::Customer;
                                            end;
                                        end;
                                    end else begin
                                        JournalAcc := prTransactionCodes."GL Account";
                                        JournalPostingType := JournalPostingType::"G/L Account";
                                    end;

                                    //Get is Cash Benefits
                                    if prTransactionCodes."Is Cash" then
                                        IsCashBenefit := IsCashBenefit + curTransAmount;
                                    //End posting Details
                                    NoOfUnits := prEmployeeTransactions."No of Units";
                                    fnUpdatePeriodTrans(EmployeeRec."No.", prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                                    strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                                    prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code", JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                                    prTransactionCodes."coop parameters");

                                end;
                            until prEmployeeTransactions.Next = 0;
                        end;


                        //<<RBS Lateef 23062022 Leave Z

                        //>>RBS Lateef 10112022 OtherTax
                        PeriodTranx.reset;
                        PeriodTranx.SetFilter("Employee Code", '%1', EmployeeRec."No.");
                        PeriodTranx.SetFilter("Payroll Period", '%1', SelectedPeriod);
                        PeriodTranx.SetFilter("Transaction Code", '%1|%2', 'PAYE', 'GPAY');
                        IF PeriodTranx.FindFirst() then
                            repeat
                                if PeriodTranx."Transaction Code" = 'PAYE' THEN
                                    RBSPAYE := PERIODTRANX.AMOUNT;
                                if PeriodTranx."Transaction Code" = 'GPAY' THEN
                                    RBSGPAY := PERIODTRANX.AMOUNT;
                            until PeriodTranx.next() = 0;
                        if (RBSGpay <> 0) and (RBSPAYE <> 0) then begin
                            RBSTAXRATE := Round(RBSPAYE / rbsgpay, 0.0001);
                            fnUpdatePeriodTrans(EmployeeRec."No.", 'TAX RATE', 'TAX', TGroupOrder, TSubGroupOrder,
                                                                'TAX RATE', RBSTAXRATE, 0, intMonth, intYear, prEmployeeTransactions.Membership,
                                                                prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code", JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                                                                prTransactionCodes."coop parameters");
                        end;
                        if RBSTAXRATE <> 0 then begin
                            prTransactionCodesTax.reset;
                            prTransactionCodesTax.SetFilter("Extra Payee", '%1', True);
                            prTransactionCodesTax.setfilter("Allowance Incetive Formula", '%1', False);
                            if prTransactionCodesTax.findfirst then
                                repeat
                                    PeriodTranx.reset;
                                    PeriodTranx.SetFilter("Employee Code", '%1', EmployeeRec."No.");
                                    PeriodTranx.SetFilter("Payroll Period", '%1', SelectedPeriod);
                                    PeriodTranx.SetFilter("Transaction Code", '%1', prTransactionCodesTax."Transaction Code");
                                    IF PeriodTranx.FindFirst() then
                                        repeat
                                            RBSExtraTax += Round((PeriodTranx.Amount * RBStaxrate), 0.01);
                                        until PeriodTranx.next() = 0;
                                until prTransactionCodesTax.next = 0;

                            prTransactionCodesTax.reset;
                            prTransactionCodesTax.SetFilter("Extra Payee", '%1', True);
                            prTransactionCodesTax.setfilter("Allowance Incetive Formula", '%1', True);
                            if prTransactionCodesTax.findfirst then
                                repeat
                                    PeriodTranx.reset;
                                    PeriodTranx.SetFilter("Employee Code", '%1', EmployeeRec."No.");
                                    PeriodTranx.SetFilter("Payroll Period", '%1', SelectedPeriod);
                                    PeriodTranx.SetFilter("Transaction Code", '%1', prTransactionCodesTax."Transaction Code");
                                    IF PeriodTranx.FindFirst() then
                                        repeat
                                            RBSExtraTax += Round((PeriodTranx.Amount / (1 - rbstaxrate) - PeriodTranx.Amount), 0.01);
                                        until PeriodTranx.next() = 0;
                                until prTransactionCodesTax.next = 0;
                            // RBSExtraTax := TaxOnAllow + TaxOnIcnc + Round((TaxOnOthers * RBStaxrate), 0.01);
                            fnUpdatePeriodTrans(EmployeeRec."No.", 'EXTRA PAYE', 'TAX', TGroupOrder, TSubGroupOrder,
                                                                'EXTRA PAYE', RBSExtraTax, 0, intMonth, intYear, prEmployeeTransactions.Membership,
                                                                prEmployeeTransactions."Reference No", SelectedPeriod, EmployeeRec."Department Code", JournalAcc, JournalPostAs::Debit, JournalPostingType, '',
                                                                prTransactionCodes."coop parameters");
                        end;
                        //<<RBS Lateef 10112022 OtherTax


                        //Rounding Effect: if the Net pay is rounded, take the rounding effect &
                        //save it as an earning for the staff for the next month
                        //>Insert the Netpay rounding effect into the tblRoundingEffect table


                        //Negative pay: if the NetPay<0 then log the entry
                        //>Display an on screen report
                        //>Through a pop-up to the user
                        //>Send an email to the user or manager
                    end;
                end;//skip suspended
            until EmployeeRec.Next = 0;
        ProgressWindow.Close;
        Message('Process Complete');

    end;
}

