page 51534883 "HR Oral Evaluation Template"
{
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Oral Evaluation Template';
    SourceTable = "HR Oral Interview Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Experience Level"; "Experience Level")
                {
                    ApplicationArea = All;
                }
                field("Oral Interview Code"; "Oral Interview Code")
                {
                    ApplicationArea = All;
                }
                field("Oral Interview Group"; "Oral Interview Group")
                {
                    ApplicationArea = All;
                }
                field("Target Score"; "Target Score")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rating)
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

