codeunit 51534414 IntegrationCU
{
    /// <summary>
    /// SendEmail.
    /// </summary>
    /// <param name="MailRecipients">List of[Text],MailSubject.</param>
    Procedure RBSSendEmail(MailRecipients: List of [Text]; MailSubject: Text; MailBody: Text; htmlformat: Boolean)
    var
        EmailAccount: Record "Email Account";
        EmailMessage: Codeunit "Email Message";
        EmailSend: Codeunit Email;
        BodyMessage: Text;
        Receipient: List of [text];
    begin
        EmailAccount.reset;
        EmailAccount.SetFilter(Connector, 'SMTP');
        IF EmailAccount.FindFirst() then begin
            clear(BodyMessage);
            Clear(Receipient);
            Receipient := MailRecipients;
            BodyMessage := MailBody;
            EmailMessage.Create(Receipient, MailSubject, BodyMessage, htmlformat);
            EmailSend.Send(EmailMessage);
        end;

    end;
}