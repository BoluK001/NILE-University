page 51534626 "Salary Step/Notch Transactions"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Salary Step/Notch Transactions";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Salary Step/Notch Transactions';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Frequency; Frequency)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("% of Basic Pay"; "% of Basic Pay")
                {
                    ApplicationArea = all;
                    Caption = '% Of Gross Pay';
                }
                field(Formula; Formula)
                {
                    Editable = true;
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Annual Amount"; "Annual Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

