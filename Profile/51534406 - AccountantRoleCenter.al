pageextension 51534406 AccountantRoleCenter extends "Accountant Role Center"
{

    actions
    {
        addafter(Vendors)
        {
            action("Students")
            {
                RunObject = page "Student List";
                ApplicationArea = All;
            }
        }
        addafter(Action16)
        {
            group("Vouchers")
            {
                //Caption = 'Documents';
                //group("Voucher Document")
                //{
                Caption = 'Documents';
                action("Bank Payment Voucher")
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
                Caption = 'Posted Documents';
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
            //}

            group("Self Service")
            {
                group("Advance/Retirement/Claim")
                {
                    action("Staff Advance Request1")
                    {
                        RunObject = page "Staff Advance Request List";
                        ApplicationArea = All;
                    }
                    action("Approved Staff Advance")
                    {
                        //RunObject = page "Approved Staff Advances";
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
                    action("Staff Advance Request")
                    {
                        RunObject = page "Satff Advance Req List";
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
                        RunObject = page "Posted Staff Advance Requests";
                        ApplicationArea = All;
                    }
                    action("Posted Staff Claims")
                    {
                        RunObject = page "Posted Staff Claims List";
                        ApplicationArea = All;
                    }
                }
            }
        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
    }

}


