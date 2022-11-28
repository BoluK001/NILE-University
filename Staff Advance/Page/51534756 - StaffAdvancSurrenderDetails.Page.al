page 51534756 "Staff Advanc Surrender Details"
{
    Caption = 'Retirement Line';
    PageType = ListPart;
    SourceTable = "Staff Advanc Surrender Details";
    //Caption = 'Staff Advance Retirement Lines';
    //PageType = ListPart;
    //SourceTable = "Staff Advan Surrender Details";

    layout
    {
        area(content)
        {
            repeater(Control1000000014)
            {
                ShowCaption = false;
                field("Imprest Type"; "Imprest Type")
                {
                    Caption = 'Advance Type';
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; "Account Name")
                {
                    Caption = 'Description';
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
                field("Cash Receipt Amount"; "Cash Receipt Amount")
                {
                    Caption = 'Deposit Amount';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Apply to"; "Apply to")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        "Apply to" := '';
                        "Apply to ID" := '';

                        //Amt:=0;

                        EmployeeLedgerEntry.Reset;
                        EmployeeLedgerEntry.SetCurrentKey(EmployeeLedgerEntry."Employee No.", Open, "Document No.");
                        EmployeeLedgerEntry.SetRange(EmployeeLedgerEntry."Employee No.", "Advance Holder");
                        EmployeeLedgerEntry.SetRange(Open, true);
                        //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
                        EmployeeLedgerEntry.CalcFields(EmployeeLedgerEntry.Amount);
                        if PAGE.RunModal(5237, EmployeeLedgerEntry) = ACTION::LookupOK then begin

                            if EmployeeLedgerEntry."Applies-to ID" <> '' then begin
                                EmployeeLedgerEntry1.Reset;
                                EmployeeLedgerEntry1.SetCurrentKey(EmployeeLedgerEntry1."Employee No.", Open, "Applies-to ID");
                                EmployeeLedgerEntry1.SetRange(EmployeeLedgerEntry1."Employee No.", "Advance Holder");
                                EmployeeLedgerEntry1.SetRange(Open, true);
                                //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
                                EmployeeLedgerEntry1.SetRange("Applies-to ID", EmployeeLedgerEntry."Applies-to ID");
                                if EmployeeLedgerEntry1.Find('-') then begin
                                                                           repeat
                                                                               EmployeeLedgerEntry1.CalcFields(EmployeeLedgerEntry1.Amount);
                                                                               Amt := Amt + Abs(EmployeeLedgerEntry1.Amount);
                                                                           until EmployeeLedgerEntry1.Next = 0;
                                end;

                                if Amt <> Amt then
                                    //ERROR('Amount is not equal to the amount applied on the application form');
                                    /*Amount:=Amt;
                                    VALIDATE(Amount);*/
                           "Apply to" := EmployeeLedgerEntry."Document No.";
                                "Apply to ID" := EmployeeLedgerEntry."Applies-to ID";
                            end else begin
                                if Amount <> Abs(EmployeeLedgerEntry.Amount) then
                                    EmployeeLedgerEntry.CalcFields(EmployeeLedgerEntry."Remaining Amount");

                                /*Amount:=ABS(CustLedger."Remaining Amount");
                                 VALIDATE(Amount);*/
                                //ERROR('Amount is not equal to the amount applied on the application form');

                                "Apply to" := EmployeeLedgerEntry."Document No.";
                                "Apply to ID" := EmployeeLedgerEntry."Applies-to ID";

                            end;
                        end;

                        if "Apply to ID" <> '' then
                            "Apply to" := '';

                        Validate(Amount);

                        /*
                        IF (Rec."Account Type"<>Rec."Account Type"::Employee) THEN
                            ERROR('You cannot apply to %1',"Account Type");
                        IF "Account Type" = "Account Type"::Employee THEN BEGIN
                        WITH Rec DO BEGIN
                          //Amount:=0;
                          //VALIDATE(Amount);
                          PayToVendorNo := "Account No." ;
                          VendLedgEntry.SETCURRENTKEY("Vendor No.",Open);
                          VendLedgEntry.SETRANGE("Vendor No.",PayToVendorNo);
                          VendLedgEntry.SETRANGE(Open,TRUE);
                          IF "Applies-to ID" = '' THEN
                            "Applies-to ID" := No;
                          IF "Applies-to ID" = '' THEN
                            ERROR(
                              Text000,
                              FIELDCAPTION(No),FIELDCAPTION("Applies-to ID"));
                          //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                          ApplyVendEntries.SetPVLine(Rec,VendLedgEntry,Rec.FIELDNO("Applies-to ID"));
                          ApplyVendEntries.SETRECORD(VendLedgEntry);
                            ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                          ApplyVendEntries.LOOKUPMODE(TRUE);
                          OK := ApplyVendEntries.RUNMODAL = ACTION::LookupOK;
                          CLEAR(ApplyVendEntries);
                          IF NOT OK THEN
                            EXIT;
                          VendLedgEntry.RESET;
                          VendLedgEntry.SETCURRENTKEY("Vendor No.",Open);
                          VendLedgEntry.SETRANGE("Vendor No.",PayToVendorNo);
                          VendLedgEntry.SETRANGE(Open,TRUE);
                          VendLedgEntry.SETRANGE(VendLedgEntry."Applies-to ID","Applies-to ID");
                          IF VendLedgEntry.FIND('-') THEN BEGIN
                            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
                            "Applies-to Doc. No." := VendLedgEntry."Document No.";
                        
                          END ELSE
                            "Applies-to ID" := '';
                        END;
                        //Calculate  Total To Apply
                          VendLedgEntry.RESET;
                          VendLedgEntry.SETCURRENTKEY("Vendor No.",Open,"Applies-to ID");
                          VendLedgEntry.SETRANGE("Vendor No.",PayToVendorNo);
                          VendLedgEntry.SETRANGE(Open,TRUE);
                          VendLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
                          IF VendLedgEntry.FIND('-') THEN BEGIN
                                VendLedgEntry.CALCSUMS("Amount to Apply");
                                Amount:=ABS(VendLedgEntry."Amount to Apply");
                                VALIDATE(Amount);
                                //Total Invoice Amount
                                "Total Invoice Amount":=ABS(VendLedgEntry."Amount to Apply");
                                //Total Invoice Amount
                          END;
                         END;
                         */

                    end;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    // Caption = 'ECU Code';   //jj020722 
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Advance Holder"; "Advance Holder")
                {
                    ApplicationArea = All;
                }
                field("Surrender Doc No."; "Surrender Doc No.")
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
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
        UserSetup: Record "User Setup";
        StaffSurHeader: Record "Staff Advance Surrender Header";
        PayToVendorNo: Integer;
        EmployeeLedgerEntry: Record "Employee Ledger Entry";
        EmployeeLedgerEntry1: Record "Employee Ledger Entry";

}

