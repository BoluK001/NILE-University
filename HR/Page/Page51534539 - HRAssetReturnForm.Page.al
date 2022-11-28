page 51534539 "HR Asset Return Form"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Asset Return Form';
    RefreshOnActivate = true;
    SourceTable = "Misc. Article Information";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Misc. Article Code"; "Misc. Article Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Returned; Returned)
                {
                    ApplicationArea = all;
                }
                field("Status On Return"; "Status On Return")
                {
                    ApplicationArea = all;
                }
                field("Date Returned"; "Date Returned")
                {
                    ApplicationArea = all;
                }
                field(Recommendations; Recommendations)
                {
                    ApplicationArea = all;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        EI: Record "HR Employee Exit Interviews";

    [Scope('OnPrem')]
    procedure refresh()
    begin
        CurrPage.Update(false);
    end;
}

