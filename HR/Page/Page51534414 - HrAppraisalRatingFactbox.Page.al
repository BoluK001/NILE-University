page 51534414 "Hr Appraisal Rating Factbox"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "HR Ratings";
    SourceTableView = SORTING(Score)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field(Score; Rec.Score)
                { 
                    ApplicationArea = all; 
                }
                field(Rating; Rec.Rating)
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

