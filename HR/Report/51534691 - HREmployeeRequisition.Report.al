report 51534691 "HR Employee Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeRequisition.rdlc';

    dataset
    {
        dataitem("HR Employee Requisitions"; "HR Employee Requisitions")
        {
            PrintOnlyIfDetail = true;
            column(RequisitionNo_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition No.")
            {
                IncludeCaption = true;
            }
            column(JobDescription_HREmployeeRequisitions; "HR Employee Requisitions"."Job Description")
            {
                IncludeCaption = true;
            }
            column(JobGrade_HREmployeeRequisitions; "HR Employee Requisitions"."Job Grade")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_HREmployeeRequisitions; "HR Employee Requisitions"."Shortcut Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            column(ReasonforRequestOther_HREmployeeRequisitions; "HR Employee Requisitions"."Reason for Request(Other)")
            {
                IncludeCaption = true;
            }
            column(ReasonForRequest_HREmployeeRequisitions; "HR Employee Requisitions"."Reason For Request")
            {
                IncludeCaption = true;
            }
            column(TypeofContractRequired_HREmployeeRequisitions; "HR Employee Requisitions"."Type of Contract Required")
            {
                IncludeCaption = true;
            }
            column(AnyAdditionalInformation_HREmployeeRequisitions; "HR Employee Requisitions"."Any Additional Information")
            {
                IncludeCaption = true;
            }
            column(RequisitionDate_HREmployeeRequisitions; "HR Employee Requisitions"."Requisition Date")
            {
                IncludeCaption = true;
            }
            column(JobSupervisorManager_HREmployeeRequisitions; "HR Employee Requisitions"."Job Supervisor/Manager")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Requisition No.");
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.") ORDER(Ascending) WHERE(Status = CONST(Approved));
                column(Comment_ApprovalEntry; "Approval Entry".Comment)
                {
                    IncludeCaption = true;
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                    IncludeCaption = true;
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                    IncludeCaption = true;
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(LastModifiedByID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    DataItemTableView = SORTING("User ID") ORDER(Ascending);
                    column(UserID_UserSetup; "User Setup"."User ID")
                    {
                        IncludeCaption = true;
                    }
                }
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

    trigger OnPreReport()
    begin
        CI.Reset;
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
}

