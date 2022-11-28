report 51534650 "Validate Salary Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateSalaryCard.rdlc';

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
            column(prSalary_Card__Basic_Pay_; "Basic Pay")
            {
            }
            column(prSalary_Card__Payment_Mode_; "Payment Mode")
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
            column(prSalary_Card__Basic_Pay_Caption; FieldCaption("Basic Pay"))
            {
            }
            column(prSalary_Card__Payment_Mode_Caption; FieldCaption("Payment Mode"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Employee.Get("prSalary Card"."Employee Code") then begin
                    "prSalary Card"."Location/Division" := Employee."Location/Division Code";
                    "prSalary Card".Department := Employee."Department Code";
                    "prSalary Card"."Cost Centre" := Employee."Cost Center Code";
                    "prSalary Card"."Salary Grade" := Employee."Salary Grade";
                    "prSalary Card"."Salary Notch" := Employee."Salary Notch/Step";
                end;

                "prSalary Card"."Pays NSSF" := false;
                "prSalary Card"."Pays NHF" := false;
                if SalaryGrades.Get("prSalary Card"."Salary Grade") then
                    "prSalary Card"."Pays NHF" := SalaryGrades."Pays NHF";
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
        Employee: Record "HR-Employee";
        SalaryGrades: Record "Salary Grades";
        prSalary_CardCaptionLbl: Label 'prSalary Card';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

