page 51534463 "HR Career Event Option Box11"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            label(MessageTextBox)
            {
                CaptionClass = Format(MessageText);
                MultiLine = true;
            }
            label(Control1102755000)
            {
                ShowCaption = false;
            }
            field(ReasonText; ReasonText)
            {
                Caption = 'Reason';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = ACTION::No then
            NoOnPush;
        if CloseAction = ACTION::Yes then
            YesOnPush;
    end;

    var
        MessageText: Text[250];
        ResultEvent: Boolean;
        ReasonText: Text[100];
        CareerHistory: Record "HR Employees";
        ResultReason: Text[100];

    [Scope('OnPrem')]
    procedure SetMessage(Message: Text[200])
    begin
        MessageText := StrSubstNo(Message);
    end;

    [Scope('OnPrem')]
    procedure ReturnResult() Result: Boolean
    begin
        Result := ResultEvent;
    end;

    [Scope('OnPrem')]
    procedure ReturnReason() ReturnReason: Text[100]
    begin
        ReturnReason := ReasonText;
    end;

    local procedure YesOnPush()
    begin
        ResultEvent := true;
    end;

    local procedure NoOnPush()
    begin
        ResultEvent := false;
    end;
}

