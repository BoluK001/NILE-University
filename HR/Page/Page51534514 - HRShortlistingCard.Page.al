page 51534514 "HR Shortlisting Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlist';
    SourceTable = "HR Employee Requisitions";
    SourceTableView = WHERE(Status = CONST(Approved),
                            Closed = CONST(false));

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = true;
                field("Job ID"; "Job ID")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Job Description"; "Job Description")
                {
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Requisition Date"; "Requisition Date")
                {
                    Editable = "Requisition DateEditable";
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Priority; Priority)
                {
                    Editable = PriorityEditable;
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Vacant Positions"; "Vacant Positions")
                {
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Required Positions"; "Required Positions")
                {
                    Editable = "Required PositionsEditable";
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            part(Shortlisted; "HR Shortlisting Lines")
            {
                Editable = ShortlistedEditable;
                SubPageLink = "Employee Requisition No" = FIELD("Requisition No."),
                              Qualified = CONST(true);
            }
        }
        area(factboxes)
        {
            part(Control1102755003; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755001; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("&ShortList Applicants")
                {
                    Caption = '&ShortList Applicants';
                    Image = SelectField;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRJobRequirements.Reset;
                        HRJobRequirements.SetRange(HRJobRequirements."Job Id", "Job ID");
                        if HRJobRequirements.Count = 0 then begin
                            Message('Job Requirements for the job ' + "Job ID" + ' have not been setup');
                            exit;
                        end else begin

                            //GET JOB REQUIREMENTS
                            HRJobRequirements.Reset;
                            HRJobRequirements.SetRange(HRJobRequirements."Job Id", "Job ID");

                            //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants.Reset;
                            HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Employee Requisition No", "Requisition No.");
                            HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Shortlist Type", HRShortlistedApplicants."Shortlist Type"::"Application Stage");
                            HRShortlistedApplicants.DeleteAll;

                            //GET JOB APPLICANTS
                            HRJobApplications.Reset;
                            HRJobApplications.SetRange(HRJobApplications."Employee Requisition No", "Requisition No.");
                            if HRJobApplications.Find('-') then begin
                                repeat
                                    Qualified := true;
                                    if HRJobRequirements.Find('-') then begin
                                        StageScore := 0;
                                        Score := 0;
                                        repeat
                                            //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                            AppQualifications.Reset;
                                            AppQualifications.SetRange(AppQualifications."Application No", HRJobApplications."Application No");
                                            AppQualifications.SetRange(AppQualifications."Qualification Code", HRJobRequirements."Qualification Code");
                                            if AppQualifications.Find('-') then begin
                                                Score := Score + AppQualifications."Score ID";
                                                if AppQualifications."Score ID" < HRJobRequirements."Desired Score" then
                                                    Qualified := false;
                                            end else begin
                                                Qualified := false;
                                            end;

                                        until HRJobRequirements.Next = 0;
                                    end;

                                    HRShortlistedApplicants."Entry No." := 0;
                                    HRShortlistedApplicants."Employee Requisition No" := "Requisition No.";
                                    HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                    HRShortlistedApplicants."Stage Score" := Score;
                                    HRShortlistedApplicants.Qualified := Qualified;
                                    HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                    HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                    HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                    HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                    HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                    HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                    HRShortlistedApplicants."Shortlist Type" := HRShortlistedApplicants."Shortlist Type"::"Application Stage";
                                    HRShortlistedApplicants.Insert;

                                until HRJobApplications.Next = 0;
                            end;
                            //MARK QUALIFIED APPLICANTS AS QUALIFIED
                            HRShortlistedApplicants.SetRange(HRShortlistedApplicants.Qualified, true);
                            if HRShortlistedApplicants.Find('-') then
                                repeat
                                    HRJobApplications.Get(HRShortlistedApplicants."Job Application No");
                                    HRJobApplications.Qualified := true;
                                    HRJobApplications.Modify;
                                until HRShortlistedApplicants.Next = 0;
                            /*
                            RecCount:= 0;
                            MyCount:=0;
                            StageShortlist.RESET;
                            StageShortlist.SETRANGE(StageShortlist."Need Code","Need Code");
                            StageShortlist.SETRANGE(StageShortlist."Stage Code","Stage Code");

                            IF StageShortlist.FIND('-') THEN BEGIN
                            RecCount:=StageShortlist.COUNT ;
                            StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                            StageShortlist.ASCENDING;
                            REPEAT
                            MyCount:=MyCount + 1;
                            StageShortlist.Position:=RecCount - MyCount;
                            StageShortlist.MODIFY;
                            UNTIL StageShortlist.NEXT = 0;
                            END;
                            */
                            Message('%1', 'Shortlisting Competed Successfully.');

                        end;
                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');

                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Report "HR Shortlisted Candidates";

                    trigger OnAction()
                    begin
                        HREmpReq.Reset;
                        HREmpReq.SetRange(HREmpReq."Requisition No.", "Requisition No.");
                        if HREmpReq.Find('-') then
                            REPORT.Run(51534526, true, true, HREmpReq);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Required PositionsEditable" := true;
        PriorityEditable := true;
        ShortlistedEditable := true;
        "Requisition DateEditable" := true;
        "Job IDEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        HRJobRequirements: Record "HR Job Requirements";
        AppQualifications: Record "HR Applicant Qualifications";
        HRJobApplications: Record "HR Job Applications";
        Qualified: Boolean;
        StageScore: Decimal;
        HRShortlistedApplicants: Record "HR Shortlisted Applicants";
        MyCount: Integer;
        RecCount: Integer;
        HREmpReq: Record "HR Employee Requisitions";
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        ShortlistedEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        Text19057439: Label 'Short Listed Candidates';

    [Scope('OnPrem')]
    procedure UpdateControls()
    begin

        if Status = Status::New then begin
            "Job IDEditable" := true;
            "Requisition DateEditable" := true;
            ShortlistedEditable := true;
            PriorityEditable := true;
            "Required PositionsEditable" := true;
        end else begin
            "Job IDEditable" := false;
            "Requisition DateEditable" := false;
            ShortlistedEditable := false;
            PriorityEditable := false;
            "Required PositionsEditable" := false;
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}

