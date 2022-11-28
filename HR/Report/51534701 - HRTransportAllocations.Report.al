report 51534701 "HR Transport Allocations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTransportAllocations.rdlc';

    dataset
    {
        dataitem("HR Transport Allocations H"; "HR Transport Allocations H")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Transport Allocation No", Status;
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
            column(AssignedDriver_HRTransportAllocationsH; "HR Transport Allocations H"."Assigned Driver")
            {
                IncludeCaption = true;
            }
            column(DriverName_HRTransportAllocationsH; "HR Transport Allocations H"."Driver Name")
            {
                IncludeCaption = true;
            }
            column(DateofTrip_HRTransportAllocationsH; "HR Transport Allocations H"."Date of Trip")
            {
                IncludeCaption = true;
            }
            column(TransportAllocationNo_HRTransportAllocationsH; "HR Transport Allocations H"."Transport Allocation No")
            {
                IncludeCaption = true;
            }
            column(VehicleRegNumber_HRTransportAllocationsH; "HR Transport Allocations H"."Vehicle Reg Number")
            {
                IncludeCaption = true;
            }
            column(Destinations_HRTransportAllocationsH; "HR Transport Allocations H"."Destination(s)")
            {
                IncludeCaption = true;
            }
            dataitem("HR Transport Allocations"; "HR Transport Allocations")
            {
                DataItemLink = "Allocation No" = FIELD("Transport Allocation No");
                DataItemTableView = SORTING("Allocation No", "Requisition No") ORDER(Ascending);
                column(EmployeeNo_HRTransportAllocations; "HR Transport Allocations"."Employee No")
                {
                    IncludeCaption = true;
                }
                column(PassengersFullNames_HRTransportAllocations; "HR Transport Allocations"."Passenger/s Full Name/s")
                {
                    IncludeCaption = true;
                }
                column(Dept_HRTransportAllocations; "HR Transport Allocations".Dept)
                {
                    IncludeCaption = true;
                }
                column(From_HRTransportAllocations; "HR Transport Allocations".From)
                {
                    IncludeCaption = true;
                }
                column(To_HRTransportAllocations; "HR Transport Allocations H"."Destination(s)")
                {
                    IncludeCaption = true;
                }
                column(No; No)
                {
                    IncludeCaption = false;
                }

                trigger OnAfterGetRecord()
                begin
                    Int := Int + 1;
                end;

                trigger OnPreDataItem()
                begin
                    Int := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                No := No + 1;
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
        Int: Integer;
        HR_Transport_RequisitionsCaptionLbl: Label 'HR Transport Requisitions';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        TRANSPORT_REQUESTCaptionLbl: Label 'TRANSPORT REQUEST';
        Travelling_Staff_DetailsCaptionLbl: Label 'Travelling Staff Details';
        No: Integer;
}

