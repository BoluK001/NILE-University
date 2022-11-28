report 51534508 "Hr HMO Class Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrHMOClassReport.rdlc';

    dataset
    {
        dataitem("HR HMO"; "HR HMO")
        {
            DataItemTableView = SORTING("Employment Type") ORDER(Ascending);
            RequestFilterFields = "Employment Type";
            column(EmploymentType_HRHMO; "HR HMO"."Employment Type")
            {
            }
            column(NumberofBeneficiaries_HRHMO; "HR HMO"."Number of Beneficiaries")
            {
            }
            column(TotalStaff; TotalStaff)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(User; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalStaff := 0;

                if HmoClass = "HR HMO"."Employment Type" then
                    CurrReport.Skip
                else
                    HmoClass := '';

                Hmo.SetRange(Hmo."Employment Type", "Employment Type");
                if Hmo.FindSet then
                    repeat
                        TotalStaff += 1;
                    until Hmo.Next = 0;

                HmoClass := "HR HMO"."Employment Type";
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
        TotalStaff: Integer;
        Hmo: Record "HR HMO";
        HmoClass: Code[20];
}

