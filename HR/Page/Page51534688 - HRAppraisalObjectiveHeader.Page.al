page 51534688 "HR Appraisal Objective Header"
{
    PageType = Document;
    SourceTable = "HR Appraisal Objective Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Level; Level)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
            part(Control5; "HR Appraisal Obj Template")
            {
                SubPageLink = Level = FIELD(Level);
            }
        }
    }

    actions
    {
    }
}

