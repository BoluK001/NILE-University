report 51534805 "HR Jobs Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobsReport.rdlc';

    dataset
    {
        dataitem(HR_Jobs; "HR Jobs")
        {
            column(Job_ID; HR_Jobs."Job ID")
            {
            }
            column(Job_Title; HR_Jobs."Job Title")
            {
            }
            column(Position_Reporting; HR_Jobs."Position Reporting to")
            {
            }
            column(Vacant_Positions; HR_Jobs."Vacant Positions")
            {
            }
            column(Score_Code; HR_Jobs."Score code")
            {
            }
            column(Location; HR_Jobs."Global Dimension 1 Code")
            {
            }
            column(Business_Unit; HR_Jobs."Global Dimension 2 Code")
            {
            }
            column(Total_Score; HR_Jobs."Total Score")
            {
            }
            column(Main_Obj; HR_Jobs."Main Objective")
            {
            }
            column(Key_Position; HR_Jobs."Key Position")
            {
            }
            column(Job_Category; HR_Jobs.Category)
            {
            }
            column(Job_Grade; HR_Jobs.Grade)
            {
            }
            column(Created_By; HR_Jobs."Created By")
            {
            }
            column(Supervisor_Manager; HR_Jobs."Supervisor/Manager")
            {
            }
            column(Supervisor_Name; HR_Jobs."Supervisor Name")
            {
            }
            column(Jobs_Status; HR_Jobs.Status)
            {
            }
            column(Resp_Center; HR_Jobs."Responsibility Center")
            {
            }
            column(DateCreated; HR_Jobs."Date Created")
            {
            }
            column(Is_Supervisor; HR_Jobs."Is Supervisor")
            {
            }
            column(Job_Level; HR_Jobs."Job Level")
            {
            }
            column(Occupied_Positions; HR_Jobs."Occupied Positions")
            {
            }
            column(Employee_Req; HR_Jobs."Employee Requisitions")
            {
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

