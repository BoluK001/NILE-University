report 51534521 "HR Query Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRQueryReport.rdlc';

    dataset
    {
        dataitem("HR Disciplinary Cases"; "HR Disciplinary Cases")
        {
            DataItemTableView = WHERE (Query = CONST (true));
            RequestFilterFields = "Date of Complaint";
            column(DateofComplaint_HRDisciplinaryCases; Format("Date of Complaint", 0, 4))
            {
            }
            column(RecommendedAction_HRDisciplinaryCases; "HR Disciplinary Cases"."Recommended Action")
            {
            }
            column(CaseDescription_HRDisciplinaryCases; "HR Disciplinary Cases"."Case Description")
            {
            }
            column(EmployeeName_HRDisciplinaryCases; "HR Disciplinary Cases"."Employee Name")
            {
            }
            column(SupervisorNo_HRDisciplinaryCases; "HR Disciplinary Cases"."Supervisor No.")
            {
            }
            column(SupervisorName_HRDisciplinaryCases; "HR Disciplinary Cases"."Supervisor Name")
            {
            }
            column(DisciplinaryActionTaken_HRDisciplinaryCases; "HR Disciplinary Cases"."Disciplinary Action Taken")
            {
            }
            column(User; UserId)
            {
            }
            column(TODAY; Format(Today, 0, 4))
            {
            }
            column(Picture; CompInfo.Picture)
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}

