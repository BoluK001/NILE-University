page 51534591 "HR Approved Appraisal History"
{
    CardPageID = "HR Appraisal Closed";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Approved Appraisal History';
    SourceTable = "HR Appraisal Goal Setting H";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Date"; "Appraisal Date")
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
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Overal Rating Desc"; "Overal Rating Desc")
                {
                    ApplicationArea = all;
                }
                field("Company Score"; "Company Score")
                {
                    ApplicationArea = all;
                }
                field("Performance Score Mgt"; "Performance Score Mgt")
                {
                    ApplicationArea = all;
                }
                field("KPIs Mgt Score"; "KPIs Mgt Score")
                {
                    ApplicationArea = all;
                }
                field("Overall Mgt Score"; "Overall Mgt Score")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000001; Outlook)
            {
            }
            systempart(Control1000000000; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

