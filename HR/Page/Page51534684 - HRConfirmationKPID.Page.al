page 51534684 "HR Confirmation KPI D"
{
    PageType = ListPart;
    SourceTable = "HR Confirmation KPI";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Objectives; Objectives)
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Weight; Weight)
                {
                    ApplicationArea = All;
                }
                field("Behavioural Group"; "Behavioural Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Ratings; Ratings)
                {
                    ApplicationArea = All;
                }
                field(Score; Score)
                {
                    ApplicationArea = All;
                }
                field("KPI Weighting"; "KPI Weighting")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Target Score %"; "Target Score %")
                {
                    Caption = 'Weight';
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Behavioural Group" := 'LEARNING GROWTH';
    end;
}

