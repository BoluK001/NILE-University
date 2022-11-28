page 51534622 "Salary Grades"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Salary Grades";
    PromotedActionCategories = 'New,Process';
    AdditionalSearchTerms = 'Salary Grades';

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Pays NHF"; "Pays NHF")
                {
                    ApplicationArea = all;
                }
                field("Pays NSITF"; "Pays NSITF")
                {
                    ApplicationArea = all;
                }
                field("Pays PAYE"; "Pays PAYE")   //jj150222
                {
                    ApplicationArea = all;
                }
                field("Grade Classification"; "Grade Classification") //jj150522
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Salary Notches")
            {
                Caption = 'Salary Notches';
                action(Notch)
                {
                    Caption = 'Notch';
                    Image = NumberGroup;
                    RunObject = Page "Salary Notches";
                    RunPageLink = "Salary Grade" = FIELD("Salary Grade");
                    ApplicationArea = All; //jj120422 I added
                    Promoted = true;  //jj120422 I added
                    PromotedCategory = Process;

                }
            }
        }
    }
}

