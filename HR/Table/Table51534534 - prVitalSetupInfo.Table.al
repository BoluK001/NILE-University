table 51534534 "prVital Setup Info"
{

    fields
    {
        field(1; "Setup Code"; Code[20])
        {
            Description = '[Relief]';
        }
        field(2; "Tax Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(3; "Insurance Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(4; "Max Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(5; "Mortgage Relief"; Decimal)
        {
            Description = '[Relief]';
        }
        field(6; "Max Pension Contribution"; Decimal)
        {
            Description = '[Pension]';
        }
        field(7; "Tax On Excess Pension"; Decimal)
        {
            Description = '[Pension]';
        }
        field(8; "Loan Market Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(9; "Loan Corporate Rate"; Decimal)
        {
            Description = '[Loans]';
        }
        field(10; "Taxable Pay (Normal)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(11; "Taxable Pay (Agricultural)"; Decimal)
        {
            Description = '[Housing]';
        }
        field(12; "NHIF Based on"; Option)
        {
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(13; "NSSF Employee"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(14; "NSSF Employer Factor"; Decimal)
        {
            Description = '[NSSF]';
        }
        field(15; "OOI Deduction"; Decimal)
        {
            Description = '[OOI]';
        }
        field(16; "OOI December"; Decimal)
        {
            Description = '[OOI]';
        }
        field(17; "Security Day (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(18; "Security Night (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(19; "Ayah (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(20; "Gardener (U)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(21; "Security Day (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(22; "Security Night (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(23; "Ayah (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(24; "Gardener (R)"; Decimal)
        {
            Description = '[Servant]';
        }
        field(25; "Benefit Threshold"; Decimal)
        {
            Description = '[Servant]';
        }
        field(200; "Tax Relief % of Gross Income"; Decimal)
        {
            Description = '[Relief]';
        }
        field(201; "Child Relief"; Decimal)
        {
        }
        field(202; "Dependants Relief"; Decimal)
        {
        }
        field(203; "NHF - % of Basic Pay"; Decimal)
        {
        }
        field(204; "NHF - Maximum Age"; DateFormula)
        {
        }
        field(205; "NISTF % of Basic Pay"; Decimal)
        {
        }
        field(206; "Payroll Cut Off Day"; Integer)
        {

            trigger OnValidate()
            begin
                if "Payroll Cut Off Day" > 28 then
                    Error('Day can not be greater that 28th');
            end;
        }
        field(207; "Pay upto Cut Off Date"; Boolean)
        {
        }
        field(208; "Prorate Absence"; Boolean)
        {
        }
        field(209; "Prorate Pension"; Boolean)
        {
        }
        field(210; "Prorate NHF"; Boolean)
        {
        }
        field(211; "Arrears Based on days in month"; Boolean)
        {
        }
        field(212; "Prol. Based on days in month"; Boolean)
        {
        }
        field(213; "Show Signatory in Payslip"; Boolean)
        {
        }
        field(214; "Don't Prorate Basic Pay"; Boolean)
        {
        }
        field(215; "Exclude NonTax from Relief"; Boolean)
        {
        }
        field(216; "Show Cumm. Stat. on Payslip"; Boolean)
        {
        }
        field(217; "2 Decimals in Payslip"; Boolean)
        {
        }
        field(218; "Prorate Absence Basic Pay"; Boolean)
        {
        }
        field(219; "Prol. Absence on days in month"; Boolean)
        {
        }
        field(220; "Working Days"; Integer)
        {
            Description = 'Total number of working days in a month';
        }
    }

    keys
    {
        key(Key1; "Setup Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

