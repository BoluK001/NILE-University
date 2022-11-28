page 51534745 "Budgetary Control Setup"
{
    PageType = Card;
    SourceTable = "Budgetary Control Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Mandatory)
                {
                    ApplicationArea = All;
                }
                field("Allow OverExpenditure"; "Allow OverExpenditure")
                {
                    ApplicationArea = All;
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code"; "Current Budget Code")
                {
                    ApplicationArea = All;
                }
                field("Current Budget Start Date"; "Current Budget Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Budget End Date"; "Current Budget End Date")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 1 Code"; "Budget Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 2 Code"; "Budget Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 3 Code"; "Budget Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 4 Code"; "Budget Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 5 Code"; "Budget Dimension 5 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Dimension 6 Code"; "Budget Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                field("Analysis View Code"; "Analysis View Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 1 Code"; "Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 2 Code"; "Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 3 Code"; "Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension 4 Code"; "Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

