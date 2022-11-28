page 51534706 "HR Appraisal Development Plan"
{
    AutoSplitKey = false;
    PageType = ListPart;
    SaveValues = false;
    SourceTable = "HR Training Development PlanL1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Key Development Area"; "Key Development Area")
                {
                    ApplicationArea = all;
                }
                field("KDA Description"; "KDA Description")
                {
                    ApplicationArea = all;
                }
                field("Purpose of Training"; "Purpose of Training")
                {
                    ApplicationArea = all;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = all;
                }
                field("Duration Units"; "Duration Units")
                {
                    ApplicationArea = all;
                }
                field(Duration; Duration)
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

