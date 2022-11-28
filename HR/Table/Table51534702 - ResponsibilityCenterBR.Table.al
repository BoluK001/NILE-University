table 51534702 "Responsibility Center BR"
{
    Caption = 'Responsibility Center';
    DrillDownPageID = "Responsibility Center List BR";
    LookupPageID = "Responsibility Center List BR";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(4; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(5; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", true);
            end;
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",County,"Country/Region Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", true);
            end;
        }
        field(7; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(10; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(11; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(14; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(15; County; Text[30])
        {
            Caption = 'County';
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[90])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(5900; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5901; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Gain/Loss Entry".Amount WHERE("Responsibility Center" = FIELD(Code),
                                                                       "Change Date" = FIELD("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Payment User(s) - E-Mail"; Text[250])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50001; "Notify Payment User(s)"; Boolean)
        {
        }
        field(50004; "CPV Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50005; "BPV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50006; "CRV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50007; "BRV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50008; "JV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50009; "Posted CPV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50010; "Posted BPV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50011; "Posted CRV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50012; "Posted BRV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50013; "Posted JV Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50015; "Posted Contra Voucher Nos."; Code[20]) { TableRelation = "No. Series"; }
        field(50016; "Petty Cash Nos"; Code[20]) { TableRelation = "No. Series"; }
        field(50017; "Posted Petty Cash Nos"; Code[20]) { TableRelation = "No. Series"; }
        field(50018; "Contra Voucher Nos."; Code[20]) { TableRelation = "No. Series"; }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DimMgt.DeleteDefaultDim(DATABASE::"Responsibility Center", Code);

        //Prevent deletion once entries exist
        TestNoEntriesExist(FieldCaption(Code));
    end;

    var
        PostCode: Record "Post Code";
        DimMgt: Codeunit 408;
        Text001: Label 'You cannot delete %1 %2 because there is at least one %3 associated to this Responsibity Centre.';

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Responsibility Center", Code, FieldNumber, ShortcutDimCode);
        Modify;
    end;

    [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        ItemLedgEntry: Record "Voucher Header";
    begin
        //To prevent change of field

        ItemLedgEntry.SetCurrentKey(ItemLedgEntry."Responsibility Center");
        ItemLedgEntry.SetRange("Responsibility Center", Code);
        if ItemLedgEntry.Find('-') then
            Error(
              Text001,
              CurrentFieldName);
    end;
}

