page 51534480 "HR Lookup Values List"
{
    CardPageID = "HR Lookup Values Card";
    DeleteAllowed = false;
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Lookup Values List';
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Code"; Rec.Code)
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("HMO Plan"; Rec."HMO Plan")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Lookup Values Factbox")
            {
                SubPageLink = Type = FIELD(Type);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin

        Error('You cannot delete this record. Please contact your Systems Administrator');
    end;
}

