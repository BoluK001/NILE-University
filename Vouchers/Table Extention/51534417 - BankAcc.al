tableextension 51534406 BankAccExt extends "Bank Account" //MyTargetTableId
{
    fields
    {
        field(51534400; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            DataClassification = ToBeClassified;
            //OptionMembers = ,Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
            OptionMembers = ,Normal,Cash,Cheque,EFT;
            //OptionCaption = 'Default';
        }
        field(51534401; Cash; Boolean)
        {

        }
        field(51534402; "G/L Account No."; Code[20])
        {
            CalcFormula = Lookup("Bank Account Posting Group"."G/L Bank Account No." WHERE(Code = FIELD("Bank Acc. Posting Group")));
            FieldClass = FlowField;
        }
        field(51534403; Bank; Boolean) { }
        field(51534404; "Other Ledger"; Boolean)
        {

        }
    }
}