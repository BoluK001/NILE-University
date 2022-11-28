page 51534415 "HR Entitlement Lines"
{
    PageType = ListPart;
    SourceTable = "HR Entitlement Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                { 
                    ApplicationArea = all; 
                }
                field(Question; Rec.Question)
                { 
                    ApplicationArea = all; 
                }
                field("Yes/No"; Rec."Yes/No")
                { 
                    ApplicationArea = all; 
                }
                field(Option; Rec.Option)
                { 
                    ApplicationArea = all; 
                }
                field("Line No."; Rec."Line No.")
                { 
                    ApplicationArea = all; 
                }
                field("Question Header"; Rec."Question Header")
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

