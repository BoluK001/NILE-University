page 51534598 "Emp. Training Evaluation"
{
    CardPageID = "Emp. Training Eval - Card";
    DeleteAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Emp. Training Evaluation';
    SourceTable = "Emp Traing Eval. Questionaire";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Emp Code"; "Emp Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Traning Evaluation Type"; "Traning Evaluation Type")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Date"; "Evaluation Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetFilter("User ID", UserId);
    end;
}

