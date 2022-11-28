page 51534406 "HR Query List"
{
    CardPageID = "HR Query Card";
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Disciplinary Cases";
    AdditionalSearchTerms = 'HR Query List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    ApplicationArea = all;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetFilter("User ID", UserId)
    end;

    var
        UserMgt: Codeunit "User Setup Management BR";
}

