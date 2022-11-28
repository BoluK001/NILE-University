page 51534484 "HR Leave Ledger Entries"
{
    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Period";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Leave Ledger Entries';
    SourceTable = "HR Leave Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Leave Period"; "Leave Period")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; "Staff No.")
                {
                    ApplicationArea = all;
                }
                field("Staff Name"; "Staff Name")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Leave Entry Type"; "Leave Entry Type")
                {
                    ApplicationArea = all;
                }

                field("No. of days"; "No. of days")
                {
                    ApplicationArea = all;
                }

                field("Leave Posting Description"; "Leave Posting Description")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    //RunObject = Page Page544;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

