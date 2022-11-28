page 51534493 "HR Activity Participants SF"
{
    Caption = 'Activity Participants';
    ApplicationArea = all;
    PageType = List;
    SaveValues = true;
    AdditionalSearchTerms = 'Activity Participants';
    SourceTable = "HR Activity Participants";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Notified; Notified)
                {
                    ApplicationArea = all;
                }
                field(Participant; Participant)
                {
                    ApplicationArea = all;
                }
                field("Participant Name"; "Participant Name")
                {
                    ApplicationArea = all;
                }
                field(Contribution; Contribution)
                {
                    ApplicationArea = all;
                }
                field("Email Message"; "Email Message")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        "Table ID" := 1;
        "Sequence No." := 1;
    end;
}

