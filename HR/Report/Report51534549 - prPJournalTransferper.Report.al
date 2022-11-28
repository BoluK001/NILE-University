report 51534549 "prPJournalTransfer per"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code", "Payroll Type";

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp.Status, HREmp.Status::Normal);
                if HREmp.FindFirst then begin
                    repeat
                        if HREmp.Office = '' then
                            HREmp.FieldError(HREmp.Office);

                        if HREmp."Department Code" = '' then
                            HREmp.FieldError(HREmp."Department Code");

                    until HREmp.Next = 0;
                end;

                LineNumber := 10000;

                /*
                //Create batch*****************************************************************************
                GenJnlBatch.RESET;
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name",'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name,'SALARIES');
                IF GenJnlBatch.FIND ('-')=FALSE THEN
                BEGIN
                 GenJnlBatch.INIT;
                 GenJnlBatch."Journal Template Name":='GENERAL';
                 GenJnlBatch.Name:='SALARIES';
                 GenJnlBatch.INSERT;
                END;
                // End Create Batch
                  */
                if UserSetup.Get(UserId) then begin
                    JTemplate := UserSetup."Journal Template Name";
                    JBatch := UserSetup."Journal Batch Name";
                end;


                // Clear the journal Lines
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", JBatch);
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;

                "Slip/Receipt No" := UpperCase(objPeriod."Period Name");

                //For use when posting Pension and NSSF

                //PostingGroup.GET('PERMANENT');
                //PostingGroup.GET('EXECUTIVE');
                /*//PKK
                PostingGroup.TESTFIELD("SSF Employer Account");
                PostingGroup.TESTFIELD("SSF Employee Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                PostingGroup.TESTFIELD("Pension Employee Acc");
                *///PKK


                ObjDim.SetRange(ObjDim."Dimension Code", 'L. CODE');
                if ObjDim.FindFirst then begin
                    repeat
                        //Get the staff details (header)
                        //TransCode.SETRANGE(TransCode."Transaction Code");
                        //IF TransCode.FIND('-') THEN
                        //BEGIN
                        // REPEAT
                        strEmpName := TransCode."Transaction Code";
                        //GlobalDim1:=ObjDim.Code;
                        //GlobalDim2:=objEmp."Department Code";    //objEmp.Office;
                        //PostingGroup.GET(objEmp."Posting Group");

                        LineNumber := LineNumber + 10;

                        //for Departments
                        ObjDimDept.SetRange(ObjDimDept."Dimension Code", 'BU');
                        if ObjDimDept.FindFirst then begin
                            repeat

                                GlobalDim1 := ObjDim.Code;
                                GlobalDim2 := ObjDimDept.Code;    //objEmp.Office;

                                PeriodTrans.Reset;
                                PeriodTrans.SetCurrentKey(PeriodTrans."Location/Division", PeriodTrans."Transaction Code", PeriodTrans.Department);
                                PeriodTrans.SetRange(PeriodTrans."Location/Division", ObjDim.Code);
                                PeriodTrans.SetRange(PeriodTrans.Department, ObjDimDept.Code);
                                PeriodTrans.SetRange(PeriodTrans."Payroll  Classification", JBatch);
                                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", '<>%1', 'NPAY');
                                PeriodTrans.SetFilter(PeriodTrans."Post As", '%1', PeriodTrans."Post As"::Debit);////////////
                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                if PeriodTrans.Find('-') then begin
                                    repeat
                                        if PeriodTrans."Journal Account Code" <> '' then begin
                                            //AmountToDebit:=0;AmountToCredit:=0;

                                            //IF PeriodTrans."Post As" =PeriodTrans."Post As"::Debit THEN
                                            TotalAmt += PeriodTrans.Amount;

                                            //IF PeriodTrans."Post As" =PeriodTrans."Post As"::Credit THEN
                                            //AmountToCredit+=PeriodTrans.Amount;

                                            if PeriodTrans."Journal Account Type" = 1 then
                                                IntegerPostAs := 0;
                                            if PeriodTrans."Journal Account Type" = 2 then
                                                IntegerPostAs := 1;

                                        end;
                                    until PeriodTrans.Next = 0;
                                    /* CreateJnlEntry(IntegerPostAs,PeriodTrans."Journal Account Code",
                                     GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+ObjDim.Code+'-'+ObjDimDept.Code,AmountToDebit,AmountToCredit,
                                     PeriodTrans."Post As",PeriodTrans."Loan Number",SaccoTransactionType);  //PeriodTrans."Loan Number"
                                     */
                                    CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                    GlobalDim1, GlobalDim2, ObjDim.Code + ' ' + ObjDimDept.Code + ' ' + 'Salary', TotalAmt, 0,
                                    PeriodTrans."Post As"::Debit, PeriodTrans."Loan Number", SaccoTransactionType);

                                    /* CreateJnlEntry(IntegerPostAs,PeriodTrans."Journal Account Code",
                                     GlobalDim1,GlobalDim2,ObjDim.Code+' ' + ObjDimDept.Code + ' ' + 'Salary',0,AmountToCredit,
                                     PeriodTrans."Post As"::Credit,PeriodTrans."Loan Number",SaccoTransactionType);  //PeriodTrans."Loan Number"
                                      */
                                    //PKK
                                    /* IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::NSSF THEN BEGIN
                                        //Credit Payables
                                       //Credit Payables
                                           CreateJnlEntry(0,PostingGroup."SSF Employee Account",
                                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+ObjDim.Code+'-'+ObjDimDept.Code,0,PeriodTrans.Amount,
                                           PeriodTrans."Post As",'',SaccoTransactionType);

                                       //Debit Staff Expense
                                           CreateJnlEntry(0,PostingGroup."SSF Employer Account",
                                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+ObjDim.Code+'-'+ObjDimDept.Code,PeriodTrans.Amount,0,1,'',
                                           SaccoTransactionType);
                                     END;
                                     */

                                    ////////////////////////////////////
                                    HRDeductionAccount.Reset;
                                    HRDeductionAccount.SetCurrentKey(HRDeductionAccount."G/L Account");
                                    HRDeductionAccount.SetRange(HRDeductionAccount."G/L Account");
                                    if HRDeductionAccount.FindFirst then begin
                                        repeat
                                            PeriodTrans.Reset;
                                            PeriodTrans.SetCurrentKey(PeriodTrans."Location/Division", PeriodTrans."Transaction Code", PeriodTrans.Department);
                                            PeriodTrans.SetRange(PeriodTrans."Location/Division", ObjDim.Code);
                                            PeriodTrans.SetRange(PeriodTrans.Department, ObjDimDept.Code);
                                            PeriodTrans.SetRange(PeriodTrans."Payroll  Classification", JBatch);
                                            PeriodTrans.SetRange(PeriodTrans."Journal Account Code", HRDeductionAccount."G/L Account");
                                            PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                            if PeriodTrans.Find('-') then begin
                                                repeat
                                                    if PeriodTrans."Journal Account Code" <> '' then begin
                                                        //AmountToDebit:=0;AmountToCredit:=0;
                                                        //IF PeriodTrans."Post As" =PeriodTrans."Post As"::Credit THEN
                                                        AmountToCredit += PeriodTrans.Amount;
                                                        totalDedAmt += PeriodTrans.Amount;
                                                        if PeriodTrans."Journal Account Type" = 1 then
                                                            IntegerPostAs := 0;
                                                        if PeriodTrans."Journal Account Type" = 2 then
                                                            IntegerPostAs := 1;
                                                        /*IF PeriodTrans."Emp Amount" <> 0 THEN
                                                           ERAmount += PeriodTrans."Emp Amount";*/
                                                    end;
                                                until PeriodTrans.Next = 0;
                                                //IF HRDeductionAccount.NetPay THEN
                                                //AmountToCredit:=TotalAmt+totalDedAmt;

                                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                                GlobalDim1, GlobalDim2, ObjDim.Code + ' ' + ObjDimDept.Code + ' ' + HRDeductionAccount.Code + ' ' + 'Total', 0, AmountToCredit,
                                                PeriodTrans."Post As"::Credit, PeriodTrans."Loan Number", SaccoTransactionType);  //PeriodTrans."Loan Number"
                                            end;
                                            AmountToCredit := 0;
                                        until HRDeductionAccount.Next = 0;
                                        if HRDeductionAccount.NetPay then begin
                                            AmountToCredit := TotalAmt - totalDedAmt;


                                            CreateJnlEntry(IntegerPostAs, HRDeductionAccount."G/L Account",
                                            GlobalDim1, GlobalDim2, ObjDim.Code + ' ' + ObjDimDept.Code + ' ' + HRDeductionAccount.Code + ' ' + 'Total', 0, AmountToCredit,
                                            PeriodTrans."Post As"::Credit, PeriodTrans."Loan Number", SaccoTransactionType);  //PeriodTrans."Loan Number"
                                            totalDedAmt := 0;
                                        end;
                                    end;
                                    /////////////////////////
                                    //PENSION ER
                                    //REPEAT
                                    EmployerDed.Reset;
                                    EmployerDed.SetRange(EmployerDed."Transaction Code", 'PENS');
                                    EmployerDed.SetRange(EmployerDed."Payroll Period", SelectedPeriod);
                                    EmployerDed.SetRange(EmployerDed."Payroll Classification", JBatch);
                                    if EmployerDed.Find('-') then begin

                                        PeriodTrans.Reset;
                                        PeriodTrans.SetCurrentKey(PeriodTrans."Location/Division", PeriodTrans."Transaction Code", PeriodTrans.Department);
                                        PeriodTrans.SetRange(PeriodTrans."Location/Division", ObjDim.Code);
                                        PeriodTrans.SetRange(PeriodTrans.Department, ObjDimDept.Code);
                                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'PENS');
                                        PeriodTrans.SetRange(PeriodTrans."Payroll  Classification", JBatch);
                                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                        if PeriodTrans.Find('-') then begin
                                            if PeriodTrans."Emp Amount" <> 0 then
                                                PeriodTrans.CalcSums(PeriodTrans."Emp Amount");
                                            ERAmount := PeriodTrans."Emp Amount";


                                            if PeriodTrans."Journal Account Type" = 1 then
                                                IntegerPostAs := 0;
                                            if PeriodTrans."Journal Account Type" = 2 then
                                                IntegerPostAs := 1;
                                        end;
                                        //EmployerDed.CALCSUMS(EmployerDed.Amount);
                                        //ERAmount :=EmployerDed.Amount;

                                        // END;

                                        CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                        GlobalDim1, GlobalDim2, ObjDim.Code + ' ' + ObjDimDept.Code + ' ' + 'ER-PENS' + ' ' + 'Total', 0, ERAmount,
                                        PeriodTrans."Post As"::Credit, '', SaccoTransactionType);
                                        //PostingGroup.GET(objEmp."Posting Group");
                                        ERAcctNo := '5002009';
                                        CreateJnlEntry(IntegerPostAs, ERAcctNo,
                                        GlobalDim1, GlobalDim2, ObjDim.Code + ' ' + ObjDimDept.Code + ' ' + 'ER-PENS' + ' ' + 'ER-ACCT', ERAmount, 0,
                                        PeriodTrans."Post As"::Debit, '', SaccoTransactionType);


                                        //UNTIL HRDeductionAccount.NEXT =0;


                                    end;
                                    AmountToDebit := 0;
                                    AmountToCredit := 0;
                                    TotalAmt := 0;
                                end; //stop prtrans
                            until ObjDimDept.Next = 0;
                        end;
                    //UNTIL TransCode.NEXT = 0;
                    //END;
                    until ObjDim.Next = 0;
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        objEmp: Record "HR-Employee";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "prPayroll Periods";
        ControlInfo: Record "Control-Information";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record "prSalary Card";
        TaxableAmount: Decimal;
        PostingGroup: Record "prEmployee Posting Group";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        TransCode: Record "prTransaction Codes";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        EmployerDed: Record "prEmployer Deductions";
        SalCard: Record "HR-Employee";
        ObjDim: Record "Dimension Value";
        ObjDimDept: Record "Dimension Value";
        UserSetup: Record "User Setup";
        JTemplate: Code[20];
        JBatch: Code[20];
        HRDeductionAccount: Record "HR Deduction Account";
        TotalAmt: Decimal;
        totalDedAmt: Decimal;
        HREmp: Record "HR-Employee";
        ERAmount: Decimal;
        ERAcctNo: Code[20];
        EmpDed: Decimal;

    [Scope('OnPrem')]
    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2")
    begin

        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init;
        GeneraljnlLine."Journal Template Name" := JTemplate;
        GeneraljnlLine."Journal Batch Name" := JBatch;
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        //GeneraljnlLine."Loan No":=LoanNo;
        //GeneraljnlLine."Transaction Type":=TransType;
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = PostAs::Debit then begin
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.Validate("Credit Amount");
        end;
        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert;
    end;
}

