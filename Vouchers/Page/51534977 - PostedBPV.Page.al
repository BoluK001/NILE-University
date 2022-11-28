page 51534977 "Posted BPV"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Posted Voucher Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Reference Voucher No."; "Reference Voucher No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Narration; Narration)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            part(PostedVoucherList; "Posted Cash Pay Vou. Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Voucher Type" = FIELD("Voucher Type"),
                              "Document No." = FIELD("No.");
            }
            group(Usertrail)
            {
                Editable = false;
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created By Name"; "Created By Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created Date"; "Created Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created Time"; "Created Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modified By"; "Modified By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modified By Name"; "Modified By Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modified Date"; "Modified Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modified Time"; "Modified Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posted By Name"; "Posted By Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posted Date"; "Posted Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posted Time"; "Posted Time")
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
        area(processing)
        {
            action(Print)
            {

                ApplicationArea = all;
                trigger OnAction()
                begin

                    pVoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                    pVoucherHeader.SETRANGE("No.", "No.");
                    if pVoucherHeader.FIND('-') THEN
                        REPORT.RUN(51534986, TRUE, FALSE, pVoucherHeader);
                end;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                Promoted = true;
                ApplicationArea = all;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Navigate;
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

                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Voucher Header", "Voucher Type".AsInteger(), "No.");
                end;
            }
        }
    }

    var
        pVoucherHeader: Record "Posted Voucher Header";
}

