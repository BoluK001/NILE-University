page 51534529 "HR Appraisal Evaluation Areas"
{
    CardPageID = "HR Appraisal Evaluation Area";
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Appraisal Evaluation Areas";
    AdditionalSearchTerms = 'HR Appraisal Evaluation Areas';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                ShowCaption = false;
                field("Categorize As"; "Categorize As")
                {
                    ApplicationArea = all;
                }
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    ApplicationArea = all;
                }
                field("Assign To"; "Assign To")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Include in Evaluation Form"; "Include in Evaluation Form")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    Caption = 'Is For Supervisor Only';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}

