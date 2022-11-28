page 51534521 "HR Employees Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            field(PersonalDetails; PersonalDetails)
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            field("No."; "No.")
            {
                ApplicationArea = all;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = all;
            }
            field("Middle Name"; "Middle Name")
            {
                ApplicationArea = all;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = all;
            }
            field("Personal E-Mail"; "Personal E-Mail")
            {
                ApplicationArea = all;
            }
            field("Company E-Mail"; "Company E-Mail")
            {
                ApplicationArea = all;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
            }
            field(JobDetails; JobDetails)
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            field("Job Title"; "Job Title")
            {
                ApplicationArea = all;
            }
            field("Job Description"; "Job Description")
            {
                ApplicationArea = all;
            }
            field(Grade; Grade)
            {
                ApplicationArea = all;
            }
            field(LeaveDetails; LeaveDetails)
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = all;
            }
            field("Leave Balance"; "Leave Balance")
            {
                ApplicationArea = all;
            }
            field("Total Leave Taken"; "Total Leave Taken")
            {
                ApplicationArea = all;
            }
            field("Allocated Leave Days"; "Allocated Leave Days")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    var
        PersonalDetails: Label 'Personal Details';
        BankDetails: Label 'Bank Details';
        JobDetails: Label 'Job Details';
        LeaveDetails: Label 'Leave Details';
}

