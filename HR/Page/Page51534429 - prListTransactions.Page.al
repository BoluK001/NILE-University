page 51534429 "prList Transactions"
{
    Editable = true;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'List Transactions';
    SourceTable = "prEmployee Transactions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;    //jj120422  I added
                    trigger OnValidate()
                    begin
                        blnIsLoan := FALSE;
                        IF objTransCodes.GET("Transaction Code") THEN
                            "Transaction Name" := objTransCodes."Transaction Name";
                        "Payroll Period" := SelectedPeriod;
                        "Period Month" := PeriodMonth;
                        "Period Year" := PeriodYear;
                        IF objTransCodes."Special Transactions" = 8 THEN blnIsLoan := TRUE;

                        /*IF objTransCodes."Is Formula"=TRUE THEN
                        BEGIN
                         empCode:="Employee Code";
                         CLEAR(objOcx);
                         curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes.Formula);
                         Amount:=curTransAmount;
                        END;
                        */
                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;
                        /*
                        IF objTransCodes."Include Employer Deduction"=TRUE THEN
                        BEGIN
                          curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes."Is Formula for employer");
                          "Employer Amount":=curTransAmount;
                        END;
                        */

                    end;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No of Units"; "No of Units")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;  //jj120422 I addede
                    trigger OnValidate()
                    begin
                        IF (blnIsLoan = TRUE) AND (Balance > 0) AND (Amount > 0) THEN BEGIN
                            "No Of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "No Of Repayments" := ROUND("No Of Repayments", 1, '>');
                        END;
                    end;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (blnIsLoan = TRUE) AND (Balance > 0) AND (Amount > 0) THEN BEGIN
                            "No Of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "No Of Repayments" := ROUND("No Of Repayments", 1, '>');
                        END;
                    end;
                }
                field("No Of Repayments"; "No Of Repayments")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF blnIsLoan = TRUE THEN BEGIN
                            "No Of Repayments" := ROUND(Balance / Amount, 1, '>');
                            "No Of Repayments" := ROUND("No Of Repayments", 1, '>');
                        END;
                    end;
                }
                field("Amortized Loan Total Repay Amt"; "Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Employer Amount"; "Employer Amount")
                {
                    ApplicationArea = all;
                }
                field("Employer Balance"; "Employer Balance")
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; "Employee Code")
                {
                    ApplicationArea = all;
                }
                field(Membership; Membership)
                {
                    ApplicationArea = all;
                }
                field("Loan Number"; "Loan Number")
                {
                    ApplicationArea = all;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                }
                field(Suspended; Suspended)
                {
                    ApplicationArea = all;
                }
                field("Stop for Next Period"; "Stop for Next Period")
                {
                    ApplicationArea = all;
                }

                field("Original Amount"; "Original Amount")
                {
                    ApplicationArea = all;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = all;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = all;
                }
                field(integera; integera)
                {
                    ApplicationArea = all;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    ApplicationArea = all;
                }
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Arrears")
            {
                Caption = 'Generate Arrears';
                Image = CalculateRegenerativePlan;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    VitalSetUp.GET();
                    VitalSetUp.TESTFIELD(VitalSetUp."Payroll Cut Off Day");
                    ArreasAmount := 0;
                    TotalEarnings := 0;

                    Employee.RESET;
                    Employee.SETRANGE(Employee."No.", "Employee Code");
                    IF Employee.FIND('-') THEN BEGIN
                        Employee.TESTFIELD(Employee."Date Of Join");

                        //message('%1',SelectedPeriod);
                        IF DATE2DMY(CALCDATE('-1M', SelectedPeriod), 2) <> DATE2DMY(Employee."Date Of Join", 2) THEN
                            ERROR('Date of employment must be last month.');

                        IF DATE2DMY(Employee."Date Of Join", 1) < VitalSetUp."Payroll Cut Off Day" THEN
                            ERROR('Date of employment must be after the cut of date.');

                        IF SalaryCard.GET("Employee Code") THEN BEGIN
                            TotalEarnings := SalaryCard."Basic Pay";
                            SalaryCard.CALCFIELDS("Cumm PAYE");
                            PayeAmount := SalaryCard."Cumm PAYE";

                            //IF DedEmp.GET("Employee Code",SelectedPeriod) THEN BEGIN
                            PeriodTrans.SETRANGE(PeriodTrans."Employee Code", "Employee Code");
                            PeriodTrans.SETRANGE(PeriodTrans."Transaction Code", 'NHF');
                            IF PeriodTrans.FINDFIRST THEN
                                NHFAmt := PeriodTrans.Amount;
                            //PayeAmount:=DedEmp.PAYE;
                            //END;
                            /*
                            EmpTrans.RESET;
                            EmpTrans.SETRANGE(EmpTrans."Employee Code","Employee Code");
                            EmpTrans.SETRANGE(EmpTrans."Payroll Period",SelectedPeriod);
                            IF EmpTrans.FIND('-') THEN BEGIN
                            REPEAT
                            IF objTransCodes.GET(EmpTrans."Transaction Code") THEN BEGIN
                            IF (objTransCodes.Frequency = objTransCodes.Frequency::Fixed) AND
                               (objTransCodes."Transaction Type"= objTransCodes."Transaction Type"::Income) THEN BEGIN
                            TotalEarnings:=TotalEarnings+EmpTrans.Amount;

                            END;
                            END;
                            UNTIL EmpTrans.NEXT = 0;
                            END; */

                            //to look at deductions and income
                            EmpTra.RESET;
                            EmpTra.SETRANGE(EmpTra."Employee Code", "Employee Code");
                            EmpTra.SETRANGE(EmpTra."Payroll Period", SelectedPeriod);
                            IF EmpTra.FIND('-') THEN BEGIN
                                REPEAT
                                    IF objTransCodes.GET(EmpTra."Transaction Code") THEN BEGIN
                                        IF objTransCodes."Transaction Type" = objTransCodes."Transaction Type"::Income THEN
                                            IncAmount += EmpTra.Amount
                                        ELSE
                                            IF objTransCodes."Transaction Type" = objTransCodes."Transaction Type"::Deduction THEN
                                                DedAmt += EmpTra.Amount;

                                        IF objTransCodes.Pension THEN
                                            PenArrears := EmpTra.Amount;
                                    END;

                                UNTIL EmpTra.NEXT = 0;
                                IncAmount := IncAmount + TotalEarnings;
                                IF SalaryCard."Pays NHF" THEN
                                    DedAmt := DedAmt + PayeAmount + NHFAmt
                                ELSE
                                    DedAmt := DedAmt + PayeAmount;
                                //MESSAGE('%1..%2',IncAmount,DedAmt);PenArrears
                                TEarning := IncAmount - DedAmt;
                                TotalEarnings := TEarning;
                                //MESSAGE('%1..%2',TotalEarnings);
                            END;
                        END;
                    END;


                    IF TotalEarnings > 0 THEN BEGIN

                        RemainingDays := (CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Employee."Date Of Join", 2), DATE2DMY(Employee."Date Of Join", 3))))
                                                      - Employee."Date Of Join");
                        TDate := Employee."Date Of Join";

                        REPEAT
                            i := i + 1;
                            IF (DATE2DWY(TDate, 1) <> 6) AND (DATE2DWY(TDate, 1) <> 7) THEN   //exclude weekend
                                ArrearsDays := ArrearsDays + 1;

                            TDate := CALCDATE('1D', TDate);

                        UNTIL i = RemainingDays + 1;

                        //get total working days from period mgt
                        objPeriod.RESET;
                        objPeriod.SETCURRENTKEY(objPeriod."Date Opened");
                        objPeriod.SETRANGE(objPeriod.Closed, TRUE);
                        IF objPeriod.FINDLAST THEN BEGIN
                            NoOfMonthDays := objPeriod."Total Working Days";
                        END;

                        /*//working days in the selected period
                        Jmonth:=CALCDATE('CM',SelectedPeriod);
                        Jmonth:=CALCDATE('-1M',Jmonth);
                        MESSAGE('%1',Jmonth);
                        cnt:=DATE2DMY(Jmonth,1);
                        MonthStart:=DMY2DATE(1,DATE2DMY(Jmonth,2),DATE2DMY(Jmonth,3));
                        REPEAT
                          IF (DATE2DWY(MonthStart,1) <> 6) AND (DATE2DWY(MonthStart,1) <> 7)  THEN   //exclude week
                              NoOfMonthDays:=NoOfMonthDays+1;
                          j+=1;
                          MonthStart:=CALCDATE('1D',MonthStart);
                        UNTIL j=cnt;

                          MESSAGE('%1..ArrearsDays',ArrearsDays);
                          MESSAGE('%1....Working Days',NoOfMonthDays);
                          //MESSAGE('%1....TotalEarnings',TotalEarnings);
                         */

                        //NoOfMonthDays:=VitalSetUp."Working Days";
                        //message('%1',NoOfMonthDays);


                        ArreasAmount := ROUND(TotalEarnings * (ArrearsDays / NoOfMonthDays), 0.01);
                        PenArrears := ROUND(PenArrears * (ArrearsDays / NoOfMonthDays), 0.01);
                    END;

                    //create arrears transaction
                    EmpTrans.INIT;
                    EmpTrans."Employee Code" := "Employee Code";
                    EmpTrans."Period Month" := PeriodMonth;
                    EmpTrans."Period Year" := PeriodYear;
                    EmpTrans."Payroll Period" := SelectedPeriod;
                    TransCode.SETRANGE(TransCode.Arrear, TRUE);
                    IF TransCode.FINDFIRST THEN BEGIN
                        EmpTrans."Transaction Code" := TransCode."Transaction Code";
                        EmpTrans."Transaction Name" := TransCode."Transaction Name";
                        EmpTrans.VALIDATE(EmpTrans."Transaction Code");
                    END;

                    EmpTrans.Amount := ArreasAmount;
                    EmpTrans.INSERT;

                    //insert pen arrears for pensure

                    EmpTrans.RESET;
                    EmpTrans.INIT;
                    EmpTrans."Employee Code" := "Employee Code";
                    EmpTrans."Period Month" := PeriodMonth;
                    EmpTrans."Period Year" := PeriodYear;
                    EmpTrans."Payroll Period" := SelectedPeriod;
                    TransCode.RESET;
                    TransCode.SETRANGE(TransCode."Pensure Arrears", TRUE);
                    IF TransCode.FINDFIRST THEN BEGIN
                        EmpTrans."Transaction Code" := TransCode."Transaction Code";
                        EmpTrans."Transaction Name" := TransCode."Transaction Name";
                        EmpTrans.VALIDATE(EmpTrans."Transaction Code");
                    END;

                    EmpTrans.Amount := PenArrears;
                    EmpTrans.INSERT;

                end;
            }
            action("Arrears Summary")
            {
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    //HREmp.GET("Employee Code");
                    //RESET;
                    HREmp.SETFILTER(HREmp."No.", "Employee Code");
                    REPORT.RUN(51534529, TRUE, TRUE, HREmp);
                    //RESET;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SETFILTER("Payroll Period", FORMAT(objPeriod."Date Opened"));
    end;

    trigger OnInit()
    begin

        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed, FALSE);
        IF objPeriod.FIND('-') THEN BEGIN
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        END;

        //Filter per period  - Dennis
        //SETFILTER("Payroll Period",FORMAT(objPeriod."Date Opened"));
    end;

    trigger OnOpenPage()
    begin
        SETFILTER("Payroll Period", FORMAT(objPeriod."Date Opened"));
    end;

    var
        objTransCodes: Record "prTransaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "prPayroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "prPeriod Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        objOcx: Codeunit prPayrollProcessing;
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        Employee: Record "HR-Employee";
        EmpTrans: Record "prEmployee Transactions";
        VitalSetUp: Record "prVital SetUp Info";
        SalaryCard: Record "prSalary Card";
        TotalEarnings: Decimal;
        ArreasAmount: Decimal;
        ArrearsDays: Integer;
        NoOfMonthDays: Integer;
        i: Integer;
        RemainingDays: Integer;
        TDate: Date;
        TransCode: Record "prTransaction Codes";
        j: Integer;
        JarrDays: Integer;
        Jmonth: Date;
        cnt: Integer;
        MonthStart: Date;
        HREmp: Record "HR-Employee";
        EmpTra: Record "prEmployee Transactions";
        IncAmount: Decimal;
        DedAmt: Decimal;
        PayeAmount: Decimal;
        TEarning: Decimal;
        NHFAmt: Decimal;
        DedEmp: Record "prEmployee P9 Info";
        PenArrears: Decimal;
}

