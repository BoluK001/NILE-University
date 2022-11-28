page 51534963 "Posted Voucher List"
{
    CardPageID = "Posted Journal Voucher";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Posted Voucher Header";
    UsageCategory = Lists;
    SourceTableView = WHERE("Voucher Type" = FILTER(JV));

    layout
    {
        area(content)
        {
            repeater(New)
            {
                field("Posting Date"; "Posting Date")

                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reference Voucher No."; "Reference Voucher No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }

        }
        area(factboxes)
        {

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534982), "No." = FIELD("No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Voucher")
            {
                Caption = '&Voucher';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        /*IF PostedVoucherHeader.GET("Voucher Type","No.") THEN
                         BEGIN
                           CASE "Voucher Type"  OF
                             "Voucher Type"::JV :
                               PAGE.RUN(PAGE::"Posted Journal Voucher",PostedVoucherHeader);
                             "Voucher Type" :: CPV :
                               PAGE.RUN(PAGE::Page50065,PostedVoucherHeader);
                             "Voucher Type" :: CRV :
                               PAGE.RUN(PAGE::Page50067,PostedVoucherHeader);
                             "Voucher Type" :: BRV :
                               PAGE.RUN(PAGE::Page50069,PostedVoucherHeader);
                             "Voucher Type" :: BPV :
                               PAGE.RUN(PAGE::"Purchase Request List",PostedVoucherHeader);
                           END;
                         END;
                        */

                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Enum "Approval Document Type";
                    begin

                        //ApprovalEntries.Setfilters(DATABASE::"HR Employee Confirmation", DocType.AsInteger(), "Application No.");
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Voucher Header", "Voucher Type".AsInteger(), "No.");
                    end;
                }
            }
        }
    }

    var
        PostedVoucherHeader: Record "Posted Voucher Header";
}

