page 51534604 "HR WebService Role Cent"
{
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control10)
            {
                ShowCaption = false;
                systempart(Control7; Outlook)
                {
                    ApplicationArea = all;
                }
            }
            group(Control6)
            {
                ShowCaption = false;
                part(Control5; "My Job Queue")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                part(Control4; "My Customers")
                {
                    ApplicationArea = all;
                }
                part(Control3; "My Vendors")
                {
                    ApplicationArea = all;
                }
                systempart(Control1; MyNotes)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(sections)
        {
            group("Hr Self Service")
            {
                action("My Profile")
                {
                    Caption = 'My Profile';
                    RunObject = Page "HR Employee List Self";
                }
                action(HMO)
                {
                    Caption = 'HMO';
                    RunObject = Page "HR HMO List Self";
                }
                action("Canteen Application")
                {
                    Caption = 'Canteen Application';
                    RunObject = Page "HR Canteen App List Self";
                }
                action("Leave Application")
                {
                    Caption = 'Leave Application';
                    RunObject = Page "HR Leave Apps List Self";
                }
                action("Query")
                {
                    Caption = 'Query';
                    RunObject = Page "HR Query List";
                    RunPageView = WHERE("User ID" = FILTER('USERID'));
                }
                action("My Training Application")
                {
                    Caption = 'My Training Application';
                    RunObject = Page "HR Training Application List";
                    RunPageView = WHERE("User ID" = FILTER('USERID'));
                }
                action("My Appraisal Goal Setting")
                {
                    Caption = 'My Appraisal Goal Setting';
                    RunObject = Page "Appraisal Goal Setting List";
                }
            }
            /*
            group("Employee Tasks")
            {
                Caption = 'Employee Tasks';
                action("Staff Advance Requests")
                {
                    Caption = 'Staff Advance Requests';
                    RunObject = Page "Staff Advance Request List";
                }
                action("Staff Advance Retire")
                {
                    Caption = 'Staff Advance Retire';
                    RunObject = Page "Staff Advance Surrender List";
                }
                action("Staff Claims")
                {
                    Caption = 'Staff Claims';
                    RunObject = Page "Staff Claims List";
                }
                action("Payment Requests")
                {
                    Caption = 'Payment Requests';
                    RunObject = Page "Payment Request Lists";
                }
                action("Payment Vouchers")
                {
                    Caption = 'Payment Vouchers';
                    RunObject = Page "Payment Vouchers List";
                }
                action("Cash Vouchers")
                {
                    Caption = 'Cash Vouchers';
                    RunObject = Page "Petty Cash Vouchers List";
                }
                action("Store Requisitions")
                {
                    Caption = 'Store Requisitions';
                    RunObject = Page "Store Requisition List";
                }
                action("Request for Quotation")
                {
                    RunObject = Page "RFQ List";
                }
                action("Purchase Requisitions")
                {
                    Caption = 'Purchase Requisitions';
                    RunObject = Page Requisitions;
                    Visible = true;
                }
            }
            */ //RBS
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Approval Entries")
                {
                    Caption = 'Approval Entries';
                    RunObject = Page "Approval Entries";
                }
                action("Approval Request Entries")
                {
                    Caption = 'Approval Request Entries';
                    RunObject = Page "Approval Request Entries";
                }
            }
        }
    }
}

