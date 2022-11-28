report 51534686 "HR Jobs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobs.rdlc';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            RequestFilterFields = "Job ID";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(HR_Jobs_UserID; "Created By")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_City; CI.City)
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
            column(HR_Jobs__No_of_Posts_; "No of Posts")
            {
            }
            column(HR_Jobs__Position_Reporting_to_; "Position Reporting to")
            {
            }
            column(HR_Jobs__Occupied_Positions_; "Occupied Positions")
            {
            }
            column(HR_Jobs__Vacant_Positions_; "Vacant Positions")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Job_StatisticsCaption; Job_StatisticsCaptionLbl)
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
            column(HR_Jobs__No_of_Posts_Caption; FieldCaption("No of Posts"))
            {
            }
            column(HR_Jobs__Position_Reporting_to_Caption; FieldCaption("Position Reporting to"))
            {
            }
            column(HR_Jobs__Occupied_Positions_Caption; FieldCaption("Occupied Positions"))
            {
            }
            column(HR_Jobs__Vacant_Positions_Caption; FieldCaption("Vacant Positions"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                Validate("Vacant Positions");
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
        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HR_JobsCaptionLbl: Label 'HR Jobs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Job_StatisticsCaptionLbl: Label 'HR Job Statistics';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        MyUserID: Text;
        UserSetup: Record "User Setup";
}

