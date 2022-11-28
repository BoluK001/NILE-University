report 51534649 "Validate Transactions Codes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateTransactionsCodes.rdlc';

    dataset
    {
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Type_; "Transaction Type")
            {
            }
            column(TransactionsCaption; TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prTransaction_Codes__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prTransaction_Codes__Transaction_Name_Caption; FieldCaption("Transaction Name"))
            {
            }
            column(prTransaction_Codes__Transaction_Type_Caption; FieldCaption("Transaction Type"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "prTransaction Codes"."Transaction Type" = "prTransaction Codes"."Transaction Type"::Income then
                    "prTransaction Codes"."Group Order" := 3
                else
                    "prTransaction Codes"."Group Order" := 8;
                "prTransaction Codes".Modify;
            end;

            trigger OnPostDataItem()
            begin
                if Trans.Get('BPAY') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'BPAY';
                    Trans."Transaction Name" := 'Basic Pay';
                    Trans."Transaction Type" := Trans."Transaction Type"::Income;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 1;
                    Trans.Insert;
                end;

                if Trans.Get('GPAY') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'GPAY';
                    Trans."Transaction Name" := 'Gross Pay';
                    Trans."Transaction Type" := Trans."Transaction Type"::Income;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 4;
                    Trans.Insert;
                end;

                if Trans.Get('NONTAX') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'NONTAX';
                    Trans."Transaction Name" := 'Non-Taxable Pay';
                    Trans."Transaction Type" := Trans."Transaction Type"::Income;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 6;
                    Trans."Sub Group Order" := 5;
                    Trans.Insert;
                end;

                if Trans.Get('NPAY') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'NPAY';
                    Trans."Transaction Name" := 'Net Pay';
                    Trans."Transaction Type" := Trans."Transaction Type"::Income;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 9;
                    Trans.Insert;
                end;

                if Trans.Get('PAYE') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'PAYE';
                    Trans."Transaction Name" := 'PAYE';
                    Trans."Transaction Type" := Trans."Transaction Type"::Deduction;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 7;
                    Trans."Sub Group Order" := 3;
                    Trans.Insert;
                end;

                if Trans.Get('NHF') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'NHF';
                    Trans."Transaction Name" := 'N.H.F';
                    Trans."Transaction Type" := Trans."Transaction Type"::Deduction;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 7;
                    Trans."Sub Group Order" := 4;
                    Trans.Insert;
                end;


                if Trans.Get('TOT-DED') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'TOT-DED';
                    Trans."Transaction Name" := 'Total Deductions';
                    Trans."Transaction Type" := Trans."Transaction Type"::Deduction;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 8;
                    Trans."Sub Group Order" := 9;
                    Trans.Insert;
                end;


                if Trans.Get('TXCHRG') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'TXCHRG';
                    Trans."Transaction Name" := 'Tax Charged';
                    Trans."Transaction Type" := Trans."Transaction Type"::Deduction;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 6;
                    Trans."Sub Group Order" := 7;
                    Trans.Insert;
                end;

                if Trans.Get('TXBP') = false then begin
                    Trans.Init;
                    Trans."Transaction Code" := 'TXBP';
                    Trans."Transaction Name" := 'Taxable Pay';
                    Trans."Transaction Type" := Trans."Transaction Type"::Deduction;
                    Trans."Non-Transactional" := true;
                    Trans."Group Order" := 6;
                    Trans."Sub Group Order" := 6;
                    Trans.Insert;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Trans.Reset;
                Trans.SetRange(Trans."Non-Transactional", true);
                if Trans.Find('-') then
                    Trans.DeleteAll;
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

    var
        HREmployee: Record "HR-Employee";
        Trans: Record "prTransaction Codes";
        TransactionsCaptionLbl: Label 'Transactions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

