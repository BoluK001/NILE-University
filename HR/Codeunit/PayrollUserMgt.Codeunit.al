codeunit 51534515 "Payroll User Mgt"
{

    trigger OnRun()
    begin
    end;

    var
        UserSetup: Record "User Setup";
        HasEmployeeClass: Boolean;
        CompanyInfo: Record "Company Information";
        PayrollClass: Code[20];
        Pay: Code[20];
        GradeClass: Code[20];

    [Scope('OnPrem')]
    procedure GetPayrollFilter(): Code[20]
    begin
        exit(GetPayrollFilter2(UserId));
    end;

    [Scope('OnPrem')]
    procedure GetPayrollFilter2(UserCode: Code[50]): Code[20]
    begin
        CompanyInfo.Get;
        PayrollClass := CompanyInfo."Responsibility Center";
        if UserSetup.Get(UserCode) and (UserCode <> '') then
            if UserSetup."PayRoll Cent. Filter" <> '' then
                PayrollClass := UserSetup."PayRoll Cent. Filter";
        HasEmployeeClass := true;
        exit(PayrollClass);
    end;

    [Scope('OnPrem')]
    procedure GetPayrollSubFilter(UserCod: Code[50]): Code[20]
    begin
        exit(GetPayrollFilter2(UserCod));
    end;

    [Scope('OnPrem')]
    procedure GetGradeFilter(): Code[20]
    begin
        exit(GetGradeFilter2(UserId));
    end;

    [Scope('OnPrem')]
    procedure GetGradeFilter2(UserCode: Code[50]): Code[20]
    begin
        CompanyInfo.Get;
        GradeClass := CompanyInfo."Responsibility Center";
        if UserSetup.Get(UserCode) and (UserCode <> '') then
            //  IF UserSetup."User ID" <> '' THEN //AND ("User ID" <> '') THEN
            if UserSetup."Grade Classification" <> '' then
                GradeClass := UserSetup."Grade Classification";
        HasEmployeeClass := true;
        exit(GradeClass);
    end;

    [Scope('OnPrem')]
    procedure GetGradeSubFilter(UserCod: Code[50]): Code[20]
    begin
        exit(GetGradeFilter2(UserCod));
    end;
}

