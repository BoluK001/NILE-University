page 51534701 "HR Appraisal Next KPI"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Goal Setting L";
    SourceTableView = WHERE("KPI Period" = CONST(Next));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal Period"; "Appraisal Period")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Targets/Objectives"; "Planned Targets/Objectives")
                {
                    Caption = 'Key Result Areas';
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Caption = 'Key Performance Indicator';
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Measurement Criteria"; "Measurement Criteria")
                {
                    Caption = 'Key performance Objective';
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Target Score';
                    ApplicationArea = All;
                }
                field("Agreement With Rating"; "Agreement With Rating")
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

