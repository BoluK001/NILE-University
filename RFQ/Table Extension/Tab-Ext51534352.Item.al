tableextension 51534352 Item extends Item
{
    fields
    {
        field(51534350; "Item G/L Budget Account"; Code[20])
        {
            Caption = 'Item G/L Budget Account';
            DataClassification = ToBeClassified;
        }
        field(51534351; Location; Code[20])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }

        field(51534352; "Status"; Option)
        {
            Caption = '';
            DataClassification = ToBeClassified;
            Description = 'Stores the status of the record in the database';
            OptionMembers = Open,"Pending Approval",Approved;
        }
    }
}
