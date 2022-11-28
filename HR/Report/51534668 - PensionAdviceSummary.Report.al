report 51534668 "Pension Advice Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PensionAdviceSummary.rdlc';

    dataset
    {
        dataitem("prInstitutional Membership"; "prInstitutional Membership")
        {
            DataItemTableView = SORTING ("Group No", "Institution No") WHERE ("Group No" = CONST ('PENSION'));
            RequestFilterFields = "Current Month Filter", "Location/Division Filter", "Department Filter", "Cost Centre Filter", "Salary Grade Filter", "Salary Notch Filter";
            column(GETFILTERS_; GetFilters)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(RCount; RCount)
            {
            }
            column(prInstitutional_Membership__prInstitutional_Membership__Description; "prInstitutional Membership".Description)
            {
            }
            column(TCount; TCount)
            {
            }
            column(NetAmount_Control1102755006; NetAmount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Staff_Pension_Advice_SummaryCaption; Staff_Pension_Advice_SummaryCaptionLbl)
            {
            }
            column(Pension_HouseCaption; Pension_HouseCaptionLbl)
            {
            }
            column(No__Of_EmployeesCaption; No__Of_EmployeesCaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755016; EmptyStringCaption_Control1102755016Lbl)
            {
            }
            column(NameCaption_Control1102755017; NameCaption_Control1102755017Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755018; EmptyStringCaption_Control1102755018Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755020; NameCaption_Control1102755020Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755029; EmptyStringCaption_Control1102755029Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755030; Signature___DateCaption_Control1102755030Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755031; EmptyStringCaption_Control1102755031Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755032; Signature___DateCaption_Control1102755032Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755033; EmptyStringCaption_Control1102755033Lbl)
            {
            }
            column(prInstitutional_Membership_Group_No; "Group No")
            {
            }
            column(prInstitutional_Membership_Institution_No; "Institution No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := 0;
                NetAmount := 0;


                Employee.Reset;
                Employee.SetRange(Employee."Pension House", "prInstitutional Membership"."Institution No");
                Employee.SetFilter("Current Month Filter", GetFilter("Current Month Filter"));
                Employee.SetFilter("Location/Division Code", GetFilter("Location/Division Filter"));
                Employee.SetFilter("Department Code", GetFilter("Department Filter"));
                Employee.SetFilter("Cost Center Code", GetFilter("Cost Centre Filter"));
                Employee.SetFilter("Salary Grade", GetFilter("Salary Grade Filter"));
                Employee.SetFilter("Salary Notch/Step", GetFilter("Salary Notch Filter"));
                Employee.SetFilter(Employee."Transaction Code Filter", TransCodeFilter);
                if Employee.Find('-') then begin
                    repeat
                        Employee.CalcFields(Employee."Transaction Amount");
                        if Employee."Transaction Amount" > 0 then begin
                            RCount := RCount + 1;
                            TCount := TCount + 1;
                            NetAmount := NetAmount + Employee."Transaction Amount";
                        end;
                    until Employee.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(NetAmount);

                Trans.Reset;
                Trans.SetRange(Trans.Pension, true);
                if Trans.Find('-') then begin
                    repeat
                        if TransCodeFilter = '' then
                            TransCodeFilter := Trans."Transaction Code"
                        else
                            TransCodeFilter := TransCodeFilter + '|' + Trans."Transaction Code";
                    until Trans.Next = 0;
                end;

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
        EmployeeName: Text[200];
        bankStruct: Record "prBank Structure";
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
        RCount: Integer;
        NetAmount: Decimal;
        Employee: Record "HR-Employee";
        TCount: Integer;
        TransCodeFilter: Code[200];
        Trans: Record "prTransaction Codes";
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_Pension_Advice_SummaryCaptionLbl: Label 'Staff Pension Advice Summary';
        Pension_HouseCaptionLbl: Label 'Pension House';
        No__Of_EmployeesCaptionLbl: Label 'No. Of Employees';
        Net_AmountCaptionLbl: Label 'Net Amount';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755016Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755017Lbl: Label 'Name';
        EmptyStringCaption_Control1102755018Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        NameCaption_Control1102755020Lbl: Label 'Name';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755029Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755030Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755031Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755032Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755033Lbl: Label '......................................................................................................................................................';
}

