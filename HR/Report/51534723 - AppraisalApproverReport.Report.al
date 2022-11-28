report 51534723 "Appraisal Approver Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AppraisalApproverReport.rdlc';

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            // DataItemTableView = WHERE ("Document Type" = CONST (Appraisal));
            column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
            {
            }
            column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
            {
            }
            column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
            {
            }
            column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
            {
            }
            /*            column(DateApproved_ApprovalEntry; Format("Approval Entry"."Date Approved"))
                        {
                        }
                        column(TimeApproved_ApprovalEntry; Format("Approval Entry"."Time Approved"))
                        {
                        }
                        column(ApproverName_ApprovalEntry; "Approval Entry"."Approver Name")
                        {
                        }
                        */
            column(LastModifiedByID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
            {
            }
            column(Today; Format(Today))
            {
            }
            column(USERID; UserId)
            {
            }
            column(overdue; Overdue)
            {
            }
            column(Status_ApprovalEntry; "Approval Entry".Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Overdue := 'No';
                if Status in [Status::Created, Status::Open] then begin
                    if "Due Date" < Today then
                        Overdue := 'Yes';
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Overdue: Text;
}

