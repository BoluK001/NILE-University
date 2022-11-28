table 51534555 "Salary Step/Notch Transactions"
{
    DrillDownPageID = "Salary Step/Notch Transactions";
    LookupPageID = "Salary Step/Notch Transactions";

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";

            trigger OnValidate()
            var
                SalNotch: Record "Salary Notch";
                Basic: Decimal;
                Housing: Decimal;
                Transport: Decimal;
                Others: Decimal;
                MonthlyGross: Decimal;
                Pension: Decimal;
                NSITF: Decimal;
                EmpPayrollCost: Decimal;
            begin
                // Message('Transaction Code: %1', "Transaction Code");
                // if SalNotch.Get("Salary Grade", "Salary Step/Notch") then begin
                //     SalNotch.SetRange("Salary Grade", "Salary Grade");
                //     SalNotch.SetRange("Salary Notch", "Salary Step/Notch");

                //     //
                //     if SalNotch."Gross Annual Salary" > 0 then begin
                //         Basic := 0;
                //         Housing := 0;
                //         Transport := 0;
                //         Others := 0;
                //         MonthlyGross := 0;
                //         Pension := 0;
                //         NSITF := 0;
                //         EmpPayrollCost := 0;
                //         //
                //         if SalNotch.Find('-') then begin
                //             //Amount := "% of Basic Pay" * SalNotch."Gross Annual Salary";

                //             Basic := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.1) / 12;
                //             Housing := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.3) / 12;
                //             Transport := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.15) / 12;
                //             Others := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.45) / 12;

                //             // MonthlyGross := SalNotch."Basic  Pay" + Housing + Transport + Others + SalNotch."Position Clinic Allowance";
                // Pension := (SalNotch."Basic  Pay" + Transport + Housing) * 0.1;
                // NSITF := MonthlyGross * 0.01;
                // EmpPayrollCost := MonthlyGross + Pension + NSITF;

                // //case "Transaction Code" of
                // if "Transaction Code" = 'HOUSING' then
                //     Amount := Housing;
                // if "Transaction Code" = 'TRANSPORT' then
                //     Amount := Transport;
                // if "Transaction Code" = 'OTHER INCOME' then
                //     Amount := Others;
                // if "Transaction Code" = 'PENSION' then
                //     Amount := Pension;

                // if "Transaction Code" = 'NSITF' then
                //     Amount := NSITF;

                // end;


                // end;

                //end;

            end;
        }
        field(2; "Salary Step/Notch"; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade"));
        }
        field(3; "Transaction Code"; Code[20])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                if Trans.Get("Transaction Code") then begin
                    "Transaction Name" := Trans."Transaction Name";
                    "Transaction Type" := Trans."Transaction Type";
                    Formula := Trans.Formula;
                end;
            end;
        }
        field(4; "Transaction Name"; Text[100])
        {
        }
        field(5; "Transaction Type"; Option)
        {
            OptionMembers = Income,Deduction;
        }
        field(6; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                "Annual Amount" := Amount * 12;
            end;
        }
        field(7; "% of Basic Pay"; Decimal)
        {
            trigger OnValidate()
            var
                SalNotch: Record "Salary Notch";
                Transport: Decimal;
                Housing: Decimal;
                MonthlyGross: Decimal;
                Others: Decimal;
            begin
                if SalNotch.Get("Salary Grade", "Salary Step/Notch") then begin
                    SalNotch.SetRange("Salary Grade", "Salary Grade");
                    SalNotch.SetRange("Salary Notch", "Salary Step/Notch");
                    if SalNotch.Find('-') then begin

                        Transport := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.15) / 12;
                        Housing := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.45) / 12;
                        MonthlyGross := SalNotch."Basic  Pay" + Housing + Transport + Others + SalNotch."Position Clinic Allowance";
                        Others := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * 0.45) / 12;

                        // if "Transaction Code" = 'PENSION' then
                        //     Amount := (SalNotch."Basic  Pay" + Transport + Housing) * 0.1
                        // else
                        //     if "Transaction Code" = 'NSITF' then
                        //         Amount := MonthlyGross * 0.01
                        //     else
                        Amount := ((SalNotch."Gross Annual Salary" - (SalNotch."Position Clinic Allowance" * 12)) * "% of Basic Pay") / 12;
                    end;

                end;

            end;
        }
        field(8; Formula; Code[200])
        {
        }
        field(9; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Annual Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Annual Amount" > 0 then
                    Amount := "Annual Amount" / 12;
            end;
        }
        field(11; Frequency; Option)
        {
            Description = 'Fixed,Varied,Quarterly,Annual';
            OptionMembers = "Fixed",Varied,Quarterly,Annual;
        }
    }

    keys
    {
        key(Key1; "Salary Grade", "Salary Step/Notch", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Trans: Record "prTransaction Codes";
}

