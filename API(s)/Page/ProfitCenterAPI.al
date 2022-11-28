page 51534390 "Profit Center API"
{
    APIGroup = 'Dimention1';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'profitCenterAPI';
    DelayedInsert = true;
    EntityName = 'Profitcenter';
    EntitySetName = 'ProfitCenter';
    PageType = API;
    SourceTable = "Dimension Value";
    SourceTableView = WHERE("Dimension Code" = filter('REVENUE CENTRE'));

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
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
