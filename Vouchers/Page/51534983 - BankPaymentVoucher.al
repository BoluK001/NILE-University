page 51534983 "Bank Payment Voucher"
{
    Caption = 'Bank Payment Voucher';
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Voucher Header";
    PromotedActionCategories = 'New,Process,Report,Functions,Approvals';
    SourceTableView = SORTING("Voucher Type", "No.")
                      WHERE("Voucher Type" = CONST(BPV));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = EditField;
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
                    Editable = EditField;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Account No."; "Account No.")
                {
                    Caption = 'Account Code';
                    ApplicationArea = all;
                    Editable = EditField;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    // Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {

                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Visible = false;
                    ApplicationArea = all;
                    //Editable = false;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Narration; Narration)
                {
                    //Caption = 'Payee';
                    //Editable = false;
                    ApplicationArea = all;
                }
                field("External Document No."; "External Document No.")
                {
                    //Caption = 'Voucher No.';
                    Editable = EditField;
                    ApplicationArea = all;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Exchange Rate"; "Exchange Rate")
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Budget; Budget)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Expended Value"; "Expended Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
            }
            part(Lines; "Bank Payment Voucher Subform")
            {
                Caption = 'Lines';
                ApplicationArea = all;
                Editable = EditField;
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
                Caption = 'Approvals';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = all;
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
                    PromotedCategory = Category5;
                    Image = Approvals;

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
                    ApplicationArea = all;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = category5;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                        Status1: Option Approved;
                        PayLine: record "Voucher Line";
                    begin
                        //Validate(Status, Status1::Approved);
                        if ApprovalMgt.CheckVoucherApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendVoucherForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = all;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = category5;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";

                    begin
                        //IF ApprovalMgt.OnCancelVoucherApprovalRequest(Rec, TRUE, TRUE) THEN;
                        ApprovalMgt.OnCancelVoucherForApproval(Rec);
                        VALIDATE(Status, Status::Open);
                        //RBS Dennis


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
                // action("Co&mments")
                // {
                //     ApplicationArea = Comments;
                //     Caption = 'Co&mments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category8;
                //     RunObject = Page "voucher Comment Sheet";
                //     RunPageLink = "Document Type" = FIELD("Voucher Type"),
                //                   "No." = FIELD("No."),
                //                   "Document Line No." = CONST(0);
                //     ToolTip = 'View or add comments for the record.';
                // }
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
                    ApplicationArea = all;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'F9';

                    trigger OnAction()
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
                    Visible = false;
                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534980, TRUE, FALSE, VoucherHeader);
                        VoucherPost.RUN(Rec);
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Print Voucher")
                {
                    Caption = 'Print Voucher';
                    Promoted = true;
                    PromotedCategory = process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534980, TRUE, FALSE, VoucherHeader);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UpdateControls;
    end;

    procedure LinesExists(): Boolean
    var
        VoucherLines: Record "Voucher Line";
        HasLines: Boolean;
    begin
        HasLines := false;
        VoucherLines.Reset;
        VoucherLines.SetRange(VoucherLines."Document No.", "No.");
        if VoucherLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure UpdateControls()
    begin
        if Status <> Status::Open then begin
            EditField := false
        end else begin
            EditField := true;
        end;
    end;

    var
        VoucherPost: Codeunit "Voucher Post";
        ApprovalEntries: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        VoucherHeader: Record "Voucher Header";
        UserSetup: Record "User Setup";
        EditField: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        //WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

    end;

}

