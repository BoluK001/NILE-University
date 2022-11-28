codeunit 51534428 "HR Confirmation Notification"
{

    trigger OnRun()
    begin
        HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID", USERID);
        IF HREmp.FINDFIRST THEN BEGIN
            IF (FORMAT(HREmp."Date Of Joining the Company") <> '') AND (FORMAT(HREmp."Probation Date 3mnths") <> '') THEN BEGIN
                IF (TODAY = HREmp."Probation Date 3mnths") THEN
                    SendMail('Probation', HREmp."No.");
                IF HREmp."Probation Form Filled" = TRUE THEN BEGIN
                    IF (TODAY = HREmp."Confirmation Date") THEN
                        SendMail('Confirmation', HREmp."No.");
                END;
            END;
        END;
    end;

    var
        HREmp: Record "HR Employees";
        SMTP: Codeunit "SMTP Mail";
        text001: Label 'Dear Employee,Your %1 form is yet to be filled, Do ensure to fill and send for HR approval';

    local procedure SendMail(Type: Code[20]; EmpNo: Code[30])
    var
        HREmpl: Record "HR Employees";
        Subject: Text[250];
        EmailAdd: List of [Text];
        EmailAdd2: List of [Text];
        EmailAdd3: List of [Text];
    begin
        Subject := STRSUBSTNO(text001, Type);
        HREmpl.GET(EmpNo);
        EmailAdd.Add(HREmpl."Company E-Mail");
        EmailAdd2.Add('it@optivacp.com');
        EmailAdd3.Add('dennisbalogun@reeltechsoultions.com');
        SMTP.CreateMessage('Leadway Pensure HR', 'hr@leadwaypensure.com', EmailAdd,
        Type + ' ' + 'Notification', '', TRUE);

        SMTP.AppendBody('Dear,' + HREmpl."Full Name" + '<BR><BR>');
        SMTP.AppendBody(Subject);
        SMTP.AppendBody('<BR>');
        SMTP.AppendBody('<HR>');
        SMTP.AppendBody('Regards,<BR>');
        SMTP.AppendBody('HR <BR>');
        SMTP.AddCC(EmailAdd2);
        SMTP.AddBCC(EmailAdd3);
        SMTP.Send;
    end;
}

