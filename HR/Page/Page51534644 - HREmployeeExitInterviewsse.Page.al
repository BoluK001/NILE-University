page 51534644 "HR Employee Exit Interviews se"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Interview No"; "Exit Interview No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin



                        if HREmp.Get("Employee No.") then begin
                            JobTitle := HREmp."Job Title";
                            sUserID := HREmp."User ID";
                        end else begin
                            JobTitle := '';
                            sUserID := '';
                            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                        end;

                        RecalcDates;
                        EmployeeNoOnAfterValidate;
                    end;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(JobTitle; JobTitle)
                {
                    Caption = 'Job Title';
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field(DService; DService)
                {
                    Caption = 'Length of Service';
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                /* field("HREmpForm.GetSupervisor(sUserID)"; HREmpForm.GetSupervisor(sUserID))
                 {
                     Caption = 'Supervisor';
                     Editable = false;
                     ApplicationArea = all;
                     Importance = Promoted;
                 }  */   //jj22092022
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = all;
                }
                field("Notice Period Served"; "Notice Period Served")
                {
                    Caption = 'Notice Period Served(Days)';
                    ApplicationArea = all;
                }
                field("Date Of Interview"; "Date Of Interview")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Interview Done By"; "Interview Done By")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Interviewer Name"; "Interviewer Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Annual Leave Owed"; "Annual Leave Owed")
                {
                    ApplicationArea = all;
                }
                field("Nature of Separation"; "Nature of Separation")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Reason For Leaving (Other)"; "Reason For Leaving (Other)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; "Date Of Leaving")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Worked more than 1 position"; "Worked more than 1 position")
                {
                    ApplicationArea = all;
                }
                field("Re Employ In Future"; "Re Employ In Future")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("If Yes,in what areas?"; "If Yes,in what areas?")
                {
                    ApplicationArea = all;
                }
                field("Disciplinary Details"; "Disciplinary Details")
                {
                    ApplicationArea = all;
                }
                field("Recommendations/Comments"; "Recommendations/Comments")
                {
                    Caption = 'Recommendations';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field(Comment; Comment)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Form Submitted"; "Form Submitted")
                {
                    ApplicationArea = all;
                }
            }
            part(SF; "HR Asset Return Form")
            {
                Caption = 'Misc Articles';
                SubPageLink = "Employee No." = FIELD("Employee No.");
            }
            group(Control11)
            {
                ShowCaption = false;
                part(Control12; "HR Entitlement Lines")
                {
                    SubPageLink = "Application No." = FIELD("Exit Interview No");
                }
                part(Control13; "HR Entitlement CardPart")
                {
                    Provider = Control12;
                    SubPageLink = "Application No." = FIELD("Application No.");
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755010; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action(Form)
                {
                    Caption = 'Form';
                    Image = Form;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if DoclLink.Get("Employee No.", 'Exit Interview') then begin
                            DoclLink.PlaceFilter(true, DoclLink."Employee No");
                            PAGE.RunModal(50050, DoclLink);
                        end else begin
                            DoclLink.Init;
                            DoclLink."Employee No" := "Employee No.";
                            DoclLink."Document Description" := 'Exit Interview';
                            DoclLink.Insert;
                            Commit;
                            DoclLink.PlaceFilter(true, DoclLink."Employee No");
                            PAGE.RunModal(50050, DoclLink);
                        end;
                    end;
                }
                action("<Page HR Exit Interview Checklist")
                {
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Exit Interview Checklist";
                    RunPageLink = "Exit Interview No" = FIELD("Exit Interview No"),
                                  "Employee No" = FIELD("Employee No.");
                    Visible = false;
                }
                action("Exit Form")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("Exit Interview No", "Exit Interview No");
                        REPORT.Run(51534528, true, true, Rec);
                        Reset;
                    end;
                }
                action("<Hr Clearance Exit>")
                {
                    Caption = 'Clearance Exit';
                    Image = "Report";
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("Exit Interview No", "Exit Interview No");
                        REPORT.RUN(51534524, true, true, Rec);
                        Reset;
                    end;
                }
                action("Exit Attachment")
                {
                    ApplicationArea = all;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("Employee No."),
                                  "Document Type" = CONST(Exit);
                    Visible = false;
                }
                action("Exit Entitlement")
                {
                    Image = "Exit";
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("Exit Interview No", "Exit Interview No");
                        REPORT.Run(51534526, true, true, Rec);
                        Reset;
                    end;
                }
                action("Send to HR")
                {
                    Image = SendConfirmation;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Status = Status::"Pending Approval" then
                            exit;
                        Status := Status::"Pending Approval";
                        Modify;
                        Message('Document has been sent to HR');
                    end;
                }
                action("Test Attachment")
                {
                    Caption = 'Attachment';
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Page "Attachment Test";
                    //RunPageLink = "Employee No" = FIELD("Employee No."),"Application No" = FIELD("Exit Interview No"),"Document Type" = CONST(Exit), "Folder Type" = CONST(HR);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get("Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;


        SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "User Id" := UserId;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record "HR Employees";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HR Employee Card";
        sUserID: Code[50];
        DoclLink: Record "HR Employee Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        Misc: Record "Misc. Article Information";
        Text19062217: Label 'Misc Articles';

    [Scope('OnPrem')]
    procedure RecalcDates()
    begin
        //Recalculate Important Dates
        /*IF (HREmp."Date Of Leaving the Company" = 0D) THEN BEGIN
          IF  (HREmp."Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge(HREmp."Date Of Birth",TODAY);
          IF  (HREmp."Date Of Joining the Company" <> 0D) THEN
          DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",TODAY);
          IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
          DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",TODAY);
          IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
          DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",TODAY);
          //MODIFY;
        END ELSE BEGIN
          IF  (HREmp."Date Of Birth" <> 0D) THEN
          DAge:= Dates.DetermineAge(HREmp."Date Of Birth",HREmp."Date Of Leaving the Company");
          IF  (HREmp."Date Of Joining the Company" <> 0D) THEN
          DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",HREmp."Date Of Leaving the Company");
          IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
          DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving the Company");
          IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
          DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving the Company");
          //MODIFY;
        END;
        *///lateef

    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        FilterGroup := 2;
        Misc.SetRange(Misc."Employee No.", "Employee No.");
        FilterGroup := 0;
        if Misc.Find('-') then;
        CurrPage.Update(false);
    end;
}

