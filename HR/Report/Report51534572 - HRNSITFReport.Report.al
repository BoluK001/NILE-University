report 51534572 "HR NSITF Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRNSITFReport.rdlc';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = WHERE("Posting Group" = FILTER('SNR-ASSOC' | 'ASSOC' | 'PERMANENT'), Status = CONST(Normal));
            column(No_HREmployee; "HR-Employee"."No.")
            {
            }
            column(FirstName_HREmployee; "HR-Employee"."First Name")
            {
            }
            column(LastName_HREmployee; "HR-Employee"."Last Name")
            {
            }
            column(SerialNum; SerialNum)
            {
            }
            column(DateOfBirth_HREmployee; Format("HR-Employee"."Date Of Birth"))
            {
            }
            column(Gender_HREmployee; "HR-Employee".Gender)
            {
            }
            column(Level_HREmployee; "HR-Employee".Level)
            {
            }
            column(MonthlyTrans; MonthlyTrans)
            {
            }
            column(MonthlyHousing; MonthlyHousing)
            {
            }
            column(MonthlyBasic; MonthlyBasic)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(TotalEmo; TotalEmo)
            {
            }
            column(PercentTotal; PercentTotal)
            {
            }
            column(OnePercentBHT; OnePercentBHT)
            {
            }
            column(Total; Total)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SerialNum += 1;
                MonthlyBasic := 0;
                MonthlyHousing := 0;
                MonthlyTrans := 0;
                MonthlyDress := 0;
                MonthlyUtil := 0;
                MonthlyLunch := 0;
                MonthlyEnt := 0;
                MonthlyFurn := 0;
                MonthlyEduc := 0;
                MonthlySelfM := 0;
                MonthlyLoc := 0;
                MonthlyPens := 0;


                SalaryGrade.Reset;
                SalaryGrade.SetRange(SalaryGrade."Salary Grade", "Salary Grade");
                if SalaryGrade.FindFirst then
                    MonthlyBasic := SalaryGrade."Basic  Pay";

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'TRANS');
                if NotchTransactions.FindFirst then
                    MonthlyTrans := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'HSE');
                if NotchTransactions.FindFirst then
                    MonthlyHousing := NotchTransactions.Amount;


                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'DRESS');
                if NotchTransactions.FindFirst then
                    MonthlyDress := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'UTIL');
                if NotchTransactions.FindFirst then
                    MonthlyUtil := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'LUNCH');
                if NotchTransactions.FindFirst then
                    MonthlyLunch := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'ENT');
                if NotchTransactions.FindFirst then
                    MonthlyEnt := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'FURN');
                if NotchTransactions.FindFirst then
                    MonthlyFurn := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'EDU');
                if NotchTransactions.FindFirst then
                    MonthlyEduc := NotchTransactions.Amount;

                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'SELF-MAINT');
                if NotchTransactions.FindFirst then
                    MonthlySelfM := NotchTransactions.Amount;


                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'LOC');
                if NotchTransactions.FindFirst then
                    MonthlyLoc := NotchTransactions.Amount;


                NotchTransactions.Reset;
                NotchTransactions.SetRange(NotchTransactions."Salary Grade", "Salary Grade");
                NotchTransactions.SetRange(NotchTransactions."Salary Step/Notch", "Salary Notch/Step");  //TRANS
                NotchTransactions.SetRange(NotchTransactions."Transaction Code", 'PENS');
                if NotchTransactions.FindFirst then
                    MonthlyPens := NotchTransactions.Amount;


                TotalEmo := MonthlyHousing + MonthlyTrans + MonthlyBasic;
                OnePercentBHT := 0.01 * (MonthlyHousing + MonthlyTrans + MonthlyBasic);
                Total := MonthlyHousing + MonthlyTrans + MonthlyBasic + MonthlyDress + MonthlyUtil + MonthlyLunch + MonthlyEnt + MonthlyFurn + MonthlyEduc + MonthlySelfM + MonthlyLoc + MonthlyPens;
                PercentTotal := 0.01 * (MonthlyHousing + MonthlyTrans + MonthlyBasic + MonthlyDress + MonthlyUtil + MonthlyLunch + MonthlyEnt + MonthlyFurn + MonthlyEduc + MonthlySelfM + MonthlyLoc + MonthlyPens);
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("HR-Employee"."Posting Group",'%1|%2|%3','PERMANENT','SNR-ASSOC','ASSOC');
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

    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture);
    end;

    var
        SerialNum: Integer;
        NotchTransactions: Record "Salary Step/Notch Transactions";
        SalaryGrade: Record "Salary Notch";
        MonthlyBasic: Decimal;
        MonthlyHousing: Decimal;
        MonthlyTrans: Decimal;
        CompInfo: Record "Company Information";
        TotalEmo: Decimal;
        MonthlyDress: Decimal;
        MonthlyUtil: Decimal;
        MonthlyLunch: Decimal;
        MonthlyEnt: Decimal;
        MonthlyFurn: Decimal;
        MonthlyEduc: Decimal;
        MonthlySelfM: Decimal;
        MonthlyLoc: Decimal;
        MonthlyPens: Decimal;
        PercentTotal: Decimal;
        OnePercentBHT: Decimal;
        Total: Decimal;
}

