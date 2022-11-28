page 51534666 "HR Shortlisting Card INT"
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
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Job Description"; "Job Description")
                {
                    Enabled = false;
                    ApplicationArea = all;
                    Importance = Promoted;
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
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            part(Shortlisted; "HR Shortlisting Lines INT")
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
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRShortlistedApplicants.Reset;
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Employee Requisition No", "Requisition No.");
                        HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Shortlist Type", HRShortlistedApplicants."Shortlist Type"::"Interview Stage");
                        HRShortlistedApplicants.DeleteAll;


                        HRInterviewEvaluation.SetCurrentKey("Requisition No.");
                        HRInterviewEvaluation.SetRange(HRInterviewEvaluation."Requisition No.", "Requisition No.");
                        if "Experience Level" = "Experience Level"::"0-4 Years" then
                            HRInterviewEvaluation.SetAutoCalcFields(HRInterviewEvaluation."Interview Assessment")
                        else
                            HRInterviewEvaluation.SetAutoCalcFields(HRInterviewEvaluation."Total Evaluation Score");
                        if HRInterviewEvaluation.FindFirst then begin
                            repeat
                                Qualified := false;
                                if (HRInterviewEvaluation."Total Evaluation Score" >= Score) or (HRInterviewEvaluation."Interview Assessment" >= Score) then begin
                                    //MESSAGE('%1..%2',HRInterviewEvaluation."Total Evaluation Score",HRInterviewEvaluation."Interview Assessment");
                                    Qualified := true;
                                    HRInterviewEvaluation."Recommend for Stage 2" := true;
                                    HRInterviewEvaluation.Modify;

                                    //Insert Shortlisted Applicants
                                    HRShortlistedApplicants.Init;
                                    HRShortlistedApplicants."Entry No." := 0;
                                    HRShortlistedApplicants."Employee Requisition No" := "Requisition No.";
                                    HRShortlistedApplicants."Interview No." := HRInterviewEvaluation."Interview No.";
                                    //HRShortlistedApplicants."Stage Score":=Score;
                                    if HRInterviewEvaluation."Total Evaluation Score" <> 0 then
                                        HRShortlistedApplicants."Stage Score" := HRInterviewEvaluation."Total Evaluation Score"
                                    else
                                        HRShortlistedApplicants."Stage Score" := HRInterviewEvaluation."Interview Assessment";
                                    HRShortlistedApplicants.Qualified := Qualified;
                                    HRShortlistedApplicants."First Name" := HRInterviewEvaluation."First Name";
                                    HRShortlistedApplicants."Middle Name" := HRInterviewEvaluation."Middle Name";
                                    HRShortlistedApplicants."Last Name" := HRInterviewEvaluation."Last Name";
                                    //HRShortlistedApplicants."ID No":=HRInterviewEvaluation."ID Number";
                                    //HRShortlistedApplicants.Gender:=HRIntrviewEvaluation.Gender;
                                    //HRShortlistedApplicants."Marital Status":=HRJobApplications."Marital Status";
                                    HRShortlistedApplicants."Shortlist Type" := HRShortlistedApplicants."Shortlist Type"::"Interview Stage";
                                    HRShortlistedApplicants.Insert;

                                    //Qualified (Interview)

                                    HRJobApplications.Get(HRInterviewEvaluation."Application No.");
                                    HRJobApplications."Qualified (Interview)" := true;
                                    HRJobApplications.Modify;
                                end;
                            until HRInterviewEvaluation.Next = 0;
                        end;


                        Message('%1', 'Shortlisting Competed Successfully.');
                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintReport;
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
        HRInterviewEvaluation: Record "Hr Interview Evaluation";

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

