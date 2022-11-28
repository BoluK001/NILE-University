page 51534840 "Employee Transaction Header"
{
    PageType = Document;
    SourceTable = "HR Emp. Transaction Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Salary step"; "Salary step")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Current Period"; "Current Period")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Created By"; "Created By")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
            }
            part(Control9; "Employee Trans Line")
            {
                SubPageLink = "Document No." = FIELD("Document No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action15)
            {
                action("Update Employee Transaction")
                {
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateEmployeeTrans;
                    end;
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;


                    trigger OnAction()
                    var
                        ApprovalEntries:Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Staff Advance";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Emp. Transaction Header", DocType.AsInteger(), "Document No.");
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;


                    trigger OnAction()
                    begin
                        if Confirm('Send this Job Title for Approval?', true) = false then exit;

                        //AppMgmt.SendEmpTransApprovalRequest(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;


                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then exit;
                        //AppMgmt.CancelEmpTransAppApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
    end;

    trigger OnOpenPage()
    begin
        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            CurrPage.Update;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        AppMgmt: Codeunit "Approvals Mgmt.";
}

