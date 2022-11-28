tableextension 51534404 GLEntryExt extends "G/L Entry"
{
    fields
    {
        field(70013; "Loan ID"; Code[20]) { }
        field(70014; "Acct. No."; Code[20]) { }
    }

}


pageextension 51534404 GLEntryExt extends "General Ledger Entries"
{
    layout
    {
        addafter("G/L Account No.")
        {
            field("Loan ID"; "Loan ID") { }
            field("Acct. No."; "Acct. No.") { }
        }
    }

    // Add changes to page layout here
}


