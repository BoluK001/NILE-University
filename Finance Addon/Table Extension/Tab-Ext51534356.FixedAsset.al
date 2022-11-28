tableextension 51534356 FixedAsset extends "Fixed Asset"
{
    fields
    {
        field(51534350; "Asset Tag"; Code[50])
        {
            Caption = 'Asset Tag';
            DataClassification = ToBeClassified;
        }
        modify("Global Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                Ok: Boolean;
            begin
                if "Asset Tag" <> '' then
                    Ok := Confirm('The Asset has been tagged, are you sure you want to modify the Asset tag?', true, "Asset Tag");
            end;
        }
    }
}
