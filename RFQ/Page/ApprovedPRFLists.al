page 51534375 "Approved PRF Lists"
{
    ApplicationArea = All;
    Caption = 'Approved PR List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = CONST(Quote), "Purchase Type" = filter(Requisition), Status = filter(Released));
    Deleteallowed = false;  //jj290522
    Editable = false;   //jj290522


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
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Purchase Type"; "Purchase Type")
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

    trigger OnOpenPage()
    var
        PHeader: Record "Purchase Header";
        PLine: Record "Purchase Line";
    begin
        //If PHeader.Get("Document No.") then begin
        PHeader.SetRange("No.", "Document No.");
        PHeader.Setrange(Status, pheader.Status::Released);
        //PHeader.SetRange("No.", "Document No.");
        // end;
    end;
}


