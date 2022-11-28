page 51534475 "HR Leave Batches"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Leave Journal Batch";
    AdditionalSearchTerms = 'HR Leave Batches';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Name; Name)
                { 
                    ApplicationArea = all; 
                }
                field(Description; Description)
                { 
                    ApplicationArea = all; 
                }
                field("Posting Description"; "Posting Description")
                { 
                    ApplicationArea = all; 
                }
                field(Type; Type)
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

