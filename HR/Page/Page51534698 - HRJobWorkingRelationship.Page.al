page 51534698 "HR Job Working Relationship"
{
    Editable = true;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Job Working Relationship';
    SourceTable = "HR Job Working Relationship";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Working Relationship Code"; "Working Relationship Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = all;
                }
                field("No. of Occupants"; "No. of Occupants")
                {
                    ApplicationArea = all;
                }
                field("Vacant Position"; "Vacant Position")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

