codeunit 51534522 "Journal Post Successful"
{

    trigger OnRun()
    begin
    end;

    [Scope('OnPrem')]
    procedure PostedSuccessfully() Posted: Boolean
    var
    // ValPost: Record "Value Posting";
    begin
        // Posted := FALSE;
        // ValPost.SETRANGE(ValPost.UserID, USERID);
        // ValPost.SETRANGE(ValPost."Value Posting", 1);
        // IF ValPost.FIND('-') THEN
        //     Posted := TRUE;
    end;
}

