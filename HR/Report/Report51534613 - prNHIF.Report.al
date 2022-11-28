report 51534613 prNHIF
{
    DefaultLayout = RDLC;
    RDLCLayout = './prNHIF.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Address; Address)
            {
            }
            column(EmployerNHIFNo; EmployerNHIFNo)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(PeriodName_Control1102756007; PeriodName)
            {
            }
            column(NhifAmount; NhifAmount)
            {
            }
            column(IDNumber; IDNumber)
            {
            }
            column(NhifNo; NhifNo)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(Dob; Dob)
            {
            }
            column(TotNhifAmount; TotNhifAmount)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUNDCaption; NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(PERIOD_Caption_Control1102755032; PERIOD_Caption_Control1102755032Lbl)
            {
            }
            column(ADDRESS_Caption; ADDRESS_CaptionLbl)
            {
            }
            column(EMPLOYER_Caption; EMPLOYER_CaptionLbl)
            {
            }
            column(EMPOLOYER_NO_Caption; EMPOLOYER_NO_CaptionLbl)
            {
            }
            column(EMPLOYER_PIN_NO_Caption; EMPLOYER_PIN_NO_CaptionLbl)
            {
            }
            column(TEL_NO_Caption; TEL_NO_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_Number_Caption; ID_Number_CaptionLbl)
            {
            }
            column(NHIF_No_Caption; NHIF_No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Date_Of_BirthCaption; Date_Of_BirthCaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Total_NHIF_Caption; Total_NHIF_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then;
                EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                NhifNo := objEmp."NHIF No.";
                IDNumber := objEmp."ID Number";
                Dob := objEmp."Date Of Birth";

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Group Order", '=7');
                PeriodTrans.SetFilter(PeriodTrans."Sub Group Order", '=2');
                PeriodTrans.SetCurrentKey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");

                NhifAmount := 0;
                if PeriodTrans.Find('-') then begin
                    NhifAmount := PeriodTrans.Amount;
                end;

                if NhifAmount <= 0 then
                    CurrReport.Skip;
                TotNhifAmount := TotNhifAmount + NhifAmount;
            end;

            trigger OnPreDataItem()
            begin
                if CompInfoSetup.Get() then
                    EmployerNHIFNo := CompInfoSetup."N.H.I.F No";
                CompPINNo := CompInfoSetup."Company P.I.N";
                Address := CompInfoSetup.Address;
                Tel := CompInfoSetup."Phone No.";
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        NhifAmount: Decimal;
        TotNhifAmount: Decimal;
        EmployeeName: Text[30];
        NhifNo: Text[30];
        IDNumber: Text[30];
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        objEmp: Record "HR-Employee";
        CompInfoSetup: Record "Control-Information";
        EmployerNHIFNo: Code[20];
        CompPINNo: Code[20];
        Address: Text[90];
        Tel: Text[30];
        Dob: Date;
        Companyinfo: Record "Company Information";
        NATIONAL_HOSPITAL_INSURANCE_FUNDCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        PERIOD_Caption_Control1102755032Lbl: Label 'PERIOD:';
        ADDRESS_CaptionLbl: Label 'ADDRESS:';
        EMPLOYER_CaptionLbl: Label 'EMPLOYER:';
        EMPOLOYER_NO_CaptionLbl: Label 'EMPOLOYER NO:';
        EMPLOYER_PIN_NO_CaptionLbl: Label 'EMPLOYER PIN NO:';
        TEL_NO_CaptionLbl: Label 'TEL NO:';
        AmountCaptionLbl: Label 'Amount';
        ID_Number_CaptionLbl: Label 'ID Number:';
        NHIF_No_CaptionLbl: Label 'NHIF No:';
        Employee_NameCaptionLbl: Label 'Employee Name';
        No_CaptionLbl: Label 'No:';
        Date_Of_BirthCaptionLbl: Label 'Date Of Birth';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Total_NHIF_CaptionLbl: Label 'Total NHIF:';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

