report 51534655 "Reconciliation - By Entry/Exit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReconciliationByEntryExit.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "Current Month Filter", "Gross Income Variation", "Location/Division Code", "Department Code", "Cost Center Code", "Salary Grade", "Salary Notch/Step";
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
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Status; Status)
            {
            }
            column(HR_Employee__Prev__Gross_Pay_; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay_; "Curr. Gross Pay")
            {
            }
            column(HR_Employee__Gross_Income_Variation_; "Gross Income Variation")
            {
            }
            column(VariationRemarks; VariationRemarks)
            {
            }
            column(HR_Employee__No___Control1102755016; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name__Control1102755017; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee_Status_Control1102755025; Status)
            {
            }
            column(HR_Employee__Prev__Gross_Pay__Control1102755026; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay__Control1102755027; "Curr. Gross Pay")
            {
            }
            column(HR_Employee__Gross_Income_Variation__Control1102755028; "Gross Income Variation")
            {
            }
            column(VariationRemarks_Control1102755031; VariationRemarks)
            {
            }
            column(HR_Employee__Gross_Income_Variation__Control1102755024; "Gross Income Variation")
            {
            }
            column(RCount; RCount)
            {
            }
            column(HR_Employee__Prev__Gross_Pay__Control1102755034; "Prev. Gross Pay")
            {
            }
            column(HR_Employee__Curr__Gross_Pay__Control1102755035; "Curr. Gross Pay")
            {
            }
            column(Salary_Reconciliations___By_Staff_Entry_ExitsCaption; Salary_Reconciliations___By_Staff_Entry_ExitsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(HR_Employee_StatusCaption; FieldCaption(Status))
            {
            }
            column(HR_Employee__Prev__Gross_Pay_Caption; FieldCaption("Prev. Gross Pay"))
            {
            }
            column(HR_Employee__Curr__Gross_Pay_Caption; FieldCaption("Curr. Gross Pay"))
            {
            }
            column(HR_Employee__Gross_Income_Variation_Caption; FieldCaption("Gross Income Variation"))
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                VariationRemarks := '';

                if ("HR-Employee"."Prev. Gross Pay" = 0) and ("HR-Employee"."Curr. Gross Pay" = 0) then
                    CurrReport.Skip;


                if ("HR-Employee"."Prev. Gross Pay" > 0) and ("HR-Employee"."Curr. Gross Pay" > 0) then
                    CurrReport.Skip;


                if "HR-Employee"."Gross Income Variation" <> 0 then begin
                    MonthlyRecon.Reset;
                    MonthlyRecon.SetCurrentKey(MonthlyRecon.Employee);
                    MonthlyRecon.SetRange(MonthlyRecon.Employee, "HR-Employee"."No.");
                    MonthlyRecon.SetFilter(MonthlyRecon."Group Order", '=1|=3');
                    if MonthlyRecon.Find('-') then begin
                        repeat
                            if StrLen(VariationRemarks + ', ' + MonthlyRecon.Description + '[]' + Format(MonthlyRecon.Difference)) < 1000 then begin
                                if VariationRemarks = '' then
                                    VariationRemarks := MonthlyRecon.Description + '[' + Format(MonthlyRecon.Difference) + ']'
                                else
                                    VariationRemarks := VariationRemarks + ', ' + MonthlyRecon.Description + '[' + Format(MonthlyRecon.Difference) + ']';
                            end;

                        until MonthlyRecon.Next = 0;
                    end;
                end;

                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                if "HR-Employee".GetFilter("HR-Employee"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                Evaluate(SelectedPeriod, GetFilter("HR-Employee"."Current Month Filter"));

                "HR-Employee".SetFilter("Previous Month Filter", Format(CalcDate('-1M', SelectedPeriod)));

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
        RCount: Integer;
        VariationRemarks: Text[1000];
        MonthlyRecon: Record "Monthly Reconcilliation";
        SelectedPeriod: Date;
        CompanyInfo: Record "Company Information";
        Salary_Reconciliations___By_Staff_Entry_ExitsCaptionLbl: Label 'Salary Reconciliations - By Staff Entry/Exits';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
        RemarksCaptionLbl: Label 'Remarks';
}

