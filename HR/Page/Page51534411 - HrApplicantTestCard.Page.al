page 51534411 "Hr Applicant Test Card"
{
    PageType = Card;
    SourceTable = "HR Applicant Test";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Test Code"; Rec."Test Code")
                { 
                    ApplicationArea = all; 
                }
                field("Requsition Number"; Rec."Requsition Number")
                { 
                    ApplicationArea = all; 
                }
                field(Date; Rec.Date)
                { 
                    ApplicationArea = all; 
                }
                field(Venue; Rec.Venue)
                { 
                    ApplicationArea = all; 
                }
                field(Time; Rec.Time)
                { 
                    ApplicationArea = all; 
                }
                field("Pass Mark"; Rec."Pass Mark")
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

