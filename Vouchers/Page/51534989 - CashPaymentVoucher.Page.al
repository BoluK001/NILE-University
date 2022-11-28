page 51534989 "Cash Payment Voucher"
{
    Caption = 'Cash Payment Voucher';
    DeleteAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Functions,Approvals';
    SourceTable = "Voucher Header";
    SourceTableView = SORTING("Voucher Type", "No.") WHERE("Voucher Type" = CONST(CPV));

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
                    //Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = EditField;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Editable = EditField;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Expense Request No."; "Expense Request No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Editable = EditField;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = EditField;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = EditField;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Visible = false;
                    //ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Editable = EditField;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Editable = EditField;
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
                    Editable = false;
                    //ApplicationArea = all;
                }
                field("Exchange Rate"; "Exchange Rate")
                {
                    ApplicationArea = all;
                    //Editable = false;
                    Visible = false;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = ALl;
                    Visible = false;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                    Visible = false;
                }

            }
            part(voucherline; "Cash Payment Voucher Subform")
            {
                ApplicationArea = All;
                Caption = 'Voucher Lines';
                Editable = "Account No." <> '';
                Enabled = "Account No." <> '';
                SubPageLink = "Voucher Type" = FIELD("Voucher Type"),
                              "Document No." = FIELD("No.");
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
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(MyNotes; MyNotes)
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
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
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
                    ApplicationArea = All;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        DocType: Enum "Approval Document Type";
                    begin
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Voucher Header", "Voucher Type".AsInteger(), "No.");
                    end;
                }
            }
            Action("Charge WHT")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Visible = false;

                trigger OnAction()
                var
                    VouchLine: Record "Voucher Line";
                    Vendor: Record Vendor;
                begin
                    VouchLine.SetRange("Document No.", "No.");
                    Vendor.Setrange("No.", Vouchline."Account No.");
                    Vendor.SetRange("Create WHT Vendor", true);

                    if VouchLine.Find('-') then begin
                        repeat
                            VouchLine.Init();
                            VouchLine."Voucher Type" := "Voucher Type";
                            VouchLine.Validate("Account Type", VouchLine."Account Type"::Vendor);
                            VouchLine."Document No." := "No.";
                            VouchLine."Line No." += 10000;
                            VouchLine.Insert(true);
                            VouchLine."Account No." := Vendor."WHT Vendor Code";
                            VouchLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                            VouchLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                            VouchLine.Validate("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                            VouchLine.Validate("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                            //VouchLine.Validate("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                            VouchLine.Amount := (VouchLine."W/Tax Rate" / 100) * Vouchline.Amount;
                            //"WHT Amount" := "Invoiced Amount" - Amount;
                            Validate(Amount);

                            VouchLine.Modify(true);
                        Until VouchLine.Next = 0;
                    end;

                    //Charge Vendor
                    if VouchLine.Find('-') then begin
                        repeat
                            VouchLine.Init();
                            VouchLine."Voucher Type" := "Voucher Type";
                            VouchLine.Validate("Account Type", VouchLine."Account Type"::Vendor);
                            VouchLine."Document No." := "No.";
                            VouchLine."Line No." += 10000;
                            VouchLine.Insert(true);
                            VouchLine."Account No." := VouchLine."Account No.";
                            VouchLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                            VouchLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                            VouchLine.Validate("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                            VouchLine.Validate("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
                            //VouchLine.Validate("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
                            VouchLine.Amount := -(VouchLine."W/Tax Rate" / 100) * Vouchline.Amount;
                            //"WHT Amount" := "Invoiced Amount" - Amount;
                            Validate(Amount);

                            VouchLine.Modify(true);
                        Until VouchLine.Next = 0;
                    end;

                end;
            }
        }
        area(processing)
        {
            /* group(Release1)
            {
                Caption = 'Release';
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
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
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;
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
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

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
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelVoucherApprovalRequest(Rec,TRUE,TRUE) THEN;
                        ApprovalMgt.OnCancelVoucherForApproval(Rec);
                        VALIDATE(Status, Status::Open);
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
                /* action("Get Request Line")
                {
                    Caption = 'Get Cash Request';
                    Image = CopyDocument;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //ExpReqMgt.GetExpenseReqLine(Rec);
                        //CurrPage.voucherline.PAGE.UpdateSubform;
                    end;
                } */
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Visible = false;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
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
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        VoucherHeader.SETRANGE("Voucher Type", "Voucher Type");
                        VoucherHeader.SETRANGE("No.", "No.");
                        IF VoucherHeader.FINDFIRST THEN
                            REPORT.RUN(51534982, TRUE, FALSE, VoucherHeader);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;

        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RecordId);

    end;


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
        ApprovalEntries: Page "Approval Entries";
        ReleaseVoucher: Codeunit "Voucher Release";
        VoucherHeader: Record "Voucher Header";
        UserMgt: Codeunit "User Setup Management";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        EditField: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);

        //WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        if Status = Status::Open then
            EditField := true
        else
            EditField := false;
    end;
}