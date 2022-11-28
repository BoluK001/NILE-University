report 51534654 "Reconciliations - Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReconciliationsSummary.rdlc';

    dataset
    {
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            DataItemTableView = SORTING ("Group Order", "Sub Group Order");
            RequestFilterFields = "Current Month Filter";
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
            column(prTransaction_Codes__Gross_Variation_; "Gross Variation")
            {
            }
            column(prTransaction_Codes__Curr__Amount_; "Curr. Amount")
            {
            }
            column(prTransaction_Codes__Prev__Amount_; "Prev. Amount")
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(Curr__Amount___Prev__Amount_; "Curr. Amount" - "Prev. Amount")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(prTransaction_Codes__Gross_Variation__Control1102755028; "Gross Variation")
            {
            }
            column(prTransaction_Codes__Curr__Amount__Control1102755026; "Curr. Amount")
            {
            }
            column(prTransaction_Codes__Prev__Amount__Control1102755025; "Prev. Amount")
            {
            }
            column(prTransaction_Codes__Gross_Variation__Control1102755027; "Gross Variation")
            {
            }
            column(Reconciliation___SummaryCaption; Reconciliation___SummaryCaptionLbl)
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
            column(Last_MonthCaption; Last_MonthCaptionLbl)
            {
            }
            column(Current_MonthCaption; Current_MonthCaptionLbl)
            {
            }
            column(VarienceCaption; VarienceCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if CompanyName = 'DANGOTE GROUP' then begin
                    if "prTransaction Codes"."Transaction Code" = 'NHF' then begin
                        NHFCurr := "prTransaction Codes"."Curr. Amount";
                        NHFPrev := "prTransaction Codes"."Prev. Amount";
                        NHFGross := "prTransaction Codes"."Gross Variation";
                    end;

                    if "prTransaction Codes"."Transaction Code" = 'TOT-DED' then begin
                        "prTransaction Codes"."Curr. Amount" := "prTransaction Codes"."Curr. Amount" + NHFCurr;
                        "prTransaction Codes"."Prev. Amount" := "prTransaction Codes"."Prev. Amount" + NHFPrev;
                        ;
                        "prTransaction Codes"."Gross Variation" := "prTransaction Codes"."Gross Variation" + NHFGross;
                        ;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                Evaluate(SelectedPeriod, GetFilter("Current Month Filter"));

                SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));

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
        CompanyInfo: Record "Company Information";
        NHFCurr: Decimal;
        NHFPrev: Decimal;
        NHFGross: Decimal;
        Reconciliation___SummaryCaptionLbl: Label 'Reconciliation - Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        DescriptionCaptionLbl: Label 'Description';
        Last_MonthCaptionLbl: Label 'Last Month';
        Current_MonthCaptionLbl: Label 'Current Month';
        VarienceCaptionLbl: Label 'Varience';
}

