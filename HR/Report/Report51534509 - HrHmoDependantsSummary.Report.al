report 51534509 "Hr Hmo Dependants Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HrHmoDependantsSummary.rdlc';

    dataset
    {
        dataitem("HR HMO"; "HR HMO")
        {
            DataItemTableView = SORTING("Employee No.");
            RequestFilterFields = "Employment Type";
            column(WithDependants; WithDep)
            {
            }
            column(NoDependants; NoDep)
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
            column(TotalStaff; TotalStaff)
            {
            }

            trigger OnPreDataItem()
            begin
                Hmo.SetRange("Employee No.");
                if Hmo.FindSet then begin
                    repeat
                        HmoDepend.Reset;
                        HmoDepend.SetRange(HmoDepend."Staff No.", Hmo."Employee No.");
                        if HmoDepend.FindFirst then
                            WithDep += 1;

                        HmoDepend.Reset;
                        HmoDepend.SetRange(HmoDepend."Staff No.", Hmo."Employee No.");
                        if not HmoDepend.FindFirst then
                            NoDep += 1;

                        TotalStaff += 1;
                    until Hmo.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(Dependants; Dependants)
                    {
                    }
                }
            }
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

