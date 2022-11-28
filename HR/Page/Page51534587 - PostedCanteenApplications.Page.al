page 51534587 "Posted Canteen Applications"
{
    Caption = 'HR Meal Ticket  List';
    CardPageID = "HR Canteen Application Card";
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Meal Ticket  List';
    SourceTable = "Hr Canteen Application";
    SourceTableView = WHERE(Posted = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ticket No."; "Ticket No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = all;
                }
                field("Visitor Name"; "Visitor Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action2)
            {
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(CanteenApp);
                    if CanteenApp.FindFirst then begin
                        repeat
                            if Posted = true then
                                exit;
                            CanteenApp.TestField("Payroll Period");
                            CanteenApp.TestField(Status, Status::Approved);
                            objPeriod.Reset;
                            objPeriod.SetRange(objPeriod.Closed, false);
                            if objPeriod.Find('-') then begin
                                if CanteenApp."Payroll Period" = objPeriod."Date Opened" then begin
                                    //PrEmpTrans.INIT;
                                    //PrEmpTrans.TRANSFERFIELDS(Rec);
                                    PrEmpTrans.Reset;
                                    PrEmpTrans.Init;
                                    PrEmpTrans."Employee Code" := CanteenApp."Employee No.";
                                    PrEmpTrans."Transaction Code" := CanteenApp."Transaction Code";
                                    PrEmpTrans."Transaction Name" := CanteenApp."Transaction Name";
                                    PrEmpTrans.Amount := CanteenApp.Amount;
                                    PrEmpTrans."Payroll Period" := CanteenApp."Payroll Period";
                                    PrEmpTrans."Period Month" := CanteenApp."Period Month";
                                    PrEmpTrans."Period Year" := CanteenApp."Period Year";
                                    PrEmpTrans."Start Date" := CanteenApp."Start Date";
                                    PrEmpTrans.Insert;
                                    CanteenApp.Posted := true;
                                    CanteenApp.Modify;
                                    Message('Meal Ticket %1 successfully processed for employee %2', "Transaction Code", "Employee No.");
                                end
                                else begin
                                    // CanteenApp.Posted:=TRUE;
                                    //CanteenApp.MODIFY;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                                    //MESSAGE('Meal Ticket %1 successfully processed for employee %2',"Transaction Code","Employee No.");
                                end
                            end
                        /*ELSE BEGIN
                          Posted:=TRUE;
                          MODIFY;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                          MESSAGE('Meal Ticket %1 successfully processed for employee %2',"Transaction Code","Employee No.");
                        END
                        */
                        until CanteenApp.Next = 0;
                        //MESSAGE('Meal Ticket successfully processed for the selected employees');

                    end;

                end;
            }
            action("Posted Canteen Application")
            {
                Caption = 'Posted Canteen Application';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //RunObject = Report Report39003922; RBS
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*FILTERGROUP(2);
        SETFILTER("User ID",USERID);
        FILTERGROUP(0);
         */

    end;

    var
        Usersetup: Record "User Setup";
        objTransCodes: Record "prTransaction Codes";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        objEmpTrans: Record "prEmployee Transactions";
        transType: Text[30];
        PRTransactions: Record "prTransaction Codes";
        PrEmpTrans: Record "prEmployee Transactions";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO;
        CanteenApp: Record "Hr Canteen Application";
}

