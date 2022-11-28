page 51534545 "HR Training Application Card"
{
    DeleteAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show';
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; "Application No")
                {
                    Editable = false;  //jj280922  Changed from Editable ="Application NoEditable"
                    ApplicationArea = all;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                }
                field("Recommended By"; "Recommended By")
                {
                    ApplicationArea = all;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //CurrPage.UPDATE;
                    end;
                }


                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = "Employee DepartmentEditable";
                }
            }
            group("Training Details")
            {
                Caption = 'Training Details';
                /* group(Control9)
                 {
                     ShowCaption = false;
                     Visible = false;
                     field("Course Title"; "Course Title")
                     {
                         ApplicationArea = all;
                         Editable = "Course TitleEditable";
                     }
                     field(Description; Description)
                     {
                         ApplicationArea = all;
                     }
                     field("Reason for Training"; "Reason for Training")
                     {
                         ApplicationArea = all;
                         MultiLine = false;
                     }
                     field("From Date"; "From Date")
                     {

                         trigger OnValidate()
                         begin
                             //  message('I got here')

                             //IF "From Date" - "Application Date" < HRSetup."Training Application Before" THEN
                             //ERROR('Sorry, %1, There must be at least 10 days between the "Application Date"  and "Training Start Date"', UPPERCASE(USERID));
                         end;
                     }
                     field("To Date"; "To Date")
                     {

                         trigger OnValidate()
                         begin
                             Duration := "To Date" - "From Date";
                         end;
                     }
                     field("Duration Units"; "Duration Units")
                     {
                         ApplicationArea = all;
                         Visible = false;
                     }
                     field("Cost Of Training"; "Cost Of Training")
                     {
                         ApplicationArea = all;
                     }
                     field("Approved Cost"; "Approved Cost")
                     {
                         ApplicationArea = all;
                     }
                 }   */   //jj280922
                group(Control8)
                {
                    ShowCaption = false;
                    Visible = true;
                    field("Course Title"; "Course Title")
                    {
                        ApplicationArea = All;  //jj280922
                    }
                    field("Staff Course Title"; "Staff Course Title")
                    {
                        ApplicationArea = all;
                    }
                    field(FromDate; "From Date")
                    {
                        ApplicationArea = all;
                        Caption = 'From Date';

                        trigger OnValidate()
                        begin
                            //MESSAGE('I GOT HERE');
                            HRSetup.Get;
                            //MESSAGE('%1|%2',"From Date"-"Application Date", HRSetup."Training Application Before");
                            if "From Date" - "Application Date" < HRSetup."Training Application Before" then

                                //MESSAGE ('%1, ("Application Date" - "From Date")');
                                //MESSAGE ('%1,HRSetup."Training Application Before');
                                //Error('Sorry, %1, There must be at least 10 days between the "Application Date"  and "Training Start Date"', UpperCase(UserId));    //jj280922 Iremmed
                                Error('Sorry, %1, There must be at least %2 days between the "Application Date"  and "Training Start Date"', UpperCase(UserId), HRSetup."Training Application Before"); //jj280922 I Added
                        end;
                    }


                    field(ToDate; "To Date")
                    {
                        ApplicationArea = all;
                        Caption = 'To Date';

                        trigger OnValidate()
                        begin
                            if "To Date" < "From Date" then
                                Error('Sorry, To Date: %1, can not be less than the From date: %2', "To Date", "From Date"); //Dennis

                            Rec.Duration := (Rec."To Date" - Rec."From Date") + 1;
                        end;
                    }
                    field(Duration; Duration)
                    {
                        ApplicationArea = all;
                    }
                    field(Location; Location)
                    {
                        ApplicationArea = all;
                    }
                    field(VendorName; VendorName)
                    {
                        Caption = 'Vendor Name';
                        ApplicationArea = all;
                    }
                    field(Provider; Provider)
                    {
                        ApplicationArea = all;
                    }
                    field("Provider Name"; "Provider Name")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Total Amount"; "Total Amount")
                    {
                        ApplicationArea = all;
                        Editable = false;   //jj280922
                    }
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = "Responsibility CenterEditable";
                }
                field("No. of Applicants"; "No. of Applicants")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = true;   //jj300922  bolu to solve
                    Style = StrongAccent;
                    StyleExpr = TRUE;

                }
            }
            part(Control2; "Hr Training Need App SF")
            {
                SubPageLink = "Document No." = FIELD("Application No");
                ApplicationArea = All; //jj270422
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = FIELD("Application No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = Comment;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocumentType := DocumentType::"Training Requisition";
                        /*
                        ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.RUN;
                         */

                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    ApplicationArea = all;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        DocumentType := DocumentType::"Training Applications";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"HR Training Applications", DocumentType.AsInteger(), Rec."Application No");
                    end;
                }
                action("&Send Approval &Request")
                {
                    ApplicationArea = all;
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // TestField(Provider); //jj280922 
                        TestField("Total Amount");
                        CheckLine;
                        if Confirm('Send this Application for Approval?', true) = false then exit;

                        If ApprovalMgt.CheckHRTrainingApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRTrainingAppForApproval(Rec);

                    end;
                }
                action("&Cancel Approval request")
                {
                    ApplicationArea = all;
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request', true) = false then exit;

                        ApprovalMgt.OnCancelHRTrainingAppForApproval(Rec);
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No", "Application No");
                        if HRTrainingApplications.Find('-') then
                            REPORT.Run(51534685, true, true, HRTrainingApplications);
                    end;
                }
                action("<A ction1102755042>")
                {
                    ApplicationArea = all;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Status := Status::New;
                        Modify;
                    end;
                }
                action("Generate PV")
                {
                    ApplicationArea = all;
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;  //jj300922

                    trigger OnAction()
                    begin
                        TestField(Status, Status::Approved);
                        GeneratePV;
                    end;
                }
                /* action(" Attachments")
                 {
                     ApplicationArea = all;
                     Caption = ' Attachments';
                     Image = Attach;
                     Promoted = true;
                     RunObject = Page "HR Employee Attachments SF";
                     RunPageLink = "Employee No" = FIELD("Application No"),
                                   "Document Type" = CONST(Training);
                 }   */    //jj280922 it is old not default BC
                action("Send Mail")
                {
                    Image = SendMail;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DisPCase: Record "HR Disciplinary Cases";
                        Emp: Record "HR Employees";
                    begin
                        TestField(Status, Status::Approved);
                        SendMail;
                    end;
                }
                /*  action("Test Attachment")
                  {
                      Caption = 'Attachment';
                      Image = Attach;
                      Promoted = true;
                      PromotedCategory = Process;
                      PromotedIsBig = true;
                      RunObject = Page "Attachment Test";
                      RunPageLink = "Employee No" = FIELD("User ID"),
                                    "Document Type" = CONST(Training),
                                    "Folder Type" = CONST(HR),
                                    "Application No" = FIELD("Application No");
                  }
                  */
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*UserSetup.GET("UserID");
        IF NOT UserSetup.HR THEN BEGIN
        xRec := Rec;
        IF Status<>Status::New THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
          CurrPage.UPDATE;
        END;
        END;
        
        
        
        IF Status=Status::New THEN BEGIN
        "Responsibility CenterEditable" :=TRUE;
        "Application NoEditable" :=TRUE;
        "Employee No.Editable" :=TRUE;
        "Employee NameEditable" :=TRUE;
        "Employee DepartmentEditable" :=TRUE;
        "Purpose of TrainingEditable" :=TRUE;
        "Course TitleEditable" :=TRUE;
        END ELSE BEGIN
        "Responsibility CenterEditable" :=FALSE;
        "Application NoEditable" :=FALSE;
        "Employee No.Editable" :=FALSE;
        "Employee NameEditable" :=FALSE;
        "Employee DepartmentEditable" :=FALSE;
        "Purpose of TrainingEditable" :=FALSE;
        "Course TitleEditable" :=FALSE;
        END;
         */

        if "Recommended By" = "Recommended By"::Staff then begin
            Staff := true;
            Company := false;
        end
        else
            if "Recommended By" = "Recommended By"::Company then begin
                Company := true;
                Staff := false;
            end;

    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TrainingApplicant: Record "HR Training Need Participant";
        Emp: Record "HR Employees";
    begin
        /*IF Type = Type::Staff THEN BEGIN
         UserSetup.GET(USERID);
         Emp.SETRANGE("User ID",UserSetup."User ID");
         IF Emp.FINDFIRST THEN BEGIN
         TrainingApplicant.INIT;
         TrainingApplicant."Line No.":=0;
         TrainingApplicant."Document No.":=Rec."Application No";
         TrainingApplicant."Employee Code" := Emp."No.";
         TrainingApplicant.Department := Emp."Department Code";
         TrainingApplicant."Job Title":=Emp."Job Title";
         TrainingApplicant.VALIDATE("Employee Code");
         TrainingApplicant.INSERT;
         END;
         END;
         */

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Staff;
        "Recommended By" := "Recommended By"::" ";  //jj280922 i changed from ::Staff
        /*
        IF Type = Type::Staff THEN BEGIN
         UserSetup.GET(USERID);
         Emp.SETRANGE("User ID",UserSetup."User ID");
         IF Emp.FINDFIRST THEN BEGIN
         TrainingApplicant.INIT;
         TrainingApplicant."Line No.":=0;
         TrainingApplicant."Document No.":=Rec."Application No";
         TrainingApplicant."Employee Code" := Emp."No.";
         TrainingApplicant.Department := Emp."Department Code";
         TrainingApplicant."Job Title":=Emp."Job Title";
         TrainingApplicant.VALIDATE("Employee Code");
         TrainingApplicant.INSERT;
         END;
         END;
        */

    end;

    trigger OnOpenPage()
    begin
        //UserSetup.Get(UserId);
        //if not UserSetup.HR then begin
        xRec := Rec;
        if Status <> Status::New then begin
            CurrPage.Editable := false;
            CurrPage.Update;
            // end;   //B.Dennis
        end;

        Company := false;
        Staff := false;
    end;

    var
        Email: List of [Text];
        HREmp: Record "HR Employees";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HR Training Applications";
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]

        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;
        [InDataSet]
        "Employee NameEditable": Boolean;
        [InDataSet]
        "Employee DepartmentEditable": Boolean;
        [InDataSet]
        "Purpose of TrainingEditable": Boolean;
        [InDataSet]
        "Course TitleEditable": Boolean;
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO,Canteen,EmpTransaction,LeaveAck,PFAMod,PFATransfer;
        DocumentType: enum "Approval Document Type";
        UserSetup: Record "User Setup";
        Staff: Boolean;
        Company: Boolean;
        Emp: Record "HR Employees";
        TrainingApplicant: Record "HR Training Need Participant";
        VendorName: Code[50];
        HREmailParameters: Record "HR E-Mail Parameters";
        HRTrainingNeedParticipant: Record "HR Training Need Participant";
        HRSetup: Record "HR Setup";

    [Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        //TESTFIELD("Course Title");
        //TESTFIELD("From Date");
        //TESTFIELD("To Date");
        //TESTFIELD("Duration Units");
        //TESTFIELD(Duration);
        //TESTFIELD("Cost Of Training");
        TestField(Location);
        TestField(Provider);
        TestField("Reason for Training");
    end;

    local procedure SendMail()
    var
        HREmp: Record "HR Employees";
        ApplicantsEmail: Text[30];
        SMTP: Codeunit "SMTP Mail";
        HREmailParameters: Record "HR E-Mail Parameters";
        HrComm: Record "HR Committees";
        Emp: Record "HR Employees";
        EmpNames: Text[50];
    begin
        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        if "Sent to Staff" then Error('All applicants have been notified');
        //TESTFIELD("Applicant Type","Applicant Type"::Internal);
        TrainingApplicant.SetRange(TrainingApplicant."Document No.", "Application No");
        if TrainingApplicant.FindFirst then begin
            repeat
                HREmailParameters.Reset;
                HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Training Application");
                if HREmailParameters.Find('-') then begin
                    HREmp.Get(TrainingApplicant."Employee Code");
                    HREmp.TestField(HREmp."Company E-Mail");
                    Email.Add(HREmp."Company E-Mail");
                    SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", Email,
                    HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
                    HREmailParameters.Body + ' ' + ' ' + HREmailParameters."Body 2", true);
                    SMTP.Send();
                end;
            until TrainingApplicant.Next = 0;
            Message('Applicants have been notified');
        end;

        "Sent to Staff" := true;
        Modify;
    end;

    local procedure CheckLine()
    var
        HRTrainingNeedParticipant: Record "HR Training Need Participant";
    begin
        HRTrainingNeedParticipant.Reset;
        HRTrainingNeedParticipant.SetRange(HRTrainingNeedParticipant."Document No.", "Application No");
        if HRTrainingNeedParticipant.FindFirst then begin
            repeat
                HRTrainingNeedParticipant.TestField(HRTrainingNeedParticipant.Amount);
                HRTrainingNeedParticipant.TestField(HRTrainingNeedParticipant."Course Title");  //jj280922 changed from "Staff Course Title"
                HRTrainingNeedParticipant.TestField(HRTrainingNeedParticipant."From Date");
                HRTrainingNeedParticipant.TestField(HRTrainingNeedParticipant."To Date");
            until HRTrainingNeedParticipant.Next = 0;
        end;
    end;
}

