report 51534586 "Approval Entry Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ApprovalEntryReport.rdlc';

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {
            RequestFilterFields = "Date-Time Sent for Approval";
            column(Status_ApprovalEntry; "Approval Entry".Status)
            {
            }
            column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
            {
            }
            column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
            {
            }
            column(ApprovalCode_ApprovalEntry; "Approval Entry"."Approval Code")
            {
            }
            column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
            {
            }
            column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
            {
            }
            column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
            {
            }
            /*column(Stage_ApprovalEntry; "Approval Entry".Stage)
            {
            }
            */
            column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
            {
            }
            column(LastModifiedByID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
            {
            }
            column(Amount_ApprovalEntry; "Approval Entry".Amount)
            {
            }
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
}

