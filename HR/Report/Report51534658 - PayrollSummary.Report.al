report 51534658 "Payroll Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollSummary.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Current Month Filter", "Period Filter", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
            column(GETFILTERS; GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(cHeader_1_; cHeader[1])
            {
            }
            column(cHeader_2_; cHeader[2])
            {
            }
            column(cHeader_3_; cHeader[3])
            {
            }
            column(cHeader_7_; cHeader[7])
            {
            }
            column(cHeader_6_; cHeader[6])
            {
            }
            column(cHeader_5_; cHeader[5])
            {
            }
            column(cHeader_4_; cHeader[4])
            {
            }
            column(cHeader_11_; cHeader[11])
            {
            }
            column(cHeader_10_; cHeader[10])
            {
            }
            column(cHeader_9_; cHeader[9])
            {
            }
            column(cHeader_8_; cHeader[8])
            {
            }
            column(cHeader_12_; cHeader[12])
            {
            }
            column(cHeader_13_; cHeader[13])
            {
            }
            column(cHeader_14_; cHeader[14])
            {
            }
            column(cHeader_15_; cHeader[15])
            {
            }
            column(cHeader_17_; cHeader[17])
            {
            }
            column(cHeader_16_; cHeader[16])
            {
            }
            column(cHeader_18_; cHeader[18])
            {
            }
            column(cHeader_19_; cHeader[19])
            {
            }
            column(cHeader_20_; cHeader[20])
            {
            }
            column(cHeader_21_; cHeader[21])
            {
            }
            column(cHeader_22_; cHeader[22])
            {
            }
            column(cHeader_23_; cHeader[23])    //jj111122
            {
            }
            column(cHeader_24_; cHeader[24])    //jj111122
            {
            }
            column(cHeader_25_; cHeader[25])    //jj111122
            {
            }
            column(cHeader_26_; cHeader[26])    //jj111122
            {
            }
            column(cHeader_27_; cHeader[27])    //jj111122
            {
            }
            column(cHeader_28_; cHeader[28])    //jj111122
            {
            }
            column(cHeader_29_; cHeader[29])
            {
            }
            column(cHeader_30_; cHeader[30])
            {
            }
            column(cHeader_31_; cHeader[31])
            {
            }
            column(cHeader_32_; cHeader[32])
            {
            }
            column(cHeader_33_; cHeader[33])
            {
            }
            column(cHeader_34_; cHeader[34])
            {
            }
            column(cHeader_35_; cHeader[35])
            {
            }
            column(cHeader_36_; cHeader[36])
            {
            }
            column(cHeader_37_; cHeader[37])
            {
            }
            column(cHeader_38_; cHeader[38])
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR-Employee"."No.")
            {
            }
            column(cValue_1_; cValue[1])
            {
            }
            column(cValue_2_; cValue[2])
            {
            }
            column(cValue_3_; cValue[3])
            {
            }
            column(cValue_6_; cValue[6])
            {
            }
            column(cValue_5_; cValue[5])
            {
            }
            column(cValue_4_; cValue[4])
            {
            }
            column(cValue_9_; cValue[9])
            {
            }
            column(cValue_8_; cValue[8])
            {
            }
            column(cValue_7_; cValue[7])
            {
            }
            column(cValue_11_; cValue[11])
            {
            }
            column(cValue_12_; cValue[12])
            {
            }
            column(cValue_13_; cValue[13])
            {
            }
            column(cValue_14_; cValue[14])
            {
            }
            column(cValue_15_; cValue[15])
            {
            }
            column(cValue_10_; cValue[10])
            {
            }
            column(cValue_19_; cValue[19])
            {
            }
            column(cValue_18_; cValue[18])
            {
            }
            column(cValue_17_; cValue[17])
            {
            }
            column(cValue_16_; cValue[16])
            {
            }
            column(cValue_20_; cValue[20])
            {
            }
            column(cValue_21_; cValue[21])
            {
            }
            column(cValue_22_; cValue[22])
            {
            }
            column(cValue_23_; cValue[23])   //jj111122
            {
            }
            column(cValue_24_; cValue[24])   //jj111122
            {
            }
            column(cValue_25_; cValue[25])   //jj111122
            {
            }
            column(cValue_26_; cValue[26])   //jj111122
            {
            }
            column(cValue_27_; cValue[27])   //jj111122
            {
            }
            column(cValue_28_; cValue[28])   //jj111122
            {
            }
            column(cValue_29_; cValue[29])
            {
            }
            column(cValue_30_; cValue[30])
            {
            }
            column(cValue_31_; cValue[31])
            {
            }
            column(cValue_32_; cValue[32])
            {
            }
            column(cValue_33_; cValue[33])
            {
            }
            column(cValue_34_; cValue[34])
            {
            }
            column(cValue_35_; cValue[35])
            {
            }
            column(cValue_36_; cValue[36])
            {
            }
            column(cValue_37_; cValue[37])
            {
            }
            column(cValue_38_; cValue[38])
            {
            }
            column(HR_Employee__Department_Code_; "Department Code")
            {
            }
            column(cValue_19__Control1102755024; cValue[19])
            {
            }
            column(cValue_18__Control1102755029; cValue[18])
            {
            }
            column(cValue_17__Control1102755030; cValue[17])
            {
            }
            column(cValue_16__Control1102755031; cValue[16])
            {
            }
            column(cValue_15__Control1102755052; cValue[15])
            {
            }
            column(cValue_14__Control1102755053; cValue[14])
            {
            }
            column(cValue_13__Control1102755054; cValue[13])
            {
            }
            column(cValue_12__Control1102755055; cValue[12])
            {
            }
            column(cValue_11__Control1102755056; cValue[11])
            {
            }
            column(cValue_10__Control1102755057; cValue[10])
            {
            }
            column(cValue_9__Control1102755058; cValue[9])
            {
            }
            column(cValue_8__Control1102755059; cValue[8])
            {
            }
            column(cValue_7__Control1102755060; cValue[7])
            {
            }
            column(cValue_6__Control1102755061; cValue[6])
            {
            }
            column(cValue_5__Control1102755062; cValue[5])
            {
            }
            column(cValue_4__Control1102755063; cValue[4])
            {
            }
            column(cValue_3__Control1102755064; cValue[3])
            {
            }
            column(cValue_2__Control1102755065; cValue[2])
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(RCount; RCount)
            {
            }
            column(cValue_20__Control1102755071; cValue[20])
            {
            }
            column(cValue_23__Control1102755071; cValue[23])  //jj111122
            {
            }
            column(cValue_24_Control1102755072; cValue[24])
            {
            }
            column(cValue_25_Control1102755079; cValue[25])
            {
            }
            column(cValue_26_Control1102755080; cValue[26])
            {
            }
            column(cValue_27_Control1102755084; cValue[27])
            {
            }
            column(cValue_28_Control1102755084; cValue[28])
            {
            }
            column(cValue_29_Control1102755084; cValue[29])
            {
            }
            column(cValue_30_Control1102755084; cValue[30])
            {
            }
            column(cValue_31_Control1102755084; cValue[31])
            {
            }
            column(cValue_32_Control1102755084; cValue[32])
            {
            }
            column(cValue_33_Control1102755084; cValue[33])
            {
            }
            column(cValue_34_Control1102755084; cValue[34])
            {
            }
            column(cValue_35_Control1102755084; cValue[35])
            {
            }
            column(cValue_36_Control1102755084; cValue[36])
            {
            }
            column(cValue_37_Control1102755084; cValue[37])
            {
            }
            column(cValue_38_Control1102755084; cValue[38])
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payroll_SummaryCaption; Payroll_SummaryCaptionLbl)
            {
            }
            column(HR_Employee__Department_Code_Caption; FieldCaption("Department Code"))
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755072; EmptyStringCaption_Control1102755072Lbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Signature_and_DateCaption; Signature_and_DateCaptionLbl)
            {
            }
            column(Signature_and_DateCaption_Control1102755076; Signature_and_DateCaption_Control1102755076Lbl)
            {
            }
            column(NameCaption_Control1102755077; NameCaption_Control1102755077Lbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755079; EmptyStringCaption_Control1102755079Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755080; EmptyStringCaption_Control1102755080Lbl)
            {
            }
            column(Signature_and_DateCaption_Control1102755081; Signature_and_DateCaption_Control1102755081Lbl)
            {
            }
            column(NameCaption_Control1102755082; NameCaption_Control1102755082Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755084; EmptyStringCaption_Control1102755084Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755085; EmptyStringCaption_Control1102755085Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";
                EmployeeCode := "HR-Employee"."No.";

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 20;

                Trans.Reset;
                //"HR-Employee".GETFILTER("Current Month Filter")
                Trans.SetFilter(Trans."Current Month Filter", Format(PayrollPeriod));
                Trans.SetFilter(Trans."Employee Code Filter", "HR-Employee"."No.");
                if Trans.Find('-') then begin
                    repeat
                        Trans.CalcFields("Curr. Amount");
                        //Basic Pay
                        cHeader[1] := 'Basic Pay';
                        if Trans."Transaction Code" = 'BPAY' then begin
                            cValue[1] := Trans."Curr. Amount";
                        end;

                        //Transport
                        cHeader[2] := 'Transport';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Transport then begin
                            cValue[2] := cValue[2] + Trans."Curr. Amount";
                        end;

                        //Leave
                        cHeader[3] := 'Leave';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Leave then begin
                            cValue[3] := cValue[3] + Trans."Curr. Amount";
                        end;

                        //Housing
                        cHeader[4] := 'Housing';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Housing then begin
                            cValue[4] := cValue[4] + Trans."Curr. Amount";
                        end;

                        //Bonus Special
                        cHeader[5] := 'Lunch';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Lunch then begin
                            cValue[5] := cValue[5] + Trans."Curr. Amount";
                        end;

                        //Entertainment
                        cHeader[6] := 'Entertainment';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Entertainment then begin
                            cValue[6] := cValue[6] + Trans."Curr. Amount";
                        end;

                        //Utility
                        cHeader[7] := 'Utility';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Utility then begin
                            cValue[7] := cValue[7] + Trans."Curr. Amount";
                        end;

                        //Inconvinience
                        cHeader[8] := 'Inconvinience';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Inconvinience then begin
                            cValue[8] := cValue[8] + Trans."Curr. Amount";
                        end;


                        //Bonus Special
                        cHeader[9] := 'Bonus Special';
                        if Trans."Transaction Category" = Trans."Transaction Category"::"Bonus Special" then begin
                            cValue[9] := cValue[9] + Trans."Curr. Amount";
                        end;

                        //Gross Pay
                        cHeader[10] := 'Gross Pay';
                        if Trans."Transaction Code" = 'GPAY' then begin
                            cValue[10] := Trans."Curr. Amount";
                        end;

                        //Taxable Pay
                        cHeader[11] := 'Taxable Pay';
                        if Trans."Transaction Code" = 'TXBP' then begin
                            cValue[11] := Trans."Curr. Amount";
                        end;

                        //Gross Pay
                        cHeader[12] := 'P.A.Y.E';
                        if Trans."Transaction Code" = 'PAYE' then begin
                            cValue[12] := Trans."Curr. Amount";
                        end;

                        //NHF
                        cHeader[13] := 'N.H.F';
                        if Trans."Transaction Code" = 'NHF' then begin
                            cValue[13] := Trans."Curr. Amount";
                        end;


                        //Pension
                        cHeader[14] := 'Pension';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Pension then begin
                            cValue[14] := cValue[14] + Trans."Curr. Amount";
                            //Pension Employer
                            cHeader[21] := 'Employer Contrib. Pension';
                            begin
                                EmployerDed.Reset;
                                EmployerDed.SetRange("Employee Code", "HR-Employee"."No.");
                                EmployerDed.SetRange("Transaction Code", Trans."Transaction Code");
                                EmployerDed.SetRange("Payroll Period", PayrollPeriod);
                                if EmployerDed.FindLast then
                                    cValue[21] := EmployerDed.Amount;
                            end;
                        end;


                        //WHT
                        cHeader[15] := 'WHT';
                        if Trans."Transaction Code" = 'WHT' then begin
                            cValue[15] := Trans."Curr. Amount";
                        end;

                        //Housing Deduction
                        cHeader[16] := 'Housing Loan';
                        if Trans."Transaction Category" = Trans."Transaction Category"::"Housing Deduction" then begin
                            cValue[16] := cValue[16] + Trans."Curr. Amount";
                        end;

                        //Personal Loan
                        cHeader[17] := 'Personal Loan';
                        if Trans."Transaction Category" = Trans."Transaction Category"::"Personal Loan" then begin
                            cValue[17] := cValue[17] + Trans."Curr. Amount";
                        end;

                        //Other Co-Deductions
                        cHeader[18] := 'Other Co-Deductions';
                        if Trans."Transaction Category" = Trans."Transaction Category"::"Other Co-deductions" then begin
                            cValue[18] := cValue[18] + Trans."Curr. Amount";
                        end;


                        //Other Deductions
                        cHeader[19] := 'Other Deductions';
                        if Trans."Transaction Category" = Trans."Transaction Category"::"Other Deductions" then begin
                            cValue[19] := cValue[19] + Trans."Curr. Amount";
                        end;

                        //Total Deductions
                        cHeader[20] := 'Total Deductions';
                        begin
                            PeriodTrans.Reset;
                            PeriodTrans.SetRange(PeriodTrans."Employee Code", "HR-Employee"."No.");
                            PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'TOT-DED');
                            PeriodTrans.SetRange(PeriodTrans."Payroll Period", PayrollPeriod);
                            if PeriodTrans.FindFirst then
                                cValue[20] := PeriodTrans.Amount;
                        end;

                        //Net Pay
                        cHeader[22] := 'Net Pay';
                        if Trans."Transaction Code" = 'NPAY' then begin
                            cValue[22] := Trans."Curr. Amount";
                        end;
                        //Extra PAYE   //jj111122
                        cHeader[23] := 'Extra PAYE';
                        if Trans."Transaction Code" = 'EXTRA PAYE' then begin
                            cValue[23] := Trans."Curr. Amount";
                        end;

                        //Salary Arrears
                        cHeader[24] := 'Salary Arrears';
                        if Trans."Transaction Code" = 'SALA ARR' then begin
                            cValue[24] := Trans."Curr. Amount";
                        end;

                        //Other Income
                        cHeader[25] := 'Other Income';
                        if Trans."Transaction Code" = 'OTHER INCOME' then begin
                            cValue[25] := Trans."Curr. Amount";
                        end;

                        //Overtime
                        cHeader[26] := 'Overtime';
                        if Trans."Transaction Code" = 'OVERTIME' then begin
                            cValue[26] := Trans."Curr. Amount";
                        end;

                        //13th Month
                        cHeader[27] := '13th Month';
                        if Trans."Transaction Code" = '13TH MONTH' then begin
                            cValue[27] := Trans."Curr. Amount";
                        end;

                        //Allowance
                        cHeader[28] := 'Allowance';
                        if Trans."Transaction Code" = 'ALLOWANCE' then begin
                            cValue[28] := Trans."Curr. Amount";
                        end;

                        //AVC
                        cHeader[29] := 'AVC';
                        if Trans."Transaction Code" = 'AVC' then begin
                            cValue[29] := Trans."Curr. Amount";
                        end;

                        //COOP DEDUCT
                        cHeader[30] := 'COOP DEDUCT';
                        if Trans."Transaction Code" = 'COOP DEDUCT' then begin
                            cValue[30] := Trans."Curr. Amount";
                        end;

                        //Disciplinary Ded
                        cHeader[31] := 'Disciplinary Ded';
                        if Trans."Transaction Code" = 'DISCIPLINARY DED' then begin
                            cValue[31] := Trans."Curr. Amount";
                        end;

                        //Electricity
                        cHeader[32] := 'Electricity';
                        if Trans."Transaction Code" = 'ELECRICITY' then begin
                            cValue[32] := Trans."Curr. Amount";
                        end;

                        //Incentive
                        cHeader[33] := 'Incentive';
                        if Trans."Transaction Code" = 'INCENTIVE' then begin
                            cValue[33] := Trans."Curr. Amount";
                        end;

                        //Loan Ded
                        cHeader[34] := 'Loan Ded';
                        if Trans."Transaction Code" = 'LOAN DED' then begin
                            cValue[34] := Trans."Curr. Amount";
                        end;

                        //Maintenance
                        cHeader[35] := 'Maintenance';
                        if Trans."Transaction Code" = 'MAINTENANCE' then begin
                            cValue[35] := Trans."Curr. Amount";
                        end;

                        //Position-Clinical
                        cHeader[36] := 'Position-Clinical';
                        if Trans."Transaction Code" = 'POSITION-CLINICAL' then begin
                            cValue[36] := Trans."Curr. Amount";
                        end;

                        //Rent
                        cHeader[37] := 'Rent';
                        if Trans."Transaction Code" = 'RENT' then begin
                            cValue[37] := Trans."Curr. Amount";
                        end;

                        //Water
                        cHeader[38] := 'Water';
                        if Trans."Transaction Code" = 'WATER' then begin
                            cValue[38] := Trans."Curr. Amount";
                        end;


                    until Trans.Next = 0;
                end;



                if (cValue[1] = 0) then
                    CurrReport.Skip;

                if PrintToExcel then begin
                    if HeaderCreated = false then begin
                        MakeExcelDataHeader;
                        HeaderCreated := true;
                    end;
                end;

                if PrintToExcel then
                    MakeExcelDataBody;


                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                IF "HR-Employee".GETFILTER("HR-Employee"."Current Month Filter") = '' THEN
                    if PayrollPeriod = 0D then
                        Error('You must specify current Period filter.');

                CurrReport.CreateTotals(cValue[1], cValue[2], cValue[3], cValue[4], cValue[5], cValue[6], cValue[7], cValue[8], cValue[9], cValue[10]);
                CurrReport.CreateTotals(cValue[11], cValue[12], cValue[13], cValue[14], cValue[15], cValue[16], cValue[17]);
                CurrReport.CreateTotals(cValue[18], cValue[19], cValue[20]);

                RCount := 0;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PayrollPeriod; PayrollPeriod)
                {
                    Caption = 'Payroll Period';
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

    trigger OnPostReport()
    begin
        if PrintToExcel then
            MakeExcelTotalBody;


        if PrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        //IF PrintToExcel THEN
        //  MakeExcelInfo;
    end;

    var
        strEmpName: Text[100];
        cHeader: array[200] of Text[200];
        cValue: array[200] of Decimal;
        Trans: Record "prTransaction Codes";
        ColNo: Integer;
        i: Integer;
        RCount: Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        Text008: Label 'All Amounts in LCY';
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text011: Label 'Data';
        Text012: Label 'Aged Accounts Receivable';
        Text013: Label 'Company Name';
        Text014: Label 'Report No.';
        Text015: Label 'Report Name';
        Text016: Label 'User ID';
        Text017: Label 'Date';
        Text018: Label 'Filters';
        Emp: Record "HR-Employee";
        HeaderCreated: Boolean;
        EmployeeCode: Code[20];
        CompanyInfo: Record "Company Information";
        Employee_NameCaptionLbl: Label 'Employee Name';
        Employee_CodeCaptionLbl: Label 'Employee Code';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Payroll_SummaryCaptionLbl: Label 'Payroll Summary';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755072Lbl: Label '......................................................................................................................................................';
        NameCaptionLbl: Label 'Name';
        Signature_and_DateCaptionLbl: Label 'Signature and Date';
        Signature_and_DateCaption_Control1102755076Lbl: Label 'Signature and Date';
        NameCaption_Control1102755077Lbl: Label 'Name';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        EmptyStringCaption_Control1102755079Lbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755080Lbl: Label '......................................................................................................................................................';
        Signature_and_DateCaption_Control1102755081Lbl: Label 'Signature and Date';
        NameCaption_Control1102755082Lbl: Label 'Name';
        Approved_by_CaptionLbl: Label 'Approved by:';
        EmptyStringCaption_Control1102755084Lbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755085Lbl: Label '......................................................................................................................................................';
        EmployerDed: Record "prEmployer Deductions";
        PeriodTrans: Record "prPeriod Transactions";
        PayrollPeriod: Date;

    [Scope('OnPrem')]
    procedure MakeExcelInfo()
    begin
        /*
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text013),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text015),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Payroll Summary',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text016),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text017),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text018),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("HR-Employee".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        //MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee Code',FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn('Names',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Department',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[1],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[2],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[3],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[4],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[5],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[6],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[7],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[8],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[9],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[10],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[11],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[12],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[13],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[14],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[15],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[16],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[17],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[18],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[19],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[20],FALSE,'',TRUE,FALSE,TRUE,'');
        {
        ExcelBuf.AddColumn(cHeader[21],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[22],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[23],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[24],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[25],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[26],FALSE,'',TRUE,FALSE,TRUE,'');
        }
        */

    end;

    [Scope('OnPrem')]
    procedure MakeExcelDataBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(("HR-Employee"."No."),FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(strEmpName,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("HR-Employee"."Department Code",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[6],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[7],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[8],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[9],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[10],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[11],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[12],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[13],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[14],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[15],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[16],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[17],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[18],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[19],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[20],FALSE,'',FALSE,FALSE,FALSE,'');
        {
        ExcelBuf.AddColumn(cValue[21],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[22],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[23],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[24],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[25],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[26],FALSE,'',FALSE,FALSE,FALSE,'');
        }
        */

    end;

    [Scope('OnPrem')]
    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text011,Text012,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;

    [Scope('OnPrem')]
    procedure MakeExcelTotalBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[6],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[7],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[8],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[9],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[10],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[11],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[12],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[13],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[14],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[15],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[16],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[17],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[18],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[19],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[20],FALSE,'',FALSE,FALSE,FALSE,'');
        {
        ExcelBuf.AddColumn(cValue[21],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[22],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[23],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[24],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[25],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[26],FALSE,'',FALSE,FALSE,FALSE,'');
        }
        */

    end;
}

