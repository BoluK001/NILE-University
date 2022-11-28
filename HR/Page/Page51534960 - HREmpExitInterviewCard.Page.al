page 51534960 "HR Emp Exit Interview Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interview Done By"; "Interview Done By")
                {
                    ApplicationArea = all;
                }
                field("Date Of Interview"; "Date Of Interview")
                {
                    ApplicationArea = all;
                }
                field("Date of Join"; "Date of Join")
                {
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; "Date Of Leaving")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Mode of Exit"; "Mode of Exit")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
            }
            group("Part 1")
            {
                part(ExInterview; "HR Exit Interiew SF")
                {
                    Caption = 'Exit Interview';
                    SubPageLink = "Employee No." = FIELD("Employee No."),
                                  "Exit No." = FIELD("Exit Interview No");
                    SubPageView = WHERE(Segment = CONST("Part 1"));
                }
                part("Comment/Answer"; "HR Exit Interview Answer")
                {
                    Caption = 'Comment/Answer';
                    Provider = ExInterview;
                    SubPageLink = "Exit No." = FIELD("Exit No."),
                                  "Entry No." = FIELD("Entry No.");
                }
            }
            group("Part 2")
            {
                part("Exit Interview"; "HR Exit Interiew SF")
                {
                    SubPageLink = "Employee No." = FIELD("Employee No."),
                                  "Exit No." = FIELD("Exit Interview No");
                    SubPageView = WHERE(Segment = CONST("Part 2"));
                }
                part(Control14; "HR Exit Interview Answer")
                {
                    Caption = 'Comment/Answer';
                    Provider = "Exit Interview";
                    SubPageLink = "Exit No." = FIELD("Exit No."),
                                  "Entry No." = FIELD("Entry No.");
                }
            }
        }
    }

    actions
    {
    }
}

