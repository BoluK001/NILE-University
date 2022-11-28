page 51534637 "HR Particpant Line"
{
    PageType = ListPart;
    SourceTable = "HR Participant Group Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Doc No"; "Doc No")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }

                field("Job Level"; "Job Level")
                {
                    ApplicationArea = all;
                }

                field(Description; Description)
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

