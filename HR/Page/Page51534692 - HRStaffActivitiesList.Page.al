page 51534692 "HR Staff Activities List"
{
    CardPageID = "HR Staff Activities";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Company Activities";
    SourceTableView = WHERE("Activity Type" = CONST(Staff));
    AdditionalSearchTerms = 'HR Staff Activities List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {ApplicationArea = all;}
                field("Employee No"; "Employee No")
                {ApplicationArea = all;}
                field("Employee Name"; "Employee Name")
                {ApplicationArea = all;}
                field(Date; Date)
                {ApplicationArea = all;}
                field(Subject; Subject)
                {ApplicationArea = all;}
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
        FilterGroup(2);
        SetFilter("Created By", UserId);
        FilterGroup(0);
    end;
}

