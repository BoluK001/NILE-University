page 51534413 "HR Job Employment History"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Jv Lines Attachments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Link"; Rec."Document Link")
                { 
                    ApplicationArea = all; 
                }
                /*
                field(MaintainAttachment; MaintainAttachment)
                { 
                    ApplicationArea = all; 
                }
                field("End Date"; Rec."End Date")
                { 
                    ApplicationArea = all; 
                }
                */
                field("Language Code (Default)"; Rec."Language Code (Default)")
                { 
                    ApplicationArea = all; 
                }
                field(Attachment; Rec.Attachment)
                { 
                    ApplicationArea = all; 
                }
                /*
                field(ExportAttachment; ExportAttachment)
                { 
                    ApplicationArea = all; 
                }
                field(ImportAttachment; ImportAttachment)
                { 
                    ApplicationArea = all; 
                }
                */
            }
        }
    }

    actions
    {
    }
}

