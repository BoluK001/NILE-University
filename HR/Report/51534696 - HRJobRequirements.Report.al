report 51534696 "HR Job Requirements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobRequirements.rdlc';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + Format(CurrReport.PageNo))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(HR_Jobs__Job_ID_; "Job ID")
            {
            }
            column(HR_Jobs__Job_Description_; "Job Title")
            {
            }
            column(HR_Jobs__Main_Objective_; "Main Objective")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(Job_RequirementsCaption; Job_RequirementsCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Jobs__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(HR_Jobs__Job_Description_Caption; FieldCaption("Job Title"))
            {
            }
            column(HR_Jobs__Main_Objective_Caption; FieldCaption("Main Objective"))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job Id" = FIELD ("Job ID");
                DataItemTableView = SORTING ("Job Id", "Qualification Type", "Qualification Code");
                column(JobId_HRJobRequirements; "HR Job Requirements"."Job Id")
                {
                    IncludeCaption = true;
                }
                column(QualificationType_HRJobRequirements; "HR Job Requirements"."Qualification Type")
                {
                    IncludeCaption = true;
                }
                column(QualificationCode_HRJobRequirements; "HR Job Requirements"."Qualification Code")
                {
                    IncludeCaption = true;
                }
                column(Priority_HRJobRequirements; "HR Job Requirements".Priority)
                {
                    IncludeCaption = true;
                }
                column(ScoreID_HRJobRequirements; "HR Job Requirements"."Score ID")
                {
                    IncludeCaption = true;
                }
                column(Needcode_HRJobRequirements; "HR Job Requirements"."Need code")
                {
                    IncludeCaption = true;
                }
                column(StageCode_HRJobRequirements; "HR Job Requirements"."Stage Code")
                {
                    IncludeCaption = true;
                }
                column(Mandatory_HRJobRequirements; "HR Job Requirements".Mandatory)
                {
                    IncludeCaption = true;
                }
                column(DesiredScore_HRJobRequirements; "HR Job Requirements"."Desired Score")
                {
                    IncludeCaption = true;
                }
                column(TotalStageDesiredScore_HRJobRequirements; "HR Job Requirements"."Total (Stage)Desired Score")
                {
                    IncludeCaption = true;
                }
                column(QualificationDescription_HRJobRequirements; "HR Job Requirements"."Qualification Description")
                {
                    IncludeCaption = true;
                }
            }
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

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: Label 'HR Jobs';
        Job_RequirementsCaptionLbl: Label 'Job Requirements';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        PageConst: Label 'Page';
        NameCaptionLbl: Label 'Name';
}

