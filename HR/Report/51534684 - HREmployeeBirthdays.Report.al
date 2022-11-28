report 51534684 "HR Employee - Birthdays"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeBirthdays.rdlc';
    Caption = 'Employee - Birthdays';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Department Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Employee_TABLECAPTION__________EmployeeFilter; TableCaption + ': ' + EmployeeFilter)
            {
            }
            column(EmployeeFilter; EmployeeFilter)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(FullName; FullName)
            {
            }
            column(Employee__Birth_Date_; Format("Date Of Birth"))
            {
            }
            column(Employee___BirthdaysCaption; Employee___BirthdaysCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(Full_NameCaption; Full_NameCaptionLbl)
            {
            }
            column(Employee__Birth_Date_Caption; Employee__Birth_Date_CaptionLbl)
            {
            }
            column(CompanyEMail_HREmployees; "HR Employees"."Company E-Mail")
            {
            }
            column(CellPhoneNumber_HREmployees; "HR Employees"."Cell Phone Number")
            {
            }
            column(SNO; SNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "HR Employees"."Date Of Birth" = 0D then CurrReport.Skip;//ERROR('Employee %1 does not have a date of birth',"HR Employees"."No.");
                if MonthFilter <> 0 then begin
                    if Date2DMY("HR Employees"."Date Of Birth", 2) <> MonthFilter then CurrReport.Skip;
                end;

                SNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    requestpage
    {
        Caption = 'Employee - Birthdays';

        layout
        {
            area(content)
            {
                field(MonthFilter; MonthFilter)
                {
                    Caption = 'Month Filter';
                    MaxValue = 12;
                    MinValue = 0;
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
        EmployeeFilter := "HR Employees".GetFilters;
        SNo := 0;
    end;

    var
        SNo: Integer;
        EmployeeFilter: Text[250];
        Employee___BirthdaysCaptionLbl: Label 'Employee - Birthdays';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Full_NameCaptionLbl: Label 'Full Name';
        Employee__Birth_Date_CaptionLbl: Label 'Birth Date';
        MonthFilter: Integer;
        LastFieldNo: Integer;
}

