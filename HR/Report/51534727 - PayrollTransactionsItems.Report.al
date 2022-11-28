report 51534727 "Payroll Transactions Items"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PayrollTransactionsItems.rdlc';

    dataset
    {
        dataitem("Salary Step/Notch Transactions"; "Salary Step/Notch Transactions")
        {
            column(Grade; "Salary Step/Notch Transactions"."Salary Grade")
            {
            }
            column(Step; "Salary Step/Notch Transactions"."Salary Step/Notch")
            {
            }
            column(EntryNo; "Salary Step/Notch Transactions"."Entry No")
            {
            }
            column(TransactionCode; "Salary Step/Notch Transactions"."Transaction Code")
            {
            }
            column(TransactionName; "Salary Step/Notch Transactions"."Transaction Name")
            {
            }
            column(TransactionType; "Salary Step/Notch Transactions"."Transaction Type")
            {
            }
            column(Amount; "Salary Step/Notch Transactions".Amount)
            {
            }
            column(PercentageOfBasicPay; "Salary Step/Notch Transactions"."% of Basic Pay")
            {
            }
            column(Formula; "Salary Step/Notch Transactions".Formula)
            {
            }
            column(AnnualAmount; "Salary Step/Notch Transactions"."Annual Amount")
            {
            }
            column(Frequency; "Salary Step/Notch Transactions".Frequency)
            {
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

    labels
    {
    }
}

