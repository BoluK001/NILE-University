report 51534794 "HR Confirmation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRConfirmationReport.rdlc';

    dataset
    {
        dataitem("HR Employee Confirmation"; "HR Employee Confirmation")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            column(ApplicationNo_HREmployeeConfirmation; "HR Employee Confirmation"."Application No.")
            {
            }
            column(Score_HREmployeeConfirmation; "HR Employee Confirmation".Score)
            {
            }
            column(EmployeeName_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Name")
            {
            }
            column(DateofEmployment_HREmployeeConfirmation; Format("Date of Employment"))
            {
            }
            column(DateofReview_HREmployeeConfirmation; Format("Date of Review"))
            {
            }
            column(Department_HREmployeeConfirmation; "HR Employee Confirmation".Department)
            {
            }
            column(Level_HREmployeeConfirmation; "HR Employee Confirmation".Level)
            {
            }
            column(From_HREmployeeConfirmation; Format("Start Date"))
            {
            }
            column(EndDate_HREmployeeConfirmation; Format("End Date"))
            {
            }
            column(Name; CompInfo.Name)
            {
            }
            column(BehScore; BehScore)
            {
            }
            column(KPIScore; KpiScore)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(Comment_HREmployeeConfirmation; "HR Employee Confirmation".Comment)
            {
            }
            column(DevelopmentAreas_HREmployeeConfirmation; "HR Employee Confirmation"."Development Areas")
            {
            }
            column(TrainingIdeas_HREmployeeConfirmation; "HR Employee Confirmation"."Training Ideas")
            {
            }
            column(EmployeeComment_HREmployeeConfirmation; "HR Employee Confirmation"."Employee Comment")
            {
            }
            dataitem("HR Employee Confirmation Line"; "HR Employee Confirmation Line")
            {
                DataItemLink = "Application No." = FIELD ("Application No.");
                column(EntryNo_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Entry No.")
                {
                }
                column(Responbilities_HREmployeeConfirmationLine; "HR Employee Confirmation Line".Responbilities)
                {
                }
                column(ApplicationNo_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Application No.")
                {
                }
                column(EmployeeRating_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Supervisor Rating")
                {
                }
                column(AvailableRating_HREmployeeConfirmationLine; "HR Employee Confirmation Line"."Available Rating")
                {
                }
            }
            dataitem("HR Confirmation KPI"; "HR Confirmation KPI")
            {
                DataItemLink = "Document No." = FIELD ("Application No.");
                column(Score_HRConfirmationKPI; "HR Confirmation KPI".Weight)
                {
                }
                column(DocumentNo_HRConfirmationKPI; "HR Confirmation KPI"."Document No.")
                {
                }
                column(Objectives_HRConfirmationKPI; "HR Confirmation KPI".Objectives)
                {
                }
                column(Description_HRConfirmationKPI; "HR Confirmation KPI".Description)
                {
                }
                column(SerialNum; SNum)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNum += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BehScore := 0;
                KpiScore := 0;
                "HR Employee Confirmation".CalcFields(Score);
                "HR Employee Confirmation".CalcFields("KPI Score");

                BehScore := ("HR Employee Confirmation".Score / 100) * 40;
                KpiScore := ("HR Employee Confirmation"."KPI Score" / 100) * 60;
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
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        SNum: Integer;
        BehScore: Decimal;
        KpiScore: Decimal;
}

