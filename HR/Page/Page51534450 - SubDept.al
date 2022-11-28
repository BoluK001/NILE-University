page 51534450 "Sub. Dept."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sub. Department";
    Caption = 'Unit';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Dept. Code"; "Dept. Code")
                {
                    Caption = 'Division Code';
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Code';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Description';
                }
            }

        }
        area(Factboxes)
        {

        }
    }


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}
