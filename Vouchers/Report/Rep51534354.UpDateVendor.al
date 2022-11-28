report 51534354 UpDateVendor
{
    Caption = 'UpDateVendor';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") where("No." = filter(''));

            trigger OnAfterGetRecord()
            begin
                SetRange("No.", '');
                vendor.Delete()
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
