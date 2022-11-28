report 51534541 "HR Employee Kin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeKin.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(GlobalDimension2_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(FirstName_HREmployees; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployees; "HR Employees"."Middle Name")
            {
            }
            column(LastName_HREmployees; "HR Employees"."Last Name")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            dataitem("HR Employee Kin"; "HR Employee Kin")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(EmployeeCode_HREmployeeKin; "HR Employee Kin"."Employee Code")
                {
                }
                column(Relationship_HREmployeeKin; "HR Employee Kin".Relationship)
                {
                }
                column(SurName_HREmployeeKin; "HR Employee Kin".SurName)
                {
                }
                column(OtherNames_HREmployeeKin; "HR Employee Kin"."Other Names")
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
}

