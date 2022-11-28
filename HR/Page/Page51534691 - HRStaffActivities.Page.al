page 51534691 "HR Staff Activities"
{
    PageType = Card;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No"; "Employee No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Subject; Subject)
                 {
                    ApplicationArea = all;
                }
                field("Email Message"; "Email Message")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Sent; Sent)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action10)
            {
                action("Send Mail")
                {
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SendMail;
                    end;
                }
                action(Attachment)
                {
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Employee No"),
                                  "Document Type" = CONST("Staff Activity");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Test Attachment")
                {/*
                    Caption = 'Attachment';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Attachment Test";
                    RunPageLink = "Employee No" = FIELD ("Employee No"),
                                  "Document Type" = CONST ("Staff Activity"),
                                  "Application No" = FIELD (Code),
                                  "Folder Type" = CONST (HR);
                                  */
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Emp.SetRange("User ID", UserId);
        if Emp.FindFirst then begin
            "Employee No" := Emp."No.";
            "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Activity Type" := "Activity Type"::Staff;
    end;

    var
        Emp: Record "HR Employees";
        Text001: Label 'Mail sent successfully';

    local procedure SendMail()
    var
        HREmp: Record "HR Employees";
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        HrComm: Record "HR Committees";
        Emp: Record "HR Employees";
        Email: List of [Text];

    begin
        //Send Emp
        if Sent then Error('HR has been notified');
        Emp.Get("Employee No");
        Emp.TestField("Company E-Mail");
        Emp.TestField(Emp."Company E-Mail");
        Email.Add('hr@leadway-Pensure.com');

        SMTP.CreateMessage("Employee Name", Emp."Company E-Mail", Email,
        Subject, 'Dear' + ' ' + Emp."First Name" + ' ' +
        ' ' + "Email Message", true);
        SMTP.Send();
        Sent := true;
        Modify;
        Message('%1', Text001);
    end;
}

