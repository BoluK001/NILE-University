report 51534522 "HR Meal Ticket Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRMealTicketReport.rdlc';

    dataset
    {
        dataitem("Hr Canteen Application"; "Hr Canteen Application")
        {
            DataItemTableView = WHERE (Posted = CONST (true));
            RequestFilterFields = Date;
            column(User; UserId)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(TicketNo_HrCanteenApplication; "Hr Canteen Application"."Ticket No.")
            {
            }
            column(EmployeeNo_HrCanteenApplication; "Hr Canteen Application"."Employee No.")
            {
            }
            column(EmployeeName_HrCanteenApplication; "Hr Canteen Application"."Employee Name")
            {
            }
            column(Date_HrCanteenApplication; Format(Date, 0, 4))
            {
            }
            column(DepartmentName_HrCanteenApplication; "Hr Canteen Application"."Department Name")
            {
            }
            column(RequestType_HrCanteenApplication; "Hr Canteen Application"."Request Type")
            {
            }
            column(VisitorName_HrCanteenApplication; "Hr Canteen Application"."Visitor Name")
            {
            }
            column(Sn; sn)
            {
            }

            trigger OnAfterGetRecord()
            begin
                sn += 1;
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        sn: Integer;
}

