tableextension 51534410 PurchPayable extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(51534400; "Foreign Vendor"; Code[20])
        {

            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534401; "Local Vendor"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534402; "Cash Vendor"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534403; "Import Vendor"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534404; "Foreign Purchase Order"; Code[20])
        {

            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534405; "Local Purchase Order"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534406; "Cash Purchase Order"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }
        field(51534407; "Import Purchase Order"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534408; "Foreign Purchase Quote"; Code[20])
        {

            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }

        field(51534409; "Local Purchase Quote"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;


        }

        field(51534410; "Cash Purchase Quote"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }

        field(51534411; "Import Purchase Quote"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534412; "Foreign Purchase Invoice"; Code[20])
        {

            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534413; "Local Purchase Invoice"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534414; "Cash Purchase Invoice"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534415; "Import Purchase Invoice"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534416; "Purchase Req"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

        field(51534417; "Vendor Requisition No"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
        }
        field(51534418; "WHT No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(51534419; "Quotation Request No"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(51534420; "Requisition No"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }


}

