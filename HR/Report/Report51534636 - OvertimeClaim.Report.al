report 51534636 "Overtime Claim"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OvertimeClaim.rdlc';

    dataset
    {
        dataitem("Payroll Variations"; "Payroll Variations")
        {
            DataItemTableView = SORTING ("Employee Code");
            RequestFilterFields = "Employee Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Payroll_Variations__Employee_Code_; "Employee Code")
            {
            }
            column(Payroll_Variations__Payroll_Period_; "Payroll Period")
            {
            }
            column(Payroll_Variations__Effective_Date_; "Effective Date")
            {
            }
            column(Names; Names)
            {
            }
            column(Payroll_Variations__Hrs_Worked_; "Hrs Worked")
            {
            }
            column(Payroll_Variations__Overtime_Type_; "Overtime Type")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Overtime_Claim_DetailsCaption; Overtime_Claim_DetailsCaptionLbl)
            {
            }
            column(Payroll_Variations__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(Payroll_Variations__Payroll_Period_Caption; FieldCaption("Payroll Period"))
            {
            }
            column(Payroll_Variations__Effective_Date_Caption; FieldCaption("Effective Date"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Payroll_Variations__Hrs_Worked_Caption; FieldCaption("Hrs Worked"))
            {
            }
            column(Payroll_Variations__Overtime_Type_Caption; FieldCaption("Overtime Type"))
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Names := '';
                if "Hr-Employee".Get("Employee Code") then
                    Names := "Hr-Employee"."First Name" + ' ' + "Hr-Employee"."Middle Name" + ' ' + "Hr-Employee"."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee Code");
                "Payroll Variations".SetRange("Payroll Variations".Type, "Payroll Variations".Type::"Overtime Claim")
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
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
        "Hr-Employee": Record "HR-Employee";
        Names: Text[100];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Overtime_Claim_DetailsCaptionLbl: Label 'Overtime Claim Details';
        NamesCaptionLbl: Label 'Names';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

