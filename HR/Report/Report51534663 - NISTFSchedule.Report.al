report 51534663 "NISTF Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NISTFSchedule.rdlc';

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
            column(cHeader_2_; cHeader[2])
            {
            }
            column(cHeader_3_; cHeader[3])
            {
            }
            column(cHeader_5_; cHeader[5])
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
            column(cValue_3_; cValue[3])
            {
            }
            column(cValue_5_; cValue[5])
            {
            }
            column(cValue_4_; cValue[4])
            {
            }
            column(HR_Employee__NSITF_No__; "NSITF No.")
            {
            }
            column(cValue_4__Control1102755063; cValue[4])
            {
            }
            column(cValue_3__Control1102755064; cValue[3])
            {
            }
            column(cValue_2__Control1102755065; cValue[2])
            {
            }
            column(cValue_1__Control1102755066; cValue[1])
            {
            }
            column(RCount; RCount)
            {
            }
            column(cValue_5__Control1102755011; cValue[5])
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
            column(NISTF_ScheduleCaption; NISTF_ScheduleCaptionLbl)
            {
            }
            column(HR_Employee__NSITF_No__Caption; FieldCaption("NSITF No."))
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
            column(EmptyStringCaption_Control1102755023; EmptyStringCaption_Control1102755023Lbl)
            {
            }
            column(NameCaption_Control1102755024; NameCaption_Control1102755024Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755025; EmptyStringCaption_Control1102755025Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755027; NameCaption_Control1102755027Lbl)
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
            column(Signature___DateCaption_Control1102755034; Signature___DateCaption_Control1102755034Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755035; EmptyStringCaption_Control1102755035Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                strEmpName := "Last Name" + ' ' + "First Name" + ' ' + "Middle Name";

                if SalaryGrades.Get("HR-Employee"."Salary Grade") then begin
                    if SalaryGrades."Pays NSITF" = false then
                        CurrReport.Skip;
                end;

                i := 1;
                repeat
                    i := i + 1;
                    cValue[i] := 0;
                until i = 6;

                Trans.Reset;
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
                        cHeader[2] := 'Housing';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Housing then begin
                            cValue[2] := cValue[2] + Trans."Curr. Amount";
                        end;

                        //Transport
                        cHeader[3] := 'Transport';
                        if Trans."Transaction Category" = Trans."Transaction Category"::Transport then begin
                            cValue[3] := cValue[3] + Trans."Curr. Amount";
                        end;

                        cHeader[4] := 'Total';
                        cValue[4] := (cValue[1] + cValue[2] + cValue[3]);


                        //NISTF
                        cHeader[5] := 'NISTF';
                        cValue[5] := (cValue[1] + cValue[2] + cValue[3]) * NISTFRate * NISTFRate * 0.01;



                    until Trans.Next = 0;
                end;

                if (cValue[4] = 0) then
                    CurrReport.Skip;

                if PrintToExcel then begin
                    if HeaderCreated = false then begin
                        MakeExcelDataHeader;
                        HeaderCreated := true;
                    end;
                end;

                if PrintToExcel then
                    MakeExcelDataBody;


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

    trigger OnPostReport()
    begin
        if PrintToExcel then
            MakeExcelTotalBody;


        if PrintToExcel then
            CreateExcelbook;
    end;

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
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        HeaderCreated: Boolean;
        Employee_NameCaptionLbl: Label 'Employee Name';
        Employee_CodeCaptionLbl: Label 'Employee Code';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NISTF_ScheduleCaptionLbl: Label 'NISTF Schedule';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        Authorised_by_CaptionLbl: Label 'Authorised by:';
        NameCaptionLbl: Label 'Name';
        EmptyStringCaptionLbl: Label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755023Lbl: Label '......................................................................................................................................................';
        NameCaption_Control1102755024Lbl: Label 'Name';
        EmptyStringCaption_Control1102755025Lbl: Label '......................................................................................................................................................';
        Approved_by_CaptionLbl: Label 'Approved by:';
        NameCaption_Control1102755027Lbl: Label 'Name';
        Signature___DateCaptionLbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755029Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755030Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755031Lbl: Label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755034Lbl: Label 'Signature & Date';
        EmptyStringCaption_Control1102755035Lbl: Label '......................................................................................................................................................';

    local procedure MakeExcelDataHeader()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee Code',FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn('Names',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('NSITF No.',FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn(cHeader[1],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[2],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[3],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[4],FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(cHeader[5],FALSE,'',TRUE,FALSE,TRUE,'');
        */

    end;

    [Scope('OnPrem')]
    procedure MakeExcelDataBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(("HR-Employee"."No."),FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(strEmpName,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("HR-Employee"."NSITF No.",FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        */

    end;

    [Scope('OnPrem')]
    procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet('Bank Payment Schedule','Bank Payment Schedule',COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;

    [Scope('OnPrem')]
    procedure MakeExcelTotalBody()
    begin
        /*
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(cValue[1],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[2],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[3],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[4],FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(cValue[5],FALSE,'',FALSE,FALSE,FALSE,'');
        */

    end;
}

