page 51534485 "HR Transport Requisition Pass"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Transport Allocations";
    SourceTableView = SORTING("Allocation No", "Requisition No");
    AdditionalSearchTerms = 'HR Transport Requisition Pass';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Requisition No"; "Requisition No")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = all;
                }
                field("Passenger/s Full Name/s"; "Passenger/s Full Name/s")
                {
                    Editable = false;
                }
                field(From; From)
                {
                    ApplicationArea = all;
                }
                field("To"; "To")
                {
                    ApplicationArea = all;
                }
                field(Dept; Dept)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

