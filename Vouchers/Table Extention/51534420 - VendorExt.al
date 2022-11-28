/// <summary>
/// TableExtension VendorExt (ID 50008) extends Record Vendor.
/// </summary>
tableextension 51534409 VendorExt extends Vendor
{
    fields
    {

        // Add changes to table fields here
        field(50000; "Vendor Category"; Option)
        {

            Caption = 'Vendor Category';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Foreign",Local,Cash,Import,"Local Staff";
            OptionCaption = ' ,Foreign Vendor,Local Vendor,Cash Vendor,Import Vendor,Local Staff';
            trigger OnValidate()
            begin
                // "Vendor Type" := "Vendor Category";
            end;

        }
        field(50001; "Vendor Type"; Option)
        {
            Caption = 'Vendor Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Import,Local,"Import File",Cash,IOU,"Local Staff","Expat Staff",Foreign,"With Holding Tax";
            OptionCaption = ' ,,Local,,,,,,Foreign,With Holding Tax';
        }
        field(50004; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50005; "Bank Name"; Text[30])
        {

        }
        field(50006; "Bank Approval Date"; Date)
        {

        }
        field(50007; "G/L Account No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Vendor Posting Group"."Payables Account" WHERE(Code = FIELD("Vendor Posting Group")));
        }
        field(50008; "Proforma Order No."; Code[20])
        { }
        field(70001; "W/Tax Code"; Code[20])
        {
            TableRelation = "With-Holding Tax Setup";
            trigger OnValidate()
            var
                WHT: Record "With-Holding Tax Setup";
            begin
                WHT.Get("W/Tax Code");
                WHT.SetRange(code, "W/Tax Code");
                "W/Tax Rate" := WHT."W/Tax Rate";
            end;
        }
        field(70002; "WHT Vendor Code"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(70003; "W/Tax Rate"; Decimal)
        {

        }
        field(70004; "Create WHT Vendor"; Boolean)
        {

        }
        field(70005; "RC Number"; Code[20])
        {

        }
        field(70006; "Main Product/Services"; Text[250])
        {
        }
        field(70007; "Nature Of Business"; Text[100])
        {
        }
        field(70008; "Type of Business"; Text[100])
        {
        }
        field(70010; "Status"; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Open,"Pending Approval",Approved;
        }
    }

    trigger OnBeforeInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        Sleep(5000);
        IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::" ") THEN BEGIN
            //  TESTFIELD("Vendor Type");
            //          Sleep(5000);
            //     //  PurchSetup.GET;
            //     // PurchSetup.TESTFIELD("Vendor Nos.");
            //     // NoSeriesMgt.InitSeries(PurchSetup."Local Vendor", xRec."No. Series", 0D, "No.", "No. Series");
        END
        ELSE
            IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::Local) THEN BEGIN
                PurchSetup.GET;
                PurchSetup.TESTFIELD("Local Vendor");
                NoSeriesMgt.InitSeries(PurchSetup."Local Vendor", xRec."No. Series", 0D, "No.", "No. Series");
            END
            ELSE
                IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::Foreign) THEN BEGIN
                    PurchSetup.GET;
                    PurchSetup.TESTFIELD("Foreign Vendor");
                    NoSeriesMgt.InitSeries(PurchSetup."Foreign Vendor", xRec."No. Series", 0D, "No.", "No. Series");
                END
                ELSE
                    IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::Cash) THEN BEGIN
                        PurchSetup.GET;
                        PurchSetup.TESTFIELD("Cash Vendor");
                        NoSeriesMgt.InitSeries(PurchSetup."Cash Vendor", xRec."No. Series", 0D, "No.", "No. Series");
                    END
                    ELSE
                        IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::Import) THEN BEGIN
                            PurchSetup.GET;
                            PurchSetup.TESTFIELD("Import Vendor");
                            NoSeriesMgt.InitSeries(PurchSetup."Import Vendor", xRec."No. Series", 0D, "No.", "No. Series");
                        END
                        ELSE
                            IF ("No." = '') AND ("Vendor Type" = "Vendor Type"::"With Holding Tax") THEN BEGIN
                                PurchSetup.GET;
                                PurchSetup.TESTFIELD("WHT No.");
                                NoSeriesMgt.InitSeries(PurchSetup."WHT No.", xRec."No. Series", 0D, "No.", "No. Series");
                            END;
    end;

}

