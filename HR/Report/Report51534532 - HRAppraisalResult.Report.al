report 51534532 "HR Appraisal Result"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRAppraisalResult.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(No_HREmployees; "No.")
            {
            }
            column(FirstName_HREmployees; "First Name")
            {
            }
            column(MiddleName_HREmployees; "Middle Name")
            {
            }
            column(LastName_HREmployees; "Last Name")
            {
            }
            column(DateOfJoiningtheCompany_HREmployees; "Date Of Joining the Company")
            {
            }
            column(JobLevel_HREmployees; "Salary Grade")
            {
            }
            column(SalaryStep_HREmployees; "HR Employees"."Salary Step")
            {
            }
            column(PrevYear1; PrevYear1)
            {
            }
            column(PrevYear2; PrevYear2)
            {
            }
            column(PrevYear1Grade; PrevYear1Grade)
            {
            }
            column(PrevYear2Grade; PrevYear2Grade)
            {
            }
            column(PrevSalaryGrad; PrevSalaryGrad)
            {
            }
            column(PrevSalaryNotch; PrevSalaryNotch)
            {
            }
            column(DateModified; Format(DateModified))
            {
            }
            column(AppraisalPeriod; AppraisalPeriod)
            {
            }
            column(AveragePrev1; AveragePrev1)
            {
            }
            column(AveragePrev2; AveragePrev2)
            {
            }
            column(GlobalDimension2_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            dataitem("HR Appraisal Goal Setting H"; "HR Appraisal Goal Setting H")
            {
                DataItemLink = "Employee No" = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(HR));
                column(KPIFirstHalfAggregate_HRA; "KPI First Half Aggregate")
                {
                }
                column(KPISecondHalfAggregate_HRAppraisalGoalSettingH; "KPI Second Half Aggregate")
                {
                }
                column(BehaviouralFirstHalfScore_HRAppraisalGoalSettingH; "Behavioural First Half Score")
                {
                }
                column(BehaviouralSecondHalfScore_HRAppraisalGoalSettingH; "Behavioural Second Half Score")
                {
                }
                column(TotalFirst; TotalFirst)
                {
                }
                column(FirstHalfGrade; FirstHalfGrade)
                {
                }
                column(TotalSecond; TotalSecond)
                {
                }
                column(SecondHalfGrade; SecondHalfGrade)
                {
                }
                column(GrossPay; GPay)
                {
                }
                column(ProposedGrade_HRAppraisalGoalSettingH; "Proposed Grade")
                {
                }
                column(ProposedPay; ProposedSal)
                {
                }
                column(SalaryDifference; SalDifference)
                {
                }
                column(CommiteeRecommendation; CommiteeRecom)
                {
                }
                column(Remarks; Remarks)
                {
                }
                column(YearGrade; YearGrade)
                {
                }
                column(YearAverage; YearAverage)
                {
                }
                column(HalfGrade; HalfGrade)
                {
                }
                column(HalfAverage; HalfAverage)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields("Behavioural First Half Score", "KPI First Half Aggregate", "Behavioural Second Half Score", "KPI Second Half Aggregate");
                    BehavSecond := 0;
                    BehavFirst := 0;
                    KPiSecond := 0;
                    TotalSecond := 0;
                    KPIFirst := 0;
                    GPay := 0;
                    ProposedSal := 0;
                    SalDifference := 0;
                    FirstHalfGrade := '';
                    SecondHalfGrade := '';
                    YearAverage := 0;
                    YearGrade := '';
                    HalfAverage := 0;
                    HalfGrade := '';

                    if "HR Employees"."Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                        BehavFirst := ("Behavioural First Half Score" / 125) * 40
                    else
                        if "HR Employees"."Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                            BehavFirst := ("Behavioural First Half Score" / 100) * 40;

                    if "HR Employees"."Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                        BehavSecond := ("Behavioural Second Half Score" / 125) * 40
                    else
                        if "HR Employees"."Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                            BehavSecond := ("Behavioural Second Half Score" / 100) * 40;


                    KPIFirst := ("KPI First Half Aggregate" / 100) * 60;
                    TotalFirst := BehavFirst + KPIFirst;
                    FirstHalfGrade := ScoreGrade(TotalFirst);


                    KPiSecond := ("KPI Second Half Aggregate" / 100) * 60;
                    TotalSecond := BehavSecond + KPiSecond;
                    SecondHalfGrade := ScoreGrade(TotalSecond);

                    YearAverage := (TotalFirst + TotalSecond) / 2;
                    YearGrade := ScoreGrade(YearAverage);

                    HalfAverage := (TotalFirst + Prev2BehSec + Prev2KPiSec) / 2;
                    HalfGrade := ScoreGrade(HalfAverage);


                    prPeriodTrans.SetCurrentKey("Transaction Code", "Payroll Period");
                    prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "HR Appraisal Goal Setting H"."Employee No");
                    prPeriodTrans.SetRange("Transaction Code", 'GPAY');
                    if prPeriodTrans.FindLast then
                        GPay := prPeriodTrans.Amount;


                    //GetTrans
                    PropTRans.SetCurrentKey("Transaction Code", "Payroll Period");
                    PropTRans.SetRange(PropTRans."Salary Grade", "HR Appraisal Goal Setting H"."Proposed Grade");
                    PropTRans.SetRange(PropTRans."Period Year", AppraisalPeriod);
                    PropTRans.SetRange("Transaction Code", 'GPAY');
                    if PropTRans.FindLast then
                        ProposedSal := PropTRans.Amount;

                    SalDifference := ProposedSal - GPay;
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter("Appraisal Period", Format(AppraisalPeriod));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PrevLevel1 := '';
                Prev1Beh := 0;
                Prev1KPi := 0;
                Prev1KPiSec := 0;
                Prev1BehSec := 0;
                AveragePrev1 := 0;
                PrevYear1Grade := '';
                PrevYear2Grade := '';

                PrevLevel2 := '';
                Prev2Beh := 0;
                Prev2KPi := 0;
                Prev2KPiSec := 0;
                Prev2BehSec := 0;
                AveragePrev2 := 0;
                SalDifference := 0;

                PrevSalaryGrad := '';
                PrevSalaryNotch := '';
                DateModified := 0D;

                CareerEvent.Reset;
                CareerEvent.SetRange(CareerEvent."Employee No.", "HR Employees"."No.");
                CareerEvent.SetRange(CareerEvent."Field Modified", 'SALARY GRADE');
                if CareerEvent.FindLast then begin
                    PrevSalaryGrad := CareerEvent."Old Value";
                    DateModified := CareerEvent."Date Modified";
                end;

                CareerEvent.Reset;
                CareerEvent.SetRange(CareerEvent."Employee No.", "HR Employees"."No.");
                CareerEvent.SetRange(CareerEvent."Field Modified", 'SALARY NOTCH');
                if CareerEvent.FindLast then begin
                    PrevSalaryNotch := CareerEvent."Old Value";
                    DateModified := CareerEvent."Date Modified";
                end;


                begin
                    HRAppraisal.Reset;
                    HRAppraisal.SetRange(HRAppraisal."Employee No", "HR Employees"."No.");
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Period", Format(PrevYear1));
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Half", HRAppraisal."Appraisal Half"::First);
                    if HRAppraisal.FindFirst then begin
                        HRAppraisal.CalcFields(HRAppraisal."Behavioural First Half Score", HRAppraisal."KPI First Half Aggregate");

                        GetJobLevel.Reset;
                        GetJobLevel.SetRange(GetJobLevel."Employee Code", "HR Employees"."No.");
                        GetJobLevel.SetRange(GetJobLevel."Transaction Code", 'GPAY');
                        GetJobLevel.SetRange(GetJobLevel."Period Year", PrevYear1);
                        if GetJobLevel.FindLast then
                            PrevLevel1 := GetJobLevel."Salary Grade";

                        if PrevLevel1 in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                            Prev1Beh := (HRAppraisal."Behavioural First Half Score" / 125) * 40
                        else
                            if PrevLevel1 in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                                Prev1Beh := (HRAppraisal."Behavioural First Half Score" / 100) * 40;

                        Prev1KPi := (HRAppraisal."KPI First Half Aggregate" / 100) * 60;
                    end;

                    HRAppraisal.Reset;
                    HRAppraisal.SetRange(HRAppraisal."Employee No", "HR Employees"."No.");
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Period", Format(PrevYear1));
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Half", HRAppraisal."Appraisal Half"::Second);
                    if HRAppraisal.FindFirst then begin
                        HRAppraisal.CalcFields(HRAppraisal."Behavioural Second Half Score", HRAppraisal."KPI Second Half Aggregate");

                        GetJobLevel.Reset;
                        GetJobLevel.SetRange(GetJobLevel."Employee Code", "HR Employees"."No.");
                        GetJobLevel.SetRange(GetJobLevel."Transaction Code", 'GPAY');
                        GetJobLevel.SetRange(GetJobLevel."Period Year", PrevYear1);
                        if GetJobLevel.FindLast then
                            PrevLevel1 := GetJobLevel."Salary Grade";

                        if PrevLevel1 in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                            Prev1BehSec := (HRAppraisal."Behavioural Second Half Score" / 125) * 40
                        else
                            if PrevLevel1 in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                                Prev1BehSec := (HRAppraisal."Behavioural Second Half Score" / 100) * 40;

                        Prev1KPiSec := (HRAppraisal."KPI Second Half Aggregate" / 100) * 60;

                    end;
                    AveragePrev1 := (Prev1Beh + Prev1BehSec + Prev1KPi + Prev1KPiSec) / 2;
                    PrevYear1Grade := ScoreGrade(AveragePrev1);
                end;
                ///End of Prev1////////

                begin
                    HRAppraisal.Reset;
                    HRAppraisal.SetRange(HRAppraisal."Employee No", "HR Employees"."No.");
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Period", Format(PrevYear2));
                    HRAppraisal.SetRange(HRAppraisal."Appraisal Half", HRAppraisal."Appraisal Half"::First);
                    HRAppraisal.SetRange(HRAppraisal.Status, HRAppraisal.Status::HR);
                    if HRAppraisal.FindFirst then begin
                        HRAppraisal.CalcFields(HRAppraisal."Behavioural First Half Score", HRAppraisal."KPI First Half Aggregate");

                        GetJobLevel.Reset;
                        GetJobLevel.SetRange(GetJobLevel."Employee Code", "HR Employees"."No.");
                        GetJobLevel.SetRange(GetJobLevel."Transaction Code", 'GPAY');
                        GetJobLevel.SetRange(GetJobLevel."Period Year", PrevYear2);
                        if GetJobLevel.FindLast then
                            PrevLevel2 := GetJobLevel."Salary Grade";

                        if PrevLevel2 in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                            Prev2Beh := (HRAppraisal."Behavioural First Half Score" / 125) * 40
                        else
                            if PrevLevel2 in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                                Prev2Beh := (HRAppraisal."Behavioural First Half Score" / 100) * 40;

                        Prev2KPi := (HRAppraisal."KPI First Half Aggregate" / 100) * 60;
                    end;

                    HRAppraisalSec.Reset;
                    HRAppraisalSec.SetRange(HRAppraisalSec."Employee No", "HR Employees"."No.");
                    HRAppraisalSec.SetRange(HRAppraisalSec."Appraisal Period", Format(PrevYear2));
                    HRAppraisalSec.SetRange(HRAppraisalSec."Appraisal Half", HRAppraisalSec."Appraisal Half"::Second);
                    HRAppraisalSec.SetRange(HRAppraisalSec.Status, HRAppraisalSec.Status::HR);
                    if HRAppraisalSec.FindFirst then begin
                        HRAppraisalSec.CalcFields(HRAppraisalSec."Behavioural Second Half Score", HRAppraisalSec."KPI Second Half Aggregate");

                        GetJobLevel.Reset;
                        GetJobLevel.SetRange(GetJobLevel."Employee Code", "HR Employees"."No.");
                        GetJobLevel.SetRange(GetJobLevel."Transaction Code", 'GPAY');
                        GetJobLevel.SetRange(GetJobLevel."Period Year", PrevYear2);
                        if GetJobLevel.FindLast then
                            PrevLevel2 := GetJobLevel."Salary Grade";

                        if PrevLevel2 in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                            Prev2BehSec := (HRAppraisalSec."Behavioural Second Half Score" / 125) * 40
                        else
                            if PrevLevel2 in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'CS', 'AS'] then
                                Prev2BehSec := (HRAppraisalSec."Behavioural Second Half Score" / 100) * 40;

                        Prev2KPiSec := (HRAppraisalSec."KPI Second Half Aggregate" / 100) * 60;

                    end;
                    AveragePrev2 := (Prev2Beh + Prev2BehSec + Prev2KPi + Prev2KPiSec) / 2;
                    PrevYear2Grade := ScoreGrade(AveragePrev2);
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
                group(General)
                {
                    field("Appraisal Period"; AppraisalPeriod)
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

    trigger OnPreReport()
    begin
        if AppraisalPeriod = 0 then Error('please specify a period');
        PrevYear1Date := CalcDate('-2Y', DMY2Date(1, 1, AppraisalPeriod));
        PrevYear2Date := CalcDate('-1Y', DMY2Date(1, 1, AppraisalPeriod));

        PrevYear1 := Date2DMY(PrevYear1Date, 3);
        PrevYear2 := Date2DMY(PrevYear2Date, 3);

        //message('%1...%2,..%3....%4',PrevYear1Date,PrevYear1,PrevYear2Date,PrevYear2);
    end;

    var
        AppraisalPeriod: Integer;
        KPIFirst: Decimal;
        TotalFirst: Decimal;
        BehavFirst: Decimal;
        KPiSecond: Decimal;
        TotalSecond: Decimal;
        BehavSecond: Decimal;
        prPeriodTrans: Record "prPeriod Transactions";
        GPay: Decimal;
        PrevYear1: Integer;
        PrevYear2: Integer;
        PrevYear1Date: Date;
        PrevYear2Date: Date;
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        Prev1Beh: Decimal;
        Prev1KPi: Decimal;
        Prev2Beh: Decimal;
        Prev2KPi: Decimal;
        GetJobLevel: Record "prPeriod Transactions";
        PrevLevel1: Code[20];
        PrevLevel2: Code[20];
        Prev1BehSec: Decimal;
        Prev1KPiSec: Decimal;
        Prev2BehSec: Decimal;
        Prev2KPiSec: Decimal;
        AveragePrev1: Decimal;
        AveragePrev2: Decimal;
        PropTRans: Record "prPeriod Transactions";
        ProposedSal: Decimal;
        CommiteeRecom: Text[250];
        Remarks: Text[250];
        SalDifference: Decimal;
        FirstHalfGrade: Code[20];
        SecondHalfGrade: Code[20];
        YearAverage: Decimal;
        YearGrade: Code[20];
        PrevYear1Grade: Code[20];
        PrevYear2Grade: Code[20];
        HalfAverage: Decimal;
        HalfGrade: Code[20];
        PrevSalaryGrad: Code[20];
        PrevSalaryNotch: Code[20];
        DateModified: Date;
        CareerEvent: Record "HR Career Event";
        HRAppraisalSec: Record "HR Appraisal Goal Setting H";

    local procedure ScoreGrade(Scr: Decimal): Code[20]
    begin
        case Scr of
            0 .. 49:
                exit('E');
            50 .. 59:
                exit('D');
            60 .. 69:
                exit('C');
            70 .. 79:
                exit('B');
            80 .. 100:
                exit('A');
        end;
    end;
}

