page 51534998 "Petty Cash List"
{
    CardPageID = "Petty Cash Voucher";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Voucher Header";
    AdditionalSearchTerms = 'Petty Cash List';
    SourceTableView = WHERE("Voucher Type" = CONST(PettyCash));
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
                    ApplicationArea = all;
                    Promoted = true;
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
                    begin

                        ApprovalEntries.Setfilters(DATABASE::"Voucher Header", 7, "No.");
                        ApprovalEntries.RUN;
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
                    ApplicationArea = all;
                    Ellipsis = true;
                    Image = TestReport;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
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

        ApprovalEntries : Page 658;
        ReleaseVoucher: Codeunit "Voucher Release";
        UserMgt: Codeunit "User Setup Management";
}

