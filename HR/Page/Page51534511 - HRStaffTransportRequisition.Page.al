page 51534511 "HR Staff Transport Requisition"
{
    PageType = Card;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = all;
                    Caption = 'Application No';
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                    Caption = 'Applicant No.';
                    Editable = false;
                }
                field(EmpName; EmpName)
                {
                    ApplicationArea = all;
                    Caption = 'Applicant Name';
                    Editable = false;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = all;
                    Caption = 'Job Title';
                    Editable = false;
                }
                field(EmpJobDesc; EmpJobDesc)
                {
                    ApplicationArea = all;
                    Caption = 'Job Description';
                    Editable = false;
                }
                field(EmpDept; EmpDept)
                {
                    ApplicationArea = all;
                    Caption = 'Department';
                    Editable = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = all;
                    Caption = 'No of Days';
                }
                field("Time of Trip"; "Time of Trip")
                {
                    ApplicationArea = all;
                }
                field("From Destination"; "From Destination")
                {
                    ApplicationArea = all;
                }
                field("To Destination"; "To Destination")
                {
                    ApplicationArea = all;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = all;
                }
                field("Purpose of Trip"; "Purpose of Trip")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(SupervisorName; SupervisorName)
                {
                    ApplicationArea = all;
                    Caption = 'Supervisor Name';
                    Editable = false;
                }
                field("Supervisor Email"; "Supervisor Email")
                {
                    ApplicationArea = all;
                    Caption = 'Supervisor Email';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    ApplicationArea = all;
                    Caption = '&Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    begin
                        /*DocumentType:=DocumentType::"Leave Application";
                        ApprovalEntries.Setfilters(DATABASE::"HR Transport Requisition",DocumentType,"Application Code");
                        ApprovalEntries.RUN;
                         */

                    end;
                }
                separator(Action1102755017)
                {

                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMGT: Codeunit "Approval Mgmt. ExtCal";

                    begin

                        TESTFIELDS;

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        Selected := true;
                        "User ID" := UserId;

                        //ApprovalMgt.SendTransportReqApprovalReq(Rec);

                    end;
                }
                separator(Action1102755018)
                {

                }
                action(Print)
                {
                    ApplicationArea = all;
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                        if HRLeaveApp.Find('-') then
                            REPORT.RUN(51534519, true, true, HRLeaveApp);
                    end;
                }
                action("Attachments (Handover Docs)")
                {
                    Caption = 'Attachments (Handover Docs)';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if DoclLink.Get("Application Code", FieldCaption("Application Code")) then begin
                            DoclLink.PlaceFilter(true, DoclLink."Employee No");
                            PAGE.RunModal(39003998, DoclLink);
                        end else begin
                            DoclLink.Init;
                            DoclLink."Employee No" := "Application Code";
                            DoclLink."Document Description" := FieldCaption("Application Code");
                            DoclLink.Insert;
                            Commit;
                            DoclLink.PlaceFilter(true, DoclLink."Employee No");
                            PAGE.RunModal(39003998, DoclLink);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls();

        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        //GetLeaveStats("Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        //SETFILTER("User ID",USERID);
        /*
         IF Status=Status::Approved THEN// or IF Status:=Status::"Pending Approval" THEN
         CurrForm.EDITABLE:=FALSE;

         IF Status=Status::"Pending Approval" THEN// or IF Status:=Status::"Pending Approval" THEN
         CurrForm.EDITABLE:=FALSE;
        */

    end;

    trigger OnOpenPage()
    begin
        //SETFILTER("User ID",USERID);
        /*IF "Employee No"<>'' THEN*/
        UpdateControls;

    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[30];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[30];
        SMTP: Codeunit "SMTP Mail";
        URL: Text[500];
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        HRSetup: Record "HR Setup";
        EmpDept: Text[30];
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        HRLeaveApp: Record "HR Transport Requisition";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        D: Date;
        EmpName: Text[70];
        DoclLink: Record "HR Leave Attachments";

    [Scope('OnPrem')]
    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        HREmp.Reset;
        if HREmp.Get("Employee No") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            EmpDept := HREmp."Global Dimension 2 Code";
        end else begin
            EmpDept := '';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        HRJobs.Reset;
        if HRJobs.Get("Job Tittle") then begin
            EmpJobDesc := HRJobs."Job Title";
        end else begin
            EmpJobDesc := '';
        end;

        //GET THE APPROVER NAMES
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", Supervisor);
        if HREmp.Find('-') then begin
            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            SupervisorName := '';
        end;
    end;

    [Scope('OnPrem')]
    procedure GetLeaveStats(LeaveType: Text[50])
    begin

        dAlloc := 0;
        dEarnd := 0;
        dTaken := 0;
        dLeft := 0;
        cReimbsd := 0;
        cPerDay := 0;
        cbf := 0;
        if HREmp.Get("Employee No") then begin
            HREmp.SetFilter(HREmp."Leave Type Filter", LeaveType);
            HREmp.CalcFields(HREmp."Allocated Leave Days");
            dAlloc := HREmp."Allocated Leave Days";
            HREmp.Validate(HREmp."Allocated Leave Days");
            dEarnd := HREmp."Total (Leave Days)";
            HREmp.CalcFields(HREmp."Total Leave Taken");
            dTaken := HREmp."Total Leave Taken";
            dLeft := HREmp."Leave Balance";
            cReimbsd := HREmp."Cash - Leave Earned";
            cPerDay := HREmp."Cash per Leave Day";
            cbf := HREmp."Reimbursed Leave Days";
        end;
    end;

    [Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        //TESTFIELD("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");
        //TESTFIELD(Reliever);
        TestField(Supervisor);
    end;

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin

        /*
         IF Status<>Status::New THEN BEGIN
         CurrForm."Leave Type".EDITABLE:=FALSE;
         CurrForm."Days Applied".EDITABLE:=FALSE;
         CurrForm."Start Date".EDITABLE:=FALSE;
         CurrForm.Reliever.EDITABLE:=FALSE;
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Leave Type".EDITABLE:=TRUE;
         CurrForm."Days Applied".EDITABLE:=TRUE;
         CurrForm."Start Date".EDITABLE:=TRUE;
         CurrForm.Reliever.EDITABLE:=TRUE;
         CurrForm."Responsibility Center".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END;

         IF Status<>Status::Approved THEN BEGIN
         CurrForm."Leave Type".EDITABLE:=TRUE;
         CurrForm."Days Applied".EDITABLE:=TRUE;
         CurrForm."Start Date".EDITABLE:=TRUE;
         CurrForm.Reliever.EDITABLE:=TRUE;
         CurrForm."Responsibility Center".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Leave Type".EDITABLE:=FALSE;
         CurrForm."Days Applied".EDITABLE:=FALSE;
         CurrForm."Start Date".EDITABLE:=FALSE;
         CurrForm.Reliever.EDITABLE:=FALSE;
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END;
         */

    end;
}

