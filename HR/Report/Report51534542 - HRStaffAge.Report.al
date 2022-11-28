report 51534542 "HR Staff Age"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRStaffAge.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = ORDER(Ascending) WHERE("Employee Classification" = FILTER('PERM' | 'SNR-AS' | 'AS'));
            column(No_HREmployees; "HR Employees"."No.")
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
            column(Gender_HREmployees; "HR Employees".Gender)
            {
            }
            column(DateOfBirth_HREmployees; Format("HR Employees"."Date Of Birth"))
            {
            }
            column(Sn; Sn)
            {
            }
            column(Age; Agee)
            {
            }
            column(GlobalDimension2_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(EmployeeClassification_HREmployees; "HR Employees"."Employee Classification")
            {
            }
            column(YearofBirth; YearofBirth)
            {
            }
            column(AgeGroup; AgeGroup)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Agee := '';
                YearofBirth := 0;
                AgeGroup := '';
                Sn += 1;
                if Format("HR Employees"."Date Of Birth") <> '' then begin
                    Agee := Format(HRDatesNoPermissionMonths.DetermineAgeYears("HR Employees"."Date Of Birth", Today));
                    YearofBirth := Date2DMY("HR Employees"."Date Of Birth", 3);

                    if YearofBirth < 1963 then
                        AgeGroup := 'Baby Boomer'
                    else
                        if (YearofBirth >= 1963) and (YearofBirth < 1980) then
                            AgeGroup := 'GEN X'
                        else
                            if (YearofBirth >= 1980) and (YearofBirth < 1995) then
                                AgeGroup := 'Millennial';
                end;
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
        HRDatesNoPermissionMonths: Codeunit "HR Dates No Permission Months";
        Agee: Text;
        Sn: Integer;
        YearofBirth: Integer;
        AgeGroup: Code[20];
}

