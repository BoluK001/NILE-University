pageextension 51534360 VendorList extends "Vendor List"
{
    trigger OnOpenPage()
    var

    begin
        SetFilter("Vendor Type", '<>%1', 9);
    end;
}
