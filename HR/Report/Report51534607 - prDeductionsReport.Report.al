report 51534607 "prDeductions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './prDeductionsReport.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = SORTING ("Group Order", "Transaction Code", "Period Month", "Period Year");
            RequestFilterFields = "Payroll Period", "Transaction Code";
            column(GETFILTERS; GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions___Transaction_Name_; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(prPeriod_Transactions__prPeriod_Transactions__Membership; "prPeriod Transactions".Membership)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755038; Amount)
            {
            }
            column(prPeriod_Transactions_Balance_Control1102755039; Balance)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transactions___DetailedCaption; Transactions___DetailedCaptionLbl)
            {
            }
            column(Period_AmountCaption; Period_AmountCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    strEmpName := objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                end;

                "prPeriod Transactions".SetRange("Payroll Period", SelectedPeriod);
                //"prPeriod Transactions".SETFILTER("Group Order",'=7|=8');

                if (Amount <= 0) or ("prPeriod Transactions"."Transaction Code" = 'TOT-DED') or ("prPeriod Transactions"."Group Order" = 1) then begin
                    GrandTotal := GrandTotal + 0;
                    CurrReport.Skip;
                end;

                GrandTotal := GrandTotal + Amount;
                GrandBalance := GrandBalance + Balance;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Period Year");
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
        SelectedPeriod := "prPeriod Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;



        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        PeriodTrans: Record "prPeriod Transactions";
        GroupOrder: Label '3';
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        GrandTotal: Decimal;
        strEmpName: Text[100];
        objEmp: Record "HR-Employee";
        GrandBalance: Decimal;
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Transactions___DetailedCaptionLbl: Label 'Transactions - Detailed';
        Period_AmountCaptionLbl: Label 'Period Amount';
        BalanceCaptionLbl: Label 'Balance';
        Employee_No_CaptionLbl: Label 'Employee No.';
        Employee_Name_CaptionLbl: Label 'Employee Name:';
}

