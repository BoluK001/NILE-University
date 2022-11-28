page 51534754 "Staff Advance Lines"
{
    //Caption = 'Work Advance Lines';
    PageType = ListPart;
    SourceTable = "Staff Advance Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Advance Type"; "Advance Type")
                {
                    ApplicationArea = All;
                }
                field(No; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Account No."; "Account No.")
                {
                    Editable = EditAll;
                    ApplicationArea = All;
                }
                field("Advance Narration"; "Advance Narration")
                {
                    Editable = EditAll;
                    ApplicationArea = All;
                }
                field("Account Name"; "Account Name")
                {
                    Caption = 'Description';
                    Editable = true;
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;
                    Editable = EditAll;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = EditAll;

                    trigger OnValidate()
                    begin
                        /*{Get the total amount paid}
                        Bal:=0;
                        
                        PayHeader.RESET;
                        PayHeader.SETRANGE(PayHeader."Line No.",No);
                        IF PayHeader.FINDFIRST THEN
                          BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine."No.",PayHeader."Line No.");
                            IF PayLine.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Bal:=Bal + PayLine."Pay Mode";
                                UNTIL PayLine.NEXT=0;
                              END;
                          END;
                        //Bal:=Bal + Amount;
                        
                        IF Bal > PayHeader.Amount THEN
                          BEGIN
                            ERROR('Please ensure that the amount inserted does not exceed the amount in the header');
                          END;
                          */

                    end;
                }
                field("Due Date"; "Due Date")
                {
                    Editable = EditAll;
                    ApplicationArea = All;
                }
                field("Date Issued"; "Date Issued")
                {
                    Editable = EditAll;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        DimVal.Reset;
                        DimVal.SetRange(DimVal."Global Dimension No.", 2);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Pheader.Get("No.") then begin
            if (Pheader.Status = Pheader.Status::Approved) or (Pheader.Status = Pheader.Status::"Pending Approval") then
                EditAll := false
            else
                EditAll := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if Pheader.Get("No.") then begin
            if (Pheader.Status = Pheader.Status::Approved) or (Pheader.Status = Pheader.Status::"Pending Approval") then
                EditAll := false
            else
                EditAll := true;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Pheader.Get("No.") then begin
            if (Pheader.Status = Pheader.Status::Approved) or (Pheader.Status = Pheader.Status::"Pending Approval") then
                EditAll := false
            else
                EditAll := true;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Pheader.Get("No.") then begin
            if (Pheader.Status = Pheader.Status::Approved) or (Pheader.Status = Pheader.Status::"Pending Approval") then
                EditAll := false
            else
                EditAll := true;
        end;
    end;

    var
        // PayHeader: Record "Pending Vch. Surr. Line";
        // PayLine: Record "Receipt Line";
        Bal: Decimal;
        DimVal: Record "Dimension Value";
        Pheader: Record "Staff Advance Header";
        EditAll: Boolean;
}

