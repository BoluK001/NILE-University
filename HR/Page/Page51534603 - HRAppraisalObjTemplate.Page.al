page 51534603 "HR Appraisal Obj Template"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Appraisal Obj Template";
    AdditionalSearchTerms = 'HR Appraisal Obj Template';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Behavioural Category"; "Behavioural Category")
                {
                    ApplicationArea = all;
                }
                field(Level; Level)
                {
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Caption = 'Step';
                    Visible = false;
                }
                field(Criteria; Criteria)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Weigthed Score"; "Weigthed Score")
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

