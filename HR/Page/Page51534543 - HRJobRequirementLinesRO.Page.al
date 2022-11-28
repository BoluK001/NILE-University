page 51534543 "HR Job Requirement Lines(RO)"
{
    Caption = '<HR Job Requirements';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Job Requirements";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Qualification Type"; "Qualification Type")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Description"; "Qualification Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field("Desired Score"; "Desired Score")
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Mandatory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

