page 51534419 "HR Confirmation Duties"
{
    Caption = 'HR Confirmation Duties';
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Confm/Probation  Duties";
    AdditionalSearchTerms = 'HR Confirmation Duties';
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
                field(Duties; Rec.Duties)
                { 
                    ApplicationArea = all; 
                }
                field("Total Available Rating"; Rec."Total Available Rating")
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

