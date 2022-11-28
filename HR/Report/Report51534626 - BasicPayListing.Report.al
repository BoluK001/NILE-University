report 51534626 "Basic Pay Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BasicPayListing.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Normal));
            RequestFilterFields = "Current Month Filter", "Period Filter", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
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
            column(cHeader_2_; cHeader[2])
            {
            }
            column(cHeader_4_; cHeader[4])
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
            column(cValue_2_; cValue[2])
            {
            }
            column(cValue_4_; cValue[4])
            {
            }
            column(cValue_2__Control1102755065; cValue[2])
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(cValue_1__Control1102755067; cValue[4])
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
            column(Basic_Pay___Gross_Pay_ScheduleCaption; Basic_Pay___Gross_Pay_ScheduleCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 6;

                Trans.Reset;
                Trans.SetFilter(Trans."Transaction Code", 'BPAY|GPAY|NPAY');
                Trans.SetFilter(Trans."Current Month Filter", "HR-Employee".GetFilter("Current Month Filter"));
                Trans.SetFilter(Trans."Employee Code Filter", "HR-Employee"."No.");
                if Trans.Find('-') then begin
                    repeat
                        Trans.CalcFields("Curr. Amount");
                        //Basic Pay
                        cHeader[1] := 'Basic Pay';
                        if Trans."Transaction Code" = 'BPAY' then begin
                            cValue[1] := Trans."Curr. Amount";
                        end;

                        //Housing
                        cHeader[2] := 'Gross Pay';
                        if Trans."Transaction Code" = 'GPAY' then begin
                            cValue[2] := cValue[2] + Trans."Curr. Amount";
                        end;

                        //Transport
                        cHeader[3] := 'Net Pay';
                        if Trans."Transaction Code" = 'NPAY' then begin
                            cValue[3] := cValue[3] + Trans."Curr. Amount";
                        end;

                        //Position Clinical
                        cHeader[4] := 'Position Clinical'; // jj271022
                        if Trans."Transaction Code" = 'POSITION-CLINICAL' then begin
                            cValue[4] := cValue[4] + Trans."Curr. Amount";
                        end;


                    until Trans.Next = 0;

                end;


                if (cValue[2] = 0) then
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
        Basic_Pay___Gross_Pay_ScheduleCaptionLbl: Label 'Basic Pay & Gross Pay Schedule';
}

