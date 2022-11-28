codeunit 51534504 "HR Leave Jnl.-Post"
{
    TableNo = "HR Journal Line";

    trigger OnRun()
    begin
        InsuranceJnlLine.Copy(Rec);
        Code;
        Rec.Copy(InsuranceJnlLine);
    end;

    var
        Text000: Label 'Do you want to post the journal lines?';
        Text001: Label 'There is nothing to post.';
        Text002: Label 'The journal lines were successfully posted.';
        Text003: Label 'The journal lines were successfully posted. You are now in the %1 journal.';
        InsuranceJnlTempl: Record "HR Leave Journal Template";
        InsuranceJnlLine: Record "HR Journal Line";
        InsuranceJnlPostBatch: Codeunit "HR Leave Jnl.-Post Batch";
        TempJnlBatchName: Code[20];

    local procedure "Code"()
    begin
        with InsuranceJnlLine do begin
            InsuranceJnlTempl.Get("Journal Template Name");
            InsuranceJnlTempl.TestField("Force Posting Report", false);

            if not Confirm(Text000, false) then
                exit;

            TempJnlBatchName := "Journal Batch Name";

            InsuranceJnlPostBatch.Run(InsuranceJnlLine);

            if "Line No." = 0 then
                Message(Text001)
            else
                if TempJnlBatchName = "Journal Batch Name" then
                    Message(Text002)
                else
                    Message(
                      Text003,
                      "Journal Batch Name");

            if not Find('=><') or (TempJnlBatchName <> "Journal Batch Name") then begin
                Reset;
                FilterGroup := 2;
                SetRange("Journal Template Name", "Journal Template Name");
                SetRange("Journal Batch Name", "Journal Batch Name");
                FilterGroup := 0;
                "Line No." := 1;
            end;
        end;
    end;
}

