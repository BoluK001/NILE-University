report 51534748 "Contract Pension Contrib Bal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ContractPensionContribBal.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            DataItemTableView = WHERE("Salary Grade" = CONST('AS|SNR-AS'));
            RequestFilterFields = "Period Filter", "Pension House Filter", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
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
            column(Companyinfo_Picture; Companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
            {
            }
            column(SelfContrib; SelfContrib)
            {
            }
            column(CompanyContrib; CompanyContrib)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(CummContrib; CummContrib)
            {
            }
            column(PINNo; PINNo)
            {
            }
            column(PensionH; PensionH)
            {
            }
            column(RCount; RCount)
            {
            }
            column(TotCompanyContrib; TotCompanyContrib)
            {
            }
            column(TotSelfContrib; TotSelfContrib)
            {
            }
            column(TotCummContrib; TotCummContrib)
            {
            }
            column(Self_ContributionCaption; Self_ContributionCaptionLbl)
            {
            }
            column(Company_Contrib_Caption; Company_Contrib_CaptionLbl)
            {
            }
            column(Cumm_ContributionCaption; Cumm_ContributionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Earnings_SummaryCaption; Employee_Earnings_SummaryCaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(Pension_No_Caption; Pension_No_CaptionLbl)
            {
            }
            column(Pension_HouseCaption; Pension_HouseCaptionLbl)
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
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755030; EmptyStringCaption_Control1102755030Lbl)
            {
            }
            column(NameCaption_Control1102755031; NameCaption_Control1102755031Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755032; EmptyStringCaption_Control1102755032Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755034; EmptyStringCaption_Control1102755034Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755037; EmptyStringCaption_Control1102755037Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755039; Signature___DateCaption_Control1102755039Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755041; EmptyStringCaption_Control1102755041Lbl)
            {
            }
            column(NameCaption_Control1102755042; NameCaption_Control1102755042Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755043; Signature___DateCaption_Control1102755043Lbl)
            {
            }
            column(VoluntaryCont; VoluntaryCont)
            {
            }
            column(obj_trans_code; objListTrans."Transaction Code")
            {
            }
            column(obj_trans_amt; objListTrans.Amount)
            {
            }
            column(date1; date1)
            {
            }
            column(date2; date2)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PINNo := '';
                EmployeeName := '';

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";
                    PINNo := objEmp."PIN No.";
                    PensionH := objEmp."Pension House";
                    if PensionHouse <> '' then begin
                        if PensionHouse <> objEmp."Pension House" then
                            CurrReport.Skip;
                    end;
                end;

                //**changes added to enhance exclusion of employees without pin
                //IF ExcludeEmpWithoutPin = TRUE THEN
                //IF PINNo = '' THEN

                if showCriteria = showCriteria::"Show Without PIN Only" then begin
                    if PINNo <> '' then CurrReport.Skip;
                end
                else
                    if showCriteria = showCriteria::"Show With PIN Only" then begin
                        if PINNo = '' then CurrReport.Skip;
                    end;

                SelfContrib1 := 0;
                CompanyContrib2 := 0;
                VoluntaryCont := 0;
                SelfContrib := 0;
                CompanyContrib := 0;
                SelfContribARREARS := 0;
                CompanyContribARREARS := 0;

                BasicPay := 0;

                //Get the Basic pay
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                PeriodTrans.SetRange(PeriodTrans."Group Order", 1);
                PeriodTrans.SetRange(PeriodTrans."Sub Group Order", 1);
                if PeriodTrans.Find('-') then begin
                    repeat
                        BasicPay := BasicPay + PeriodTrans.Amount;

                    until PeriodTrans.Next = 0;
                end;

                SelfContrib := 0;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                //PeriodTrans.SETRANGE(PeriodTrans."Transaction Name",'PENSION');
                PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);  //dennis
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", SelfContribCode);   //SelfContribCode
                if PeriodTrans.Find('-') then begin
                    repeat
                        SelfContrib := SelfContrib + PeriodTrans.Amount;
                    until PeriodTrans.Next = 0;
                end;

                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                PeriodTrans.SetRange(PeriodTrans."Company Deduction", false);  //dennis
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'PENS2');   //SelfContribCode
                if PeriodTrans.Find('-') then begin
                    repeat
                        SelfContrib := PeriodTrans.Amount;
                        SelfContrib1 := PeriodTrans.Amount;
                    until PeriodTrans.Next = 0;
                end;

                SelfContrib := SelfContrib + SelfContribARREARS;

                //PKK

                prEmployerContrib.Reset;
                prEmployerContrib.SetRange(prEmployerContrib."Employee Code", "Employee Code");
                //prEmployerContrib.SETRANGE(prEmployerContrib."Payroll Period",SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                prEmployerContrib.SetRange(prEmployerContrib."Transaction Code", SelfContribCode);
                if prEmployerContrib.Find('-') then begin
                    repeat
                        CompanyContrib := CompanyContrib + prEmployerContrib.Amount;
                    until prEmployerContrib.Next = 0;
                end;

                //PKK

                prEmployerContrib.Reset;
                prEmployerContrib.SetRange(prEmployerContrib."Employee Code", "Employee Code");
                //prEmployerContrib.SETRANGE(prEmployerContrib."Payroll Period",SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                prEmployerContrib.SetRange(prEmployerContrib."Transaction Code", 'PENS2');
                if prEmployerContrib.Find('-') then begin
                    repeat
                        CompanyContrib := CompanyContrib + prEmployerContrib.Amount;
                        CompanyContrib2 := CompanyContrib2 + prEmployerContrib.Amount;
                    until prEmployerContrib.Next = 0;
                end;

                VoluntaryCont := SelfContrib1 + CompanyContrib2;

                CompanyContrib := CompanyContrib + CompanyContribARREARS;

                //CummContrib:= SelfContrib+CompanyContrib+VoluntaryCont;

                RCount := RCount + 1;

                //get voluntary contributions
                //self contribution...Defined contribution is a Special Transaction 1
                objTransCode.Reset;
                //objTransCode.SETRANGE(objTransCode.Pension,TRUE);
                objTransCode.SetRange(objTransCode.Passage, true);
                if objTransCode.FindSet then
                    repeat
                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                        //   PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                        PeriodTrans.SetFilter(PeriodTrans."Payroll Period", '%1..%2', date1, date2);//PeriodFilter
                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", objTransCode."Transaction Code");
                        if PeriodTrans.Find('-') then begin
                            repeat
                                VoluntaryCont := PeriodTrans.Amount;
                            //CompanyContrib:=SelfContrib; //PKK
                            until PeriodTrans.Next = 0;
                        end;
                    until objTransCode.Next = 0;

                CummContrib := SelfContrib + CompanyContrib + VoluntaryCont;

                if (SelfContrib <= 0) /*AND (CompanyContrib<=0)*/ and (VoluntaryCont <= 0) /*OR ((objListTrans."Transaction Code"='AVC') AND (objListTrans.Amount<>0))*/ then
                    // ELSE
                    // (objListTrans."Transaction Code"='AVC') AND (objListTrans.Amount<>0)
                    CurrReport.Skip;
                TotBasicPay := TotBasicPay + BasicPay;
                TotSelfContrib := TotSelfContrib + SelfContrib;
                TotCompanyContrib := TotCompanyContrib + CompanyContrib;
                TotCummContrib := TotCummContrib + CummContrib + VoluntaryCont;
                // ELSE
                // (objListTrans."Transaction Code"='AVC') AND (objListTrans.Amount<>0)
                //   IF(PeriodTrans.PeriodTrans."Transaction Code"='AVC')

            end;

            trigger OnPreDataItem()
            begin
                objTransCode.Reset;
                objTransCode.SetRange(objTransCode.Pension, true);
                if objTransCode.Find('-') then
                    SelfContribCode := objTransCode."Transaction Code";

                PensionHouse := "prSalary Card".GetFilter("Pension House Filter");

                if Companyinfo.Get() then
                    Companyinfo.CalcFields(Companyinfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(showCriteria; showCriteria)
                {
                    Caption = 'Display Criteria';
                }
                field(Date1; date1)
                {
                    Caption = 'From Date';
                }
                field(Date2; date2)
                {
                    Caption = 'To Date';
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

    trigger OnPreReport()
    begin
        PeriodFilter := Format(date1) + '..' + Format(date2); //"prSalary Card".GETFILTER("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := date1;//"prSalary Card".GETRANGEMIN(PeriodFilter);
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";

        //self contribution...Defined contribution is a Special Transaction 1
        objTransCode.Reset;
        objTransCode.SetRange(objTransCode.Pension, true);
        if objTransCode.Find('-') then begin
            repeat
                SelfContribCode := objTransCode."Transaction Code";
            until objTransCode.Next = 0;
        end;

        //self contribution...Defined contribution is a Special Transaction 1 PENSION ARREARS
        objTransCode.Reset;
        objTransCode.SetRange(objTransCode."Transaction Code", '114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            SelfContribCodeArrears := objTransCode."Transaction Code";
        end;

        //Company contribution
        objTransCode.Reset;
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-455'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCode := 'Emp-455';


        //Company contribution ARREARS
        objTransCode.Reset;
        //objTransCode.SETRANGE(objTransCode."Special Transactions",1);
        //objTransCode.SETRANGE(objTransCode."Employer Deduction",TRUE);
        objTransCode.SetRange(objTransCode."Transaction Code", 'Emp-114'); //HARD CODED TO ENSURE THE self pension is calx - Dennis
        if objTransCode.Find('-') then begin
            // CompanyContribCode:=objTransCode."Transaction Code";
        end;
        CompanyContribCodeArrears := 'Emp-114';


        if Companyinfo.Get() then
            Companyinfo.CalcFields(Companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        BasicPay: Decimal;
        SelfContrib: Decimal;
        CompanyContrib: Decimal;
        CummContrib: Decimal;
        TotBasicPay: Decimal;
        TotSelfContrib: Decimal;
        TotCompanyContrib: Decimal;
        TotCummContrib: Decimal;
        EmployeeName: Text[200];
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodFilter: Text[30];
        PeriodName: Text[30];
        SelfContribCode: Text[30];
        CompanyContribCode: Text[30];
        objTransCode: Record "prTransaction Codes";
        SelfContribCodeArrears: Text[30];
        CompanyContribCodeArrears: Text[30];
        SelfContribARREARS: Decimal;
        CompanyContribARREARS: Decimal;
        prEmployerContrib: Record "prEmployer Deductions";
        Companyinfo: Record "Company Information";
        PINNo: Code[50];
        PensionHouse: Code[100];
        PensionH: Code[20];
        RCount: Integer;
        PrintToExcel: Boolean;
        HeaderCreated: Boolean;
        GrandTotal: Decimal;
        Self_ContributionCaptionLbl: Label 'Self Contribution';
        Company_Contrib_CaptionLbl: Label 'Company Contrib.';
        Cumm_ContributionCaptionLbl: Label 'Cumm Contribution';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Earnings_SummaryCaptionLbl: Label 'Employee Earnings Summary';
        NamesCaptionLbl: Label 'Names';
        Employee_CodeCaptionLbl: Label 'Employee Code';
        Pension_No_CaptionLbl: Label 'Pension No.';
        Pension_HouseCaptionLbl: Label 'Pension House';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        EmptyStringCaption_Control1102755030Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755031Lbl: Label 'Name';
        EmptyStringCaption_Control1102755032Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        EmptyStringCaption_Control1102755034Lbl: Label '......................................................................................................................................................';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755037Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755039Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755041Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755042Lbl: Label 'Name';
        Signature___DateCaption_Control1102755043Lbl: Label 'Signature & Date';
        PensionNo: Code[20];
        ExcludeEmpWithoutPin: Boolean;
        VoluntaryCont: Decimal;
        SelfContrib1: Decimal;
        CompanyContrib2: Decimal;
        objListTrans: Record "prEmployee Transactions";
        showCriteria: Option ShowAll,"Show Without PIN Only","Show With PIN Only";
        date1: Date;
        date2: Date;
}

