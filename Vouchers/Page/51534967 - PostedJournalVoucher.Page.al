page 51534967 "Posted Journal Voucher"
{
    PageType = Document;
    SourceTable = "Posted Voucher Header";
    Editable = false;

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
            part(PostedVoucherList; "Posted Journal Vou. Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Voucher Type" = FIELD("Voucher Type"),
                              "Document No." = FIELD("No.");
            }
            part(Approvals; "Approval Status")
            {
                Caption = 'Approvals';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
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

                trigger OnAction()
                begin

                    pVoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                    pVoucherHeader.SETRANGE("No.", "No.");
                    IF pVoucherHeader.FINDFIRST THEN
                        REPORT.RUN(50049, TRUE, FALSE, pVoucherHeader);
                    // end;
                end;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                ApplicationArea = all;
                Promoted = true;
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

                    //ApprovalEntries.Setfilters(DATABASE::"HR Employee Confirmation", DocType.AsInteger(), "Application No.");
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Voucher Header", "Voucher Type".AsInteger(), "No.");
                end;
            }
        }
    }

    var
        pVoucherHeader: Record "Posted Voucher Header";
}

