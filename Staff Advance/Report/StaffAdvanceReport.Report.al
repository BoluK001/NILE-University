/*report 51534724 "Staff Advance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffAdvanceReport.rdlc';

    dataset
    {
        dataitem("Staff Advance Header"; "Staff Advance Header")
        {
            CalcFields = "Staff Advance Retire No.";
            DataItemTableView = SORTING("Account No.");
            column(No_StaffAdvanceHeader; "Staff Advance Header"."No.")
            {
            }
            column(AccountNo_StaffAdvanceHeader; "Staff Advance Header"."Account No.")
            {
            }
            column(OnBehalfOf_StaffAdvanceHeader; "Staff Advance Header"."On Behalf Of")
            {
            }
            column(Payee_StaffAdvanceHeader; "Staff Advance Header".Payee)
            {
            }
            column(TotalNetAmount_StaffAdvanceHeader; "Staff Advance Header"."Total Net Amount")
            {
            }
            column(Date_StaffAdvanceHeader; Format("Staff Advance Header".Date))
            {
            }
            column(GlobalDimension1Code_StaffAdvanceHeader; "Staff Advance Header"."Global Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_StaffAdvanceHeader; "Staff Advance Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Balance; Cust.Balance)
            {
            }
            dataitem("Staff Advanc Surrender Details"; "Staff Advanc Surrender Details")
            {
                DataItemLink = "Surrender Doc No." = FIELD("Staff Advance Retire No.");
                column(SurrenderDocNo_StaffAdvancSurrenderDetails; "Staff Advanc Surrender Details"."Surrender Doc No.")
                {
                }
                column(SurrenderDate_StaffAdvancSurrenderDetails; Format(SurrDate))
                {
                }
                column(AccountName_StaffAdvancSurrenderDetails; "Staff Advanc Surrender Details"."Account Name")
                {
                }
                column(ShortcutDimension1Code_StaffAdvancSurrenderDetails; "Staff Advanc Surrender Details"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_StaffAdvancSurrenderDetails; "Staff Advanc Surrender Details"."Shortcut Dimension 2 Code")
                {
                }
                column(Amount_StaffAdvancSurrenderDetails; "Staff Advanc Surrender Details".Amount)
                {
                }
                dataitem("Receipt Line"; "Receipt Line")
                {
                    DataItemLink= "No." = FIELD("Cash Receipt No");
                    column(No_ReceiptLine; "Receipt Line".No)
                    {
                    }
                    column(Amount_ReceiptLine; "Receipt Line".Amount)
                    {
                    }
                    column(OnBehalfOf_ReceiptLine; recpNarration)
                    {
                    }
                    column(GlobalDimension1Code_ReceiptLine; "Receipt Line"."Global Dimension 1 Code")
                    {
                    }
                    column(Date_ReceiptLine; Format(recpDate))
                    {
                    }
                    column(ShortcutDimension2Code_ReceiptLine; "Receipt Line"."Shortcut Dimension 2 Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ReceipHeader.Get("Receipt Line".No) then begin
                            recpNarration := ReceipHeader."Received From";
                            recpDate := ReceipHeader.Date;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SurrDate := 0D;
                    if SurHeader.Get("Staff Advanc Surrender Details"."Surrender Doc No.") then
                        SurrDate := SurHeader."Surrender Date";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Cust.Get("Staff Advance Header"."Account No.") then
                    Cust.CalcFields(Balance);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SurrDate: Date;
        SurHeader: Record "Staff Advance Surrender Header";
        ReceipHeader: Record "Voucher Header"; //Receipt Header
        recpNarration: Text[250];
        recpDate: Date;
        Cust: Record Customer;
}

*/