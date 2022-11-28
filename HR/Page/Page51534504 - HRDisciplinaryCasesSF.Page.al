page 51534504 "HR Disciplinary Cases SF"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Disciplinary Cases SF';
    SourceTable = "HR Disciplinary Cases";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Case Number"; "Case Number")
                {
                    ApplicationArea = all;
                }
                field("Date of Complaint"; "Date of Complaint")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Selected; Selected)
                {
                    ApplicationArea = all;
                }
                field("Type of Disciplinary Case"; "Type of Disciplinary Case")
                {
                    ApplicationArea = all;
                }
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = all;
                }
                field("Case Discussion"; "Case Discussion")
                {
                    ApplicationArea = all;
                }
                field("Mode of Lodging the Complaint"; "Mode of Lodging the Complaint")
                {
                    ApplicationArea = all;
                }
                field(Accuser; Accuser)
                {
                    ApplicationArea = all;
                }
                field("Witness #1"; "Witness #1")
                {
                    ApplicationArea = all;
                }
                field("Witness #2"; "Witness #2")
                {
                    ApplicationArea = all;
                }
                field("Recommended Action"; "Recommended Action")
                {
                    ApplicationArea = all;
                }
                field("Action Taken"; "Action Taken")
                {
                    ApplicationArea = all;
                }
                field("Support Documents"; "Support Documents")
                {
                    ApplicationArea = all;
                }
                field("Policy Guidlines In Effect"; "Policy Guidlines In Effect")
                {
                    ApplicationArea = all;
                }
                field(Recomendations; Recomendations)
                {
                    ApplicationArea = all;
                }
                field("HR/Payroll Implications"; "HR/Payroll Implications")
                {
                    ApplicationArea = all;
                }
                field("Disciplinary Remarks"; "Disciplinary Remarks")
                {
                    ApplicationArea = all;
                }
                field(Comments; Comments)
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

