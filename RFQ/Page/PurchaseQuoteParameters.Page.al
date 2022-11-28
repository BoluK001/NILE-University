page 51534357 "Purchase Quote Parameters"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Quote Params";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Specification; Specification)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Value; Value)
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

