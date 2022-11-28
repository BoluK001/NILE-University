page 51534999 "Petty Cash Voucher"
{
    Caption = 'Petty Cash Voucher';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Voucher Header";
    SourceTableView = SORTING("Voucher Type", "No.")
                      WHERE("Voucher Type" = CONST(PettyCash));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
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
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
                field("Exchange Rate"; "Exchange Rate")
                {
                    ApplicationArea = all;
                    //Editable = false;
                }
            }
            part(voucherline; "Cash Payment Voucher Subform")
            {
                Caption = 'Voucher Lines';
                SubPageLink = "Voucher Type" = FIELD("Voucher Type"),
                              "Document No." = FIELD("No.");
                Editable = "Account No." <> '';
                Enabled = "Account No." <> '';
            }
            group(Usertrail)
            {
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
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534980), "No." = FIELD("No."), "Document Type" = FIELD("Voucher Type");
            }
            part(ApprovalStatus; "Approval Status")
            {
                Caption = 'Approvals';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
            }
            systempart(MyNotes; MyNotes)
            {
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
                        if ApprovalMgt.CheckVoucherApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendVoucherForApproval(Rec);
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
                        ApprovalMgt.OnCancelVoucherForApproval(Rec);
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
                    Visible = false;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    ApplicationArea = all;
                    Ellipsis = false;
                    Image = Post;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin

                        /*Usersetup.GET(USERID);
                        IF NOT Usersetup."Post Voucher" THEN
                          ERROR('You do not have permision to post the Voucher....!');*/

                        IF NOT CONFIRM('Are you sure you want to post the voucher') THEN
                            EXIT;
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
                    Visible = false;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Print Voucher")
                {
                    Caption = 'Print Voucher';
                    ApplicationArea = all;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(50059, TRUE, FALSE, VoucherHeader);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetGenJnLFilter();

        "Account Type" := "Account Type"::"Bank Account";
    end;

    trigger OnOpenPage()
    begin
        "Account Type" := "Account Type"::"Bank Account";
    end;

    var
        VoucherPost: Codeunit "Voucher Post";

        ApprovalEntries: Page 658;
        ReleaseVoucher: Codeunit "Voucher Release";
        VoucherHeader: Record "Voucher Header";
        UserMgt: Codeunit "User Setup Management";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
}

