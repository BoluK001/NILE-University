codeunit 51534356 "Post and Create Workflow"
{

    trigger OnRun()
    begin


    end;

    procedure SendClaimApprovalRequest(ClaimsCode: Code[20]): Boolean
    begin
        Claim.RESET;
        Claim.SETFILTER("No.", ClaimsCode);
        IF Claim.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckStaffClaimApprovalsWorkflowEnable(Claim) THEN
                ApprovalMgt.OnSendStaffClaimForApproval(Claim);

            Claim.RESET;
            Claim.SETFILTER("No.", ClaimsCode);
            IF Claim.FINDFIRST THEN BEGIN
                IF Claim.Status = Claim.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelClaimApprovalRequest(ClaimsCode: Code[20]): Boolean
    begin
        Claim.RESET;
        Claim.SETFILTER("No.", ClaimsCode);
        IF Claim.FINDFIRST THEN BEGIN

            //IF ApprovalMgt.CheckStaffClaimApprovalsWorkflowEnable(Claim) THEN
            ApprovalMgt.OnCancelStaffClaimForApproval(claim);


            Claim.RESET;
            Claim.SETFILTER("No.", ClaimsCode);
            IF Claim.FINDFIRST THEN BEGIN
                IF Claim.Status = Claim.Status::Cancelled THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure RejectClaimApprovalRequest(ClaimsCode: Code[20]): Boolean

    begin
        Claim.RESET;
        Claim.SETFILTER("No.", ClaimsCode);
        IF Claim.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(Claim.RecordId);

            Claim.RESET;
            Claim.SETFILTER("No.", ClaimsCode);
            IF Claim.FINDFIRST THEN BEGIN
                IF Claim.Status = Claim.Status::Open THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateClaimApprovalRequest(ClaimsCode: Code[20]): Boolean

    begin
        Claim.RESET;
        Claim.SETFILTER("No.", ClaimsCode);
        IF Claim.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(Claim.RecordId);

            Claim.RESET;
            Claim.SETFILTER("No.", ClaimsCode);
            IF Claim.FINDFIRST THEN BEGIN
                IF Claim.Status = Claim.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure SendStaffAdvanceApprovalRequest(StaffAdvCode: Code[20]): Boolean

    var

    begin
        StaffAdv.RESET;
        StaffAdv.SETFILTER("No.", StaffAdvCode);
        IF StaffAdv.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckStaffAdvanceApprovalsWorkflowEnable(StaffAdv) THEN
                ApprovalMgt.OnSendStaffAdvanceForApproval(StaffAdv);

            StaffAdv.RESET;
            StaffAdv.SETFILTER("No.", StaffAdvCode);
            IF StaffAdv.FINDFIRST THEN BEGIN
                IF StaffAdv.Status = StaffAdv.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelStaffAdvanceApprovalRequest(StaffAdvCode: Code[20]): Boolean

    var

    begin
        StaffAdv.RESET;
        StaffAdv.SETFILTER("No.", StaffAdvCode);
        IF StaffAdv.FINDFIRST THEN BEGIN

            ApprovalMgt.OnCancelStaffAdvanceForApproval(StaffAdv);

            StaffAdv.RESET;
            StaffAdv.SETFILTER("No.", StaffAdvCode);
            IF StaffAdv.FINDFIRST THEN BEGIN
                IF StaffAdv.Status = StaffAdv.Status::Cancelled THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure RejectStaffAdvanceApprovalRequest(StaffAdvCode: Code[20]): Boolean

    begin
        StaffAdv.RESET;
        StaffAdv.SETFILTER("No.", StaffAdvCode);
        IF StaffAdv.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(StaffAdv.RecordId);

            StaffAdv.RESET;
            StaffAdv.SETFILTER("No.", StaffAdvCode);
            IF StaffAdv.FINDFIRST THEN BEGIN
                IF StaffAdv.Status = StaffAdv.Status::Open THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateStaffAdvanceApprovalRequest(StaffAdvCode: Code[20]): Boolean

    begin
        StaffAdv.RESET;
        StaffAdv.SETFILTER("No.", StaffAdvCode);
        IF StaffAdv.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(StaffAdv.RecordId);

            StaffAdv.RESET;
            StaffAdv.SETFILTER("No.", StaffAdvCode);
            IF StaffAdv.FINDFIRST THEN BEGIN
                IF StaffAdv.Status = StaffAdv.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;


    procedure SendRetirementApprovalRequest(RetirementCode: Code[20]): Boolean

    var

    begin
        Retirement.RESET;
        Retirement.SETFILTER("No.", RetirementCode);
        IF Retirement.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckAdvanceSurrenderApprovalsWorkflowEnable(Retirement) THEN
                ApprovalMgt.OnSendAdvanceSurrenderForApproval(Retirement);

            Retirement.RESET;
            Retirement.SETFILTER("No.", RetirementCode);
            IF Retirement.FINDFIRST THEN BEGIN
                IF Retirement.Status = Retirement.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelRetirementApprovalRequest(RetirementCode: Code[20]): Boolean

    var

    begin
        Retirement.RESET;
        Retirement.SETFILTER("No.", RetirementCode);
        IF Retirement.FINDFIRST THEN BEGIN

            ApprovalMgt.OnCancelAdvanceSurrenderForApproval(Retirement);

            Retirement.RESET;
            Retirement.SETFILTER("No.", RetirementCode);
            IF Retirement.FINDFIRST THEN BEGIN
                IF Retirement.Status = Retirement.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;


    procedure RejectRetirementApprovalRequest(RetirementCode: Code[20]): Boolean

    begin
        Retirement.RESET;
        Retirement.SETFILTER("No.", RetirementCode);
        IF Retirement.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(Retirement.RecordId);

            Retirement.RESET;
            Retirement.SETFILTER("No.", RetirementCode);
            IF Retirement.FINDFIRST THEN BEGIN
                IF Retirement.Status = Retirement.Status::Open THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateRetirementApprovalRequest(RetirementCode: Code[20]): Boolean

    begin
        Retirement.RESET;
        Retirement.SETFILTER("No.", RetirementCode);
        IF Retirement.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(Retirement.RecordId);

            Retirement.RESET;
            Retirement.SETFILTER("No.", RetirementCode);
            IF Retirement.FINDFIRST THEN BEGIN
                IF Retirement.Status = Retirement.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    //Store Requisition Store

    procedure SendStoreReqApprovalRequest(StoreReqCode: Code[20]): Boolean

    var

    begin
        StoreReq.RESET;
        StoreReq.SETFILTER("No.", StoreReqCode);
        IF StoreReq.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckStoreReqApprovalsWorkflowEnable(StoreReq) THEN
                ApprovalMgt.OnSendStoreReqForApproval(StoreReq);

            StoreReq.RESET;
            StoreReq.SETFILTER("No.", StoreReqCode);
            IF StoreReq.FINDFIRST THEN BEGIN
                IF StoreReq.Status = StoreReq.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelStoreReqApprovalRequest(StoreReqCode: Code[20]): Boolean

    var

    begin
        StoreReq.RESET;
        StoreReq.SETFILTER("No.", StoreReqCode);
        IF StoreReq.FINDFIRST THEN BEGIN

            ApprovalMgt.OnCancelStoreReqForApproval(StoreReq);

            StoreReq.RESET;
            StoreReq.SETFILTER("No.", StoreReqCode);
            IF StoreReq.FINDFIRST THEN BEGIN
                IF StoreReq.Status = StoreReq.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;


    procedure RejectStoreReqApprovalRequest(StoreReqCode: Code[20]): Boolean

    begin
        StoreReq.RESET;
        StoreReq.SETFILTER("No.", StoreReqCode);
        IF StoreReq.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(StoreReq.RecordId);

            StoreReq.RESET;
            StoreReq.SETFILTER("No.", StoreReqCode);
            IF StoreReq.FINDFIRST THEN BEGIN
                IF StoreReq.Status = StoreReq.Status::Open THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateStoreReqApprovalRequest(StoreReqCode: Code[20]): Boolean

    begin
        StoreReq.RESET;
        StoreReq.SETFILTER("No.", StoreReqCode);
        IF StoreReq.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(StoreReq.RecordId);

            StoreReq.RESET;
            StoreReq.SETFILTER("No.", StoreReqCode);
            IF StoreReq.FINDFIRST THEN BEGIN
                IF StoreReq.Status = StoreReq.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;
    //End

    //HR Employee Approval

    procedure SendHREmpApprovalRequest(HREmpCode: Code[20]): Boolean

    var

    begin
        HREmp.RESET;
        HREmp.SETFILTER("No.", HREmpCode);
        IF HREmp.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckEmpApprovalsWorkflowEnable(HREmp) then
                ApprovalMgt.OnSendEmpForApproval(HREmp);

            HREmp.RESET;
            HREmp.SETFILTER("No.", HREmpCode);
            IF HREmp.FINDFIRST THEN BEGIN
                IF HREmp.Status = HREmp."Approval Status"::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelHREmpApprovalRequest(HREmpCode: Code[20]): Boolean

    var

    begin
        HREmp.RESET;
        HREmp.SETFILTER("No.", HREmpCode);
        IF HREmp.FINDFIRST THEN BEGIN

            ApprovalMgt.OnCancelEmpForApproval(HREmp);

            HREmp.RESET;
            HREmp.SETFILTER("No.", HREmpCode);
            IF HREmp.FINDFIRST THEN BEGIN
                IF (HREmp.Status = HREmp."Approval Status"::Approved) or (HREmp.Status = HREmp."Approval Status"::New) THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;


    procedure RejectHREmpApprovalRequest(HREmpCode: Code[20]): Boolean

    begin
        HREmp.RESET;
        HREmp.SETFILTER("No.", HREmpCode);
        IF HREmp.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(HREmp.RecordId);

            HREmp.RESET;
            HREmp.SETFILTER("No.", HREmpCode);
            IF HREmp.FINDFIRST THEN BEGIN
                IF HREmp.Status = HREmp."Approval Status"::New THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateHREmpApprovalRequest(HREmpCode: Code[20]): Boolean

    begin
        HREmp.RESET;
        HREmp.SETFILTER("No.", HREmpCode);
        IF HREmp.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(HREmp.RecordId);

            HREmp.RESET;
            HREmp.SETFILTER("No.", HREmpCode);
            IF HREmp.FINDFIRST THEN BEGIN
                IF HREmp.Status = HREmp."Approval Status"::Approved THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;
    //End

    //Leave Application

    procedure SendLeaveAppApprovalRequest(LeaveAppCode: Code[20]): Boolean

    var

    begin
        LeaveApp.RESET;
        LeaveApp.SETFILTER("Application Code", LeaveAppCode);
        IF LeaveApp.FINDFIRST THEN BEGIN

            IF ApprovalMgt.CheckHRLeaveAppApprovalsWorkflowEnable(LeaveApp) THEN
                ApprovalMgt.OnSendHRLeaveAppForApproval(LeaveApp);

            LeaveApp.RESET;
            LeaveApp.SETFILTER("Application Code", LeaveAppCode);
            IF LeaveApp.FINDFIRST THEN BEGIN
                IF LeaveApp.Status = LeaveApp.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure CancelLeaveAppApprovalRequest(LeaveAppCode: Code[20]): Boolean

    var

    begin
        LeaveApp.RESET;
        LeaveApp.SETFILTER("Application Code", LeaveAppCode);
        IF LeaveApp.FINDFIRST THEN BEGIN

            ApprovalMgt.OnCancelHRLeaveAppForApproval(LeaveApp);

            LeaveApp.RESET;
            LeaveApp.SETFILTER("Application Code", LeaveAppCode);
            IF LeaveApp.FINDFIRST THEN BEGIN
                IF LeaveApp.Status = LeaveApp.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;


    procedure RejectLeaveAppApprovalRequest(LeaveAppCode: Code[20]): Boolean

    begin
        LeaveApp.RESET;
        LeaveApp.SETFILTER("Application Code", LeaveAppCode);
        IF LeaveApp.FINDFIRST THEN BEGIN

            ApprovalsMgt.RejectRecordApprovalRequest(LeaveApp.RecordId);

            LeaveApp.RESET;
            LeaveApp.SETFILTER("Application Code", LeaveAppCode);
            IF LeaveApp.FINDFIRST THEN BEGIN
                IF LeaveApp.Status = LeaveApp.Status::New THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;

        END;
    end;

    procedure DelegateLeaveAppApprovalRequest(LeaveAppCode: Code[20]): Boolean

    begin
        LeaveApp.RESET;
        LeaveApp.SETFILTER("Application Code", LeaveAppCode);
        IF LeaveApp.FINDFIRST THEN BEGIN

            ApprovalsMgt.DelegateRecordApprovalRequest(LeaveApp.RecordId);

            LeaveApp.RESET;
            LeaveApp.SETFILTER("Application Code", LeaveAppCode);
            IF LeaveApp.FINDFIRST THEN BEGIN
                IF LeaveApp.Status = LeaveApp.Status::"Pending Approval" THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END;
        END;
    end;
    //
    //
    //


    var
        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
        StaffAdv: Record "Staff Advance Header";
        Retirement: Record "Staff Advance Surrender Header";
        Claim: Record "Staff Claims Header";
        ApprovalsMgt: Codeunit "Approvals Mgmt.";
        StoreReq: Record "Store Requisition Header";
        HREmp: Record "Hr Employees";
        LeaveApp: Record "HR Leave Application";

}
