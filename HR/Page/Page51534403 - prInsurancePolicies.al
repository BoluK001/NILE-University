page 51534403 "prInsurance Policies"
{

    ApplicationArea = all;
    Caption = 'prInsurance Policies';
    SourceTable = prInsurancePolicies;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Insurance Policies';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Policy Number"; Rec."Policy Number")
                {
                    ToolTip = 'Specifies the value of the Policy Number field.';
                    ApplicationArea = all;

                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Code field.';
                    ApplicationArea = all;

                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = all;

                }
                field("Deduct premium"; Rec."Deduct premium")
                {
                    ToolTip = 'Specifies the value of the Deduct premium field.';
                    ApplicationArea = all;

                }
                field(balance; Rec.balance)
                {
                    ToolTip = 'Specifies the value of the balance field.';
                    ApplicationArea = all;

                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                    ApplicationArea = all;

                }
            }
        }
    }

}
