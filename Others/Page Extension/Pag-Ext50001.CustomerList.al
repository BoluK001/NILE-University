pageextension 51534416 CustomerList extends "Customer List"
{
    trigger OnOpenPage()
    begin
        SetFilter("Customer Type", '%1|%2', 0, 1);
    end;
}
