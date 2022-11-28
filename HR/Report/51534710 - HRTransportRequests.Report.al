report 51534710 "HR Transport Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTransportRequests.rdlc';

    dataset
    {
        dataitem("HR Transport Requisition"; "HR Transport Requisition")
        {
            RequestFilterFields = "Application Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(HR_Transport_Requests_Code; "Application Code")
            {
            }
            column(HR_Transport_Requests__Requester_Code_; "HR Transport Requisition"."Employee No")
            {
            }
            column(HR_Transport_Requests_Requester; "HR Transport Requisition"."Employee No")
            {
            }
            column(HR_Transport_Requests_From; "Days Applied")
            {
            }
            column(HR_Transport_Requests__To_; Status)
            {
            }
            column(HR_Transport_Requests__Time_of_trip_; "Time of Trip")
            {
            }
            column(HR_Transport_Requests__Purpose_of_Request_; "Start Date")
            {
            }
            column(HR_Transport_Requests__Requisition_Date_; "Return Date")
            {
            }
            column(HR_Transport_RequestsCaption; HR_Transport_RequestsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Transport_Requests_CodeCaption; FieldCaption("Application Code"))
            {
            }
            column(HR_Transport_Requests__Requester_Code_Caption; "HR Transport Requisition"."Application Code")
            {
            }
            column(HR_Transport_Requests_RequesterCaption; "HR Transport Requisition"."Application Code")
            {
            }
            column(HR_Transport_Requests_FromCaption; FieldCaption("Days Applied"))
            {
            }
            column(HR_Transport_Requests__To_Caption; FieldCaption(Status))
            {
            }
            column(HR_Transport_Requests__Time_of_trip_Caption; FieldCaption("Time of Trip"))
            {
            }
            column(HR_Transport_Requests__Purpose_of_Request_Caption; FieldCaption("Start Date"))
            {
            }
            column(HR_Transport_Requests__Requisition_Date_Caption; FieldCaption("Return Date"))
            {
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

    var
        HR_Transport_RequestsCaptionLbl: Label 'HR Transport Requests';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

