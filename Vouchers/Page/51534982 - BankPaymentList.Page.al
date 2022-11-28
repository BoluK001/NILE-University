page 51534982 "Bank Payment List"
{
    CardPageID = "Bank Payment Voucher";
    Editable = false;
    DeleteAllowed = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Voucher Header";
    AdditionalSearchTerms = 'Bank Payment List';
    SourceTableView = WHERE("Voucher Type" = CONST(BPV));
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Print,Approvals';

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
                field("External Document No."; "External Document No.")
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
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

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
                    ApplicationArea = all;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        IF ApprovalMgt.CheckVoucherApprovalsWorkflowEnable(Rec) THEN;
                        ApprovalMgt.OnSendVoucherForApproval(Rec);

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = all;
                    Image = Cancel;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        ApprovalMgt.OnCancelVoucherForApproval(Rec)
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
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Usersetup: record "User Setup";
                    begin
                        // Usersetup.GET(USERID);
                        // IF NOT Usersetup."Post Voucher" THEN
                        //     ERROR('You do not have permision to post the Voucher....!');


                        // IF NOT CONFIRM('Are you sure you want to post the voucher') THEN
                        //     EXIT;
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
                    Image = Print;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        VoucherHeader: Record "Voucher Header";
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534980, TRUE, FALSE, VoucherHeader);
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
        UserMgt: Codeunit "User Management";
}

