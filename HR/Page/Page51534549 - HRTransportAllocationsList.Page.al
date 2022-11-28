page 51534549 "HR Transport Allocations List"
{
    CardPageID = "HR Transport Allocation";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations H";
    AdditionalSearchTerms = 'HR Transport Allocations List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Transport Allocation No"; "Transport Allocation No")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Destination(s)"; "Destination(s)")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Vehicle Reg Number"; "Vehicle Reg Number")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Passenger Capacity"; "Passenger Capacity")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Assigned Driver"; "Assigned Driver")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Driver Name"; "Driver Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Allocation"; "Date of Allocation")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Trip"; "Date of Trip")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Time of Trip"; "Time of Trip")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Comments; Comments)
                {
                }
                field("Linked to Invoice No"; "Linked to Invoice No")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("<Invoice Posting Description>"; "Invoice Description")
                {
                    Caption = 'Invoice Posting Description';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
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
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

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
                    ApplicationArea = all;
                    Caption = 'Re-Open';
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
                    ApplicationArea = all;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

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
        area(reporting)
        {
            action("Transport Allocations")
            {
                ApplicationArea = all;
                Caption = 'Transport Allocations';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Transport Allocations";
            }
        }
    }

    var
        HRTransportAllocationsH: Record "HR Transport Allocations H";
        Text19021002: Label 'Passenger List';
        Text001: Label 'Are you sure you want to Release this Document?';
        Question: Text;
}

