page 51534474 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Days; Days)
                {
                    ApplicationArea = all;
                }
                field("Acrue Days"; "Acrue Days")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Unlimited Days"; "Unlimited Days")
                {
                    Visible = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = all;
                }
                field("Max Carry Forward Days"; "Max Carry Forward Days")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Carry Forward Allowed"; "Carry Forward Allowed")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Inclusive of Non Working Days"; "Inclusive of Non Working Days")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Recurring; Recurring)
                {
                    ApplicationArea = all;
                }
                field(Exam; Exam)
                {
                    ApplicationArea = all;
                }
                field(Sick; Sick)
                {
                    ApplicationArea = all;
                }
                field(Exception; Exception)
                {
                    ApplicationArea = all;
                }
                field(Compassionate; Compassionate)
                {
                    ApplicationArea = all;
                }
                field("Mat/Pat"; "Mat/Pat")
                {
                    ApplicationArea = all;
                }
                field(Maternity; Maternity)
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

