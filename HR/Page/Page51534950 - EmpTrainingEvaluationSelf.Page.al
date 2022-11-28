page 51534950 "Emp. Training Evaluation Self"
{
    CardPageID = "Emp. Training Eval - Card";
    DeleteAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Emp Traing Eval. Questionaire";
    AdditionalSearchTerms = 'Emp. Training Evaluation Self';

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
        FilterGroup(2);
        SetFilter("User ID", UserId);
        FilterGroup(0);
    end;
}

