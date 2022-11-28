report 51534713 "HR HMO List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRHMOList.rdl';

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
            column(NumberofBeneficiaries_HRHMO; "HR HMO"."Number of Beneficiaries")
            {
            }
            column(MedicalSchemeHospital_HRHMO; "HR HMO"."Medical Scheme Hospital")
            {
            }
            column(DeptName; HREmp."Department Code")
            {
            }
            column(GName; HREmp."Global Dimension 2 Code")
            {
            }
            column(Sn; Sn)
            {
            }
            column(HospitalAddress_HRHMO; "HR HMO"."Hospital Address")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if HREmp.Get("HR HMO"."Employee No.") then
                    Sn += 1;
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
        HREmp: Record "HR Employees";
        Sn: Integer;
}

