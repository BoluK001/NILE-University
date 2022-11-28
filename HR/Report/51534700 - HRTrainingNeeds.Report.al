report 51534700 "HR Training Needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTrainingNeeds.rdlc';

    dataset
    {
        dataitem("HR Training Needs"; "HR Training Needs")
        {
            RequestFilterFields = "Code", Closed, "Global Dimension 2 Code";
            column(Location_HRTrainingNeeds; "HR Training Needs".Location)
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_HRTrainingNeeds; "HR Training Needs"."Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            column(Closed_HRTrainingNeeds; "HR Training Needs".Closed)
            {
                IncludeCaption = true;
            }
            column(QualificationCode_HRTrainingNeeds; "HR Training Needs"."Qualification Code")
            {
                IncludeCaption = true;
            }
            column(QualificationType_HRTrainingNeeds; "HR Training Needs"."Qualification Type")
            {
                IncludeCaption = true;
            }
            column(QualificationDescription_HRTrainingNeeds; "HR Training Needs"."Qualification Description")
            {
                IncludeCaption = true;
            }
            column(ProviderName_HRTrainingNeeds; "HR Training Needs"."Provider Name")
            {
                IncludeCaption = true;
            }
            column(Code_HRTrainingNeeds; "HR Training Needs".Code)
            {
                IncludeCaption = true;
            }
            column(StartDate_HRTrainingNeeds; "HR Training Needs"."Start Date")
            {
                IncludeCaption = true;
            }
            column(EndDate_HRTrainingNeeds; "HR Training Needs"."End Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingNeeds; "HR Training Needs"."Duration Units")
            {
                IncludeCaption = true;
            }
            column(Duration_HRTrainingNeeds; "HR Training Needs".Duration)
            {
                IncludeCaption = true;
            }
            column(CostOfTraining_HRTrainingNeeds; "HR Training Needs"."Cost Of Training")
            {
                IncludeCaption = true;
            }
            column(Description_HRTrainingNeeds; "HR Training Needs".Description)
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }

            trigger OnAfterGetRecord()
            begin
                Ven.Get("HR Training Needs".Provider);
                VN := Ven.Name;
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

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        VN: Text[50];
        Ven: Record Vendor;
        HR_Training_NeedsCaptionLbl: Label 'HR Training Needs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Training_NeedsCaptionLbl: Label 'Training Needs';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Name_of_Training_CourseCaptionLbl: Label 'Name of Training Course';
        From__Date_CaptionLbl: Label 'From (Date)';
        Duration_CaptionLbl: Label 'Duration ';
        To__Date_CaptionLbl: Label 'To (Date)';
        Cost_of_TrainingCaptionLbl: Label 'Cost of Training';
        LocationCaptionLbl: Label 'Location';
        ProviderCaptionLbl: Label 'Provider';
        Brief_Description_of_Training_CourseCaptionLbl: Label 'Brief Description of Training Course';
        Qualifications_to_be_attained_at_the_end_of_the_Training_CourseCaptionLbl: Label 'Qualifications to be attained at the end of the Training Course';
}

