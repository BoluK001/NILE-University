report 51534675 "NHF Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NHFSchedule.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Normal));
            RequestFilterFields = "Current Month Filter", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
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
            column(cHeader_1_; cHeader[1])
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR-Employee"."No.")
            {
            }
            column(cValue_1_; cValue[1])
            {
            }
            column(HR_Employee__NHF_No__; "NHF No.")
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(RCount; RCount)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Employee_CodeCaption; Employee_CodeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(NHF_ScheduleCaption; NHF_ScheduleCaptionLbl)
            {
            }
            column(HR_Employee__NHF_No__Caption; FieldCaption("NHF No."))
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
            column(EmptyStringCaption_Control1102755018; EmptyStringCaption_Control1102755018Lbl)
            {
            }
            column(NameCaption_Control1102755020; NameCaption_Control1102755020Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755021; EmptyStringCaption_Control1102755021Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755023; EmptyStringCaption_Control1102755023Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755025; EmptyStringCaption_Control1102755025Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755026; Signature___DateCaption_Control1102755026Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755027; EmptyStringCaption_Control1102755027Lbl)
            {
            }
            column(NameCaption_Control1102755028; NameCaption_Control1102755028Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755029; Signature___DateCaption_Control1102755029Lbl)
            {
            }
            column(CurrentMonth; "HR-Employee"."Current Month Filter")
            {
            }
            column(No; "HR-Employee"."No.")
            {
            }
            column(NHFAmt; NHFAmt)
            {
            }
            dataitem("prEmployee Transactions"; "prEmployee Transactions")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(EmployeeCode; "prEmployee Transactions"."Employee Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 6;

                Txn.Reset;
                //Txn.SETFILTER(Txn."Transaction Code",'NHF|NHFF');
                Txn.SetFilter(Txn."Payroll Period", "HR-Employee".GetFilter("Current Month Filter"));
                Txn.SetFilter(Txn."Employee Code", "HR-Employee"."No.");
                if Txn.Find('-') then begin
                    repeat
                        //Txn.CALCFIELDS("Amount");
                        //NHF
                        cHeader[1] := 'NHF';
                        if (Txn."Transaction Code" = 'NHF') or (Txn."Transaction Code" = 'NHFF') then begin
                            cValue[1] := +Txn.Amount;
                        end;

                    until Txn.Next = 0;

                end;




                if (cValue[1] = 0) then
                    CurrReport.Skip;

                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if "HR-Employee".GetFilter("HR-Employee"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(cValue[1], cValue[2], cValue[3], cValue[4], cValue[5], cValue[6], cValue[7], cValue[8], cValue[9], cValue[10]);
                CurrReport.CreateTotals(cValue[11], cValue[12], cValue[13], cValue[14], cValue[15], cValue[16], cValue[17]);
                CurrReport.CreateTotals(cValue[18], cValue[19], cValue[20]);

                if VitalInfo.Get('') then
                    NISTFRate := VitalInfo."NISTF % of Basic Pay";

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
        strEmpName: Text[100];
        cHeader: array[200] of Text[200];
        cValue: array[200] of Decimal;
        Trans: Record "prTransaction Codes";
        ColNo: Integer;
        i: Integer;
        RCount: Integer;
        VitalInfo: Record "prVital Setup Info";
        NISTFRate: Decimal;
        SalaryGrades: Record "Salary Grades";
        CompanyInfo: Record "Company Information";
        Employee_NameCaptionLbl: Label 'Employee Name';
        Employee_CodeCaptionLbl: Label 'Employee Code';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NHF_ScheduleCaptionLbl: Label 'NHF Schedule';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        EmptyStringCaption_Control1102755018Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755020Lbl: Label 'Name';
        EmptyStringCaption_Control1102755021Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        EmptyStringCaption_Control1102755023Lbl: Label '......................................................................................................................................................';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755025Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755026Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755027Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755028Lbl: Label 'Name';
        Signature___DateCaption_Control1102755029Lbl: Label 'Signature & Date';
        Txn: Record "prPeriod Transactions";
        PeriodTrans: Record "prPeriod Transactions";
        NHFAmt: Decimal;
}

