page 51534487 "HR Leave Applicaitons Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                CaptionClass = Text1;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
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
            field(Designation; Designation)
            {
                ApplicationArea = all;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
            }
            label(Control1102755005)
            {
                ApplicationArea = all;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            label(Control1102755012)
            {
                ApplicationArea = all;
                CaptionClass = Text2;
                ShowCaption = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
            }
            field("Total Leave Taken"; "Total Leave Taken")
            {
                ApplicationArea = all;
            }
            field("Total (Leave Days)"; "Total (Leave Days)")
            {
                ApplicationArea = all;
            }
            field("Reimbursed Leave Days"; "Reimbursed Leave Days")
            {
                ApplicationArea = all;
            }
            field("Allocated Leave Days"; "Allocated Leave Days")
            {
                ApplicationArea = all;
            }
            field("Personal E-Mail"; "Personal E-Mail")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    var
        Text1: Label 'Employee Details';
        Text2: Label 'Employeee Leave Details';
    //Text3: ;
}

