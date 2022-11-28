page 51534697 "Job KPI's"
{
    CardPageID = "HR Appraisal Evaluation Area";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Appraisal Evaluation Areas";
    AdditionalSearchTerms = 'Job KPIs';

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
                    ApplicationArea = All;
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

