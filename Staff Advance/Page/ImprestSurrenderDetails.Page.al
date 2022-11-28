page 51534725 "Imprest Surrender Details"
{
    PageType = ListPart;
    SourceTable = "Imprest Surrender Details";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Spent"; "Actual Spent")
                {
                    ApplicationArea = All;
                }
                field("Cash Receipt No"; "Cash Receipt No")
                {
                    ApplicationArea = All;
                }
                field("Cash Receipt Amount"; "Cash Receipt Amount")
                {
                    ApplicationArea = All;
                }
                field("Imprest Holder"; "Imprest Holder")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Apply to"; "Apply to")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        "Apply to" := '';
                        "Apply to ID" := '';

                        //Amt:=0;

                        Custledger.Reset;
                        Custledger.SetCurrentKey(Custledger."Customer No.", Open, "Document No.");
                        Custledger.SetRange(Custledger."Customer No.", "Imprest Holder");
                        Custledger.SetRange(Open, true);
                        //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
                        Custledger.CalcFields(Custledger.Amount);
                        if PAGE.RunModal(25, Custledger) = ACTION::LookupOK then begin

                            if Custledger."Applies-to ID" <> '' then begin
                                Custledger1.Reset;
                                Custledger1.SetCurrentKey(Custledger1."Customer No.", Open, "Applies-to ID");
                                Custledger1.SetRange(Custledger1."Customer No.", "Imprest Holder");
                                Custledger1.SetRange(Open, true);
                                //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
                                Custledger1.SetRange("Applies-to ID", Custledger."Applies-to ID");
                                if Custledger1.Find('-') then begin
                                                                  repeat
                                                                      Custledger1.CalcFields(Custledger1.Amount);
                                                                      Amt := Amt + Abs(Custledger1.Amount);
                                                                  until Custledger1.Next = 0;
                                end;

                                if Amt <> Amt then
                                    //ERROR('Amount is not equal to the amount applied on the application form');
                                    /*Amount:=Amt;
                                    VALIDATE(Amount);*/
                           "Apply to" := Custledger."Document No.";
                                "Apply to ID" := Custledger."Applies-to ID";
                            end else begin
                                if Amount <> Abs(Custledger.Amount) then
                                    Custledger.CalcFields(Custledger."Remaining Amount");

                                /*Amount:=ABS(CustLedger."Remaining Amount");
                                 VALIDATE(Amount);*/
                                //ERROR('Amount is not equal to the amount applied on the application form');

                                "Apply to" := Custledger."Document No.";
                                "Apply to ID" := Custledger."Applies-to ID";

                            end;
                        end;

                        if "Apply to ID" <> '' then
                            "Apply to" := '';

                        Validate(Amount);

                    end;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Custledger: Record "Cust. Ledger Entry";
        Custledger1: Record "Cust. Ledger Entry";
        Amt: Decimal;
}

