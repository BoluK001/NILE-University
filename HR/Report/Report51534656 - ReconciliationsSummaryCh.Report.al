report 51534656 "Reconciliations - Summary Ch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReconciliationsSummaryCh.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            RequestFilterFields = "Current Month Filter";
            column(COMPANYNAME; CompanyName)
            {
            }
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Status; Status)
            {
            }
            column(HR_Employee__Gross_Income_Variation_; "Gross Income Variation")
            {
            }
            column(HR_Employee__Gross_Income_Variation__Control1102755021; "Gross Income Variation")
            {
            }
            column(Reconciliation___SummaryCaption; Reconciliation___SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(Gross_VariationCaption; Gross_VariationCaptionLbl)
            {
            }
            column(Balance_BFCaption; Balance_BFCaptionLbl)
            {
            }
            column(Entry_ExitsCaption; Entry_ExitsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR-Employee".CalcFields("Prev. Gross Pay", "Curr. Gross Pay");

                if ("HR-Employee"."Prev. Gross Pay" = 0) and ("HR-Employee"."Curr. Gross Pay" = 0) then
                    CurrReport.Skip;

                if ("HR-Employee"."Prev. Gross Pay" > 0) and ("HR-Employee"."Curr. Gross Pay" > 0) then
                    CurrReport.Skip;

                TotalEntryExits := TotalEntryExits + "HR-Employee"."Gross Income Variation";
            end;

            trigger OnPreDataItem()
            begin
                if "HR-Employee".GetFilter("HR-Employee"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                Evaluate(SelectedPeriod, "HR-Employee".GetFilter("Current Month Filter"));

                "HR-Employee".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));

                BalanceBF := 0;
                TotalEntryExits := 0;
                TotalEVariations := 0;
                TotalDVariations := 0;

                Trans.Reset;
                Trans.SetRange(Trans."Transaction Code", 'NPAY');
                Trans.SetFilter(Trans."Current Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
                if Trans.Find('-') then begin
                    Trans.CalcFields(Trans."Curr. Amount");
                    BalanceBF := Trans."Curr. Amount";
                end;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
        dataitem("prTransaction Codes"; "prTransaction Codes")
        {
            DataItemTableView = SORTING ("Group Order", "Sub Group Order") WHERE ("Transaction Type" = CONST (Income));
            column(prTransaction_Codes__Gross_Variation_; "Gross Variation")
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(TotalEVariations; TotalEVariations)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Gross Variation");

                if "prTransaction Codes"."Gross Variation" = 0 then
                    CurrReport.Skip;

                if TransR.Get("prTransaction Codes"."Transaction Code") then begin
                    if TransR."Non-Transactional" = true then begin
                        if (TransR."Transaction Code" <> 'BPAY') and (TransR."Transaction Code" <> 'PAYE') and
                           (TransR."Transaction Code" <> 'NHF') then
                            CurrReport.Skip;
                    end;
                end;


                TotalEVariations := TotalEVariations + "prTransaction Codes"."Gross Variation"
            end;

            trigger OnPreDataItem()
            begin
                if "HR-Employee".GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                SetFilter("Current Month Filter", "HR-Employee".GetFilter("Current Month Filter"));

                Evaluate(SelectedPeriod, "HR-Employee".GetFilter("Current Month Filter"));

                SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
                SetFilter("prTransaction Codes"."Entry/Exit Filter", Format(false));
            end;
        }
        dataitem("<prTransaction Codes2>"; "prTransaction Codes")
        {
            DataItemTableView = WHERE ("Transaction Type" = CONST (Deduction));
            column(prTransaction_Codes2___Gross_Variation_; "Gross Variation")
            {
            }
            column(prTransaction_Codes2___Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes2___Transaction_Code_; "Transaction Code")
            {
            }
            column(BalanceBF_TotalEntryExits_TotalEVariations_TotalDVariations; BalanceBF + TotalEntryExits + TotalEVariations + TotalDVariations)
            {
            }
            column(TotalDVariations; TotalDVariations)
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
            column(EmptyStringCaption_Control1102755033; EmptyStringCaption_Control1102755033Lbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755037; NameCaption_Control1102755037Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755038; EmptyStringCaption_Control1102755038Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755040; NameCaption_Control1102755040Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755042; EmptyStringCaption_Control1102755042Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755043; Signature___DateCaption_Control1102755043Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755044; EmptyStringCaption_Control1102755044Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755045; Signature___DateCaption_Control1102755045Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755046; EmptyStringCaption_Control1102755046Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Gross Variation");

                if "Gross Variation" = 0 then
                    CurrReport.Skip;

                if TransR.Get("Transaction Code") then begin
                    if TransR."Non-Transactional" = true then begin
                        if (TransR."Transaction Code" <> 'BPAY') and (TransR."Transaction Code" <> 'PAYE') and
                           (TransR."Transaction Code" <> 'NHF') then
                            CurrReport.Skip;
                    end;
                end;

                TotalDVariations := TotalDVariations + (-1 * "Gross Variation")
            end;

            trigger OnPreDataItem()
            begin
                if "HR-Employee".GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                SetFilter("Current Month Filter", "HR-Employee".GetFilter("Current Month Filter"));

                Evaluate(SelectedPeriod, "HR-Employee".GetFilter("Current Month Filter"));

                SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));
                SetFilter("Entry/Exit Filter", Format(false));
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
        Trans: Record "prTransaction Codes";
        BalanceBF: Decimal;
        TotalEntryExits: Decimal;
        TotalEVariations: Decimal;
        TotalDVariations: Decimal;
        TransR: Record "prTransaction Codes";
        CompanyInfo: Record "Company Information";
        Reconciliation___SummaryCaptionLbl: Label 'Reconciliation - Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        DescriptionCaptionLbl: Label 'Description';
        CodeCaptionLbl: Label 'Code';
        Gross_VariationCaptionLbl: Label 'Gross Variation';
        Balance_BFCaptionLbl: Label 'Balance BF';
        Entry_ExitsCaptionLbl: Label 'Entry/Exits';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755033Lbl: Label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        NameCaption_Control1102755037Lbl: Label 'Name';
        EmptyStringCaption_Control1102755038Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        NameCaption_Control1102755040Lbl: Label 'Name';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755042Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755043Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755044Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755045Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755046Lbl: Label '......................................................................................................................................................';
}

