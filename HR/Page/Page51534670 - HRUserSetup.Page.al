page 51534670 "HR User Setup"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "User Setup";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR User Setup';
    SourceTableView = SORTING(HR)
                      ORDER(Ascending)
                      WHERE(HR = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field(HR; HR)
                {
                    Editable = false;
                }
                field("PayRoll Cent. Filter"; "PayRoll Cent. Filter")
                {
                    ApplicationArea = all;
                }
                field("Payroll Substitute"; "Payroll Substitute")
                {
                    ApplicationArea = all;
                }
                field("Grade Classification"; "Grade Classification")
                {
                    ApplicationArea = all;
                }
                field("Reopen Doc"; "Reopen Doc")
                {
                    ApplicationArea = all;
                }
                field("HR Job"; "HR Job")
                {
                    ApplicationArea = all;
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; "Journal Batch Name")
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

