page 51534652 "Responsibility Center API"
{
    APIGroup = 'Responsibilities';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'responsibilityCenterAPI';
    DelayedInsert = true;
    EntityName = 'Resposibilitycenter';
    EntitySetName = 'ResponsibiltyCenterAPI';
    PageType = API;
    SourceTable = "Responsibility Center";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
            }
        }
    }
}
