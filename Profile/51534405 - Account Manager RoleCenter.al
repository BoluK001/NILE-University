pageextension 51534405 ExtendNavigationArea extends "Accounting Manager Role Center"
{
    layout
    {
        addafter("User Tasks Activities")
        {
            part("Purchase Agent Activities"; "Purchase Agent Activities")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {


        addafter(Vendors)
        {
            action("Vendors(WHT)")
            {
                RunObject = page "Vendor WHT";
                ApplicationArea = All;
            }
            action("Students")
            {
                RunObject = page "Student List";
                ApplicationArea = All;
            }
            action("Recurring General Journal")
            {
                RunObject = page "Recurring General Journal";
                ApplicationArea = All;
            }
        }
        addafter("Fixed Assets")
        {
            group("Vouchers")
            {
                //Caption = 'Documents';
                //group("Voucher Documents")
                //{
                //Caption = 'Documents';
                action("Bank Payment")
                {
                    RunObject = page "Bank Payment List";
                    ApplicationArea = All;
                }
                action("Bank Receipt")
                {
                    RunObject = page "Bank Receipt List";
                    ApplicationArea = All;
                }
                action("Cash Receipt")
                {
                    RunObject = page "Cash Receipt List";
                    ApplicationArea = All;
                }
                action("Cash Payment")
                {
                    RunObject = page "Cash Payment List";
                    ApplicationArea = All;
                }
                action("Petty Cash")
                {
                    RunObject = page "Petty Cash List";
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Journal Voucher")
                {
                    RunObject = page "Journal Voucher List";
                    ApplicationArea = All;
                }
            }
            group("Posted Vouchers")
            {
                Caption = 'Posted Vouchers';
                action("Posted JV")
                {
                    RunObject = page "Posted Voucher List";
                    ApplicationArea = All;
                }
                action("Posted CPV")
                {
                    RunObject = page "Posted CPV List";
                    ApplicationArea = All;
                }
                action("Posted CRV")
                {
                    RunObject = page "Posted CRV List";
                    ApplicationArea = All;
                }
                action("Posted BPV")
                {
                    RunObject = page "Posted BPV List";
                    ApplicationArea = All;
                }
                action("Posted BRV")
                {
                    RunObject = page "Posted BRV List";
                    ApplicationArea = All;
                }
                action("Posted Petty Cash")
                {
                    RunObject = page "Posted Petty Cash List";
                    ApplicationArea = All;
                }
            }
            // }

            group("Self Service")
            {
                group("Advance/Retirement/Claim")
                {
                    action("Staff Advance Request")
                    {
                        RunObject = page "Staff Advance Request List";
                        ApplicationArea = All;
                    }
                    action("Approved Staff Advance")
                    {
                        RunObject = page "Staff Advance Request List.";
                        ApplicationArea = All;
                        Visible = false;
                    }
                    action("Staff Advance Surrender")
                    {
                        Caption = 'Staff Advance Retirement';
                        RunObject = page "Staff Advance Surrender List";
                        ApplicationArea = All;
                    }
                    action("Staff Claims")
                    {
                        RunObject = page "Staff Claims List";
                        ApplicationArea = All;
                    }
                }
                group("Posted Advance Doc.")
                {
                    Caption = 'Posted Documents';
                    action("Posted Staff Advance Request")
                    {
                        RunObject = page "Posted Staff Advance Requests";
                        ApplicationArea = All;
                    }
                    action("Posted Retirements")
                    {
                        Caption = 'Posted Advance Retirement';
                        RunObject = page "Posted Staff Advance Surrender";
                        ApplicationArea = All;
                    }
                    action("Posted Staff Claims")
                    {
                        RunObject = page "Posted Staff Claims List";
                        ApplicationArea = All;
                    }
                }
            }
            group("Student Transaction Data")
            {
                action("SIS Student Details")
                {
                    RunObject = page SISStudentDetails;
                    ApplicationArea = All;
                }
                action("Payments Detail")
                {
                    RunObject = page "Payments Detail";
                    ApplicationArea = All;
                }

                action("Bank Allocation Setup")
                {
                    RunObject = page "Bank Allocation Setup";
                    ApplicationArea = All;
                }
            }
        }
        addafter("Posted Documents")
        {
            group(Approvals)
            {
                action("Requests to Approve")
                {
                    RunObject = page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("Approval Request Entries")
                {
                    RunObject = page "Approval Request Entries";
                    ApplicationArea = All;
                }
            }
        }
        addlast(Administration)
        {
            action("Collection Distr. Setup")
            {
                Caption = 'Collection Distr. Setup';
                RunObject = page "Collection Distribution Setup";
                ApplicationArea = all;
            }
            action("Receipt and Payment Types")
            {
                ApplicationArea = all;
                Caption = 'Receipt and Payment Types';
                RunObject = page "Receipt and Payment Types List";
            }

        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
        modify(Journals)
        {
            Visible = false;
        }
    }


}