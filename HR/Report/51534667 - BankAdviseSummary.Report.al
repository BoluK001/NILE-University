report 51534667 "Bank Advise Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BankAdviseSummary.rdlc';

    dataset
    {
        dataitem("prBank Structure"; "prBank Structure")
        {
            DataItemTableView = SORTING ("Bank Code", "Branch Code");
            RequestFilterFields = "Current Month Filter", "Location/Division Filter", "Department Filter", "Cost Centre Filter", "Salary Grade Filter", "Salary Notch Filter", "Bank Sort Code";
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
            column(prBank_Structure__Branch_Name_; "Branch Name")
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Name")
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
            column(Bank_Advice_SummaryCaption; Bank_Advice_SummaryCaptionLbl)
            {
            }
            column(Bank_NameCaption; Bank_NameCaptionLbl)
            {
            }
            column(Bank_BranchCaption; Bank_BranchCaptionLbl)
            {
            }
            column(No__Of_EmployeesCaption; No__Of_EmployeesCaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755017; EmptyStringCaption_Control1102755017Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755018; Signature___DateCaption_Control1102755018Lbl)
            {
            }
            column(NameCaption_Control1102755019; NameCaption_Control1102755019Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755020; EmptyStringCaption_Control1102755020Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755028; EmptyStringCaption_Control1102755028Lbl)
            {
            }
            column(NameCaption_Control1102755029; NameCaption_Control1102755029Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755030; Signature___DateCaption_Control1102755030Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755031; EmptyStringCaption_Control1102755031Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755032; EmptyStringCaption_Control1102755032Lbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(prBank_Structure_Bank_Code; "Bank Code")
            {
            }
            column(prBank_Structure_Branch_Code; "Branch Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := 0;
                TCount := 0;
                NetAmount := 0;

                Employee.Reset;
                Employee.SetRange(Employee."Main Bank", "prBank Structure"."Bank Code");
                //Employee.SETRANGE(Employee."Branch Bank","prBank Structure"."Branch Code");
                Employee.SetFilter("Current Month Filter", "prBank Structure".GetFilter("prBank Structure"."Current Month Filter"));
                Employee.SetFilter("Location/Division Code", "prBank Structure".GetFilter("prBank Structure"."Location/Division Filter"));
                Employee.SetFilter("Department Code", "prBank Structure".GetFilter("prBank Structure"."Department Filter"));
                Employee.SetFilter("Payroll Class", "prBank Structure".GetFilter("prBank Structure"."Bank Sort Code"));

                //Employee.SETFILTER("Cost Center Code","prBank Structure".GETFILTER("prBank Structure"."Cost Centre Filter"));
                //Employee.SETFILTER("Salary Grade","prBank Structure".GETFILTER("prBank Structure"."Salary Grade Filter"));
                //Employee.SETFILTER("Salary Notch/Step","prBank Structure".GETFILTER("prBank Structure"."Salary Notch Filter"));
                if Employee.Find('-') then begin
                    repeat
                        Employee.CalcFields(Employee."Net Pay");
                        if Employee."Net Pay" > 0 then begin
                            RCount := RCount + 1;
                            TCount := TCount + 1;
                            NetAmount := NetAmount + Employee."Net Pay";
                        end;
                    until Employee.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "prBank Structure".GetFilter("Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(NetAmount);

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
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bank_Advice_SummaryCaptionLbl: Label 'Bank Advice Summary';
        Bank_NameCaptionLbl: Label 'Bank Name';
        Bank_BranchCaptionLbl: Label 'Bank Branch';
        No__Of_EmployeesCaptionLbl: Label 'No. Of Employees';
        Net_AmountCaptionLbl: Label 'Net Amount';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755017Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755018Lbl: Label 'Signature & Date';
        NameCaption_Control1102755019Lbl: Label 'Name';
        EmptyStringCaption_Control1102755020Lbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755028Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755029Lbl: Label 'Name';
        Signature___DateCaption_Control1102755030Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755031Lbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755032Lbl: Label '......................................................................................................................................................';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        Approved_by_CaptionLbl: Label 'Approved by:';
}

