report 51534510 "Hr Hmo Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrHmoReport.rdlc';

    dataset
    {
        dataitem("HR HMO"; "HR HMO")
        {
            column(EmployeeNo_HRHMO; "HR HMO"."Employee No.")
            {
            }
            column(EmployeeName_HRHMO; "HR HMO"."Employee Name")
            {
            }
            column(Department_HRHMO; "HR HMO".Department)
            {
            }
            column(JobLevel_HRHMO; "HR HMO"."Job Level")
            {
            }
            column(HMOLevel_HRHMO; "HR HMO"."HMO Level")
            {
            }
            column(NumberofBeneficiaries_HRHMO; "HR HMO"."Number of Beneficiaries")
            {
            }
            column(EmploymentType_HRHMO; "HR HMO"."Employment Type")
            {
            }
            column(HMOCardNumber_HRHMO; "HR HMO"."HMO Card Number")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(UserID; UserId)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            dataitem("HR HMO Beneficiary"; "HR HMO Beneficiary")
            {
                DataItemLink = "Staff No." = FIELD("Employee No.");
                DataItemTableView = WHERE(Active = CONST(true));
                column(FirstName_HRHMOBeneficiary; "HR HMO Beneficiary"."First Name")
                {
                }
                column(MiddleName_HRHMOBeneficiary; "HR HMO Beneficiary"."Middle Name")
                {
                }
                column(LastName_HRHMOBeneficiary; "HR HMO Beneficiary"."Last Name")
                {
                }
                column(PhoneNo_HRHMOBeneficiary; "HR HMO Beneficiary"."Phone No.")
                {
                }
                column(Relationship_HRHMOBeneficiary; "HR HMO Beneficiary".Relationship)
                {
                }
                column(Gender_HRHMOBeneficiary; "HR HMO Beneficiary".Gender)
                {
                }
                column(DateofBirth_HRHMOBeneficiary; "HR HMO Beneficiary"."Date of Birth")
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
        TotalStaff: Integer;
        Hmo: Record "HR HMO";
        HmoClass: Code[20];
        Dependants: Boolean;
        HmoDepend: Record "HR HMO Beneficiary";
        WithDep: Integer;
        NoDep: Integer;
}

