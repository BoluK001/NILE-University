codeunit 51534508 "Pre and Post Training Email"
{

    trigger OnRun()
    begin
        /*IF (STRPOS("Parameter string",':')) > 0 THEN BEGIN
          Param := COPYSTR("Parameter string",1,(STRPOS("Parameter string",':')-1));
          CASE Param OF
            'Item':
                CreateItemMail();
            'Cust':
                CreateCustMail();
          END;
         END;  */


        // message('Thanks');

        CreateItemMail();
        //******************************************************************PRE TRaining Evaluation*********************************************************************************//
        /*
        IF HRTrainingRec.FIND('-') THEN
           HRTrainingRec.SETRANGE(HRTrainingRec.Status,HRTrainingRec.Status::Approved);
        
           IF HRTrainingRec.FIND('-') THEN BEGIN REPEAT
           SysDate := TODAY;
           NumberOfDays := HRTrainingRec."From Date" - SysDate;
          //MESSAGE('%1',NumberOfDays);
           IF NumberOfDays >= -3 THEN BEGIN
        //MESSAGE('%1|%2|%3',NumberOfDays,SysDate,HRTrainingRec."From Date");
        
        
           HRTrainingPart.SETRANGE(HRTrainingPart."Document No.",HRTrainingRec."Application No");
            IF HRTrainingPart.FIND('-') THEN BEGIN REPEAT
        
             IF HREmployeeRec.GET(HRTrainingPart."Employee Code") THEN BEGIN
             EmpEmail := HREmployeeRec."Company E-Mail";
           //MESSAGE('%1',EmpEmail);
                IF NOT smtpTable.GET THEN
                 ERROR('The SMTP Setup does not exist, the mail was not sent');
                 EmailSubject :=STRSUBSTNO('HR TRAINING PRE-TRAINING EVALUATION - %1',HRTrainingRec."Staff Course Title");
                 receiverEmail := EmpEmail ;
                 senderEmail :='hr@leadway-pensure.com';
                   EmailBody := STRSUBSTNO('Dear %1, You have been scheduled for %2 training. Start Date %3 Duration %4 Days. Please logon to Nav to complete your Pre-Training Evaluation assessment forms. Training Application No:%5',
                   HREmployeeRec."First Name",HRTrainingRec."Staff Course Title",HRTrainingRec."From Date",HRTrainingRec.Duration,HRTrainingRec."Application No");
                   //EmailBody := STRSUBSTNO('This is a Microsoft Dynamics test Email');
                   smtp.CreateMessage(SenderName,senderEmail,receiverEmail,EmailSubject,EmailBody,TRUE);
                   smtp.AddBCC('p-philips@leadeay-pensure.com');
                   smtp.Send;
        
             END;
            UNTIL HRTrainingPart.NEXT = 0;
            END;
        
           END;
        //MESSAGE('%1|%2|%3',NumberOfDays,SysDate,HRTrainingRec."From Date");
            UNTIL HRTrainingRec.NEXT = 0;
            END;
        
        /******************************************************************Post TRaining Evaluation*********************************************************************************/
        IF HRTrainingRec.FIND('-') THEN
            HRTrainingRec.SETRANGE(HRTrainingRec.Status, HRTrainingRec.Status::Approved);

        IF HRTrainingRec.FIND('-') THEN BEGIN
            REPEAT
                SysDate := TODAY;
                NumberOfDays := SysDate - HRTrainingRec."To Date";
                IF NumberOfDays = 3 THEN BEGIN
                    //MESSAGE('%1|%2|%3',NumberOfDays,SysDate,HRTrainingRec."From Date");


                    HRTrainingPart.SETRANGE(HRTrainingPart."Document No.", HRTrainingRec."Application No");
                    IF HRTrainingPart.FIND('-') THEN BEGIN
                        REPEAT
                            IF HREmployeeRec.GET(HRTrainingPart."Employee Code") THEN BEGIN
                                EmpEmail := HREmployeeRec."Company E-Mail";
                                //MESSAGE('%1',EmpEmail);
                                IF NOT smtpTable.GET THEN
                                    ERROR('The SMTP Setup does not exist, the mail was not sent');
                                EmailSubject := STRSUBSTNO('HR TRAINING POST-TRAINING - EVALUATION %1', HRTrainingRec."Staff Course Title");
                                receiverEmail.Add(EmpEmail);
                                senderEmail := 'hr@leadway-pensure.com';
                                EmailAdd.Add('p-philips@leadeay-pensure.com');
                                EmailBody := STRSUBSTNO('Dear %1, Please log on to Navision to Complete your Post-Training Evaluation for %2 completed on %3. Training Application No: %4',
                                HREmployeeRec."First Name", HRTrainingRec."Staff Course Title", HRTrainingRec."To Date", HRTrainingRec."Application No");
                                //EmailBody := STRSUBSTNO('This is a Microsoft Dynamics test Email');
                                smtp.CreateMessage(SenderName, senderEmail, receiverEmail, EmailSubject, EmailBody, TRUE);
                                smtp.AddBCC(EmailAdd);
                                smtp.Send;

                            END;
                        UNTIL HRTrainingPart.NEXT = 0;
                    END;

                END;
            //MESSAGE('%1|%2|%3',NumberOfDays,SysDate,HRTrainingRec."From Date");
            UNTIL HRTrainingRec.NEXT = 0;
        END;


    end;

    var
        EmailAdd: List of [Text];
        ReceiverEmail: List of [Text];
        HRTrainingRec: Record "HR Training Applications";
        HREmployeeRec: Record "HR Employees";
        smtpTable: Record "SMTP Mail Setup";
        senderEmail: Text;
        HRTrainingPart: Record "HR Training Need Participant";
        SysDate: Date;
        NumberOfDays: Integer;
        EmpEmail: Text[50];
        EmailSubject: Text[100];
        SenderName: Text[50];
        EmailBody: Text[250];
        smtp: Codeunit "SMTP Mail";
        HREvaluationRec: Record "Emp Traing Eval. Questionaire";
        itemRec: Record Item;
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        i: Integer;
        itemNo: array[200000] of Text;
        itemdescription: array[200000] of Text;
        qty: array[200000] of Decimal;
        Param: Text;
        "Parameter string": Text;

    [Scope('OnPrem')]
    procedure CreateItemMail()
    begin
        /*
        IF itemRec.FIND('-') THEN
        BEGIN
          REPEAT
              itemRec.CALCFIELDS(itemRec.Inventory);
        
              IF itemRec.Inventory < itemRec."Reorder Point" THEN
                 BEGIN
                    SMTPMail.CreateMessage('Gbenga','g-onuoha@leadway-pensure.com','p-philips@leadway-pensure.com','Inventory','',TRUE);
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Dear'+' '+ 'Inventory Manager'+ ' ' + ''+ ' ' +'' + ',');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody(FORMAT(itemRec."No." +','+ itemRec.Description + ',' + FORMAT(itemRec.Inventory)));
                    SMTPMail.AppendBody('Thanks');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Thanks');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AddBCC('olubitan@gmail.com');
                    SMTPMail.Send;
        
           // message('Thanks');
                END
          UNTIL itemRec.NEXT=0;
        END;
             */

    end;

    local procedure CreateCustMail()
    begin
    end;
}

