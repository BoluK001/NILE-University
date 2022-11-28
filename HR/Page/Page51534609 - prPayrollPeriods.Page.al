page 51534609 "prPayroll Periods"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "prPayroll Periods";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Payroll Periods';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Period Month"; "Period Month")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Period Year"; "Period Year")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Period Name"; "Period Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Date Opened"; "Date Opened")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Date Closed"; "Date Closed")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Closed; Closed)
                {
                    Editable = true;
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Payroll Code"; "Payroll Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Quarter; Quarter)
                {
                    ApplicationArea = all;
                }
                field("Total Working Days"; "Total Working Days")
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
            action("Close Period")
            {
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;  //jj120422  I added

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']';

                    //For Multiple Payroll
                    ContrInfo.Get();
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, 3);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll



                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
        }
    }

    var
        PayPeriod: Record "prPayroll Periods";
        strPeriodName: Text[30];
        Text000: Label '''Leave without saving changes?''';
        Text001: Label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit prPayrollProcessing;
        dtOpenPeriod: Date;
        PayrollType: Record "prPayroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[20];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";

    [Scope('OnPrem')]
    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}

