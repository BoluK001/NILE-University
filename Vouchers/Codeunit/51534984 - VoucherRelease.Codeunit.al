codeunit 51534984 "Voucher Release"
{
    TableNo = "Voucher Header";

    trigger OnRun()
    var
        VoucherLine: Record "Voucher Line";
    begin
        IF Status = Status::Released THEN
            EXIT;

        TESTFIELD("No.");
        TESTFIELD("Posting Date");
        /*
        IF "Voucher Type" = "Voucher Type" :: JV THEN BEGIN
          CALCFIELDS("Debit Amount");
          CALCFIELDS("Credit Amount");
          IF "Debit Amount" <> "Credit Amount" THEN
            ERROR(
              Text012 +
              Text013,
              ("Debit Amount" - "Credit Amount"),"No.",FIELDCAPTION("Posting Date"),FIELDCAPTION("Voucher Type"),
              FIELDCAPTION("No."),FIELDCAPTION(Amount));
        END;
        */
        VoucherLine.RESET;
        VoucherLine.SETRANGE("Voucher Type", "Voucher Type");
        VoucherLine.SETRANGE("Document No.", "No.");
        VoucherLine.SETFILTER(Amount, '<>%1', 0);
        IF VoucherLine.FIND('-') THEN
            REPEAT
                VoucherLine.TESTFIELD("Account No.");
            UNTIL VoucherLine.NEXT = 0;

        VALIDATE(Status, Status::Released);
        MODIFY(TRUE);

    end;

    var
        ApprovalManagement: Codeunit "Approval Mgmt. ExtCal";
        ApprovalManagement2: Codeunit "Approvals Mgmt.";
        Text001: Label 'There is nothing to release for %1 .';
        Text002: Label 'This Voucher Request can only be released when the approval process is complete.';
        Text003: Label 'The Approval Process must be cancelled or completed to reopen this voucher.';
        Text012: Label '%5 %2 is out of balance by %1. ';
        Text013: Label 'Please check that %3, %4, %5 and %6 are correct for each line.';

    [Scope('OnPrem')]
    procedure Reopen(var VoucherHeader: Record "Voucher Header")
    begin
        WITH VoucherHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            VALIDATE(Status, Status::Open);
            MODIFY(TRUE);
        END;
    end;

    [Scope('OnPrem')]
    procedure PerformManualRelease(var VoucherHeader: Record "Voucher Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovedOnly: Boolean;
    begin
        WITH VoucherHeader DO BEGIN
            IF ApprovalManagement.CheckVoucherApprovalsWorkflowEnable(VoucherHeader) THEN BEGIN
                CASE Status OF
                    Status::"Pending Approval":
                        ERROR(Text002);
                    Status::Released:
                        CODEUNIT.RUN(CODEUNIT::"Voucher Release", VoucherHeader);
                    Status::Open:
                        BEGIN
                            ApprovedOnly := TRUE;
                            ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.");
                            ApprovalEntry.SETRANGE("Table ID", DATABASE::"Voucher Header");
                            ApprovalEntry.SETRANGE("Document Type", VoucherHeader."Voucher Type");
                            ApprovalEntry.SETRANGE("Document No.", VoucherHeader."No.");
                            ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
                            IF ApprovalEntry.FIND('-') THEN BEGIN
                                REPEAT
                                    IF (ApprovedOnly = TRUE) AND (ApprovalEntry.Status <> ApprovalEntry.Status::Approved) THEN
                                        ApprovedOnly := FALSE;
                                UNTIL ApprovalEntry.NEXT = 0;
                                IF ApprovedOnly = TRUE THEN
                                    CODEUNIT.RUN(CODEUNIT::"Voucher Release", VoucherHeader)
                                ELSE
                                    ERROR(Text002);
                            END ELSE
                                ERROR(Text002);
                        END;
                END;
            END ELSE
                CODEUNIT.RUN(CODEUNIT::"Voucher Release", VoucherHeader);
        END;
    end;

    [Scope('OnPrem')]
    procedure PerformManualReopen(var VoucherHeader: Record "Voucher Header")
    begin
        WITH VoucherHeader DO BEGIN
            IF ApprovalManagement.CheckVoucherApprovalsWorkflowEnable(VoucherHeader) THEN BEGIN
                CASE Status OF
                    Status::"Pending Approval":
                        ERROR(Text003);
                    Status::Open, Status::Released:
                        Reopen(VoucherHeader);
                END;
            END ELSE
                Reopen(VoucherHeader);
        END;
    end;
}

