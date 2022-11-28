page 51534409 "HR Email Parameter List"
{
    CardPageID = "HR E-Mail Parameters";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Email Parameter List';
    SourceTable = "HR E-Mail Parameters";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Associate With"; Rec."Associate With")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

