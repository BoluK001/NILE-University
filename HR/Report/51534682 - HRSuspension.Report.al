report 51534682 "HR Suspension"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRSuspension.rdlc';

    dataset
    {
        dataitem("Pr Suspension"; "Pr Suspension")
        {
            RequestFilterFields = Employee, "Date Of Suspension", "End Of Suspension", "Suspend Pay";
            column(Employee_PrSuspension; "Pr Suspension".Employee)
            {
            }
            column(Date_PrSuspension; "Pr Suspension".Date)
            {
            }
            column(DateOfSuspension_PrSuspension; "Pr Suspension"."Date Of Suspension")
            {
            }
            column(EndOfSuspension_PrSuspension; "Pr Suspension"."End Of Suspension")
            {
            }
            column(ReasonOfSuspension_PrSuspension; "Pr Suspension"."Reason Of Suspension")
            {
            }
            column(LastDateModified_PrSuspension; "Pr Suspension"."Last Date Modified")
            {
            }
            column(UserID_PrSuspension; "Pr Suspension"."User ID")
            {
            }
            column(SNo; SNo)
            {
            }
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
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage; CI."Home Page")
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
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "No." = FIELD(Employee);
                column(No_HREmployee; "HR-Employee"."No.")
                {
                }
                column(FirstName_HREmployee; "HR-Employee"."First Name")
                {
                }
                column(MiddleName_HREmployee; "HR-Employee"."Middle Name")
                {
                }
                column(LastName_HREmployee; "HR-Employee"."Last Name")
                {
                }
                column(DepartmentCode_HREmployee; "HR-Employee"."Department Code")
                {
                }
                column(Office_HREmployee; "HR-Employee".Office)
                {
                }
                column(DateOfJoin_HREmployee; "HR-Employee"."Date Of Join")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
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
        SNo := 0;
        CI.Get;
        CI.CalcFields(Picture);
    end;

    var
        SNo: Integer;
        CI: Record "Company Information";
}

