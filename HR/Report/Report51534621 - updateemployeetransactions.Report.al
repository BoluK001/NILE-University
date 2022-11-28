report 51534621 "update employee transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './updateemployeetransactions.rdlc';

    dataset
    {
        dataitem("prEmployee Trans IMP BAL"; "prEmployee Trans IMP BAL")
        {

            trigger OnAfterGetRecord()
            begin
                prEmpTrans.Init;
                prEmpTrans."Employee Code" := "prEmployee Trans IMP BAL"."Employee Code";
                prEmpTrans."Transaction Code" := "prEmployee Trans IMP BAL"."Transaction Code";
                prEmpTrans.Validate("Transaction Code");
                prEmpTrans."Period Month" := 1;
                prEmpTrans."Period Year" := 2011;
                prEmpTrans."Payroll Period" := 20110101D;
                //prEmpTrans.Amount:="prEmployee Trans IMP BAL".Amount;
                prEmpTrans."Amortized Loan Total Repay Amt" := "prEmployee Trans IMP BAL".Amount;
                prEmpTrans.Balance := "prEmployee Trans IMP BAL".Balance;
                prEmpTrans.Insert;
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
        prEmpTrans: Record "prEmployee Transactions";
}

