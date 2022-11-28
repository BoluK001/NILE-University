page 51534540 "HR Leave Application Comments"
{
    PageType = Card;
    SourceTable = "Approval Comment Line";

    layout
    {
        area(content)
        {
            field(DocType; DocType)
            {
                Editable = false;
                ApplicationArea = all;
                // OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Bank Slip,Grant,Grant Surrender,Employee Requisition,Leave Application,Training Application,Transport Requisition';
            }
            field(DocNo; DocNo)
            {
                Editable = false;
                ApplicationArea = all;
            }
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Date and Time"; "Date and Time")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Approved Days"; "Approved Days")
                {
                    ApplicationArea = all;
                }
                field("Approved Start Date"; "Approved Start Date")
                {
                    ApplicationArea = all;
                }
                field("Approved Return Date"; "Approved Return Date")
                {
                    ApplicationArea = all;
                }
                field(Reason; Reason)
                {
                    ApplicationArea = all;
                }
                field("Leave Allowance Granted"; "Leave Allowance Granted")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        NewTableId: Integer;
        NewDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        NewDocumentNo: Code[20];
        //DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        DocType: Enum "Approval Document Type";
        DocNo: Code[20];

    [Scope('OnPrem')]
    procedure SetUpLine(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application"; DocumentNo: Code[20])
    begin
        NewTableId := TableId;
        NewDocumentType := DocumentType;
        NewDocumentNo := DocumentNo;
    end;

    [Scope('OnPrem')]
    procedure Setfilters(TableId: Integer; DocumentType: Enum "Approval Document Type"; DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
            FilterGroup(2);
            SetCurrentKey("Table ID", "Document Type", "Document No.");
            SetRange("Table ID", TableId);
            SetRange("Document Type", DocumentType);
            if DocumentNo <> '' then
                SetRange("Document No.", DocumentNo);
            FilterGroup(0);
        end;

        DocType := DocumentType;
        DocNo := DocumentNo;
    end;
}

