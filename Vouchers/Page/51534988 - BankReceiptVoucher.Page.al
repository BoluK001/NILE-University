page 51534988 "Bank Receipt Voucher"
{
    Caption = 'Bank Receipt Voucher';
    DeleteAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "Voucher Header";
    SourceTableView = SORTING("Voucher Type", "No.")
                      WHERE("Voucher Type" = CONST(BRV));

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
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    //Visible = false;
                    ApplicationArea = all;
                    Editable = Editall;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Narration; Narration)
                {
                    //caption = 'Payee';
                    ApplicationArea = all;
                    Editable = Editall;
                }
                field("External Document No."; "External Document No.")
                {
                    //Caption = 'BRV No.';
                    ApplicationArea = all;
                    Editable = Editall;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            part(voucherline; "Bank Receipt Voucher Subform")
            {
                Caption = 'Voucher Lines';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
                Editable = "Account No." <> '';
                Enabled = "Account No." <> '';
            }
            group(Usertrail)
            {
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                }
                field("Created By Name"; "Created By Name")
                {
                    ApplicationArea = all;
                }
                field("Created Date"; "Created Date")
                {
                    ApplicationArea = all;
                }
                field("Created Time"; "Created Time")
                {
                    ApplicationArea = all;
                }
                field("Modified By"; "Modified By")
                {
                    ApplicationArea = all;
                }
                field("Modified By Name"; "Modified By Name")
                {
                    ApplicationArea = all;
                }
                field("Modified Date"; "Modified Date")
                {
                    ApplicationArea = all;
                }
                field("Modified Time"; "Modified Time")
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
                SubPageLink = "Table ID" = CONST(51534980), "No." = FIELD("No."), "Document Type" = FIELD("Voucher Type");

            }
            part(ApprovalStatus; "Approval Status")

            {
                ApplicationArea = all;
                Caption = 'Approvals';
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = All;
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
                    ApplicationArea = All;

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
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.OnCancelVoucherForApproval(Rec, TRUE, TRUE) THEN;
                        ApprovalMgt.OnCancelVoucherForApproval(Rec);
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
                    ApplicationArea = all;
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
                            REPORT.RUN(51534981, TRUE, FALSE, VoucherHeader);
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
                    ApplicationArea = all;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534981, TRUE, FALSE, VoucherHeader);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls();
    end;

    procedure UpdateControls()
    begin
        if Status <> Status::Open then begin
            Editall := false;
        end else begin
            Editall := true;
        end;
    end;


    var
        VoucherPost: Codeunit "Voucher Post";
        FieldEditable: Boolean;
        ApprovalEntries1: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        VoucherHeader: Record "Voucher Header";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        Editall: Boolean;
}

