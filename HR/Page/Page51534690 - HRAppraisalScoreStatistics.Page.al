page 51534690 "HR Appraisal Score Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Job Level"; "Job Level")
                {
                    ApplicationArea = All;
                }
                field("HRSETUP.""Appraisal Period"""; HRSETUP."Appraisal Period")
                {
                    Caption = 'Appraisal Period';
                    ApplicationArea = All;
                }
            }
            group(Control7)
            {
                ShowCaption = false;
                label("First Half")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(TotalFirst; TotalFirst)
                {
                    Caption = 'Total First';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                group(Behavioural)
                {
                    Caption = 'Behavioural';
                    field("Functional Assessment"; HRAppraisalGoalSettingHFirst."Functional Ass. First Half")
                    {
                        ApplicationArea = All;
                    }
                    field("Organisational Capability"; HRAppraisalGoalSettingHFirst."Org. Capability First Half")
                    {
                        ApplicationArea = All;
                    }
                    field("Management Competencies"; HRAppraisalGoalSettingHFirst."Mgt. Competencies First Half")
                    {
                        ApplicationArea = All;
                    }
                    field("Behavioural Aggregate"; HRAppraisalGoalSettingHFirst."Behavioural First Half Score")
                    {
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field(BehavFirst; BehavFirst)
                    {
                        Caption = 'Behavioural (40%)';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
                group(KPI)
                {
                    field(Financial; HRAppraisalGoalSettingHFirst."Financial First Half")
                    {
                        ApplicationArea = All;
                    }
                    field(Customer; HRAppraisalGoalSettingHFirst."Customer First Half")
                    {
                        ApplicationArea = All;
                    }
                    field("Internal Process"; HRAppraisalGoalSettingHFirst."Internal Process First Half")
                    {
                        ApplicationArea = All;
                    }
                    field("Learning Growth"; HRAppraisalGoalSettingHFirst."Learning Growth First Half")
                    {
                    }
                    field("KPI ScoreFirst"; HRAppraisalGoalSettingHFirst."KPI First Half Aggregate")
                    {
                        Caption = 'Aggregate Score';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field(KPIFirst; KPIFirst)
                    {
                        Caption = 'KPI (60%)';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
                label("Second Half")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(TotalSecond; TotalSecond)
                {
                    Caption = 'Total Second';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                group(BehaviouralSec)
                {
                    Caption = 'Behavioural';
                    field(FunctionalSec; HRAppraisalGoalSettingHSecond."Functional Ass. Second Half")
                    {
                        Caption = 'Functional Assessment';
                        ApplicationArea = All;
                    }
                    field(OrganisationSec; HRAppraisalGoalSettingHSecond."Org. Capability Second Half")
                    {
                        Caption = 'Organisational Capability';
                        ApplicationArea = All;
                    }
                    field(MgtSecond; HRAppraisalGoalSettingHSecond."Mgt. Competencies Second Half")
                    {
                        Caption = 'Management Competencies';
                        ApplicationArea = All;
                    }
                    field(BehSec; HRAppraisalGoalSettingHSecond."Behavioural Second Half Score")
                    {
                        Caption = 'Behavioural Aggregate';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field(BehavSecond; BehavSecond)
                    {
                        Caption = 'Behavioural (40%)';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
                group(KPISec)
                {
                    Caption = 'KPI';
                    field(FinancialSec; HRAppraisalGoalSettingHSecond."Financial Second Half")
                    {
                        Caption = 'Financial';
                        ApplicationArea = All;
                    }
                    field(CustomerSec; HRAppraisalGoalSettingHSecond."Customer Second Half")
                    {
                        Caption = 'Customer';
                        ApplicationArea = All;
                    }
                    field(InternalSec; HRAppraisalGoalSettingHSecond."Internal Process Second Half")
                    {
                        Caption = 'Internal Process';
                        ApplicationArea = All;
                    }
                    field(LearningGrowth; HRAppraisalGoalSettingHSecond."Learning Growth Second Half")
                    {
                        Caption = 'Learning Growth';
                        ApplicationArea = All;
                    }
                    field(KPISecd; HRAppraisalGoalSettingHSecond."KPI Second Half Aggregate")
                    {
                        Caption = 'Aggregate Score';
                        Style = StandardAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field(KPISecond; KPISecond)
                    {
                        Caption = 'KPI (60%)';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        HRSETUP.Get;
        HRAppraisalGoalSettingHFirst.SetRange(HRAppraisalGoalSettingHFirst."Appraisal Period", HRSETUP."Appraisal Period");
        HRAppraisalGoalSettingHFirst.SetRange("Appraisal Half", HRAppraisalGoalSettingHFirst."Appraisal Half"::First);
        HRAppraisalGoalSettingHFirst.SetRange(HRAppraisalGoalSettingHFirst."Employee No", "No.");
        HRAppraisalGoalSettingHFirst.SetAutoCalcFields("Functional Ass. First Half", "Org. Capability First Half", "Mgt. Competencies First Half", "Financial First Half",
        "Customer First Half", "Internal Process First Half", "Learning Growth First Half", "Behavioural First Half Score", "KPI First Half Aggregate");
        if HRAppraisalGoalSettingHFirst.FindFirst then begin
            if "Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then             //add an option field to emp table 'level group'
                BehavFirst := (HRAppraisalGoalSettingHFirst."Behavioural First Half Score" / 125) * 40
            else
                if "Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'AS', 'SNR-AS', 'CS'] then
                    BehavFirst := (HRAppraisalGoalSettingHFirst."Behavioural First Half Score" / 100) * 40;

            KPIFirst := (HRAppraisalGoalSettingHFirst."KPI First Half Aggregate" / 100) * 60;
            TotalFirst := BehavFirst + KPIFirst;
        end;


        HRSETUP.Get;
        HRAppraisalGoalSettingHSecond.SetRange(HRAppraisalGoalSettingHSecond."Appraisal Period", HRSETUP."Appraisal Period");
        HRAppraisalGoalSettingHSecond.SetRange("Appraisal Half", HRAppraisalGoalSettingHSecond."Appraisal Half"::Second);
        HRAppraisalGoalSettingHSecond.SetRange(HRAppraisalGoalSettingHSecond."Employee No", "No.");
        HRAppraisalGoalSettingHSecond.SetAutoCalcFields("Functional Ass. Second Half", "Org. Capability Second Half", "Mgt. Competencies Second Half", "Financial Second Half",
        "Customer Second Half", "Internal Process Second Half", "Learning Growth Second Half", "Behavioural Second Half Score", "KPI Second Half Aggregate");
        if HRAppraisalGoalSettingHSecond.FindFirst then begin
            if "Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                BehavSecond := (HRAppraisalGoalSettingHSecond."Behavioural Second Half Score" / 125) * 40
            else
                if "Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'AS', 'SNR-AS', 'CS'] then
                    BehavSecond := (HRAppraisalGoalSettingHSecond."Behavioural Second Half Score" / 100) * 40;

            KPISecond := (HRAppraisalGoalSettingHSecond."KPI Second Half Aggregate" / 100) * 60;
            TotalSecond := BehavSecond + KPISecond;
        end;
    end;

    var
        HRAppraisalGoalSettingHFirst: Record "HR Appraisal Goal Setting H";
        HRAppraisalGoalSettingHSecond: Record "HR Appraisal Goal Setting H";
        HRSETUP: Record "HR Setup";
        BehavFirst: Decimal;
        BehavSecond: Decimal;
        KPIFirst: Decimal;
        KPISecond: Decimal;
        TotalFirst: Decimal;
        TotalSecond: Decimal;
}

