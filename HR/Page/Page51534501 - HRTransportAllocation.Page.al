page 51534501 "HR Transport Allocation"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations H";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transport Allocation No"; "Transport Allocation No")
                {
                    ApplicationArea = all;
                }
                field("Destination(s)"; "Destination(s)")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Reg Number"; "Vehicle Reg Number")
                {
                    ApplicationArea = all;
                }
                field("Passenger Capacity"; "Passenger Capacity")
                {
                    ApplicationArea = all;
                }
                field("Assigned Driver"; "Assigned Driver")
                {
                    ApplicationArea = all;
                }
                field("Driver Name"; "Driver Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Allocation"; "Date of Allocation")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Date of Trip"; "Date of Trip")
                {
                    ApplicationArea = all;
                }
                field("Time of Trip"; "Time of Trip")
                {
                    ApplicationArea = all;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = all;
                }
                field("Linked to Invoice No"; "Linked to Invoice No")
                {
                    ApplicationArea = all;
                }
                field("<Invoice Posting Description>"; "Invoice Description")
                {
                    ApplicationArea = all;
                    Caption = 'Invoice Posting Description';
                    Editable = false;
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
            part("Passenger List"; "HR Transport Requisition Pass")
            {
                Caption = 'Passenger List';
                SubPageLink = "Allocation No" = FIELD("Transport Allocation No");
            }
            group("Closing Remarks")
            {
                Caption = 'Closing Remarks';
                field("Opening Odometer Reading"; "Opening Odometer Reading")
                {
                    ApplicationArea = all;
                }
                field("Closing Odometer Reading"; "Closing Odometer Reading")
                {
                    ApplicationArea = all;
                }
                field("Journey Route"; "Journey Route")
                {
                    ApplicationArea = all;
                }
                field("Time out"; "Time out")
                {
                    ApplicationArea = all;
                }
                field("Time In"; "Time In")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part("HR Transport Allocations Factbo"; "HR Transport Alloc. Factbox")
            {
                Caption = 'HR Transport Allocations Factbox';
                SubPageLink = "Transport Allocation No" = FIELD("Transport Allocation No");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        HRTransportAllocationsH.Reset;
                        HRTransportAllocationsH.SetRange(HRTransportAllocationsH."Transport Allocation No", "Transport Allocation No");
                        if HRTransportAllocationsH.Find('-') then
                            REPORT.RUN(51534529, true, true, HRTransportAllocationsH);
                    end;
                }
                action("<Action1102755035>p")
                {
                    Caption = 'Re-Open';
                    ApplicationArea = all;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Status := Status::Open;
                        Modify;
                        Message('Transport Allocation No :: :: has been Re-Opened', "Transport Allocation No");
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        Question := Text001;
                        if Confirm(Question) then begin
                            Status := Status::Released;
                            Modify;
                            Message('Transport Allocation No :: :: has been released', "Transport Allocation No");
                        end else begin
                            Message('You selected :: NO :: Release Cancelled');
                        end;
                    end;
                }
            }
        }
    }

    var
        HRTransportAllocationsH: Record "HR Transport Allocations H";
        Text19021002: Label 'Passenger List';
        Text001: Label 'Are you sure you want to Release this Document?';
        Question: Text;
}

