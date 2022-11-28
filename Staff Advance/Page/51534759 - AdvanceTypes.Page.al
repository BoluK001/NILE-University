#pragma implicitwith disable
page 51534759 "Advance Types"
{
    PageType = Card;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = WHERE(Type = CONST(Advance));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        AccountTypeOnAfterValidate;
                    end;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Reference';
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                    ApplicationArea = All;
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
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
        Rec.Type := Rec.Type::Advance;
        Rec."Direct Expense" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Account Type" := Rec."Account Type"::"G/L Account";
    end;

    local procedure AccountTypeOnAfterValidate()
    begin
        //CurrPage."G/L Account".VISIBLE:=("Account Type"="Account Type"::"G/L Account");
    end;
}

#pragma implicitwith restore

