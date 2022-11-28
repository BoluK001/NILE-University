table 51534413 "SIS Invoices Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; ReferenceNo; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; StudentNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; InvoiceType; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; ReferenceDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; CurrencyCode; code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; ExchangeRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; ReferenceInvNo; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; IntegrationStatus; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; ProgramVersionCode; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; MiscRef1; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Invoice Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {

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