report 51534512 "Hr Emp Applicant to Employee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrEmpApplicanttoEmployee.rdlc';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            DataItemTableView = WHERE("Turn Around Time" = FILTER(<> 0));
            column(JobID_HREmployeeRequisitions; "HR Employee Requisitions"."Job ID")
            {
            }
            column(RequisitionDate_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition Date")
            {
            }
            column(GlobalDimension2Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 2 Code")
            {
            }
            column(TurnAroundTime_HREmployeeRequisitions; "HR Employee Requisitions"."Turn Around Time")
            {
            }
            column(ClosingDate_HREmployeeRequisitions; Format("HR Employee Requisitions"."Closing Date", 0, 4))
            {
            }
            column(VacantPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Vacant Positions")
            {
            }
            column(RequisitionNo_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition No.")
            {
            }
            column(RequisitionType_HREmployeeRequisitions; "HR Employee Requisitions"."Recruitment Type")
            {
            }
            column(JobDescription_HREmployeeRequisitions; "HR Employee Requisitions"."Job Description")
            {
            }
            column(USER; UserId)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(RequiredPositions_HREmployeeRequisitions; "HR Employee Requisitions"."Required Positions")
            {
            }
            column(FieldCaption_______GlobalDim; FieldCaption("Shortcut Dimension 2 Code"))
            {
            }
            dataitem("HR Job Applications"; "HR Job Applications")
            {
                DataItemLink = "Employee Requisition No" = FIELD("Requisition No.");
                DataItemTableView = WHERE(Qualified = CONST(true));
                column(FirstName_HRJobApplications; "HR Job Applications"."First Name")
                {
                }
                column(MiddleName_HRJobApplications; "HR Job Applications"."Middle Name")
                {
                }
                column(LastName_HRJobApplications; "HR Job Applications"."Last Name")
                {
                }
                column(EmployeeNo_HRJobApplications; "HR Job Applications"."Employee No")
                {
                }
                column(EmployeeCreationDate_HRJobApplications; "HR Job Applications"."Employee Creation Date")
                {
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}

