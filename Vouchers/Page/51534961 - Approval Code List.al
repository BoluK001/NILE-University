page 51534961 "Approval CodeList"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Approval code";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Approval Code"; "Approval Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }

    }


}