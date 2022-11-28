codeunit 51534413 "Posting Check FP"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        Post: Boolean;
        blnState: Boolean;
        blnJrnlState: Boolean;
        FromNo: Code[20];
        ToNo: Code[20];

    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;


    [Scope('OnPrem')]
    procedure SetCheck(var blnPost: Boolean)
    begin
        Post := blnPost;
    end;

    [Scope('OnPrem')]
    procedure GetCheck() blnPost: Boolean
    begin
        blnPost := Post;
    end;

    [Scope('OnPrem')]
    procedure ResetState()
    begin
        blnState := false;
        FromNo := '';
        ToNo := '';
    end;

    [Scope('OnPrem')]
    procedure SetState(Post: Boolean)
    begin
        blnState := Post;
    end;

    [Scope('OnPrem')]
    procedure GetState() ActState: Boolean
    begin
        ActState := blnState;
        exit(ActState);
    end;

    [Scope('OnPrem')]
    procedure FromEntryNo(var FromNoReg: Code[20])
    begin
        FromNo := FromNoReg;
    end;

    [Scope('OnPrem')]
    procedure ToEntryNo(var ToNoReg: Code[20])
    begin
        ToNo := ToNoReg;
    end;

    [Scope('OnPrem')]
    procedure GetFromRegNo() FromRegisterNo: Code[20]
    begin
        FromRegisterNo := FromNo;
    end;

    [Scope('OnPrem')]
    procedure GetToRegNo() ToRegisterNo: Code[20]
    begin
        ToRegisterNo := ToNo;
    end;

    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Employee;
    begin
        Name := '';
        if Cust.Get(No) then
            Name := Cust."First Name" + ' ' + Cust."Middle Name" + ' ' + CUst."Last Name";
        exit(Name);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Expense No.', false, false)]
    local procedure OnValidateCurrentField(VAR Rec: Record "Purchase Line"; VAR xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        ExpenseList: record "Receipts and Payment Types";
    begin
        ExpenseList.SETCURRENTKEY(ExpenseList.Code);
        ExpenseList.SETRANGE(ExpenseList.Code, Rec."Expense No.");
        IF ExpenseList.FIND('-') THEN BEGIN
            Rec.Type := Rec.Type::"G/L Account";
            Rec.validate("No.", ExpenseList."Account No.");
            Rec."Expense No." := ExpenseList.code;
            Rec.Description := ExpenseList.Description;
        END;
    end;

    var
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
}