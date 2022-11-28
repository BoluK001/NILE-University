report 51534524 "HR Clearance Exit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRClearanceExit.rdlc';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            column(EmployeeNo_HREmployeeExitInterviews; "HR Employee Exit Interviews"."Employee No.")
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

