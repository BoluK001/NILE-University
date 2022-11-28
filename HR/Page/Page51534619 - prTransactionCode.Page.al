page 51534619 "prTransaction Code"
{
    PageType = Card;
    SourceTable = "prTransaction Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = all;
                }
                field(Frequency; Frequency)
                {
                    ValuesAllowed = Fixed, Varied, Quarterly, Annual;
                }
                field("Balance Type"; "Balance Type")
                {
                    ValuesAllowed = None, Increasing, Reducing;
                }
                field("Amount Preference"; "Amount Preference")
                {
                    ValuesAllowed = "Posted Amount", "Take Lower ", "Take Higher";
                }
                field("Is Cash"; "Is Cash")
                {
                    ApplicationArea = all;
                }
                field(Taxable; Taxable)
                {
                    ApplicationArea = all;
                }
                field("Voluntary Contribution"; "Voluntary Contribution")
                {
                    ApplicationArea = all;
                }
                field(Welfare; Welfare)
                {
                    ApplicationArea = all;
                }
                field(Pension; Pension)
                {
                    ApplicationArea = all;
                }
                field(Meal; Meal)
                {
                    ApplicationArea = all;
                }
                field(Arrear; Arrear)
                {
                    ApplicationArea = all;
                }
                field(Passage; Passage)
                {
                    ApplicationArea = all;
                }
                field("Passage %"; "Passage %")
                {
                    ApplicationArea = all;
                }
                field("Is Formula"; "Is Formula")
                {
                    ApplicationArea = all;
                }
                field(Formula; Formula)
                {
                    ApplicationArea = all;
                }
                label(Control1102756053)
                {
                    CaptionClass = Text19025872;
                    ShowCaption = false;
                }
                field("Include Employer Deduction"; "Include Employer Deduction")
                {
                    ApplicationArea = all;
                }
                field("Employer Deduction"; "Employer Deduction")
                {
                    ApplicationArea = all;
                }
                field("Is Formula for employer"; "Is Formula for employer")
                {
                    ApplicationArea = all;
                }
                field("Pension EE formula"; "Pension EE formula")
                {
                    ApplicationArea = all;
                }
                label(Control1102756054)
                {
                    CaptionClass = Text19080001;
                    ShowCaption = false;
                }
                field("Transaction Category"; "Transaction Category")
                {
                    ApplicationArea = all;
                }
                field("Overtime Type"; "Overtime Type")
                {
                    ApplicationArea = all;
                }
                field("Pensure Arrears"; "Pensure Arrears")
                {
                    ApplicationArea = all;
                }
                field(Exclude; Exclude)
                {
                    Caption = 'Exclude';
                    ApplicationArea = all;
                }
                group(Loans)
                {
                    Caption = 'Loans';
                    field("Special Transactions"; "Special Transactions")
                    {
                        Caption = 'Loans';
                        ValuesAllowed = Ignore, "Staff Loan";
                    }
                    field("Nominal Interest Rate"; "Nominal Interest Rate")
                    {
                        Caption = 'Interest Rate';
                        ApplicationArea = all;
                    }
                    field("Effective Interest Loan"; "Effective Interest Loan")
                    {
                        ApplicationArea = all;
                    }
                    field("Repayment Method"; "Repayment Method")
                    {
                        ValuesAllowed = Reducing, "Straight line", Amortized;
                        ApplicationArea = all;
                    }
                    field("Related Transaction Code"; "Related Transaction Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Fringe Benefit"; "Fringe Benefit")
                    {
                        ApplicationArea = all;
                    }
                    field("Special Allowances"; "Special Allowances")
                    {
                        ApplicationArea = all;
                    }
                }
                field("Non-Transactional"; "Non-Transactional")
                {
                    ApplicationArea = all;
                }
                field("Leave Allowance"; "Leave Allowance")
                {
                    ApplicationArea = all;
                }
                field("GL Account"; "GL Account")
                {
                    ApplicationArea = all;
                }
                field(Subledger; Subledger)
                {
                    Caption = 'Posting to Subledger';
                }
                field(CustomerPostingGroup; CustomerPostingGroup)
                {
                    Caption = 'Debtor Posting Group';
                }
                field("IsCoop/LnRep"; "IsCoop/LnRep")
                {
                    Caption = 'Is Loan/Coop';
                    ApplicationArea = all;
                }
                field("Add to Relief"; "Add to Relief")
                {
                    ApplicationArea = all;
                }
                field("Prorate Absence"; "Prorate Absence")
                {
                    ApplicationArea = all;
                }
                field("Annual Pay"; "Annual Pay")
                {
                    ApplicationArea = all;
                }
                field("Exclude from Monthly Gross"; Rec."Exclude from Monthly Gross")
                {
                    ApplicationArea = all;
                }
                field("Extra Payee"; "Extra Payee")
                {
                    ApplicationArea = all;
                }
                field("Allowance Incetive Formula"; "Allowance Incetive Formula")
                {
                    ApplicationArea = all;
                }
            }
            group("Other Set-Ups")
            {
                Caption = 'Other Set-Ups';
                group("Select one")
                {
                    Caption = 'Select one';
                    field("Special Transactions3"; "Special Transactions")
                    {
                        Caption = 'Other Transactions';
                        ApplicationArea = all;
                        ValuesAllowed = Ignore, "Defined Contribution", "Home Ownership Savings Plan", "Owner Occupier Interest", "Prescribed Benefit", "Salary Arrears", "Value of Quarters";
                    }
                }
                group(Control1102756068)
                {
                    Caption = 'Select one';
                    field("Special Transactions4"; "Special Transactions")
                    {
                        Caption = 'Life Insurance';
                        ApplicationArea = all;
                        ValuesAllowed = "Life Insurance";
                    }
                    field("Deduct Premium"; "Deduct Premium")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Coop Reporting")
                {
                    Caption = 'Coop Reporting';
                    field("IsCoop/LnRep2"; "IsCoop/LnRep")
                    {
                        Caption = 'Coop Parameter';
                        ApplicationArea = all;
                    }
                    field("coop parameters"; "coop parameters")
                    {
                        DrillDown = false;
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19025872: Label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: Label 'E.g ([005]+[020]*[24])/2268';
}

