report 51534676 "Gross Reconcilliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GrossReconcilliation.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            RequestFilterFields = "Current Month Filter", "No.";
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(HR_Employee__HR_Employee___No__; "HR-Employee"."No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TCurrAmount; TCurrAmount)
            {
            }
            column(TPrevAmount; TPrevAmount)
            {
            }
            column(TCurrAmount_TPrevAmount; TCurrAmount - TPrevAmount)
            {
            }
            column(Payment_ReconcilliationCaption; Payment_ReconcilliationCaptionLbl)
            {
            }
            column(Prev__AmountCaption; Prev__AmountCaptionLbl)
            {
            }
            column(VarienceCaption; VarienceCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Current_AmountCaption; Current_AmountCaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            dataitem("Monthly Reconcilliation"; "Monthly Reconcilliation")
            {
                DataItemLink = Employee = FIELD("No.");
                DataItemTableView = SORTING(Employee, TransCode) ORDER(Ascending);
                column(Monthly_Reconcilliation_TransCode; TransCode)
                {
                }
                column(Monthly_Reconcilliation_Description; Description)
                {
                }
                column(Monthly_Reconcilliation_CurrAmount; CurrAmount)
                {
                }
                column(Monthly_Reconcilliation_PrevAmount; PrevAmount)
                {
                }
                column(No; No)
                {
                }
                column(CurrAmount_PrevAmount; CurrAmount - PrevAmount)
                {
                }
                column(Monthly_Reconcilliation_Employee; Employee)
                {
                }
                column(Monthly_Reconcilliation_Group_Order; "Group Order")
                {
                }
                column(Monthly_Reconcilliation_Refference_Code; "Refference Code")
                {
                }
                column(Monthly_Reconcilliation_Entry_Exit; "Entry/Exit")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No += 1;

                    TCurrAmount := TCurrAmount + "Monthly Reconcilliation".CurrAmount;
                    TPrevAmount := TPrevAmount + "Monthly Reconcilliation".PrevAmount;
                end;

                trigger OnPreDataItem()
                begin
                    No := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "HR-Employee"."No.");
                if objEmp.Find('-') then
                    EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";


                //IF NetPay<=0 THEN
                //CurrReport.SKIP;
                TotBasicPay := TotBasicPay + BasicPay;
                TotGrossPay := TotGrossPay + GrossPay;
                TotNetPay := TotNetPay + NetPay;
            end;

            trigger OnPreDataItem()
            begin
                //ReconcilliationTable.DELETEALL;
                if companyinfo.Get() then
                    companyinfo.CalcFields(companyinfo.Picture);
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
        PeriodFilter := "HR-Employee".GetFilter("Current Month Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "HR-Employee".GetRangeMin("Current Month Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";
    end;

    var
        PeriodTrans: Record "prPeriod Transactions";
        BasicPay: Decimal;
        GrossPay: Decimal;
        NetPay: Decimal;
        TotBasicPay: Decimal;
        TotGrossPay: Decimal;
        TotNetPay: Decimal;
        EmployeeName: Text[200];
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        PeriodTransPREV: Record "prPeriod Transactions";
        BasicPayPREV: Decimal;
        GrossPayPREV: Decimal;
        NetPayPREV: Decimal;
        ReconcilliationTable: Record "Monthly Reconcilliation";
        No: Integer;
        "Entry/Exit": Boolean;
        TCurrAmount: Decimal;
        TPrevAmount: Decimal;
        Payment_ReconcilliationCaptionLbl: Label 'Payment Reconcilliation';
        Prev__AmountCaptionLbl: Label 'Prev. Amount';
        VarienceCaptionLbl: Label 'Varience';
        User_Name_CaptionLbl: Label 'User Name:';
        Print_Date_CaptionLbl: Label 'Print Date:';
        Period_CaptionLbl: Label 'Period:';
        Page_No_CaptionLbl: Label 'Page No:';
        Current_AmountCaptionLbl: Label 'Current Amount';
        Prepared_by_______________________________________Date_________________CaptionLbl: Label 'Prepared byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                 DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Checked_by________________________________________Date_________________CaptionLbl: Label 'Checked byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                   DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Authorized_by____________________________________Date_________________CaptionLbl: Label 'Authorized byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..              DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
        Approved_by______________________________________Date_________________CaptionLbl: Label 'Approved byÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ..                DateÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙÙ';
}

