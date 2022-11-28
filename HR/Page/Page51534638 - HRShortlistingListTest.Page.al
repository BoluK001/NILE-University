page 51534638 "HR Shortlisting List Test"
{
    CardPageID = "HR Shortlisting Card Test";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    AdditionalSearchTerms = 'HR Shortlisting List Test';
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = all;
                }

                field("Job Description"; "Job Description")
                {
                    ApplicationArea = all;
                }

                field("Requisition Date"; "Requisition Date")
                {
                    ApplicationArea = all;
                }

                field(Requestor; Requestor)
                {
                    ApplicationArea = all;
                }

                field("Reason For Request"; "Reason For Request")
                {
                    ApplicationArea = all;
                }

                field(Closed; Closed)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755005; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Shortlisting)
            {
                Caption = 'Shortlisting';
            }
        }
    }
}

