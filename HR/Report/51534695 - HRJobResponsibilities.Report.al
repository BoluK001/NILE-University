report 51534695 "HR Job Responsibilities"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRJobResponsibilities.rdlc';

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Job ID";
            column(JobDescription_HRJobs; "HR Jobs"."Job Title")
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            dataitem("HR Job Responsiblities"; "HR Job Responsiblities")
            {
                DataItemLink = "Job ID" = FIELD("Job ID");
                DataItemTableView = SORTING("Job ID");
                PrintOnlyIfDetail = false;
                column(JobID_HRJobResponsiblities; "HR Job Responsiblities"."Job ID")
                {
                    IncludeCaption = true;
                }
                column(ResponsibilityDescription_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Description")
                {
                    IncludeCaption = true;
                }
                column(Remarks_HRJobResponsiblities; "HR Job Responsiblities".Remarks)
                {
                    IncludeCaption = true;
                }
                column(ResponsibilityCode_HRJobResponsiblities; "HR Job Responsiblities"."Responsibility Code")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin

                    No := No + 1;
                end;

                trigger OnPreDataItem()
                begin

                    No := 0;
                end;
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

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
        No := 1;
    end;

    var
        CI: Record "Company Information";
        No: Integer;
}

