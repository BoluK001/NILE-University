report 51534660 "Transactions Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TransactionsSummary.rdlc';

    dataset
    {
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            DataItemTableView = SORTING("Group Order", "Sub Group Order");
            RequestFilterFields = "Current Month Filter", "Transaction Type";
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(GETFILTERS; GetFilters)
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(prTransaction_Codes__Curr__Amount_; "Curr. Amount")
            {
            }
            column(prTransaction_Codes__Curr__Amount__Control1102755010; "Curr. Amount")
            {
            }
            column(Transactions_SummaryCaption; Transactions_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if "prTransaction Codes"."Non-Transactional" = true then begin
                    if ("prTransaction Codes"."Transaction Code" <> 'BPAY') and
                       ("prTransaction Codes"."Transaction Code" <> 'PAYE') and
                       ("prTransaction Codes"."Transaction Code" <> 'NHF') then
                        CurrReport.Skip;

                end;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                Evaluate(SelectedPeriod, GetFilter("Current Month Filter"));

                //SETFILTER("Previous Month Filter",FORMAT(CALCDATE('-1M',SelectedPeriod)));
                //CurrReport.CREATETOTALS(DebitAmount,CreditAmount);
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        TotalFor: Label 'Total for ';
        SelectedPeriod: Date;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        RDebitAmount: Decimal;
        RCreditAmount: Decimal;
        CompanyInfo: Record "Company Information";
        Transactions_SummaryCaptionLbl: Label 'Transactions Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        AmountCaptionLbl: Label 'Amount';
}

