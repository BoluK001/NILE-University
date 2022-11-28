// codeunit 51534519 "Posting Check FP"
// {
//     SingleInstance = true;

//     trigger OnRun()
//     begin
//     end;

//     var
//         Post: Boolean;
//         blnState: Boolean;
//         blnJrnlState: Boolean;
//         FromNo: Code[20];
//         ToNo: Code[20];

//     [Scope('OnPrem')]
//     procedure SetCheck(var blnPost: Boolean)
//     begin
//         Post := blnPost;
//     end;

//     [Scope('OnPrem')]
//     procedure GetCheck() blnPost: Boolean
//     begin
//         blnPost := Post;
//     end;

//     [Scope('OnPrem')]
//     procedure ResetState()
//     begin
//         blnState := false;
//         FromNo := '';
//         ToNo := '';
//     end;

//     [Scope('OnPrem')]
//     procedure SetState(Post: Boolean)
//     begin
//         blnState := Post;
//     end;

//     [Scope('OnPrem')]
//     procedure GetState() ActState: Boolean
//     begin
//         ActState := blnState;
//         exit(ActState);
//     end;

//     [Scope('OnPrem')]
//     procedure FromEntryNo(var FromNoReg: Code[20])
//     begin
//         FromNo := FromNoReg;
//     end;

//     [Scope('OnPrem')]
//     procedure ToEntryNo(var ToNoReg: Code[20])
//     begin
//         ToNo := ToNoReg;
//     end;

//     [Scope('OnPrem')]
//     procedure GetFromRegNo() FromRegisterNo: Code[20]
//     begin
//         FromRegisterNo := FromNo;
//     end;

//     [Scope('OnPrem')]
//     procedure GetToRegNo() ToRegisterNo: Code[20]
//     begin
//         ToRegisterNo := ToNo;
//     end;
// }

