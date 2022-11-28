codeunit 51534512 "Register Management"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        RegisterNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;

    [Scope('OnPrem')]
    procedure ResetValues()
    begin
        RegisterNo := 0;
        FromEntryNo := 0;
        ToEntryNo := 0;
    end;

    [Scope('OnPrem')]
    procedure SetRegisterNumber(var "No.": Integer)
    begin
        RegisterNo := "No.";
    end;

    [Scope('OnPrem')]
    procedure SetFromEntryNumber(var "No.": Integer)
    begin
        FromEntryNo := "No.";
    end;

    [Scope('OnPrem')]
    procedure SetToEntryNumber(var "No.": Integer)
    begin
        ToEntryNo := "No.";
    end;

    [Scope('OnPrem')]
    procedure GetRegisterNumber() RegisterNumber: Integer
    begin
        RegisterNumber := RegisterNo;
        exit(RegisterNumber);
    end;

    [Scope('OnPrem')]
    procedure GetFromEntryNo() EntryNo: Integer
    begin
        EntryNo := FromEntryNo;
        exit(EntryNo);
    end;

    [Scope('OnPrem')]
    procedure GetToEntryNo() EntryNo: Integer
    begin
        EntryNo := ToEntryNo;
        exit(EntryNo);
    end;
}

