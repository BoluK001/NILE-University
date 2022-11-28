page 51534544 "HR Job Responsiblities (RO)"
{
    Caption = '<HR Job Responsiblities';
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Responsibility Code"; "Responsibility Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Description"; "Responsibility Description")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

