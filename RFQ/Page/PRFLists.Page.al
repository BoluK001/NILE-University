page 51534356 "PRF Lists"
{
    PageType = List;
    //Caption = 
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = CONST(Quote), Duty = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
    }

    [Scope('OnPrem')]
    procedure SetSelection(var Collection: Record "Purchase Line")
    begin
        CurrPage.SETSELECTIONFILTER(Collection);
    end;
}

