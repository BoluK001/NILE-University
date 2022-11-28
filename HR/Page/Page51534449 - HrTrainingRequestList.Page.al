page 51534449 "Hr Training Request List"
{
    CardPageID = "HR Training Request Card";
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Training Applications";
    SourceTableView = WHERE(Type = CONST(HR));
    AdditionalSearchTerms = 'Hr Training Request List';
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
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;

                }
                field(Status; Status)  //jj270422 I added
                {
                    ApplicationArea = all;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = all;
                    Visible = false;
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
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("User ID",USERID);
    end;
}

