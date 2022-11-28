page 51534444 "Student Amortization List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Amortization Book";

    layout
    {
        area(Content)
        {
            repeater("Student Armotization")
            {
                field("Student Code"; Rec."Student Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;

                }
                field("Semester Year"; Rec."Semester Year")
                {
                    ApplicationArea = All;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Semester End Date"; Rec."Semester End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Days In Semester"; Rec."Days In Semester")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Semester School Fees"; Rec."Semester School Fees")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amortized School Fees"; Rec."Amortized School Fees")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Last Date Amortized"; Rec."Last Date Amortized")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}