report 51534673 "Mark as PAYS PAYE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MarkasPAYSPAYE.rdlc';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            DataItemTableView = SORTING ("Employee Code");
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
            column(prSalary_Card__Employee_Code_; "Employee Code")
            {
            }
            column(prSalary_Card__Pays_PAYE_; "Pays PAYE")
            {
            }
            column(prSalary_CardCaption; prSalary_CardCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prSalary_Card__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(prSalary_Card__Pays_PAYE_Caption; FieldCaption("Pays PAYE"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "prSalary Card"."Salary Grade" = 'CS' then
                    exit;

                if "prSalary Card"."Salary Grade" = 'IT' then
                    exit;

                if "prSalary Card"."Salary Grade" = 'NYSC' then
                    exit;

                if "prSalary Card"."Salary Grade" = 'MGT' then
                    exit;

                "prSalary Card"."Pays PAYE" := true;
                "prSalary Card".Modify;
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
        SalaryGrades: Record "Salary Grades";
        prSalary_CardCaptionLbl: Label 'prSalary Card';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

