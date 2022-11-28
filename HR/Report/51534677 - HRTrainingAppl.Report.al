report 51534677 "HR Training Appl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTrainingAppl.rdlc';

    dataset
    {
        dataitem("HR Training Need Participant"; "HR Training Need Participant")
        {
            DataItemTableView = WHERE (Selected = CONST (true));
            column(Today; Format(Today))
            {
            }
            column(USERID; UserId)
            {
            }
            column(EmployeeCode_HRTrainingNeedParticipant; "HR Training Need Participant"."Employee Code")
            {
            }
            column(EmployeeName_HRTrainingNeedParticipant; "HR Training Need Participant"."Employee Name")
            {
            }
            column(Department_HRTrainingNeedParticipant; "HR Training Need Participant".Department)
            {
            }
            column(CourseTitle_HRTrainingNeedParticipant; "HR Training Need Participant"."Course Title")
            {
            }
            column(Amount_HRTrainingNeedParticipant; "HR Training Need Participant".Amount)
            {
            }
            column(FromDate_HRTrainingNeedParticipant; Format("HR Training Need Participant"."From Date"))
            {
            }
            column(ToDate_HRTrainingNeedParticipant; Format("HR Training Need Participant"."To Date"))
            {
            }
            column(cost; ProvidCost)
            {
            }
            column(Name; Provid)
            {
            }
            column(Sn; Sn)
            {
            }
            column(Amountt; ApplicantCost)
            {
            }
            column(TrainingCost; TCost)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sn += 1;
                TCost := 0;
                TCost := 0;
                ApplicantCost := 0;
                ProvidCost := 0;
                Provid := '';
                /*
                IF "HR Training Applications".Type <> "HR Training Applications".Type::Staff THEN
                 TCost:= "HR Training Applications"."Approved Cost"/"HR Training Applications"."No. of Applicants"
                ELSE
                 TCost:="HR Training Applications"."Cost Of Training";
                  */
                //ProvidCost
                HRTrainingApplications.Reset;
                HRTrainingApplications.SetRange(HRTrainingApplications."Application No", "HR Training Need Participant"."Document No.");
                if HRTrainingApplications.FindFirst then begin
                    //   IF "HR Training Need Participant".Status::Approved then
                    HRTrainingApplications.CalcFields(HRTrainingApplications."No. of Applicants");
                    if HRTrainingApplications.Type <> HRTrainingApplications.Type::Staff then
                        TCost := HRTrainingApplications."Approved Cost" / HRTrainingApplications."No. of Applicants"
                    else
                        TCost := HRTrainingApplications."Cost Of Training";

                    ProvidCost := HRTrainingApplications."Approved Cost";

                    Provid := HRTrainingApplications."Provider Name";

                    ApplicantCost := HRTrainingApplications."Approved Cost" / HRTrainingApplications."No. of Applicants";
                end;
                //END;

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
        Sn: Integer;
        TCost: Decimal;
        HRTrainingApplications: Record "HR Training Applications";
        Provid: Text[80];
        ProvidCost: Decimal;
        ApplicantCost: Decimal;
}

