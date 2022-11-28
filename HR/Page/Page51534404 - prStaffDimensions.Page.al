page 51534404 "prStaff Dimensions"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prStaff Dimensions";
    AdditionalSearchTerms = 'Staff Dimensions';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension 0"; Rec."Dimension 0")
                {
                    ApplicationArea = all;
                }
                field("Dimension 1"; Rec."Dimension 1")
                {
                    ApplicationArea = all;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                     ApplicationArea = all;
                }
                field("Dimension 3"; Rec."Dimension 3")
                { 
                    ApplicationArea = all; 
                }
                field("Dimension 4"; Rec."Dimension 4")

                {
                    ApplicationArea = all;
                }
                field("Dimension 5"; Rec."Dimension 5")

                {
                    ApplicationArea = all;
                }
                field(Percentage; Rec.Percentage)

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

