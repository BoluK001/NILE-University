report 51534791 "Export Job App"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            RequestFilterHeading = 'Export Job Application';
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

        CODEUNIT.Run(39005566)
    end;
}

