report 51534657 "Negative Pay List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './NegativePayList.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING ("No.") WHERE ("Net Pay" = FILTER (< 0));
            RequestFilterFields = "Current Month Filter";
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(HR_Employee__No__; "No.")
            {
            }
            column(First_Name___________Middle_Name___________Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(HR_Employee__Department_Code_; "Department Code")
            {
            }
            column(HR_Employee__Job_Title_; "Job Title")
            {
            }
            column(HR_Employee__Net_Pay_; "Net Pay")
            {
            }
            column(RCount; RCount)
            {
            }
            column(Negative_Pay_ListCaption; Negative_Pay_ListCaptionLbl)
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
            column(HR_Employee__Department_Code_Caption; FieldCaption("Department Code"))
            {
            }
            column(HR_Employee__Job_Title_Caption; FieldCaption("Job Title"))
            {
            }
            column(HR_Employee__Net_Pay_Caption; FieldCaption("Net Pay"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
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
        CompanyInfo: Record "Company Information";
        Negative_Pay_ListCaptionLbl: Label 'Negative Pay List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NamesCaptionLbl: Label 'Names';
}

