report 51534637 "Staff Transfer Advise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffTransferAdvise.rdlc';

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
            column(Payroll_Variations__Department_Code_; "Department Code")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Staff_Transfer_AdviseCaption; Staff_Transfer_AdviseCaptionLbl)
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
            column(Payroll_Variations__Department_Code_Caption; FieldCaption("Department Code"))
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
                "Payroll Variations".SetRange("Payroll Variations".Type, "Payroll Variations".Type::"New Employee")
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
        Staff_Transfer_AdviseCaptionLbl: Label 'Staff Transfer Advise';
        NamesCaptionLbl: Label 'Names';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

