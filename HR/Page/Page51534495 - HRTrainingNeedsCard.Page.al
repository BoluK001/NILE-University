page 51534495 "HR Training Needs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Location; Location)
                {
                    ApplicationArea = all;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = all;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. of Applicants"; "No. of Applicants")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Closed; Closed)
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
            group("&Functions")
            {
                Caption = '&Functions';
                action("&Mark as Closed/Open")
                {
                    ApplicationArea = all;
                    Caption = '&Mark as Closed/Open';
                    Image = CloseDocument;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Closed then begin
                            Closed := false;
                            Message('Training need :: %1 :: has been Re-Opened', Description);
                        end
                        else begin
                            Closed := true;
                            Message('Training need :: %1 :: has been closed', Description);
                            Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        D: Date;
}

