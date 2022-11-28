report 51534672 "Mark as DOES NOT pay PAYE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MarkasDOESNOTpayPAYE.rdlc';

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
                "prSalary Card"."Pays PAYE" := false;
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
        prSalary_CardCaptionLbl: Label 'prSalary Card';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

