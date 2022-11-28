page 51534661 "HR HMO List"
{
    CardPageID = "HR HMO Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR HMO List';
    SourceTable = "HR HMO";
    DeleteAllowed = false; //jj300922
    Editable = false; //jj300922


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Department; Department)
                {
                    ApplicationArea = all;
                }
                field("Job Level"; "Job Level")
                {
                    ApplicationArea = all;
                }
                field("Number of Beneficiaries"; "Number of Beneficiaries")
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
            systempart(Control10; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("HR HMO List")
            {
                Caption = 'HR HMO List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "HR HMO List";
            }
        }
    }
}

