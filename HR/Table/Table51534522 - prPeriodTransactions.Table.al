table 51534522 "prPeriod Transactions"
{

    fields
    {
        field(1; "Employee Code"; Code[50])
        {
            TableRelation = "HR-Employee"."No.";
            trigger OnValidate()
            var
                emp: Record "HR-Employee";
            begin
                /*  Validate("Employee Code");
                  if emp.get("Employee Code") then
                     // emp.SetRange("No.", "Employee Code");
                  //if emp.Find('-') then
                  "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
  */
            end;
        }
        field(2; "Transaction Code"; Text[30])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";
        }
        field(3; "Group Text"; Text[30])
        {
            Description = 'e.g Statutory, Deductions, Tax Calculation etc';
        }
        field(4; "Transaction Name"; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Balance; Decimal)
        {
        }
        field(7; "Original Amount"; Decimal)
        {
        }
        field(8; "Group Order"; Integer)
        {
        }
        field(9; "Sub Group Order"; Integer)
        {
        }
        field(10; "Period Month"; Integer)
        {
        }
        field(11; "Period Year"; Integer)
        {
        }
        field(12; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(13; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(14; Membership; Code[50])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(15; "Reference No"; Text[20])
        {
        }
        field(16; "Department Code"; Code[20])
        {
        }
        field(17; Lumpsumitems; Boolean)
        {
        }
        field(18; TravelAllowance; Code[20])
        {
        }
        field(19; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(20; "Company Deduction"; Boolean)
        {
            Description = 'Dennis- Added to filter out the company deductions esp: the Pensions';
        }
        field(21; "Emp Amount"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(22; "Emp Balance"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(23; "Journal Account Code"; Code[20])
        {
        }
        field(24; "Journal Account Type"; Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor;
        }
        field(25; "Post As"; Option)
        {
            OptionMembers = " ",Debit,Credit;
        }
        field(26; "Loan Number"; Code[20])
        {
        }
        field(27; "coop parameters"; Option)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(28; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(29; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(30; "Location/Division"; Code[20])
        {
        }
        field(31; Department; Code[20])
        {
        }
        field(32; "Cost Centre"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COSTCENTRE'));
        }
        field(33; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(34; "Salary Notch"; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade"));
        }
        field(35; "Payslip Order"; Integer)
        {
        }
        field(36; "No. Of Units"; Decimal)
        {
        }
        field(37; "Sort Order"; Integer)
        {
            CalcFormula = Lookup("prTransaction Codes"."Sort Order" WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
        }
        field(38; "Employee Classification"; Code[20])
        {
        }
        field(39; Exclude; Boolean)
        {
            CalcFormula = Lookup("prTransaction Codes".Exclude WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
        }
        field(40; Frequency; Option)
        {
            Description = 'Fixed,Varied,Quarterly,Annual';
            OptionCaption = 'Fixed,Varied,Quarterly,Annual';
            OptionMembers = "Fixed",Varied,Quarterly,Annual;
        }
        field(41; "Special Allowances"; Boolean)
        {
            CalcFormula = Lookup("prTransaction Codes"."Special Allowances" WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
        }
        field(42; "Transaction Type"; Option)
        {
            CalcFormula = Lookup("prTransaction Codes"."Transaction Type" WHERE("Transaction Code" = FIELD("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Income,Deduction;
        }
        field(43; "Payroll  Classification"; Code[20])
        {
        }
        field(44; "EE Contribution"; Decimal)
        {
        }
        field(45; "ER Contribution"; Decimal)
        {
        }
        field(46; "Employee Name"; text[200])
        {

        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key2; "Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", "Payslip Order", Membership, "Reference No")
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key3; "Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code")
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key4; Membership)
        {
        }
        key(Key5; "Transaction Code", "Payroll Period", Membership, "Reference No")
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key6; "Payroll Period", "Group Order", "Sub Group Order")
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key7; "Employee Code", "Department Code")
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key8; "Transaction Code", "Employee Code", "Payroll Period", "Location/Division", Department)
        {
            SumIndexFields = Amount, "No. Of Units";
        }
        key(Key9; "Payslip Order")
        {
        }
        key(Key10; "Transaction Code", "Employee Code", "Payroll Period", "Reference No")
        {
        }
        key(Key11; "Location/Division")
        {
        }
    }

    fieldgroups
    {
    }
}

