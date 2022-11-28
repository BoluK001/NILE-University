tableextension 51534358 PurchaseRcpt extends "Purch. Rcpt. Header"
{
    fields
    {
        field(51534350; "RFQ No."; Code[20])
        {
            TableRelation = "Quotation Request Vendors"."Document No." where("Vendor No." = field("Buy-from Vendor No."));
            Caption = 'RFQ No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RFQLines: Record "Purchase Quote Line";
                PurchaseLines: Record "Purchase Line";
                Vends: Record "Quotation Request Vendors";
            begin
                //PurchaseLines.SETRANGE("RFQ No.", Rec."RFQ No.");
                //PurchaseLines.Setrange("Document No.", "No.");
                // PurchaseLines.SetRange("Document Type", Rec."Document Type");
                //if PurchaseLines.Find('-') then
                //PurchaseLines.Deleteall();

                // RFQLines.SetRange("Document No.", "RFQ No.");
                // PurchaseLines.Setrange("Document No.", "No.");
                // PurchaseLines.Deleteall();
                // IF RFQLines.FIND('-') then begin

                //     REPEAT
                //         PurchaseLines.INIT;
                //         PurchaseLines.TRANSFERFIELDS(RFQLines);
                //         PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
                //         PurchaseLines."Document No." := "No.";
                //         //PurchaseLines."RFQ No." := "RFQ No.";
                //         PurchaseLines."Expense No." := RFQLines."Expense No.";
                //         PurchaseLines."PRF No." := RFQLines."PRF No";
                //         PurchaseLines."RFQ No." := RFQLines."Document No.";
                //         PurchaseLines."Purchase Type" := "Purchase Type"::Local;
                //         PurchaseLines.INSERT;
                //     UNTIL RFQLines.NEXT = 0;
                // end;
                // //Message('%1', RFQLines."Document No.");
            end;

        }
        field(5134351; "Purchase Type"; Enum "Purchase Type")
        {
            //OptionMembers = ,Purchase,Requisition,Quote,Capex;
            //OptionCaption = ',Purchase,Requisition,Quote,Capex';
        }
        field(5153452; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5153453; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
            TableRelation = "Approval Code";
            DataClassification = ToBeClassified;
        }
        field(5153454; "Vendor Website"; text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."Home Page" where("No." = field("Buy-from Vendor No.")));
        }

    }
}
