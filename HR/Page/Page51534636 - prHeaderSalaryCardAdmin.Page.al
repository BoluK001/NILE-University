page 51534636 "prHeader Salary Card Admin"
{
    // strempcode,dtDOE,curbasicpay,blnpaye,blnnssf,blnnhif,selectedperio,dtopenperio,
    // membership,referenceno,dttermination,blngetspayereleif

    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Navigate,Functions,Category9_caption,Category10_caption';
    SourceTable = "HR-Employee";
    SourceTableView = WHERE(Status = FILTER(Normal));

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }

                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    Enabled = true;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    Editable = false;
                }
                field("Department Code"; "Department Code")
                {
                    Editable = true;
                }
                field(DepName; DepName)
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Office)
                {
                    //Caption = 'Unit';
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = all;
                }

                field("Date Of Join"; "Date Of Join")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }

                field("Full / Part Time"; "Full / Part Time")
                {
                    Enabled = true;
                }
                field("Contract End Date"; "Contract End Date")
                {
                    ApplicationArea = all;
                }

                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                }

                field("Salary Notch/Step"; "Salary Notch/Step")
                {

                    trigger OnValidate()
                    begin
                        if not Confirm('Changing the Grade will affect the Basic Salary and the salary notch\step transactions. ' +
                                        'Do you wish to continue?', false) then begin
                            "Salary Notch/Step" := '';
                            Error('You have opted to abort the process.');

                        end;
                    end;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = all;
                }

            }
            part(Control1102756041; "prSalary Info")
            {
                SubPageLink = "Employee Code" = FIELD("No.");
            }
            group("Posting && Bank Details")
            {
                Caption = 'Posting && Bank Details';
                field("Hr Posting Group"; "Posting Group")
                {
                    Caption = 'Posting Group';
                    Editable = true;
                }
                field("Main Bank"; "Main Bank")
                {
                    ApplicationArea = all;
                }

                field("Branch Bank"; "Branch Bank")
                {
                    ApplicationArea = all;
                }

                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                }

                field("Bank Account Number"; "Bank Account Number")
                {
                    ApplicationArea = all;
                }

            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("ID Number"; "ID Number")
                {
                    Caption = 'ID No.';
                }
                field("PIN No."; "PIN No.")
                {
                    Caption = 'Pension No.';
                }
                field("Pension House"; "Pension House")
                {
                    ApplicationArea = all;
                }

                field("NHF No."; "NHF No.")
                {
                    ApplicationArea = all;
                }

                field("NSITF No."; "NSITF No.")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Info")
            {
                Caption = 'Other Info';
                Visible = false;
                action("Cost Centers")
                {
                    Caption = 'Cost Centers';
                    Image = Dimensions;
                    RunObject = Page "prStaff Dimensions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                separator(Action1102756016)
                {
                }

                action("Banking Details")
                {
                    Caption = 'Banking Details';
                    Image = BankAccount;
                    RunObject = Page "prEmployee Banks";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                separator(Action1102756059)
                {
                }

                action("Pension Details")
                {
                    Caption = 'Pension Details';
                    Image = PlanningWorksheet;
                    RunObject = Page "Pension Contribution Details";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
            }
            group(Transactions)
            {
                Caption = 'Transactions';
                action("Payroll Transactions")
                {
                    Caption = 'Payroll Transactions';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "prList Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Action1102756009)
                {
                }

                action("View Trans Codes")
                {
                    Caption = 'View Trans Codes';
                    Image = Track;
                    RunObject = Page "prList TransCode";
                    Visible = false;
                }
                separator(Action1102756011)
                {
                }

                action("Insurance Policies")
                {
                    Caption = 'Insurance Policies';
                    Image = Insurance;
                    RunObject = Page "prInsurance Policies";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                separator(Action1102756013)
                {
                }

                action("Staff Loans")
                {
                    Caption = 'Staff Loans';
                    Image = Loaner;
                    RunObject = Page "prInsurance Policies";
                    Visible = false;
                }
                separator(Action1102756000)
                {
                }

                action("Basic Salary Arrears")
                {
                    Caption = 'Basic Salary Arrears';
                    Image = CalculateRegenerativePlan;
                    //RunObject = Page "HR Deduction Account";
                    //RunPageLink = Code = FIELD("No.");
                    //RunPageView = SORTING(Code, Field7, Field8);
                    Visible = false;
                }
                action("Staff Loan External")
                {
                    Image = Loaners;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employees External Loans";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Salary Information")
                {
                    Caption = 'Salary Information';

                    trigger OnAction()
                    var
                        PrSalaryInfo: Record "prSalary Card";
                    begin
                        //PrSalaryInfo.reset;
                        if PrSalaryInfo.Get("No.") then
                            PAGE.Run(PAGE::"prSalary Info", PrSalaryInfo)
                        else begin
                            PrSalaryInfo.Init;
                            PrSalaryInfo."Employee Code" := "No.";
                            PrSalaryInfo.Insert(true);
                            PAGE.Run(PAGE::"prSalary Info", PrSalaryInfo)
                        end
                    end;
                }
            }
        }
        area(processing)
        {
            action("View Payslip")
            {
                Caption = 'View Payslip';
                Image = Payment;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;

                    //Display payslip report
                    /*
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    REPORT.Run(51534619,TRUE,FALSE,SalCard);
                    */
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", "No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    REPORT.Run(51534619, true, false, HrEmployee);

                end;
            }
            action("Process Current")
            {
                Caption = 'Process Current';
                Image = CalculatePlan;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    ContrInfo.Get;
                    VitalInfo.Get('');

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Get("No.");

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, NoofRecords);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "No."); //PKK
                    if ContrInfo."Multiple Payroll" then
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll;

                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    prEmployerDeductions.SetRange(prEmployerDeductions."Employee Code", "No."); //PKK
                    if ContrInfo."Multiple Payroll" then
                        prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);

                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;

                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Normal);
                    //PKK - PROCESS CURRENT ONLY
                    HrEmployee.SetRange(HrEmployee."No.", "No.");
                    //PKK - PROCESS CURRENT ONLY
                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.SetRange(HrEmployee."Payroll Code", PayrollCode);
                    //HrEmployee.SETRANGE(HrEmployee."No.",'CSS0005');
                    if HrEmployee.Find('-') then begin
                        //Progress Window
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            //Progress Window
                            Sleep(100);
                            //Progress Window
                            //Suspended
                            if not SalCard."Suspend Pay" then begin
                                ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name");
                                if SalCard.Get(HrEmployee."No.") then
                                    HrEmployee.TestField(HrEmployee."Date Of Join");
                                //PKK Check NHF Age
                                if (HrEmployee."Date Of Birth" <> 0D) then begin
                                    if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") <> HrEmployee."Date Of Birth" then begin
                                        if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") < Today then
                                            SalCard."Pays NHF" := false;
                                    end;
                                end;
                                //PKK Check NHF Age
                                HrEmployee.TestField(HrEmployee."Date Of Join");
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Date Of Join", SalCard."Basic Pay", SalCard."Pays PAYE"
                                    , SalCard."Pays NSSF", SalCard."Pays NHF", SelectedPeriod, SelectedPeriod, '', '',
                                    HrEmployee."Date Of Leaving", true, HrEmployee."Department Code", PayrollCode);
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Commit;

                    /*
                    SalCard.RESET;
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    REPORT.Run(51534619,TRUE,FALSE,SalCard);
                    */
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", "No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    REPORT.Run(51534619, true, false, HrEmployee);

                end;
            }
            action("Process Payroll")
            {
                Caption = 'Process Payroll';
                Image = CalculateCalendar;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    ContrInfo.Get;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //SalCard.GET("No.");

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, NoofRecords);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    prPeriodTransactions.Reset;
                    if ContrInfo."Multiple Payroll" then
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll;

                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    if ContrInfo."Multiple Payroll" then
                        prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;


                    UserSetup.Get(UserId);
                    //error('%1',Userid);
                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Normal);
                    HrEmployee.SetRange(HrEmployee."Posting Group", UserSetup."PayRoll Cent. Filter");
                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.SetRange(HrEmployee."Payroll Code", PayrollCode);
                    if HrEmployee.Find('-') then begin
                        //Progress Window
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            //Progress Window
                            Sleep(100);
                            //Progress Window
                            //Suspended
                            if SalCard.Get(HrEmployee."No.") then begin
                                if not SalCard."Suspend Pay" then begin
                                    HrEmployee.TestField(HrEmployee."Date Of Join");
                                    //PKK Check NHF Age
                                    if (HrEmployee."Date Of Birth" <> 0D) then begin
                                        if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") <> HrEmployee."Date Of Birth" then begin
                                            if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") < Today then
                                                SalCard."Pays NHF" := false;
                                        end;
                                    end;
                                    //PKK Check NHF Age
                                    //PKProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");

                                    if SalCard.Get(HrEmployee."No.") then begin
                                        HrEmployee.TestField(HrEmployee."Date Of Join");
                                        ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Date Of Join", SalCard."Basic Pay", SalCard."Pays PAYE"
                                            , SalCard."Pays NSSF", SalCard."Pays NHF", SelectedPeriod, SelectedPeriod, '', '',
                                            HrEmployee."Date Of Leaving", true, HrEmployee."Department Code", PayrollCode);
                                    end;
                                end;
                            end;

                            ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name");

                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Message('Payroll processing completed successfully.');

                    /*
                    SalCard.RESET;
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    REPORT.Run(51534619,TRUE,FALSE,SalCard);
                    */

                end;
            }
            action("New Salary")
            {
                Caption = 'New Salary';
                ApplicationArea = all;
                Image = NewSparkle;

                trigger OnAction()
                begin
                    prSalaryCard.Init;
                    prSalaryCard."Employee Code" := "No.";
                    prSalaryCard.Insert;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DepName := '';
        DValues.Reset;
        DValues.SetRange(DValues.Code, "Department Code");
        if DValues.Find('-') then
            DepName := DValues.Name;
    end;

    trigger OnInit()
    begin

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
        end;
    end;

    var
        objEmp: Record "HR-Employee";
        SalCard: Record "prSalary Card";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit prPayrollProcessing;
        HrEmployee: Record "HR-Employee";
        Employee: Record "HR-Employee";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "prPeriod Transactions";
        prEmployerDeductions: Record "prEmployer Deductions";
        PayrollType: Record "prPayroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[20];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";
        DepName: Text[200];
        DValues: Record "Dimension Value";
        VitalInfo: Record "prVital Setup Info";
        prSalaryCard: Record "prSalary Card";
        UserSetup: Record "User Setup";
}

