page 51534456 "HR Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
             group(Appraisal)
             {
                 Caption = 'Appraisal';
                 field("Appraisal Period"; "Appraisal Period")
                 {
                     ApplicationArea = all;
                 }
                /* field("Open Period"; "Open Period")
                 {
                     ApplicationArea = all;
                     Editable = false;
                 } */     //jj300922
             }   
            group(General)
            {
                Caption = 'General';
                field("Base Calendar"; "Base Calendar")
                {
                    ApplicationArea = all;
                }
                field("Meal Amount"; "Meal Amount")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Company's Group Email"; "Company's Group Email")
                {
                    ApplicationArea = all;
                }
                field("Shared Document  Path"; "Shared Document  Path")
                {
                    ApplicationArea = all;
                }
                field("Confirmation Nos"; "Confirmation Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Loan Amount %"; "Loan Amount %")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj300922
                    Visible = false;
                }
            }
            group(Control10)
            {
                Caption = 'General';
                field("Leave Posting Period[FROM]"; "Leave Posting Period[FROM]")
                {
                    ApplicationArea = all;
                }
                field("Leave Posting Period[TO]"; "Leave Posting Period[TO]")
                {
                    ApplicationArea = all;
                }
                field("Default Leave Posting Template"; "Default Leave Posting Template")
                {
                    ApplicationArea = all;
                }
                field("Default Leave Posting Batch"; "Default Leave Posting Batch")
                {
                    ApplicationArea = all;
                }
                field("Annual Leave Qualification"; "Annual Leave Qualification")
                {
                    ApplicationArea = all;
                }
                field("Leave Allowance Days"; "Leave Allowance Days")
                {
                    ApplicationArea = all;
                }
                field("Maternity Leave Period"; "Maternity Leave Period")
                {
                    ApplicationArea = all;
                }
                field("Forfeit Leave After"; "Forfeit Leave After")
                {
                    ApplicationArea = all;
                }
                field("Current Leave Period"; "Current Leave Period")
                {
                    ApplicationArea = all;
                }
                field("Maternity Application Before"; "Maternity Application Before")
                {
                    ApplicationArea = all;
                }
                field("Leave Application Before"; "Leave Application Before")
                {
                    ApplicationArea = all;
                }
                field("Training Application Before"; "Training Application Before")
                {
                    ApplicationArea = all;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Employee Nos."; "Employee Nos.")
                {
                    ApplicationArea = all;
                }
                field("Training Application Nos."; "Training Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Leave Application Nos."; "Leave Application Nos.")
                {
                    ApplicationArea = all;
                }
                field("Disciplinary Cases Nos."; "Disciplinary Cases Nos.")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Transport Req Nos"; "Transport Req Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Employee Requisition Nos."; "Employee Requisition Nos.")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Job Application Nos"; "Job Application Nos")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Nos"; "Exit Interview Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Appraisal Nos"; "Appraisal Nos")
                {
                    ApplicationArea = all;
                    // visible = false;  //jj300922
                }
                field("Company Activities"; "Company Activities")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Job Interview Nos"; "Job Interview Nos")
                {
                    ApplicationArea = all;
                }
                field("Ticket Nos"; "Ticket Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Loan Nos"; "Loan Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Career Event"; "Career Event")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Training Need Nos"; "Training Need Nos")
                {
                    ApplicationArea = all;
                }
                field("Leave Acknowledgement Nos"; "Leave Acknowledgement Nos")
                {
                    ApplicationArea = all;
                }
                field("Employee ID Nos"; "Employee ID Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
                field("Transaction Nos"; "Transaction Nos")
                {
                    ApplicationArea = all;
                    visible = false;  //jj300922
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action20)
            {
                // action("Open Employee Details")
                // {
                //     Image = ClosePeriod;
                //     Promoted = true;
                //     ApplicationArea = all;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = false;  //jj300922

                //     trigger OnAction()
                //     begin
                //         if not Confirm('Are you sure you want open employee details for updates', false) then
                //             exit;

                //         HRSetup.Get;
                //         HRSetup."Open Period" := true;
                //         HRSetup.Modify;


                //         /*AppraisalLines.SETRANGE(AppraisalLines."Appraisal Period","Appraisal Period");
                //         AppraisalLines.SETRANGE(AppraisalLines.Half,AppraisalLines.Half::" ");
                //         AppraisalLines.SETRANGE(AppraisalLines."Submit to HR",FALSE);
                //         IF AppraisalLines.FINDFIRST THEN BEGIN
                //          REPEAT
                //           AppraisalLines."Submit to HR":=TRUE;
                //           AppraisalLines.MODIFY;
                //          UNTIL AppraisalLines.NEXT = 0;
                //         END;
                //         */
                //         Message('Employees have been notified');

                //     end;
                // }
                // action("Reopen Approved Docs")
                // {
                //     ApplicationArea = All;
                //     visible = false;  //jj300922

                //     trigger OnAction()
                //     begin
                //         if UserSetup.Get(UserId) then
                //             if UserSetup."Reopen Doc" then begin
                //                 AppraisalHeader.SetRange(AppraisalHeader."Appraisal Period", "Appraisal Period");
                //                 if AppraisalHeader.FindFirst then
                //                     repeat
                //                         AppraisalHeader.Status := AppraisalHeader.Status::Open;
                //                         AppraisalHeader.Modify;
                //                     until AppraisalHeader.Next = 0;

                //                 Message('Appraisal Period Open for new half');
                //             end else
                //                 Error('you do not have permissons to perform this activity');
                //     end;
                // }
                action("Leave Period List")
                {
                    Caption = 'Leave Period List';
                    Image = List;
                    ApplicationArea = all;
                    Promoted = true;
                    RunObject = Page "HR Leave Period List";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;

    var
        AppraisalLines: Record "HR Appraisal Goal Setting L";
        HRSetup: Record "HR Setup";
        AppraisalHeader: Record "HR Appraisal Goal Setting H";
        UserSetup: Record "User Setup";
}

