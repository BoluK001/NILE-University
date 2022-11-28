page 51534427 "Beneficiary Bank List"
{

    ApplicationArea = all;
    PageType = List;
    Caption = 'Beneficiary Bank List';
    SourceTable = "Beneficiary Bank List";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Beneficiary Bank List';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bank Code "; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code  field.';
                    ApplicationArea = all;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                    ApplicationArea = all;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                    ApplicationArea = all;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = all;
                }
                field("SWIFT CODE"; Rec."SWIFT CODE")
                {
                    ToolTip = 'Specifies the value of the SWIFT CODE field.';
                    ApplicationArea = all;
                }
            }
        }
    }

}
