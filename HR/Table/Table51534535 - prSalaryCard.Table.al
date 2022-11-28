table 51534535 "prSalary Card"
{
    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {
            trigger OnValidate()
            begin
                if Employee.Get("Employee Code") then begin
                    "Location/Division" := Employee."Location/Division Code";
                    Department := Employee."Department Code";
                    "Cost Centre" := Employee."Cost Center Code";
                    "Salary Grade" := Employee."Salary Grade";
                    "Salary Notch" := Employee."Salary Notch/Step";
                end;
            end;
        }
        field(3; "Payment Mode"; Option)
        {
            Description = ',Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[20])
        {
            TableRelation = prCurrencies."Currency Code";
        }
        field(5; "Pays NSSF"; Boolean)
        {
        }
        field(6; "Pays NHF"; Boolean)
        {
        }
        field(7; "Pays PAYE"; Boolean)
        {
        }
        field(8; "Payslip Message"; Text[100])
        {
        }
        field(9; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = Sum("prEmployee P9 Info"."Basic Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = Sum("prEmployee P9 Info"."Gross Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cumm NetPay"; Decimal)
        {
            CalcFormula = Sum("prEmployee P9 Info"."Net Pay" WHERE("Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cumm Allowances"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Group Order" = FILTER(3),
                                                                    "Employee Code" = FIELD("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cumm Deductions"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Group Order" = FILTER(8),
                                                                    "Sub Group Order" = FILTER(0 | 1),
                                                                    "Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = FILTER(<> 'Total Deductions')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Suspend Pay"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Suspend Pay" = true then exit;
                TestField("Suspension End Date");
                if PrSuspension.Get("Employee Code", "Suspension Date") then begin
                    PrSuspension."End Of Suspension" := "Suspension End Date";
                    PrSuspension."Reason Of Suspension" := "Suspension Reasons";
                    PrSuspension."Last Date Modified" := Today;
                    PrSuspension."User ID" := UserId;
                    PrSuspension."Suspend Pay" := false;
                    PrSuspension.Modify;
                end
            end;
        }
        field(15; "Suspension Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Suspension Date" = 0D then exit;
                if PrSuspension.Get("Employee Code", "Suspension Date") then
                    PrSuspension.DeleteAll;
                begin
                    PrSuspension.Init;
                    PrSuspension.Employee := "Employee Code";
                    PrSuspension."Date Of Suspension" := "Suspension Date";
                    PrSuspension.Date := Today;
                    PrSuspension."End Of Suspension" := "Suspension End Date";
                    PrSuspension."Reason Of Suspension" := "Suspension Reasons";
                    PrSuspension."Last Date Modified" := Today;
                    PrSuspension."User ID" := UserId;
                    PrSuspension."Suspend Pay" := true;
                    PrSuspension.Insert(true);
                end
            end;
        }
        field(16; "Suspension Reasons"; Text[200])
        {

            trigger OnValidate()
            begin
                if PrSuspension.Get("Employee Code", "Suspension Date") then begin
                    PrSuspension."Reason Of Suspension" := "Suspension Reasons";
                    PrSuspension."Last Date Modified" := Today;
                    PrSuspension."User ID" := UserId;
                    PrSuspension.Modify;
                end
            end;
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
        }
        field(19; "Cumm PAYE"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Transaction Code" = FILTER('PAYE'),
                                                                    "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Transaction Code" = FILTER('NSSF'),
                                                                    "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Transaction Code" = FILTER('0007'),
                                                                    "Employee Code" = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(22; "Cumm HELB"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = FILTER('320')));
            FieldClass = FlowField;
        }
        field(23; "Cumm NHIF"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = FILTER('NHIF')));
            FieldClass = FlowField;
        }
        field(24; "Bank Account Number"; Code[50])
        {
        }
        field(25; "Bank Branch"; Code[50])
        {
        }
        field(26; "Employee's Bank"; Code[50])
        {
        }
        field(27; "Posting Group"; Code[20])
        {
            NotBlank = false;
            TableRelation = "prEmployee Posting Group";
        }
        field(38; "Payroll Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Group Header"."Group Code";
        }
        field(28; "Cumm Employer Pension"; Decimal)
        {
            CalcFormula = Sum("prEmployer Deductions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = CONST('0007')));
            FieldClass = FlowField;
        }
        field(29; "Location/Division"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LOC/DIV'));
        }
        field(30; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(31; "Cost Centre"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COSTCENTRE'));
        }
        field(32; "Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(33; "Salary Notch"; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("Salary Grade"));
        }
        field(34; "Pension House Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "prInstitutional Membership"."Institution No" WHERE("Group No" = CONST('PENSION'));
        }
        field(35; "Days Absent"; Decimal)
        {
        }
        field(36; "Cumm NHF"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions".Amount WHERE("Employee Code" = FIELD("Employee Code"),
                                                                    "Transaction Code" = FILTER('NHF')));
            FieldClass = FlowField;
        }
        field(37; "Suspension End Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Suspension End Date" <> 0D then
                    if PrSuspension.Get("Employee Code", "Suspension Date") then begin
                        PrSuspension."End Of Suspension" := "Suspension End Date";
                        PrSuspension."Last Date Modified" := Today;
                        PrSuspension."User ID" := UserId;
                        PrSuspension.Modify;
                    end
            end;
        }
        field(323; "Payroll Type"; Option)
        {
            CalcFormula = Lookup("HR-Employee"."Payroll Type" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(324; "Non Taxable"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
            SumIndexFields = "Basic Pay";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR-Employee";
        PrSuspension: Record "Pr Suspension";
}

