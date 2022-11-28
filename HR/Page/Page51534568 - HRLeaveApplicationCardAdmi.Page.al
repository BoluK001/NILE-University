page 51534568 "HR Leave Application Card Admi"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Comments';
    SourceTable = "HR Leave Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application Code"; "Application Code")
                {
                    Caption = 'Application No';
                    Editable = "Application CodeEditable";
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Editable = "Responsibility CenterEditable";
                    ApplicationArea = all;
                }
                label("Employee Details")
                {
                    Caption = 'Employee Details';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Employee No"; "Employee No")
                {
                    Caption = 'Employee No.';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpName; EmpName)
                {
                    Caption = 'Applicant Name';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    Caption = 'Job Title';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpJobDesc; EmpJobDesc)
                {
                    Caption = 'Job Description';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field(EmpDept; EmpDept)
                {
                    Caption = 'Department';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = SupervisorEditable;

                    trigger OnValidate()
                    begin
                        //GET THE APPROVER NAMES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."User ID", Supervisor);
                        if HREmp.Find('-') then begin
                            SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                        end else begin
                            SupervisorName := '';
                        end;
                    end;
                }
                field(SupervisorName; SupervisorName)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Supervisor Email"; "Supervisor Email")
                {
                    Caption = 'Supervisor Email';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                field("Leave Period"; "Leave Period")
                {
                    Editable = "Leave TypeEditable";
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        LeaveApp: Record "HR Leave Application";
                    begin
                        LeaveBalance := 0;
                        LeaveApp.SetRange(LeaveApp."Employee No", Rec."Employee No");
                        LeaveApp.SetRange(LeaveApp."Leave Type", 'ANNUAL');
                        LeaveApp.SetRange(LeaveApp."Leave Period", Rec."Leave Period");
                        if LeaveApp.FindFirst then begin
                            Rec.CalcFields("Total Annual Leave");
                            LeaveBalance := LeaveApp."Maximum Leave Days" - "Total Annual Leave";
                        end;
                        CurrPage.Update;
                    end;
                }
                field("Leave Type"; "Leave Type")
                {
                    Editable = "Leave TypeEditable";
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        GetLeaveStats("Leave Type");
                        //                    CurrPage.UPDATE;
                    end;
                }
                field("Start Date"; "Start Date")
                {
                    Editable = "Start DateEditable";
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Days Applied"; "Days Applied")
                {
                    Editable = "Days AppliedEditable";
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if "Leave Type" = 'ANNUAL' then
                            if LeaveBalance = 0 then
                                Error('Days applied cannot exceed leave balance');

                        /*
                         IF "Days Applied">HREmp."Acrued Leave Days" THEN
                         ERROR('Days applied cannot acrued Leave Days')
                         END
                        */

                    end;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = all;
                }
                field("Approved days"; "Approved days")
                {
                    Editable = "Application CodeEditable";
                    ApplicationArea = all;
                }
                label(Control1102755082)
                {
                    CaptionClass = Text19010232;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(dEarnd; dEarnd)
                {
                    Caption = 'Total Leave Days';
                    Editable = false;
                    Style = Strong;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Total Annual Leave"; "Total Annual Leave")
                {
                    Caption = 'Annual Leave Taken';
                    ApplicationArea = all;
                }
                field(LeaveBalance; LeaveBalance)
                {
                    Caption = 'Leave Balance';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Maximum Leave Days"; "Maximum Leave Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(dTaken; dTaken)
                {
                    Caption = 'Total Leave Taken';
                    Editable = false;
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field(dLeft; dLeft)
                {
                    Caption = 'Leave Balance';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Application Date"; "Application Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Request Leave Allowance"; "Request Leave Allowance")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Leave Allowance Amount"; "Leave Allowance Amount")
                {
                    Editable = "Leave Allowance AmountEditable";
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = all;
                    Enabled = PayrollPeriodEditable;
                }
                label(Control1000000000)
                {
                    ApplicationArea = all;
                    CaptionClass = Text1;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Reliever; Reliever)
                {
                    ApplicationArea = all;
                    Caption = 'Reliever Code';
                    Editable = RelieverEditable;
                    Visible = false;
                }
                field("Reliever Name"; "Reliever Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control1000000002; Attachments)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    Editable = true;
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            group("More Leave Details")
            {
                Caption = 'More Leave Details';
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    Editable = "Cell Phone NumberEditable";
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("E-mail Address"; "E-mail Address")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Details of Examination"; "Details of Examination")
                {
                    Editable = "Details of ExaminationEditable";
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Date of Exam"; "Date of Exam")
                {
                    Editable = "Date of ExamEditable";
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Number of Previous Attempts"; "Number of Previous Attempts")
                {
                    Editable = NumberofPreviousAttemptsEditab;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
            }
            part(Control7; "HR Leave Reliver SubForm")
            {
                ApplicationArea = all;  //jj
                Editable = false;
                SubPageLink = "Application No." = FIELD("Application Code");
            }
        }
        area(factboxes)
        {
            part(Control1000000003; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = FIELD("Employee No");
            }
            systempart(Control1102755004; Outlook)
            {
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        /*DocumentType:=DocumentType::"Leave Application";
                        
                        ApprovalComments.Setfilters(DATABASE::"HR Leave Application",DocumentType,"Application Code");
                        ApprovalComments.SetUpLine(DATABASE::"HR Leave Application",DocumentType,"Application Code");
                        ApprovalComments.RUN;
                        */

                    end;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    ApplicationArea = all;
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    //RunObject = Page "HR Interview Evaluation Stage3";
                    ///RunPageLink = Field1 = FIELD("Application Code");
                    Visible = false;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                    begin
                        DocType := DocType::"Leave Application";
                        ApprovalEntries.Setfilters(DATABASE::"HR Leave Application", DocType, "Application Code");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval Request")
                {
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        TESTFIELDS;

                        //test the maximum employees allowed to be on leave at once
                        TestLeaveFamily;

                        //Check that its up to 3 days between leave application date and leave commencement date;

                        if "Start Date" - "Application Date" < 2 then
                            Error('Sorry, %1, there must be atleast 2 days between the "Application Date"  and "Leave Start Date"', UpperCase(UserId));

                        if Confirm('Send this Application for Approval?', true) = false then exit;
                        Selected := true;
                        "User ID" := UserId;

                        If ApprovalMgt.CheckHRLeaveAppApprovalsWorkflowEnable(Rec) then
                            ApprovalMgt.OnSendHRLeaveAppForApproval(Rec);
                    end;
                }
                action("&Cancel Approval Request")
                {
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelHRLeaveAppForApproval(Rec);
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    ApplicationArea = all;
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Status := Status::New;
                        Modify;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    ApplicationArea = all;
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    //RunObject = Report "IBS Notes 3";

                    trigger OnAction()
                    begin
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                        //if HRLeaveApp.Find('-') then
                        //REPORT.Run(39005491, true, true, HRLeaveApp);
                    end;
                }
                action("Create Leave Ledger Entries")
                {
                    Caption = 'Create Leave Ledger Entries';
                    Image = CreateLinesFromJob;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CreateLeaveLedgerEntries;
                        Reset;
                    end;
                }
                action("&Post Leave Application")
                {
                    Caption = '&Post Leave Application';
                    ApplicationArea = all;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        objPeriod: Record "prPayroll Periods";
                        PrEmpTrans: Record "prEmployee Transactions";
                        text001: Label 'Do you want to generate a Payment Voucher for the Leave Allowance?';
                        MonthName: Text;
                        paid: Boolean;
                    begin
                        if Status = Status::Posted then Error('This Leave application has already been posted');
                        if Status <> Status::Approved then
                            Error('The Leave Status must be Approved');

                        HRSetup.Get;

                        TestField("Approved days");

                        HRLeaveTypes.Get("Leave Type");
                        if HRLeaveTypes.Recurring then begin
                            if "Approved days" > LeaveBalance then
                                Error('Approved Days cannot exceed leave Balance for the specified Period');
                        end;

                        paid := false;
                        objPeriod.Reset;
                        objPeriod.SetRange(objPeriod.Closed, false);
                        if objPeriod.Find('-') then begin
                            CurrentYr := objPeriod."Period Year";
                        end;


                        //EmployeeTrans

                        if "Request Leave Allowance" then begin
                            NotchEmp.Get("Employee No");
                            NotchTransactions.Reset;
                            NotchTransactions.SetRange(NotchTransactions."Salary Grade", NotchEmp."Salary Grade");
                            NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", NotchEmp."Salary Step");
                            if NotchTransactions.FindFirst then begin
                                repeat
                                    TransCode.Get(NotchTransactions."Transaction Code");
                                    if TransCode."Leave Allowance" then begin
                                        EmployeeTrans.Reset;
                                        EmployeeTrans.SetRange(EmployeeTrans."Employee Code", "Employee No");
                                        EmployeeTrans.SetRange(EmployeeTrans."Transaction Code", TransCode."Transaction Code");
                                        if EmployeeTrans.Find('-') then begin
                                            //REPEAT
                                            if EmployeeTrans."Period Year" = CurrentYr then begin
                                                MonthName := Format(EmployeeTrans."Payroll Period", 0, '<Month Text>');
                                                //ERROR(MonthName);
                                                //ERROR('Employee has already been paid leave allowance in the period of %1.- %2',EmployeeTrans."Payroll Period",
                                                //   EmployeeTrans."Employee Code");
                                                paid := true;
                                            end;
                                            //UNTIL EmployeeTrans.NEXT = 0;
                                        end;
                                    end;
                                until NotchTransactions.Next = 0;
                            end;
                            // end;
                            //UNTIL NotchTransactions.NEXT = 0;
                        end;

                        CalcFields("Total Annual Leave");

                        if paid then
                            Message('Employee has already been paid leave allowance in the period of %1.- %2', EmployeeTrans."Payroll Period",
                                 EmployeeTrans."Employee Code")
                        else begin

                            if "Request Leave Allowance" then begin
                                NotchEmp.Get("Employee No");
                                NotchTransactions.Reset;
                                NotchTransactions.SetRange(NotchTransactions."Salary Grade", NotchEmp."Salary Grade");
                                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", NotchEmp."Salary Step");
                                if NotchTransactions.FindFirst then begin
                                    repeat
                                        TransCode.Get(NotchTransactions."Transaction Code");
                                        if TransCode."Leave Allowance" then begin
                                            PrVital.Get;
                                            if (Date2DMY("Application Date", 1) <= PrVital."Payroll Cut Off Day") and (Date2DMY("Application Date", 2) = Date2DMY("Payroll Period", 2)) then begin
                                                PrEmpTrans.Init;
                                                PrEmpTrans."Employee Code" := "Employee No";
                                                PrEmpTrans."Transaction Code" := NotchTransactions."Transaction Code";
                                                PrEmpTrans."Payroll Period" := "Payroll Period";
                                                PrEmpTrans."Period Month" := Date2DMY("Payroll Period", 2);
                                                PrEmpTrans."Period Year" := Date2DMY("Payroll Period", 3);
                                                PrEmpTrans.Validate("Transaction Code");
                                                PrEmpTrans."Reference No" := "Application Code";
                                                PrEmpTrans.Insert;
                                                //END
                                                TransCode2.SetRange(TransCode2."Related Transaction Code", TransCode."Transaction Code");
                                                if TransCode2.FindFirst then begin
                                                    PrEmpTrans.Init;
                                                    PrEmpTrans."Employee Code" := "Employee No";
                                                    PrEmpTrans."Transaction Code" := TransCode2."Transaction Code";
                                                    NotchTrans.Reset;
                                                    NotchTrans.SetRange(NotchTrans."Salary Grade", NotchEmp."Salary Grade");
                                                    NotchTrans.SetRange(NotchTrans."Salary Step/Notch", NotchEmp."Salary Step");
                                                    NotchTrans.SetRange(NotchTrans."Transaction Code", TransCode2."Transaction Code");
                                                    if NotchTrans.FindFirst then
                                                        PrEmpTrans.Amount := NotchTrans.Amount;
                                                    PrEmpTrans."Payroll Period" := "Payroll Period";
                                                    PrEmpTrans."Period Month" := Date2DMY("Payroll Period", 2);
                                                    PrEmpTrans."Period Year" := Date2DMY("Payroll Period", 3);
                                                    PrEmpTrans.Validate("Transaction Code");
                                                    PrEmpTrans."Reference No" := "Application Code";
                                                    //PrEmpTrans.TRANSFERFIELDS(Rec);
                                                    PrEmpTrans.Insert
                                                end;
                                            end else
                                                if (Date2DMY("Application Date", 2) <> Date2DMY("Payroll Period", 2)) then begin
                                                    PrEmpTrans.Init;
                                                    PrEmpTrans."Employee Code" := "Employee No";
                                                    PrEmpTrans."Transaction Code" := NotchTransactions."Transaction Code";
                                                    PrEmpTrans."Payroll Period" := "Payroll Period";
                                                    PrEmpTrans."Period Month" := Date2DMY("Payroll Period", 2);
                                                    PrEmpTrans."Period Year" := Date2DMY("Payroll Period", 3);
                                                    PrEmpTrans.Validate("Transaction Code");
                                                    PrEmpTrans."Reference No" := "Application Code";
                                                    PrEmpTrans.Insert;
                                                    //END
                                                    TransCode2.SetRange(TransCode2."Related Transaction Code", TransCode."Transaction Code");
                                                    if TransCode2.FindFirst then begin
                                                        PrEmpTrans.Init;
                                                        PrEmpTrans."Employee Code" := "Employee No";
                                                        PrEmpTrans."Transaction Code" := TransCode2."Transaction Code";
                                                        NotchTrans.Reset;
                                                        NotchTrans.SetRange(NotchTrans."Salary Grade", NotchEmp."Salary Grade");
                                                        NotchTrans.SetRange(NotchTrans."Salary Step/Notch", NotchEmp."Salary Step");
                                                        NotchTrans.SetRange(NotchTrans."Transaction Code", TransCode2."Transaction Code");
                                                        if NotchTrans.FindFirst then
                                                            PrEmpTrans.Amount := NotchTrans.Amount;
                                                        PrEmpTrans."Payroll Period" := "Payroll Period";
                                                        PrEmpTrans."Period Month" := Date2DMY("Payroll Period", 2);
                                                        PrEmpTrans."Period Year" := Date2DMY("Payroll Period", 3);
                                                        PrEmpTrans.Validate("Transaction Code");
                                                        PrEmpTrans."Reference No" := "Application Code";
                                                        //PrEmpTrans.TRANSFERFIELDS(Rec);
                                                        PrEmpTrans.Insert
                                                    end;
                                                end;
                                        end;
                                    until NotchTransactions.Next = 0;
                                end;
                            end;
                        end;
                        //Generate PV
                        //IF CONFIRM(text001,FALSE) THEN
                        // GeneratePV;

                        ////*********////Post Leave
                        HRLeaveApp.Reset;
                        HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                        if HRLeaveApp.Find('-') then begin
                            HRLeaveApp.CreateLeaveLedgerEntries;
                        end;

                        //Dave---To notify leave applicant
                        /*
                      HREmp.GET("Employee No");
                      HREmp.TESTFIELD(HREmp."Company E-Mail");

                      //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
                      HREmailParameters.RESET;
                      HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::General);
                      IF HREmailParameters.FIND('-') THEN
                      BEGIN


                           HREmp.TESTFIELD(HREmp."Company E-Mail");
                           SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
                           HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
                           HREmailParameters.Body+' '+"Application Code"+' '+ HREmailParameters."Body 2",TRUE);
                           SMTP.Send();

                      MESSAGE('Leave applicant has been notified successfully');
                      END;

                         */

                    end;
                }
                action(" Attachments")
                {
                    Caption = ' Attachments';
                    Image = Attach;
                    Promoted = true;
                    ApplicationArea = all;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Employee No"),
                                  "Document Type" = CONST(Leave);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if Status = Status::Approved then
            PayrollPeriodEditable := true;
        if
          Status = Status::New then
            PayrollPeriodEditable := false;
        if
          Status = Status::"Pending Approval" then
            PayrollPeriodEditable := false;

        if
          Status = Status::MDApproval then
            PayrollPeriodEditable := false;

        if
          Status = Status::Resumed then
            PayrollPeriodEditable := false;

        if
          Status = Status::Canceled then
            PayrollPeriodEditable := false;

        if
          Status = Status::Posted then
            PayrollPeriodEditable := false;

        if
          Status = Status::Rejected then
            PayrollPeriodEditable := false;
        if
          Status = Status::"HOD Approval" then
            PayrollPeriodEditable := false;

        if
          Status = Status::"HR Approval" then
            PayrollPeriodEditable := false;

        if
          Status = Status::"On leave" then
            PayrollPeriodEditable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        /*xRec := Rec;
        IF Status<>Status::"Pending Approval" THEN
        BEGIN
          CurrPage.EDITABLE:=FALSE;
          CurrPage.UPDATE;
        END;
        */

        EmpDept := '';
        //PASS VALUES TO VARIABLES ON THE FORM
        FillVariables;
        //GET LEAVE STATS FOR THIS EMPLOYEE FROM THE EMPLOYEE TABLE
        GetLeaveStats("Leave Type");
        //TO PREVENT USER FROM SEEING OTHER PEOPLES LEAVE APPLICATIONS
        //SETFILTER("User ID",USERID);

        Updatecontrols;
        LeaveBalance := 0;
        LeaveApp.SetRange(LeaveApp."Employee No", Rec."Employee No");
        LeaveApp.SetFilter(LeaveApp."Leave Type", '%1|%2', 'INTERMITENT', 'ANNUAL');
        LeaveApp.SetRange(LeaveApp."Leave Period", Rec."Leave Period");
        if LeaveApp.FindFirst then begin
            Rec.CalcFields("Total Annual Leave");
            LeaveBalance := LeaveApp."Maximum Leave Days" - "Total Annual Leave";
        end;
        //CurrPage.UPDATE;

    end;

    trigger OnInit()
    begin
        NumberofPreviousAttemptsEditab := true;
        "Date of ExamEditable" := true;
        "Details of ExaminationEditable" := true;
        "Cell Phone NumberEditable" := true;
        SupervisorEditable := true;
        RequestLeaveAllowanceEditable := true;
        RelieverEditable := true;
        "Leave Allowance AmountEditable" := true;
        "Start DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Days AppliedEditable" := true;
        "Leave TypeEditable" := true;
        "Application CodeEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Leave Period" := Format(Date2DMY(WorkDate, 3));
    end;

    trigger OnOpenPage()
    var
        LeaveApp: Record "HR Leave Application";
    begin
        //CALCFIELDS("Total Annual Leave");
        //LeaveBalance:= "Maximum Leave Days" - "Total Annual Leave";
        Updatecontrols;
    end;

    var
        HREmp: Record "HR Employees";
        EmpJobDesc: Text[50];
        HRJobs: Record "HR Jobs";
        SupervisorName: Text[60];
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
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        HRLeaveApp: Record "HR Leave Application";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
        ApprovalEntries:Page "Approval Entries";
        HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        EmpName: Text[70];
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Application CodeEditable": Boolean;
        [InDataSet]
        "Leave TypeEditable": Boolean;
        [InDataSet]
        "Days AppliedEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Start DateEditable": Boolean;
        [InDataSet]
        "Leave Allowance AmountEditable": Boolean;
        [InDataSet]
        RelieverEditable: Boolean;
        [InDataSet]
        RequestLeaveAllowanceEditable: Boolean;
        [InDataSet]
        SupervisorEditable: Boolean;
        [InDataSet]
        "Cell Phone NumberEditable": Boolean;
        [InDataSet]
        "Details of ExaminationEditable": Boolean;
        [InDataSet]
        "Date of ExamEditable": Boolean;
        [InDataSet]
        NumberofPreviousAttemptsEditab: Boolean;
        Text19010232: Label 'Leave Statistics';
        Text1: Label 'Reliver Details';
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        sDate: Record Date;
        Customized: Record "HR Calendar List";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        ApprovalDate: Boolean;
        FileName: Text[100];
        LeaveBalance: Decimal;
        LeaveApp: Record "HR Leave Application";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        NotchTransactions: Record "Salary Step/Notch Transactions";
        NotchEmp: Record "HR Employees";
        TransCode: Record "prTransaction Codes";
        TransCode2: Record "prTransaction Codes";
        PrVital: Record "prVital Setup Info";
        NotchTrans: Record "Salary Step/Notch Transactions";
        EmployeeTrans: Record "prEmployee Transactions";
        CurrentYr: Integer;
        PayrollPeriodEditable: Boolean;

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
            //HREmp.SETFILTER(HREmp."Leave Type Filter",LeaveType);
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
    var
        hrrel: Record "HR Leave Reliver";
    begin
        TestField("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");

        TestField(Supervisor);
        hrrel.SetRange(hrrel."Application No.", "Application Code");
        if hrrel.FindSet then
            repeat
                hrrel.TestField("Reliver No.");
            until hrrel.Next = 0;
    end;

    [Scope('OnPrem')]
    procedure Updatecontrols()
    begin

        if Status = Status::New then begin
            "Application CodeEditable" := false;
            "Leave TypeEditable" := true;
            "Days AppliedEditable" := true;
            "Responsibility CenterEditable" := true;
            "Start DateEditable" := true;
            "Leave Allowance AmountEditable" := true;
            RelieverEditable := true;
            RequestLeaveAllowanceEditable := false;
            SupervisorEditable := true;
            "Cell Phone NumberEditable" := true;
            //CurrForm."E-mail Address".EDITABLE:=TRUE;
            "Details of ExaminationEditable" := true;
            "Date of ExamEditable" := true;
            NumberofPreviousAttemptsEditab := true;
        end else
            if Status = Status::"Pending Approval" then begin
                "Application CodeEditable" := true;
                "Leave TypeEditable" := false;
                "Days AppliedEditable" := false;
                "Responsibility CenterEditable" := false;
                "Start DateEditable" := false;
                "Leave Allowance AmountEditable" := false;
                RelieverEditable := false;
                RequestLeaveAllowanceEditable := true;
                SupervisorEditable := false;
                "Cell Phone NumberEditable" := false;
                //CurrForm."E-mail Address".EDITABLE:=FALSE;
                "Details of ExaminationEditable" := false;
                "Date of ExamEditable" := false;
                NumberofPreviousAttemptsEditab := false;
            end;
    end;

    [Scope('OnPrem')]
    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No", "Employee No");
        if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
            repeat
                LeaveFamily.SetRange(LeaveFamily.Code, LeaveFamilyEmployees.Family);
                LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave", '>0');
                if LeaveFamily.FindSet then //find the status other employees on the same leave family
                  begin
                    Employees.SetRange(Employees."No.", LeaveFamilyEmployees."Employee No");
                    Employees.SetRange(Employees."Leave Status", Employees."Leave Status"::" ");
                    if Employees.Count > LeaveFamily."Max Employees On Leave" then
                        Error('The Maximum number of employees on leave for this family has been exceeded, Contact the HR manager for more information');
                end
            until LeaveFamilyEmployees.Next = 0;
    end;

    [Scope('OnPrem')]
    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    [Scope('OnPrem')]
    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[20]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    [Scope('OnPrem')]
    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        HRSetup.Find('-');
        HRSetup.TestField(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;

        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
         */

    end;

    [Scope('OnPrem')]
    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('-1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    [Scope('OnPrem')]
    procedure CreateLeaveLedgerEntries()
    begin
        TestField("Approved days");
        HRSetup.Reset;
        if HRSetup.Find('-') then begin

            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DeleteAll;
            //Dave
            //HRSetup.TESTFIELD(HRSetup."Leave Template");
            //HRSetup.TESTFIELD(HRSetup."Leave Batch");

            HREmp.Get("Employee No");
            HREmp.TestField(HREmp."Company E-Mail");

            //POPULATE JOURNAL LINES

            "LineNo." := 10000;
            LeaveGjline.Init;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := '2013';
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Employee No";
            LeaveGjline.Validate(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := Today;
            LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
            LeaveGjline."Leave Approval Date" := Today;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := "Leave Type";
            //------------------------------------------------------------
            //HRSetup.RESET;
            //HRSetup.FIND('-');
            HRSetup.TestField(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := "Approved days";
            LeaveGjline."No. of days (Allw)" := "Approved days";
            if LeaveGjline."No. of Days" <> 0 then
                LeaveGjline.Insert(true);


            //Post Journal
            LeaveGjline.Reset;
            LeaveGjline.SetRange("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SetRange("Journal Batch Name", HRSetup."Leave Batch");
            if LeaveGjline.Find('-') then begin
                CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
            end;
            Status := Status::Posted;
            Modify;
            CurrPage.Update;

            /*END ELSE BEGIN
            ERROR('You must specify no of days');
            END;
            END;*/
            //NotifyApplicant;
        end;

    end;

    [Scope('OnPrem')]
    procedure NotifyApplicant()
    begin
        HREmp.Get("Employee No");
        HREmp.TestField(HREmp."Company E-Mail");

        //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        HREmailParameters.Reset;
        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::General);
        if HREmailParameters.Find('-') then begin

            EmailAdd.Add(HREmp."Company E-Mail");
            HREmp.TestField(HREmp."Company E-Mail");
            SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", EmailAdd,
            HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
            HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", true);
            SMTP.Send();


            Message('Leave applicant has been notified successfully');
        end;
    end;

    var
        EmailAdd: List of [Text];
}

