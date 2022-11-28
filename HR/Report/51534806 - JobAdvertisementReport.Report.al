report 51534806 "Job Advertisement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './JobAdvertisementReport.rdlc';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            RequestFilterFields = "Requisition No.", "Job ID";
            column(Job; "HR Employee Requisitions"."Job ID")
            {
            }
            column(JobDecription; "HR Employee Requisitions"."Job Description")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(ClosingDate; "HR Employee Requisitions"."Closing Date")
            {
            }
            column(Picture; ComanyInfo.Picture)
            {
            }
            column(CompanyName; ComanyInfo.Name)
            {
            }
            column(Address; ComanyInfo.Address)
            {
            }
            column(Email; ComanyInfo."E-Mail")
            {
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job Id" = FIELD ("Job ID");
                column(QualificationCode; "HR Job Requirements"."Qualification Code")
                {
                }
                column(Description; "HR Job Requirements"."Qualification Description")
                {
                }
            }
            dataitem("HR Job Responsiblities"; "HR Job Responsiblities")
            {
                DataItemLink = "Job ID" = FIELD ("Job ID");
                column(Detail; "HR Job Responsiblities"."Responsibility Description")
                {
                }
                column(Remarks; "HR Job Responsiblities".Remarks)
                {
                }
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

    trigger OnInitReport()
    begin
        if ComanyInfo.Get() then
            ComanyInfo.CalcFields(ComanyInfo.Picture);
    end;

    var
        ComanyInfo: Record "Company Information";
        StartDate: Date;
}

