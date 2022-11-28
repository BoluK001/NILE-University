page 51534440 "Satff Advance Req List"
{
    Caption = 'Satff Advance Req List';
    PageType = List;
    SourceTable = "Staff Advance Header";
    SourceTableView = where(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Print/Preview")
            {
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('You can only print after the document is Approved');
                    //Reset;
                    SetFilter("No.", "No.");
                    REPORT.Run(51534724, true, true, Rec);
                    Reset;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        SetFilter(Posted, '%1', false);
    end;
}
