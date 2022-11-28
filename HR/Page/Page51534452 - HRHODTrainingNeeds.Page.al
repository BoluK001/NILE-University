page 51534452 "HR HOD Training Needs"
{
    CardPageID = "HR HOD Training Need card";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR HOD Training Needs';
    SourceTable = "HR Training Applications";
    SourceTableView = WHERE(Type = CONST(HOD));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; "Application No")
                { 
                    ApplicationArea = all; 
                }
                field("Course Title"; "Course Title")
                { 
                    ApplicationArea = all; 
                }
                field(Location; Location)
                { 
                    ApplicationArea = all; 
                }
                field("No. of Applicants"; "No. of Applicants")
                { 
                    ApplicationArea = all; 
                }
                field("Application Date"; "Application Date")
                { 
                    ApplicationArea = all; 
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
           {
                    ApplicationArea = all;
                }
        }
    }

    actions
    {
    }
}

