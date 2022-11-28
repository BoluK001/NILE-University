page 51534941 "HR Appraisal Career Dev Ques"
{
    PageType = List;
    SourceTable = "HR Appraisal Career Dev";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Question; Question)
                {
                    //Editable = false;
                    ApplicationArea = All;
                }
                field(Answer; Answer)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

