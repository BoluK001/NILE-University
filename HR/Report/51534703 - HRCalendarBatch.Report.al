report 51534703 "HR Calendar Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRCalendarBatch.rdlc';
    ProcessingOnly = false;

    dataset
    {
        dataitem("HR Calendar List"; "HR Calendar List")
        {
            RequestFilterFields = "Code", "Non Working";
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
            column(HR_Calendar_List_Day; Day)
            {
            }
            column(HR_Calendar_List_Date; Date)
            {
            }
            column(HR_Calendar_List__Non_Working_; "Non Working")
            {
            }
            column(HR_Calendar_List_Reason; Reason)
            {
            }
            column(HR_Calendar_ListCaption; HR_Calendar_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Calendar_List_DayCaption; FieldCaption(Day))
            {
            }
            column(HR_Calendar_List_DateCaption; FieldCaption(Date))
            {
            }
            column(HR_Calendar_List__Non_Working_Caption; FieldCaption("Non Working"))
            {
            }
            column(HR_Calendar_List_ReasonCaption; FieldCaption(Reason))
            {
            }
            column(HR_Calendar_List_Code; Code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HRCalendar.SetRange(HRCalendar.Current, true);
                if HRCalendar.Find('-') then
                    "HR Calendar List".Code := HRCalendar.Year;
                "HR Calendar List".Modify;
                Holidays.FindFirst;
                repeat

                    if "HR Calendar List".Day = Holidays."Non Working Days" then
                        "HR Calendar List"."Non Working" := true;
                    Modify;

                    if "HR Calendar List".Date = Holidays."Non Working Dates" then
                        "HR Calendar List"."Non Working" := true;
                    Modify;

                until Holidays.Next = 0;
            end;

            trigger OnPostDataItem()
            begin
                Message('Calendar has been updated Successfully');
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
        Holidays: Record "HR Non Working Days & Dates";
        HRCalendar: Record "HR Calendar";
        CurrentDate: Date;
        HR_Calendar_ListCaptionLbl: Label 'HR Calendar List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

