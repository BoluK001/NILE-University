page 51534565 "HR Appraisal Evaluation Area"
{
    PageType = Document;
    SourceTable = "HR Appraisal Evaluation Areas";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    ApplicationArea = all;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = all;
                }
                field("Assign To"; "Assign To")
                {
                    ApplicationArea = all;
                }
            }
            part(Control1102755005; "HR Appraisal Evaluation Descri")
            {
                SubPageLink = "Evaluation Area" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

