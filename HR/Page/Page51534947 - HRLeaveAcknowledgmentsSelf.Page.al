page 51534947 "HR Leave Acknowledgments Self"
{
    CardPageID = "HR Leave Acknowledgement";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Leave Acknowledgments Self';
    SourceTable = "HR Leave Acknowledgement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Leave No."; "Leave No.")
                {
                    ApplicationArea = all;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
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
        FilterGroup(2);
        SetFilter("User ID", UserId);
        FilterGroup(0);
    end;
}

