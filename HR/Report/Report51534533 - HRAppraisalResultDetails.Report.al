report 51534533 "HR Appraisal Result Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRAppraisalResultDetails.rdlc';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = WHERE(Status = CONST(Active), "Salary Grade" = FILTER('AS' | 'SNR-AS' | 'LEVEL 1' | 'LEVEL 2' | 'LEVEL 3' | 'LEVEL 4' | 'LEVEL 5' | 'LEVEL 6' | 'LEVEL 7' | 'LEVEL 8'));
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
            column(GrossPay; GPay)
            {
            }
            column(PrevYear1; PrevYear1)
            {
            }
            column(PrevYear2; PrevYear2)
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
            column(TotalFirst; TotalFirst)
            {
            }
            column(BehFirst; BehavFirst)
            {
            }
            column(KpiFirst; KPIFirst)
            {
            }
            column(TotalSecond; TotalSecond)
            {
            }
            column(BehSec; BehavSecond)
            {
            }
            column(KpiSec; KPiSecond)
            {
            }
            column(FuncFirst; HRAppraisal."Functional Ass. First Half")
            {
            }
            column(OrgFirst; HRAppraisal."Org. Capability First Half")
            {
            }
            column(mgtFirst; HRAppraisal."Mgt. Competencies First Half")
            {
            }
            column(FunSec; HRAppraisalSec."Functional Ass. Second Half")
            {
            }
            column(OrgSec; HRAppraisalSec."Org. Capability Second Half")
            {
            }
            column(MgtSec; HRAppraisalSec."Mgt. Competencies Second Half")
            {
            }
            column(BehSecd; HRAppraisalSec."Behavioural Second Half Score")
            {
            }
            column(BehFirst__; HRAppraisal."Behavioural First Half Score")
            {
            }
            column(SalaryStep_HREmployees; "HR Employees"."Salary Step")
            {
            }
            column(BehFirstAgg; BehFirstAgg)
            {
            }
            column(BehSecAgg; BehSecAgg)
            {
            }
            column(KpiFirstAgg; KpiFirstAgg)
            {
            }
            column(KpiSecAgg; KpiSecAgg)
            {
            }
            column(DepartmentCode_HREmployees; "HR Employees"."Department Code")
            {
            }
            column(GlobalDimension2_HREmployees; "HR Employees"."Global Dimension 2 Code")
            {
            }
            column(TotalAnnual; TotalAnnual)
            {
            }
            column(FirstHalfGrade; FirstHalfGrade)
            {
            }
            column(SecondHalfGrade; SecondHalfGrade)
            {
            }
            column(YearGrade; YearGrade)
            {
            }
            dataitem("HR Appraisal Goal Setting H"; "HR Appraisal Goal Setting H")
            {
                DataItemLink = "Employee No" = FIELD("No.");
                DataItemTableView = SORTING("Appraisal No") WHERE(Status = CONST(HR));
            }

            trigger OnAfterGetRecord()
            begin
                BehavFirst := 0;
                TotalFirst := 0;
                KPIFirst := 0;
                GPay := 0;

                BehavSecond := 0;
                KPiSecond := 0;
                TotalSecond := 0;
                BehFirstAgg := 0;
                BehSecAgg := 0;
                KpiFirstAgg := 0;
                KpiSecAgg := 0;
                TotalAnnual := 0;
                FirstHalfGrade := '';
                SecondHalfGrade := '';
                YearGrade := '';



                GPay := 0;
                prPeriodTrans.SetCurrentKey("Transaction Code", "Payroll Period");
                prPeriodTrans.SetRange(prPeriodTrans."Employee Code", "No.");
                prPeriodTrans.SetRange("Transaction Code", 'GPAY');
                if prPeriodTrans.FindLast then
                    GPay := prPeriodTrans.Amount;


                HRAppraisal.SetRange(HRAppraisal."Employee No", "No.");
                HRAppraisal.SetRange(HRAppraisal."Appraisal Period", Format(AppraisalPeriod));
                HRAppraisal.SetRange(HRAppraisal."Appraisal Half", HRAppraisal."Appraisal Half"::First);
                HRAppraisal.SetRange(HRAppraisal.Status, HRAppraisal.Status::HR);
                if HRAppraisal.FindFirst then begin
                    HRAppraisal.CalcFields(HRAppraisal."Behavioural First Half Score", HRAppraisal."KPI First Half Aggregate", HRAppraisal."Functional Ass. First Half",
                    HRAppraisal."Org. Capability First Half", HRAppraisal."Mgt. Competencies First Half");


                    if "HR Employees"."Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                        BehavFirst := (HRAppraisal."Behavioural First Half Score" / 125) * 40
                    else
                        if "HR Employees"."Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'AS', 'CS'] then
                            BehavFirst := (HRAppraisal."Behavioural First Half Score" / 100) * 40;

                    BehFirstAgg := HRAppraisal."Behavioural First Half Score";

                    KpiFirstAgg := HRAppraisal."KPI First Half Aggregate";

                    KPIFirst := (HRAppraisal."KPI First Half Aggregate" / 100) * 60;
                    TotalFirst := Round((BehavFirst + KPIFirst), 0.01, '>');
                end;



                HRAppraisalSec.SetRange(HRAppraisalSec."Employee No", "No.");
                HRAppraisalSec.SetRange(HRAppraisalSec."Appraisal Period", Format(AppraisalPeriod));
                HRAppraisalSec.SetRange(HRAppraisalSec."Appraisal Half", HRAppraisalSec."Appraisal Half"::Second);
                HRAppraisalSec.SetRange(HRAppraisalSec.Status, HRAppraisalSec.Status::HR);
                if HRAppraisalSec.FindFirst then begin
                    HRAppraisalSec.CalcFields(HRAppraisalSec."Behavioural Second Half Score", HRAppraisalSec."KPI Second Half Aggregate", HRAppraisalSec."Functional Ass. Second Half",
                    HRAppraisalSec."Org. Capability Second Half", HRAppraisalSec."Mgt. Competencies Second Half");

                    if "HR Employees"."Salary Grade" in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
                        BehavSecond := (HRAppraisalSec."Behavioural Second Half Score" / 125) * 40
                    else
                        if "HR Employees"."Salary Grade" in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'SNR-AS', 'AS', 'CS'] then
                            BehavSecond := (HRAppraisalSec."Behavioural Second Half Score" / 100) * 40;

                    BehSecAgg := HRAppraisalSec."Behavioural Second Half Score";

                    KpiSecAgg := HRAppraisalSec."KPI Second Half Aggregate";
                    KPiSecond := (HRAppraisalSec."KPI Second Half Aggregate" / 100) * 60;
                    TotalSecond := Round((BehavSecond + KPiSecond), 0.01, '>');
                end;


                TotalAnnual := Round(((TotalFirst + TotalSecond) / 2), 0.01, '>');
                YearGrade := ScoreGrade(TotalAnnual);
                FirstHalfGrade := ScoreGrade(TotalFirst);
                SecondHalfGrade := ScoreGrade(TotalSecond);
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
        /*IF AppraisalPeriod = 0 THEN ERROR('please specify a period');
        PrevYear1Date:=CALCDATE('-2Y',DMY2DATE(1,1,AppraisalPeriod));
        PrevYear2Date:=CALCDATE('-1Y',DMY2DATE(1,1,AppraisalPeriod));
        
        PrevYear1:=DATE2DMY(PrevYear1Date,3);
        PrevYear2:=DATE2DMY(PrevYear2Date,3);
        
        //message('%1...%2,..%3....%4',PrevYear1Date,PrevYear1,PrevYear2Date,PrevYear2);
         */

    end;

    var
        StatusFld: Option Open,"Pending Approval",Approved,Closed,HR;
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
        HRAppraisalSec: Record "HR Appraisal Goal Setting H";
        BehFirstAgg: Decimal;
        BehSecAgg: Decimal;
        KpiFirstAgg: Decimal;
        KpiSecAgg: Decimal;
        TotalAnnual: Decimal;
        FirstHalfGrade: Text;
        SecondHalfGrade: Text;
        YearGrade: Text;

    local procedure ScoreGrade(Scr: Decimal): Code[20]
    begin
        /*CASE Scr OF
          0..49:
          EXIT('E');
          50..59:
          EXIT('D');
          60..69:
          EXIT('C');
          70..79:
          EXIT('B');
           80..100:
          EXIT('A');
        END;
         */
        if (Scr >= 0) and (Scr < 50) then exit('E');
        if (Scr > 49) and (Scr < 60) then exit('D');
        if (Scr > 59) and (Scr < 70) then exit('C');
        if (Scr > 69) and (Scr < 80) then exit('B');
        if (Scr > 79) then exit('A');

    end;

    local procedure FirstHalfScr()
    begin
    end;

    local procedure SecondHalfScr()
    begin
    end;

    local procedure YearScr()
    begin
    end;
}

