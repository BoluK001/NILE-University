page 51534401 "Pension Contribution Details"
{

    ApplicationArea = all;
    PageType = List;
    Caption = 'Pension Contribution Details';
    SourceTable = "prPension Details";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Pension Contribution Details';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                    ApplicationArea = all;

                }
                field("Inception Date"; Rec."Inception Date")
                {
                    ToolTip = 'Specifies the value of the Inception Date field.';
                    ApplicationArea = all;

                }
                field("Pension Number"; Rec."Pension Number")
                {
                    ToolTip = 'Specifies the value of the Pension Number field.';
                    ApplicationArea = all;

                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                    ApplicationArea = all;

                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                    ApplicationArea = all;

                }
                field("Deduct premium"; Rec."Deduct premium")
                {
                    ToolTip = 'Specifies the value of the Deduct premium field.';
                    ApplicationArea = all;

                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = all;

                }
                field(balance; Rec.balance)
                {
                    ToolTip = 'Specifies the value of the balance field.';
                    ApplicationArea = all;

                }
                field(lumpsumitems; Rec.lumpsumitems)
                {
                    ToolTip = 'Specifies the value of the lumpsumitems field.';
                    ApplicationArea = all;

                }
                field("Is Insurance policy"; Rec."Is Insurance policy")
                {
                    ToolTip = 'Specifies the value of the Is Insurance policy field.';
                    ApplicationArea = all;

                }
            }
        }
    }

}
