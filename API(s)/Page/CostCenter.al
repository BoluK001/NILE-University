page 51534391 "Cost Center"
{
    APIGroup = 'Dimension2';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'costCenter';
    DelayedInsert = true;
    EntityName = 'CostCenterAPI';
    EntitySetName = 'CostCenter';
    PageType = API;
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(dimensionCode; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
