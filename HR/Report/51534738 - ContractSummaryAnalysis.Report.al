report 51534738 "Contract Summary Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ContractSummaryAnalysis.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = WHERE (Frequency = FILTER (<> Quarterly), "Employee Classification" = CONST ('PERM'), "Employee Classification" = CONST ('AS'), "Employee Classification" = CONST ('SNR-AS'), "Employee Classification" = CONST ('OUTS'));
            RequestFilterFields = "Payroll Period";
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions"."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; "prPeriod Transactions".Amount)
            {
            }
            column(TransactionCode_prPeriodTransactions; "prPeriod Transactions"."Transaction Code")
            {
            }
            column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions"."Employee Code")
            {
            }
            column(Name; Name)
            {
            }
            column(GroupOrder; "prPeriod Transactions"."Group Order")
            {
            }
            column(SubGroupOrder; "prPeriod Transactions"."Sub Group Order")
            {
            }
            column(EmpClassification; EmpClassification)
            {
            }
            column(ClassFilter; ClassFilter)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("prPeriod Transactions"."Employee Code") then begin
                    Name := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";

                    EmpClassification := EmpRec."Employee Classification";
                    if ClassFilter <> '' then
                        if ClassFilter <> EmpClassification then
                            CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Classification; ClassFilter)
                {
                    DrillDownPageID = "Emplyee Classification";
                    Lookup = true;
                    LookupPageID = "Emplyee Classification";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*EmpClassPage.SETTABLEVIEW(EmpClass);
                        EmpClassPage.SETRECORD(EmpClass);
                        IF EmpClassPage.RUNMODAL = Action::LookupOK THEN
                        EmpClassification:=EmpClass.Code;
                         */
                        if PAGE.RunModal(39006223, EmpClass) = ACTION::LookupOK then
                            ClassFilter := EmpClass.Code;

                    end;
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

    var
        Name: Text;
        EmpRec: Record "HR-Employee";
        EmpClassification: Code[50];
        EmpClass: Record "Employee Class";
        EmpClassPage: Page "Emplyee Classification";
        ClassFilter: Code[30];
        CompanyInfo: Record "Company Information";
}

