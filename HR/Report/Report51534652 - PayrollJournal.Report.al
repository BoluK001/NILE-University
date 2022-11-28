report 51534652 "Payroll Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollJournal.rdlc';

    dataset
    {
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            DataItemTableView = SORTING ("Group Order", "Sub Group Order");
            RequestFilterFields = "Current Month Filter", "Location/Division Filter", "Department Filter", "Cost Centre Filter";
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
            column(GETFILTERS; GetFilters)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CreditAmount; CreditAmount)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(DebitAmount_RDebitAmount; DebitAmount + RDebitAmount)
            {
            }
            column(CreditAmount_RCreditAmount; CreditAmount + RCreditAmount)
            {
            }
            column(RDebitAmount; RDebitAmount)
            {
            }
            column(RCreditAmount; RCreditAmount)
            {
            }
            column(Payroll_JournalCaption; Payroll_JournalCaptionLbl)
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
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(Rounding_AdjustmentCaption; Rounding_AdjustmentCaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755042; EmptyStringCaption_Control1102755042Lbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755044; NameCaption_Control1102755044Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755045; EmptyStringCaption_Control1102755045Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755047; NameCaption_Control1102755047Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755049; EmptyStringCaption_Control1102755049Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755050; Signature___DateCaption_Control1102755050Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755051; EmptyStringCaption_Control1102755051Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755052; Signature___DateCaption_Control1102755052Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755053; EmptyStringCaption_Control1102755053Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "prTransaction Codes".CalcFields("prTransaction Codes"."Curr. Amount");

                if "prTransaction Codes"."Non-Transactional" = true then begin
                    if ("prTransaction Codes"."Transaction Code" <> 'BPAY') and
                       ("prTransaction Codes"."Transaction Code" <> 'PAYE') and
                       ("prTransaction Codes"."Transaction Code" <> 'NPAY') and
                       ("prTransaction Codes"."Transaction Code" <> 'NHF') then
                        CurrReport.Skip;

                end;

                if "prTransaction Codes"."Transaction Type" = "prTransaction Codes"."Transaction Type"::Income then
                    DebitAmount := "prTransaction Codes"."Curr. Amount"
                else
                    CreditAmount := "prTransaction Codes"."Curr. Amount";

                if ("prTransaction Codes"."Transaction Code" = 'NPAY') then begin
                    DebitAmount := 0;
                    CreditAmount := "prTransaction Codes"."Curr. Amount";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                Evaluate(SelectedPeriod, GetFilter("Current Month Filter"));

                CurrReport.CreateTotals(DebitAmount, CreditAmount);

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
        Payroll_JournalCaptionLbl: Label 'Payroll Journal';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        Rounding_AdjustmentCaptionLbl: Label 'Rounding Adjustment';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755042Lbl: Label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        NameCaption_Control1102755044Lbl: Label 'Name';
        EmptyStringCaption_Control1102755045Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        NameCaption_Control1102755047Lbl: Label 'Name';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755049Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755050Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755051Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755052Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755053Lbl: Label '......................................................................................................................................................';
}

