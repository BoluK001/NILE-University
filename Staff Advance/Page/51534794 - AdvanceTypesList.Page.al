page 51534794 "Advance Types List"
{
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = WHERE(Type = CONST(Advance));
    AdditionalSearchTerms = 'Advance Types List';


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        AccountTypeOnAfterValidate;
                    end;
                }
                field("Payment Reference"; "Payment Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Reference';
                }
                field("Default Grouping"; "Default Grouping")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; "Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transation Remarks"; "Transation Remarks")
                {
                    ApplicationArea = All;
                }
                field("Direct Expense"; "Direct Expense")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //CurrPage."G/L Account".VISIBLE:=("Account Type"="Account Type"::"G/L Account");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::Advance;
        "Direct Expense" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Account Type" := "Account Type"::"G/L Account";
    end;

    local procedure AccountTypeOnAfterValidate()
    begin
        //CurrPage."G/L Account".VISIBLE:=("Account Type"="Account Type"::"G/L Account");
    end;
}

