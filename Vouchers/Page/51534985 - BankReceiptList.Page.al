page 51534985 "Bank Receipt List"
{
    CardPageID = "Bank Receipt Voucher";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Voucher Header";
    AdditionalSearchTerms = 'Bank Receipt List';
    SourceTableView = SORTING("Voucher Type", "No.")
                      WHERE("Voucher Type" = CONST(BRV));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Voucher Type"; "Voucher Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Created Date"; "Created Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
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
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Name"; "Customer Name")
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
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Narration; Narration)
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
                SubPageLink = "Table ID" = CONST(51534980), "No." = FIELD("No.");

            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    ApplicationArea = all;

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
        area(processing)
        {
            /* group(Release1)
            {
                Caption = 'Release';
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        ReleaseVoucher.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ReleaseVoucher.PerformManualReopen(Rec);
                    end;
                }
            } */
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    ApplicationArea = all;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.SendVoucherApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = all;
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelVoucherApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    ApplicationArea = all;
                    Image = TestReport;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        VoucherPost.RUN(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    ApplicationArea = all;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        VoucherPost.RUN(Rec);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action(Voucher)
                {
                    Caption = 'Voucher';
                    Ellipsis = true;
                    ApplicationArea = all;
                    Image = Print;
                    trigger OnAction()
                    var
                        VoucherHeader: Record "Voucher Header";
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534981, TRUE, FALSE, VoucherHeader);
                        //VoucherPost.RUN(Rec);
                    end;
                }
            }
        }
    }

    var
        VoucherPost: Codeunit "Voucher Post";
        ApprovalEntries: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        UserMgt: Codeunit "User Setup Management";
}

