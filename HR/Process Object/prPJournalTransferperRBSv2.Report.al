/// <summary>
/// Report prPJournalTransferperRBS (ID 51534356).
/// </summary>
report 51534356 prPJournalTransferperRBS
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code", "Payroll Type";

            trigger OnPostDataItem()
            begin
                MESSAGE('Journals Created Successfully');
                WinDlg.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                HREmp.RESET;
                HREmp.SETRANGE(HREmp.Status, HREmp.Status::Normal);
                IF HREmp.FINDFIRST THEN BEGIN
                    REPEAT
                        // IF HREmp."Location/Division Code" = '' THEN
                        //   HREmp.FIELDERROR(HREmp."Location/Division Code");

                        IF HREmp."Department Code" = '' THEN
                            HREmp.FIELDERROR(HREmp."Department Code");

                    UNTIL HREmp.NEXT = 0;
                END;

                LineNumber := 10000;

                /*
                                //Create batch*****************************************************************************
                                GenJnlBatch.RESET;
                                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                                GenJnlBatch.SETRANGE(GenJnlBatch.Name, 'SALARIES');
                                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                                    GenJnlBatch.INIT;
                                    // GenJnlBatch."Journal Template Name" := 'GENERAL';
                                    // GenJnlBatch.Name := 'SALARIES';

                                    JTemplate := 'GENERAL';
                                    JBatch := 'SALARIES';
                                    GenJnlBatch.INSERT;
                                END;
                                // End Create Batch
                */
                IF UserSetup.GET(USERID) THEN BEGIN
                    JTemplate := UserSetup."Journal Template Name";
                    JBatch := UserSetup."Journal Batch Name";
                END;

                //Update Pay element codes
                IF TempPayElementCode.FINDFIRST THEN
                    TempPayElementCode.DELETEALL;
                PeriodTrans.RESET;
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                IF PeriodTrans.FINDFIRST THEN
                    REPEAT
                        IF NOT TempPayElementCode.GET(PeriodTrans."Transaction Code") THEN BEGIN
                            TempPayElementCode.INIT;
                            TempPayElementCode."Pay Element Code" := PeriodTrans."Transaction Code";
                            TempPayElementCode.Description := PeriodTrans."Transaction Name";
                            TempPayElementCode."G/L Code" := PeriodTrans."Journal Account Code";
                            TempPayElementCode.INSERT;
                        END;
                    UNTIL PeriodTrans.NEXT = 0;
                COMMIT;
                //


                // Clear the journal Lines
                GeneraljnlLine.SETRANGE(GeneraljnlLine."Journal Batch Name", JBatch);
                IF GeneraljnlLine.FIND('-') THEN
                    GeneraljnlLine.DELETEALL;

                "Slip/Receipt No" := UPPERCASE(objPeriod."Period Name");

                WinDlg.OPEN(Text0001);
                ObjDim.RESET;
                ObjDim.SETRANGE(ObjDim."Dimension Code", 'DEPARTMENT');

                IF ObjDim.FINDFIRST THEN
                    REPEAT
                        GlobalDim2 := ObjDim.Code;
                        WinDlg.UPDATE(1, ObjDim.Code);
                        PayrollPostingGroupHeader.RESET;
                        //PayrollPostingGroupHeader.GET("Posting Group");
                        //PayrollPostingGroupHeader.SetRange("Group Code", "Posting Group");
                        //IF PayrollPostingGroupHeader.FINDFIRST THEN BEGIN
                        //REPEAT
                        WinDlg.UPDATE(2, PayrollPostingGroupHeader."Group Code");
                        //Get the staff details (header)
                        //TransCode.SETRANGE(TransCode."Transaction Code");
                        //IF TransCode.FIND('-') THEN
                        //BEGIN
                        // REPEAT
                        strEmpName := TransCode."Transaction Code";

                        //GlobalDim2:=objEmp."Department Code";    //objEmp.Office;
                        //PostingGroup.GET(objEmp."Posting Group");

                        LineNumber := LineNumber + 10;
                        TempPayElementCode.RESET;
                        IF TempPayElementCode.FIND('-') THEN
                            REPEAT
                                WinDlg.UPDATE(3, TempPayElementCode."Pay Element Code");
                                TotalAmt := 0;
                                AmountToDebit := 0;
                                AmountToCredit := 0;
                                CLEAR(PostGLCode);
                                PeriodTrans.RESET;
                                PeriodTrans.SETCURRENTKEY("Transaction Code", PeriodTrans.Department);
                                PeriodTrans.SETRANGE(Department, ObjDim.Code);
                                //PeriodTrans.SETFILTER("Payroll Posting Group", PayrollPostingGroupHeader."Group Code");
                                PeriodTrans.SETFILTER("Transaction Code", '%1', TempPayElementCode."Pay Element Code");
                                PeriodTrans.SETRANGE("Payroll Period", SelectedPeriod);
                                IF PeriodTrans.FIND('-') THEN BEGIN
                                    REPEAT
                                        IF PeriodTrans."Post As" = PeriodTrans."Post As"::Debit THEN BEGIN
                                            AmountToDebit += PeriodTrans.Amount;
                                            TotalAmt += PeriodTrans.Amount;
                                        END;

                                        IF PeriodTrans."Post As" = PeriodTrans."Post As"::Credit THEN BEGIN
                                            AmountToCredit += PeriodTrans.Amount;
                                            TotalAmt += PeriodTrans.Amount;
                                        END;
                                    UNTIL PeriodTrans.NEXT = 0;

                                    IF TotalAmt <> 0 THEN BEGIN
                                        if PayrollPostingGroupLine.GET('SALARY'/*"Payroll Posting Group"*/, TempPayElementCode."Pay Element Code") THEN BEGIN
                                            PayrollPostingGroupLine.SetRange("Group Code", PayrollPostingGroupHeader."Group Code");
                                            PayrollPostingGroupLine.SetRange("Pay Element", TempPayElementCode."Pay Element Code");
                                            //PayrollPostingGroupLine.SetRange(
                                            IF PayrollPostingGroupLine."Debit Account No." <> '' THEN BEGIN
                                                IF PayrollPostingGroupLine."Debit Account Type" = 0 THEN
                                                    IntegerPostAs := 0;
                                                IF PayrollPostingGroupLine."Debit Account Type" = 1 THEN
                                                    IntegerPostAs := 2;
                                                IF PayrollPostingGroupLine."Debit Account Type" = 2 THEN
                                                    IntegerPostAs := 1;
                                                PostGLCode := PayrollPostingGroupLine."Debit Account No.";
                                            END
                                            ELSE BEGIN
                                                IF PayrollPostingGroupLine."Credit Account Type" = 0 THEN
                                                    IntegerPostAs := 0;
                                                IF PayrollPostingGroupLine."Credit Account Type" = 1 THEN
                                                    IntegerPostAs := 2;
                                                IF PayrollPostingGroupLine."Credit Account Type" = 2 THEN
                                                    IntegerPostAs := 1;
                                                PostGLCode := PayrollPostingGroupLine."Credit Account No.";
                                            END;
                                        END;
                                        CreateJnlEntry(IntegerPostAs, PostGLCode,
                                        GlobalDim1, GlobalDim2, PayrollPostingGroupHeader."Group Code" + ' ' + 'Salary ' + ' ' + TempPayElementCode."Pay Element Code", AmountToDebit, AmountToCredit,
                                        PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType);
                                    END;
                                END; //stop prtrans
                            UNTIL TempPayElementCode.NEXT = 0;
                    // UNTIL PayrollPostingGroupHeader.NEXT = 0;
                    // END;
                    UNTIL ObjDim.NEXT = 0;
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
        PeriodFilter := "prSalary Card".GETFILTER("Period Filter");
        IF PeriodFilter = '' THEN ERROR('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GETRANGEMIN("Period Filter");
        objPeriod.RESET;
        IF objPeriod.GET(SelectedPeriod) THEN PeriodName := objPeriod."Period Name";

        PostingDate := CALCDATE('1M-1D', SelectedPeriod);
    end;

    var
        PeriodFilter2: Date;
        PeriodTrans: Record "prPeriod Transactions";
        objEmp: Record "HR-Employee";
        //WinDlg: Dialog;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "prPayroll Periods";
        ControlInfo: Record "Control-Information";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GeneraljnlLine2: Record "Gen. Journal Line";
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
        TotalAmt: Decimal;
        totalDedAmt: Decimal;
        HREmp: Record "HR-Employee";
        ERAmount: Decimal;
        ERAcctNo: Code[20];
        EmpDed: Decimal;
        Text0001: Label 'Processing for Division #1#####################\Processing for Group #2#####################\Processing Transaction Code #3#####################';
        WinDlg: Dialog;
        TempPayElementCode: Record "Temp Pay Element Code";
        PayrollPostingGroupHeader: Record "Payroll Posting Group Header";
        PayrollPostingGroupLine: Record "Payroll Posting Group Line";
        PostGLCode: Code[20];
        DefaultBatch: Record "Gen. Journal Batch";

    /// <summary>
    /// CreateJnlEntry.
    /// </summary>
    /// <param name="AccountType">Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner".</param>
    /// <param name="AccountNo">Code[20].</param>
    /// <param name="GlobalDime1">Code[20].</param>
    /// <param name="GlobalDime2">Code[20].</param>
    /// <param name="Description">Text[100].</param>
    /// <param name="DebitAmount">Decimal.</param>
    /// <param name="CreditAmount">Decimal.</param>
    /// <param name="PostAs">Option " ",Debit,Credit.</param>
    /// <param name="LoanNo">Code[20].</param>
    /// <param name="TransType">Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2".</param>
    [Scope('OnPrem')]
    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[100]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2")
    begin
        LineNumber := LineNumber + 100;
        GeneraljnlLine.INIT;
        //GeneraljnlLine."Journal Template Name":=JTemplate;
        //GeneraljnlLine."Journal Batch Name":= JBatch;

        GeneraljnlLine.VALIDATE("Journal Template Name", JTemplate);
        GeneraljnlLine.VALIDATE("Journal Batch Name", JBatch);
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        //GeneraljnlLine."Loan No":=LoanNo;
        //GeneraljnlLine."Transaction Type":=TransType;
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        /* IF PostAs = PostAs::Debit THEN BEGIN
         GeneraljnlLine."Debit Amount":=DebitAmount;
         GeneraljnlLine.VALIDATE("Debit Amount");
         END ELSE BEGIN
         GeneraljnlLine."Credit Amount":=CreditAmount;
         GeneraljnlLine.VALIDATE("Credit Amount");
         END;  */
        IF DebitAmount <> 0 THEN
            GeneraljnlLine.VALIDATE("Debit Amount", DebitAmount)
        ELSE
            GeneraljnlLine.VALIDATE("Credit Amount", CreditAmount);

        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
        //IF GeneraljnlLine.Amount<>0 THEN
        GeneraljnlLine.INSERT;
    end;
}