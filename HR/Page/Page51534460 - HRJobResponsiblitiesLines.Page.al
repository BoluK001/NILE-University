page 51534460 "HR Job Responsiblities Lines"
{
    Editable = true;
    ApplicationArea = all;
    PageType = Listpart;
    AdditionalSearchTerms = 'HR Job Responsiblities Lines';
    SourceTable = "HR Job Responsiblities";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Responsibility Code";Rec."Responsibility Code")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Responsibility Description";Rec."Responsibility Description")
                {
                    Enabled = true;
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    Editable = true;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

