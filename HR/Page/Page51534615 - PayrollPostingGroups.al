page 51534615 "Payroll Posting Groups"
{
    CardPageID = "Payroll Posting Group Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payroll Posting Group Header";
    UsageCategory = Lists;
    ApplicationArea = Suite, Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = aLL;
                }
                field(Description; Description)
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


