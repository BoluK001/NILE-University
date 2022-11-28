tableextension 51534354 PurchRcptLine extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50001; "Expense No."; code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where(type = Const(Requisition), Blocked = CONST(false));
            Caption = 'Expense No.';

            trigger OnValidate()
            var
                ExpenseList: record "Receipts and Payment Types";
            begin
                // // IF Rec."Expense No." <> '' THEN
                // IF ExpenseList.GET("Expense No.") then begin
                //     VALIDATE(Type, Type::"G/L Account");
                //     VALIDATE("No.", ExpenseList."G/L Account");
                //     "Expense No." := ExpenseList.code;
                // END;
            end;
        }
        field(50002; "Direct Unit Cost Buffer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "RFQ Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Duty; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51534350; "RFQ No."; Code[20])
        {
            TableRelation = "Quotation Request Vendors"."Document No." where("Vendor No." = field("Buy-from Vendor No."));
            Caption = 'RFQ No.';
            DataClassification = ToBeClassified;
        }
        field(5134351; "Purchase Type"; Option)
        {
            OptionMembers = ,Purchase,Requisition,Quote,Capex;
            OptionCaption = ',Purchase,Requisition,Quote,Capex';
        }
        field(5153452; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5153453; Status; Enum "Purchase Document Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(5153454; "PRF No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        modify(Description)
        {
            Caption = 'Master Description';
        }
        modify("Description 2")
        {
            Caption = 'Specification';
        }
    }
}

