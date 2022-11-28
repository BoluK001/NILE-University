table 51534364 "Voucher Comment Line"
{
    Caption = 'Voucher Comment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "Voucher Comment Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine()
    var
        voucherCommentLine: Record "voucher Comment Line";
    begin
        voucherCommentLine.SetRange("Document Type", "Document Type");
        voucherCommentLine.SetRange("No.", "No.");
        voucherCommentLine.SetRange("Document Line No.", "Document Line No.");
        voucherCommentLine.SetRange(Date, WorkDate);
        if not voucherCommentLine.FindFirst then
            Date := WorkDate;

        OnAfterSetUpNewLine(Rec, voucherCommentLine);
    end;

    procedure CopyComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        voucherCommentLine: Record "voucher Comment Line";
        voucherCommentLine2: Record "voucher Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyComments(voucherCommentLine, ToDocumentType, IsHandled, FromDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        voucherCommentLine.SetRange("Document Type", FromDocumentType);
        voucherCommentLine.SetRange("No.", FromNumber);
        if voucherCommentLine.FindSet() then
            repeat
                voucherCommentLine2 := voucherCommentLine;
                voucherCommentLine2."Document Type" := "voucher Comment Document Type".FromInteger(ToDocumentType);
                voucherCommentLine2."No." := ToNumber;
                voucherCommentLine2.Insert();
            until voucherCommentLine.Next() = 0;
    end;

    procedure CopyLineComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLineNo: Integer)
    var
        voucherCommentLineSource: Record "voucher Comment Line";
        voucherCommentLineTarget: Record "voucher Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyLineComments(
          voucherCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, FromDocumentLineNo, ToDocumentLineNo);
        if IsHandled then
            exit;

        voucherCommentLineSource.SetRange("Document Type", FromDocumentType);
        voucherCommentLineSource.SetRange("No.", FromNumber);
        voucherCommentLineSource.SetRange("Document Line No.", FromDocumentLineNo);
        if voucherCommentLineSource.FindSet() then
            repeat
                voucherCommentLineTarget := voucherCommentLineSource;
                voucherCommentLineTarget."Document Type" := "voucher Comment Document Type".FromInteger(ToDocumentType);
                voucherCommentLineTarget."No." := ToNumber;
                voucherCommentLineTarget."Document Line No." := ToDocumentLineNo;
                voucherCommentLineTarget.Insert();
            until voucherCommentLineSource.Next() = 0;
    end;

    procedure CopyLineCommentsFromvoucherLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; var TempvoucherLineSource: Record "voucher Line" temporary)
    var
        voucherCommentLineSource: Record "voucher Comment Line";
        voucherCommentLineTarget: Record "voucher Comment Line";
        IsHandled: Boolean;
        NextLineNo: Integer;
    begin
        IsHandled := false;
        OnBeforeCopyLineCommentsFromvoucherLines(
          voucherCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber, TempvoucherLineSource);
        if IsHandled then
            exit;

        voucherCommentLineTarget.SetRange("Document Type", ToDocumentType);
        voucherCommentLineTarget.SetRange("No.", ToNumber);
        voucherCommentLineTarget.SetRange("Document Line No.", 0);
        if voucherCommentLineTarget.FindLast() then;
        NextLineNo := voucherCommentLineTarget."Line No." + 10000;
        voucherCommentLineTarget.Reset();

        voucherCommentLineSource.SetRange("Document Type", FromDocumentType);
        voucherCommentLineSource.SetRange("No.", FromNumber);
        if TempvoucherLineSource.FindSet() then
            repeat
                voucherCommentLineSource.SetRange("Document Line No.", TempvoucherLineSource."Line No.");
                if voucherCommentLineSource.FindSet() then
                    repeat
                        voucherCommentLineTarget := voucherCommentLineSource;
                        voucherCommentLineTarget."Document Type" := "voucher Comment Document Type".FromInteger(ToDocumentType);
                        voucherCommentLineTarget."No." := ToNumber;
                        voucherCommentLineTarget."Document Line No." := 0;
                        voucherCommentLineTarget."Line No." := NextLineNo;
                        voucherCommentLineTarget.Insert();
                        NextLineNo += 10000;
                    until voucherCommentLineSource.Next() = 0;
            until TempvoucherLineSource.Next() = 0;
    end;

    procedure CopyHeaderComments(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        voucherCommentLineSource: Record "voucher Comment Line";
        voucherCommentLineTarget: Record "voucher Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCopyHeaderComments(voucherCommentLineTarget, IsHandled, FromDocumentType, ToDocumentType, FromNumber, ToNumber);
        if IsHandled then
            exit;

        voucherCommentLineSource.SetRange("Document Type", FromDocumentType);
        voucherCommentLineSource.SetRange("No.", FromNumber);
        voucherCommentLineSource.SetRange("Document Line No.", 0);
        if voucherCommentLineSource.FindSet() then
            repeat
                voucherCommentLineTarget := voucherCommentLineSource;
                voucherCommentLineTarget."Document Type" := "voucher Comment Document Type".FromInteger(ToDocumentType);
                voucherCommentLineTarget."No." := ToNumber;
                voucherCommentLineTarget.Insert();
            until voucherCommentLineSource.Next() = 0;
    end;

    procedure DeleteComments(DocType: Option; DocNo: Code[20])
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        if not IsEmpty() then
            DeleteAll();
    end;

    procedure ShowComments(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    var
        voucherCommentSheet: Page "voucher Comment Sheet";
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        SetRange("Document Line No.", DocLineNo);
        Clear(voucherCommentSheet);
        voucherCommentSheet.SetTableView(Rec);
        voucherCommentSheet.RunModal;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetUpNewLine(var voucherCommentLineRec: Record "voucher Comment Line"; var voucherCommentLineFilter: Record "voucher Comment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyComments(var voucherCommentLine: Record "voucher Comment Line"; ToDocumentType: Integer; var IsHandled: Boolean; FromDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineComments(var voucherCommentLine: Record "voucher Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; FromDocumentLineNo: Integer; ToDocumentLine: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyLineCommentsFromvoucherLines(var voucherCommentLine: Record "voucher Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]; var TempvoucherLineSource: Record "voucher Line" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyHeaderComments(var voucherCommentLine: Record "voucher Comment Line"; var IsHandled: Boolean; FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    begin
    end;
}

