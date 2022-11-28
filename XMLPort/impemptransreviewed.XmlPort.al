xmlport 51534353 "imp emp trans reviewed"
{
    Format = VariableText;

    schema
    {
        textelement(impt_reviewed_trans)
        {
            tableelement("prEmployee Transactions"; "prEmployee Transactions")
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'emp_trans_rev';
                fieldelement(empno; "prEmployee Transactions"."Employee Code")
                {
                }
                fieldelement(transcode; "prEmployee Transactions"."Transaction Code")
                {
                }
                fieldelement(transname; "prEmployee Transactions"."Transaction Name")
                {
                }
                fieldelement(amount; "prEmployee Transactions".Amount)
                {
                }
                fieldelement(periodmonth; "prEmployee Transactions"."Period Month")
                {
                }
                fieldelement(periodyear; "prEmployee Transactions"."Period Year")
                {
                }
                fieldelement(payrollperiod; "prEmployee Transactions"."Payroll Period")
                {
                }
            }
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
}

