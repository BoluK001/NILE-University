report 51534578 "Daily Transaction Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DailyTransactionListing.rdlc';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING ("Entry No.");
            RequestFilterFields = "Posting Date";
            column(Sn; Sn)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(PostingDate_GLEntry; Format("G/L Entry"."Posting Date"))
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(UserID_GLEntry; "G/L Entry"."User ID")
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(ApproverID; ApproverID)
            {
            }
            column(GLBalance; GLBalance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sn += 1;
                GLBalance := 0;

                ApproverID := '';
                ApprovalEntry.Reset;
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No.");
                //ApprovalEntry.SetRange(ApprovalEntry.Stage, ApprovalEntry.Stage::Standard);
                ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindFirst then begin
                    if ApprovalEntry."Last Modified By User ID" = ApprovalEntry."Approver ID" then
                        ApproverID := ApprovalEntry."Approver ID";
                end;

                if ApproverID = '' then begin
                    ApprovalEntry.Reset;
                    JvLines.SetRange(JvLines."Document No.", "Document No.");
                    JvLines.SetRange(JvLines.Narration, Description);
                    if JvLines.FindFirst then
                        ApprovalEntry.SetRange(ApprovalEntry."Document No.", JvLines."Document No.");
                    //ApprovalEntry.SetRange(ApprovalEntry.Stage, ApprovalEntry.Stage::HOD);
                    ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindFirst then begin
                        if ApprovalEntry."Last Modified By User ID" = ApprovalEntry."Approver ID" then
                            ApproverID := ApprovalEntry."Approver ID";
                    end;

                end;


                GLAcct.Reset;
                GLAcct.SetRange(GLAcct."No.", "G/L Entry"."G/L Account No.");
                GLAcct.SetFilter(GLAcct."Date Filter", '..%1', "G/L Entry".GetRangeMin("Posting Date"));
                if GLAcct.FindFirst then begin
                    GLAcct.CalcFields(GLAcct."Net Change");
                    GLBalance := GLAcct."Net Change";
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Sn: Integer;
        ApprovalEntry: Record "Approval Entry";
        ApproverID: Code[70];
        GLAcct: Record "G/L Account";
        GLBalance: Decimal;
        JvLines: Record "Voucher Line";
}

