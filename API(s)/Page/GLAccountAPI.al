page 51534392 "GL Account API"
{
    APIGroup = 'GLA';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'glAccountAPI';
    DelayedInsert = true;
    EntityName = 'GLAccountAPI';
    EntitySetName = 'GLAccount';
    PageType = API;
    SourceTable = "G/L Account";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
