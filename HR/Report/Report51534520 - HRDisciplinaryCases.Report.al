report 51534520 "HR Disciplinary Cases"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRDisciplinaryCases.rdlc';

    dataset
    {
        dataitem("HR Disciplinary Cases"; "HR Disciplinary Cases")
        {
            DataItemTableView = WHERE (Query = CONST (false));
            RequestFilterFields = "Date of Complaint";
            column(CaseNumber_HRDisciplinaryCases; "HR Disciplinary Cases"."Case Number")
            {
            }
            column(DateofComplaint_HRDisciplinaryCases; Format("Date of Complaint", 0, 4))
            {
            }
            column(TypeofDisciplinaryCase_HRDisciplinaryCases; "HR Disciplinary Cases"."Type of Disciplinary Case")
            {
            }
            column(CaseDescription_HRDisciplinaryCases; "HR Disciplinary Cases"."Case Description")
            {
            }
            column(Accuser_HRDisciplinaryCases; "HR Disciplinary Cases".Accuser)
            {
            }
            column(DisciplinaryRemarks_HRDisciplinaryCases; "HR Disciplinary Cases"."Disciplinary Remarks")
            {
            }
            column(Recomendations_HRDisciplinaryCases; "HR Disciplinary Cases".Recomendations)
            {
            }
            column(ClosedBy_HRDisciplinaryCases; "HR Disciplinary Cases"."Closed By")
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
            column(EmployeeName_HRDisciplinaryCases; "HR Disciplinary Cases"."Employee Name")
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

