page 51534992 "Cash Receipt Voucher"
{
    Caption = 'Receipt Voucher';
    PageType = Card;
    DeleteAllowed = false;
    RefreshOnActivate = true;
    SourceTable = "Voucher Header";
    SourceTableView = SORTING("Voucher Type", "No.") WHERE("Voucher Type" = CONST(CRV));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

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
                    Editable = false;
                    ApplicationArea = all;
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
                    //Visible = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    caption = 'Manual Receipt No.';
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
            }
            part(Voucherline; "Cash Receipt Voucher Subform")
            {
                ApplicationArea = all;
                Caption = 'Voucher Lines';
                Editable = "Account No." <> '';
                Enabled = "Account No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
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
                ApplicationArea = All;
                Caption = 'Approvals';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
            }
            systempart(MyNotes; MyNotes)
            {
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
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
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Enum "Approval Document Type";
                    begin

                        //ApprovalEntries.Setfilters(DATABASE::"HR Employee Confirmation", DocType.AsInteger(), "Application No.");
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Voucher Header", "Voucher Type".AsInteger(), "No.");

                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
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
                        //ReleaseVoucher.PerformManualRelease(Rec);
                        VALIDATE(Status, Status::Released);
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
                        //ReleaseVoucher.PerformManualReopen(Rec);
                        VALIDATE(Status, Status::Open);
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

                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckVoucherApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendVoucherForApproval(Rec);
                        VALIDATE(Status, Status::"Pending Approval");
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = all;
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelVoucherForApproval(Rec);
                        //IF ApprovalMgt.CancelVoucherApprovalRequest(Rec,TRUE,TRUE) THEN;
                        VALIDATE(Status, Status::Open);
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
                    trigger OnAction()
                    begin
                        VoucherPost.RUN(Rec);
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534983, TRUE, FALSE, VoucherHeader);

                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Print Voucher")
                {
                    Caption = 'Print Voucher';
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534983, TRUE, FALSE, VoucherHeader);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Account Type" := "Account Type"::"Bank Account";
    end;

    trigger OnOpenPage()
    begin
        "Account Type" := "Account Type"::"Bank Account";
    end;

    var
        VoucherPost: Codeunit "Voucher Post";
        ApprovalEntries: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        VoucherHeader: Record "Voucher Header";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
}

