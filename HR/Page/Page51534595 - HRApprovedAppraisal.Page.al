page 51534595 "HR Approved Appraisal"
{
    CardPageID = "HR Appraisal Goal Setting H";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Approved Appraisal';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST(Approved));

    layout
    {
        area(content)
        {
            repeater(Control1000000001)
            {
                ShowCaption = false;
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = all;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Step; Step)
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

