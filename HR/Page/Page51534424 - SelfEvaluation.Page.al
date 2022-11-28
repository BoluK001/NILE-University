page 51534424 "Self Evaluation"
{
    PageType = List;
    SourceTable = "HR Appraisal Evaluations";
    InsertAllowed = true;   //jj271022
    Editable = True;    //jj271022
    ModifyAllowed = true;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
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

