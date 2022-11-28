report 51534679 "Generate 13th Month"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Generate13thMonth.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(Normal));
            RequestFilterFields = "Location/Division Code", "Salary Grade", "Salary Notch/Step";
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
            column(Generate_13th_Month_AllowanceCaption; Generate_13th_Month_AllowanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Location_DivisionCaption; Location_DivisionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(HR_Employee_No_; "No.")
            {
            }
            dataitem("prSalary Card"; "prSalary Card")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(HR_Employee___First_Name___________HR_Employee___Middle_Name___________HR_Employee___Last_Name_; "HR-Employee"."First Name" + ' ' + "HR-Employee"."Middle Name" + ' ' + "HR-Employee"."Last Name")
                {
                }
                column(prSalary_Card__prSalary_Card___Location_Division_; "prSalary Card"."Location/Division")
                {
                }
                column(AllowanceAmount; AllowanceAmount)
                {
                }
                column(prSalary_Card__prSalary_Card___Employee_Code_; "prSalary Card"."Employee Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AllowanceAmount := 0;

                    if Perc = 0 then
                        Perc := 100;

                    "HR-Employee".TestField("HR-Employee"."Date Of Join");

                    if Date2DMY("HR-Employee"."Date Of Join", 3) = Date2DMY(PayrollPeriodR."Date Opened", 3) then
                        AllowanceAmount := ("prSalary Card"."Basic Pay" * Perc * 0.01) * (((12 - Date2DMY("HR-Employee"."Date Of Join", 2) + 1)) / 12)
                    else
                        AllowanceAmount := "prSalary Card"."Basic Pay" * Perc * 0.01;

                    if AllowanceAmount > 0 then begin
                        if Trans.Get('13MONTHALL') then begin
                            PayrollVariations.Init;
                            PayrollVariations."Employee Code" := "prSalary Card"."Employee Code";
                            PayrollVariations."Transaction Code" := Trans."Transaction Code";
                            PayrollVariations."Period Month" := PayrollPeriodR."Period Month";
                            PayrollVariations."Period Year" := PayrollPeriodR."Period Year";
                            PayrollVariations."Payroll Period" := PayrollPeriodR."Date Opened";
                            PayrollVariations.Validate("Employee Code");
                            PayrollVariations."Transaction Type" := Trans."Transaction Type";
                            PayrollVariations."Transaction Name" := Trans."Transaction Name";
                            PayrollVariations.Frequency := Trans.Frequency;
                            PayrollVariations.Validate("Transaction Code");
                            PayrollVariations.Amount := AllowanceAmount;
                            PayrollVariations."Original Amount" := AllowanceAmount;
                            PayrollVariations.Insert;


                        end else begin
                            Error('You must create the 13th month allowance with transaction code "13MONTHALL" in set up.');
                        end;
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin
                PayrollPeriodR.Reset;
                PayrollPeriodR.SetRange(PayrollPeriodR.Closed, false);
            //    if PayrollPeriodR.Find('-') then
    
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
        Trans: Record "prTransaction Codes";
        PayrollVariations: Record "prPayroll Variations";
        PayrollPeriodR: Record "prPayroll Periods";
        AllowanceAmount: Decimal;
        Perc: Decimal;
        Generate_13th_Month_AllowanceCaptionLbl: Label 'Generate 13th Month Allowance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        NamesCaptionLbl: Label 'Names';
        Location_DivisionCaptionLbl: Label 'Location/Division';
        AmountCaptionLbl: Label 'Amount';
}

