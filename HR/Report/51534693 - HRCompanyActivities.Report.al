report 51534693 "HR Company Activities"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRCompanyActivities.rdlc';

    dataset
    {
        dataitem("HR Company Activities"; "HR Company Activities")
        {
            RequestFilterFields = "Code";
            column(Code_HRCompanyActivities; "HR Company Activities".Code)
            {
                IncludeCaption = true;
            }
            column(Description_HRCompanyActivities; "HR Company Activities".Description)
            {
                IncludeCaption = true;
            }
            column(Date_HRCompanyActivities; "HR Company Activities".Date)
            {
                IncludeCaption = true;
            }
            column(Venue_HRCompanyActivities; "HR Company Activities".Venue)
            {
                IncludeCaption = true;
            }
            column(Costs_HRCompanyActivities; "HR Company Activities".Costs)
            {
                IncludeCaption = true;
            }
            column(Posted_HRCompanyActivities; "HR Company Activities".Posted)
            {
                IncludeCaption = true;
            }
            column(EmployeeName_HRCompanyActivities; "HR Company Activities"."Employee Name")
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
            dataitem("HR Activity Participants"; "HR Activity Participants")
            {
                DataItemLink = "Document No." = FIELD(Code);
                DataItemTableView = SORTING("Approver ID", "Document No.") ORDER(Ascending);
                column(Participant_HRActivityParticipants; "HR Activity Participants".Participant)
                {
                    IncludeCaption = true;
                }
                column(Notified_HRActivityParticipants; "HR Activity Participants".Notified)
                {
                    IncludeCaption = true;
                }
                column(FullName; HREmp."Full Name")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                    HREmp.Get("HR Activity Participants".Participant);
                end;
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
        HREmp: Record "HR Employees";
        CI: Record "Company Information";
        HR_Company_ActivitiesCaptionLbl: Label 'HR Company Activities';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Company_Activities_and_ParticipantsCaptionLbl: Label 'Company Activities and Participants';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Activity_Event_DetailsCaptionLbl: Label 'Activity/Event Details';
        Date___TimeCaptionLbl: Label 'Date & Time';
        Participant_NoCaptionLbl: Label 'Participant No';
        NotifiedCaptionLbl: Label 'Notified';
        Participant_NameCaptionLbl: Label 'Participant Name';
        ParticipantsCaptionLbl: Label 'Participants';
}

