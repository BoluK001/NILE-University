page 51534980 "Cash Payment List"
{
    CardPageID = "Cash Payment Voucher";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Voucher Header";
    AdditionalSearchTerms = 'Cash Payment List';
    SourceTableView = WHERE("Voucher Type" = CONST(CPV));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Voucher Type"; "Voucher Type")
                { ApplicationArea = all; }
                field("No."; "No.")
                { ApplicationArea = all; }
                field("Account Type"; "Account Type")
                { ApplicationArea = all; }
                field("Posting Date"; "Posting Date")
                { ApplicationArea = all; }
                field("Created By"; "Created By")
                { ApplicationArea = all; }
                field("External Document No."; "External Document No.")
                { ApplicationArea = all; }
                field("Created Date"; "Created Date")
                { ApplicationArea = all; }
                field("Account No."; "Account No.")
                { ApplicationArea = all; }
                field("Account Name"; "Account Name")
                { ApplicationArea = all; }
                field(Amount; Amount)
                { ApplicationArea = all; }
                field("Amount (LCY)"; "Amount (LCY)")
                { ApplicationArea = all; }
                field("Debit Amount"; "Debit Amount")
                { ApplicationArea = all; }
                field("Credit Amount"; "Credit Amount")
                { ApplicationArea = all; }
                field(Narration; Narration)
                { ApplicationArea = all; }
                field(Status; Status)
                {
                    ApplicationArea = all;
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
            part(ApprovalStatus; "Approval Status")
            {
                Caption = 'Approvals';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
            }
            systempart(Notes; Notes)
            {
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
                    ApplicationArea = all;
                    Promoted = true;
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
                    ApplicationArea = all;
                    Promoted = true;
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
                    Image = SendApprovalRequest;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //if ApprovalMgt.CheckVoucherApprovalsWorkflowEnable(Rec) then
                        //ApprovalMgt.OnSendVoucherForApproval(Rec);
                        //VALIDATE(Status, Status::"Pending Approval");
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelVoucherApprovalRequest(Rec,TRUE,TRUE) THEN;
                        //ApprovalMgt.OnCancelVoucherForApproval(Rec);
                        //VALIDATE(Status, Status::Open);
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
                    Image = PostPrint;
                    ApplicationArea = all;
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
                            REPORT.RUN(51534982, TRUE, FALSE, VoucherHeader);
                        //VoucherPost.RUN(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetGenJnLFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetGenJnLFilter());
          FILTERGROUP(0);
        END;
        */

    end;

    var
        VoucherPost: Codeunit "Voucher Post";

        ApprovalEntries: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        UserMgt: Codeunit "User Setup Management";
}

