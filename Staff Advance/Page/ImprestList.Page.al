page 51534710 "Imprest List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Header";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = All;
                }
                field("Total Net Amount"; "Total Net Amount")
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

