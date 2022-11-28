page 51534605 "HR Participant Groups"
{
    CardPageID = "HR Particpant Group";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Participant Groups';
    SourceTable = "HR Participant Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(BU; BU)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

