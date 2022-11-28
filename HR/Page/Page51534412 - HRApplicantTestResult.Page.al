page 51534412 "HR Applicant Test Result"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Applicant Test Details";
    AdditionalSearchTerms = 'HR Applicant Test Result';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                { 
                    ApplicationArea = all; 
                }
                field("Test Code"; Rec."Test Code")
                { 
                    ApplicationArea = all; 
                }
                field("Applicant No."; Rec."Applicant No.")
                { 
                    ApplicationArea = all; 
                }
                field("Requisition No."; Rec."Requisition No.")
                { 
                    ApplicationArea = all; 
                }
                field(Score; Rec.Score)
                { 
                    ApplicationArea = all; 
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Applicant Test Score")
            {
                Caption = 'Import Applicant Test Score';
                Promoted = true;
                ///RunObject = XMLport "Import Applicant Score";RBS Dennis
            }
        }
    }
}

