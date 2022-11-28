/// <summary>
/// Table StudentDetails (ID 50103).
/// </summary>
table 51534409 PaymentDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; IntegrationStatus; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; StudentNo; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; ReceiptNumber; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; ReferenceNumber; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Transaction Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Payment Method"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bank Account"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Receipt Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Currency Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Transaction Account"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Receipt Reference No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Last Date Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(17; Remark; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Payment Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Ledger Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Amount After Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Category; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Campus Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Program Version"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Misc. Ref. 1"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Misc. Ref. 2"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Payment Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "BC Processed Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Processed Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(pk; id)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}