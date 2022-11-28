page 51534668 "Shortlisted Candidates Intvw"
{
    CardPageID = "HR Job Applications Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Job Applications";
    SourceTableView = WHERE("Qualified (Interview)" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; "Application No")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; "ID Number")
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

