report 51534715 "HR Appraisal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRAppraisal.rdlc';

    dataset
    {
        dataitem("HR Appraisal Goal Setting H"; "HR Appraisal Goal Setting H")
        {
            column(AppraisalNo_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Appraisal No")
            {
            }
            column(AppraisalPeriod_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Appraisal Period")
            {
            }
            column(EmployeeNo_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Employee No")
            {
            }
            column(EmployeeName_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Employee Name")
            {
            }
            column(JobTitle_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Job Title")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(EmployementDate; EmployementDate)
            {
            }
            column(EvaluationPeriodStart_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Evaluation Period Start")
            {
            }
            column(EvaluationPeriodEnd_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Evaluation Period End")
            {
            }
            column(AppraisalDate_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Appraisal Date")
            {
            }
            column(Unit_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H".Unit)
            {
            }
            column(CompanyScore_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Company Score")
            {
            }
            column(BonusPointAppraiser_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Bonus Point Appraiser")
            {
            }
            column(BonusPointMgt_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Bonus Point Mgt")
            {
            }
            column(BonusPointAppraiserRemarks_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Bonus Point Appraiser Remarks")
            {
            }
            column(BonusPointMgtRemarks_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Bonus Point Mgt Remarks")
            {
            }
            column(RecommendationAppraiser_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Recommendation Appraiser")
            {
            }
            column(RecommendationAppraiserRemar_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Recommendation 2")
            {
            }
            column(RecommendationMgt_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Recommendation Mgt")
            {
            }
            column(RecommendationMgtRemarks_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Recommendation 3")
            {
            }
            column(DevelopmentRequirements_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Development Requirements Appra")
            {
            }
            column(DevelopmentRequirementsMgt_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Development Requirements Mgt")
            {
            }
            column(CommentsAppraisee_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Comments Appraisee")
            {
            }
            column(CommentsAppraiser_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Comments Appraiser")
            {
            }
            column(CommentsMgt_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Comments Mgt")
            {
            }
            column(DevelopmentPlans_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."Development Plans")
            {
            }
            column(KPIsAppraiseeScore_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."KPIs Appraisee Score")
            {
            }
            column(KPIsAppraiserScore_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."KPIs Appraiser Score")
            {
            }
            column(KPIsMgtScore_HRAppraisalGoalSettingH; "HR Appraisal Goal Setting H"."KPIs Mgt Score")
            {
            }
            dataitem("HR Appraisal Evaluations"; "HR Appraisal Evaluations")
            {
                DataItemLink = "Employee No" = FIELD("Employee No"), "Appraisal Period" = FIELD("Appraisal Period");
                column(AppraiseeScore_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Achievement % (Self).")
                {
                }
                column(Category_HRAppraisalEvaluations; "HR Appraisal Evaluations".Category)
                {
                }
                column(Group_HRAppraisalEvaluations; "HR Appraisal Evaluations".Group)
                {
                }
                column(AppraiserScore_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Achievement % (Manager).")
                {
                }
                column(AppraiserRemarks_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Appraiser Remarks")
                {
                }
                column(MsgReviewRemarks_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Msg Review Remarks")
                {
                }
                column(MsgReviewScore_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Mgt Review Score")
                {
                }
                column(EvaluationCode_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Evaluation Code")
                {
                }
                column(LineNo_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Line No")
                {
                }
                column(PerformanceScoreAppraisee; PerformanceScoreAppraisee)
                {
                }
                column(PerformanceScoreAppraiser; PerformanceScoreAppraiser)
                {
                }
                column(PerformanceScoreMgt; PerformanceScoreMgt)
                {
                }
                column(KPIsAppraiseeScore; KPIsAppraiseeScore)
                {
                }
                column(KPIsAppraiserScore; KPIsAppraiserScore)
                {
                }
                column(AchievementManager_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Achievement % (Manager).")
                {
                }
                column(KRASelf_HRAppraisalEvaluations; "HR Appraisal Evaluations"."KRA (Self)")
                {
                }
                column(KRAManager_HRAppraisalEvaluations; "HR Appraisal Evaluations"."KRA (Manager)")
                {
                }
                column(RatingSelf_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Rating (Self)")
                {
                }
                column(RatingManager_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Rating (Manager)")
                {
                }
                column(AchievementSelf_HRAppraisalEvaluations; "HR Appraisal Evaluations"."Achievement % (Self).")
                {
                }
                column(KPIsMgtScore; KPIsMgtScore)
                {
                }
                dataitem("HR Appraisal Evaluation Descr"; "HR Appraisal Evaluation Descri")
                {
                    DataItemLink = "Evaluation Area" = FIELD("Evaluation Code");
                    column(EvaluationDescription_HRAppraisalEvaluationDescri; "HR Appraisal Evaluation Descr"."Evaluation Description")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*
                        KPIsAppraiseeScore:="HR Appraisal Goal Setting H"."KPIs Appraisee Score";
                        KPIsAppraiserScore:="HR Appraisal Goal Setting H"."KPIs Appraiser Score";
                        KPIsMgtScore:="HR Appraisal Goal Setting H"."KPIs Mgt Score";
                        */

                    end;
                }
            }
            dataitem("HR Training Development Plan"; "HR Training Development Plan L")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if HrEmp.Get("HR Appraisal Goal Setting H"."Employee No") then
                    EmployementDate := HrEmp."Date Of Joining the Company";
                EvaluationLines.Reset;
                EvaluationLines.SetRange(EvaluationLines."Employee No", "HR Appraisal Goal Setting H"."Employee No");
                EvaluationLines.SetRange(EvaluationLines."Appraisal Period", "HR Appraisal Goal Setting H"."Appraisal Period");
                if EvaluationLines.FindSet then
                    repeat
                        PerformanceScoreAppraisee += EvaluationLines."Achievement % (Self).";
                        PerformanceScoreAppraiser += EvaluationLines."Achievement % (Manager).";
                        PerformanceScoreMgt += EvaluationLines."Mgt Review Score";
                    until EvaluationLines.Next = 0;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        HrEmp: Record "HR Employees";
        EmployementDate: Date;
        PerformanceScoreAppraisee: Decimal;
        PerformanceScoreAppraiser: Decimal;
        PerformanceScoreMgt: Decimal;
        KPIsAppraiseeScore: Decimal;
        KPIsAppraiserScore: Decimal;
        KPIsMgtScore: Decimal;
        KPILines: Record "HR Appraisal Goal Setting L";
        EvaluationLines: Record "HR Appraisal Evaluations";
}

