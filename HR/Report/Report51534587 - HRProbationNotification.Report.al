report 51534587 "HR Probation Notification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRProbationNotification.rdlc';
    ProcessingOnly = false;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = WHERE(Status = CONST(Active));

            trigger OnAfterGetRecord()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."User ID", UserId);
                if HREmp.FindFirst then begin
                    if (Format(HREmp."Confirmation Date") <> '') and (Format(HREmp."Probation Date 3mnths") <> '') then begin
                        if (HREmp."Probation Date 3mnths" - Today) = 14 then
                            SendMail('Probation', HREmp."No.")
                        else
                            if (HREmp."Confirmation Date" - Today) = 14 then
                                SendMail('Confirmation', HREmp."No.");
                    end;
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
        HREmp: Record "HR Employees";
        SMTP: Codeunit "SMTP Mail";
        text001: Label 'Dear HR,Staff %1  %2 will be due in 2 weeks ';

    local procedure SendMail(Type: Code[20]; EmpNo: Code[30])
    var
        HREmpl: Record "HR Employees";
        Subject: Text[250];
        EmailAdd: List of [Text];
    begin
        Subject := StrSubstNo(text001, EmpNo, Type);
        HREmpl.Get(EmpNo);
        EmailAdd.Add('hr@leadwaypensure.com');
        SMTP.CreateMessage('Leadway Pensure HR', 'donotreply@leadwaypensure.com', EmailAdd,
        Type + ' ' + 'Notification', '', true);

        SMTP.AppendBody('Dear HR, <BR><BR>');
        SMTP.AppendBody(Subject);
        SMTP.AppendBody('<BR>');
        SMTP.AppendBody('<HR>');
        SMTP.AppendBody('Regards,<BR>');
        SMTP.AppendBody('HR <BR>');
        //SMTP.AddCC('hr@leadway-Pensure.com');
        //SMTP.AddBCC('coretec@leadway-pensure.com');
        SMTP.Send;
    end;
}

