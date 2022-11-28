page 51534696 "HR Staff Activities List Self"
{
    CardPageID = "HR Staff Activities";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Company Activities";
    SourceTableView = WHERE("Activity Type" = CONST(Staff));
    AdditionalSearchTerms = 'HR Staff Activities List Self';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Subject; Subject)
                {
                    ApplicationArea = all;
                }
            }
            systempart(Control8; MyNotes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*FILTERGROUP(2);
        SETFILTER("Created By",USERID);
        FILTERGROUP(0);
         */

    end;
}

