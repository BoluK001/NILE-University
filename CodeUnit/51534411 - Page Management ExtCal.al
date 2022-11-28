codeunit 51534411 "Page Management ExtCal"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    var
        CardPageID: Integer;
        VoucherHeader: Record "Voucher Header";
        HRAppraisal: Record "HR Appraisal Goal Setting H";
        HREmpReq: Record "HR Employee Requisitions";
    begin
        case RecordRef.Number of
            DATABASE::"Voucher Header":
                //exit(GetVoucherHeaderPageID(RecordRef));
                begin
                    RecordRef.SetTable(VoucherHeader);
                    case VoucherHeader."Voucher Type" of
                        VoucherHeader."Voucher Type"::BPV:
                            exit(PAGE::"Bank Payment Voucher");
                        VoucherHeader."Voucher Type"::BRV:
                            exit(PAGE::"Bank Receipt Voucher");
                        VoucherHeader."Voucher Type"::CPV:
                            exit(PAGE::"Cash Payment Voucher");
                        VoucherHeader."Voucher Type"::CRV:
                            exit(PAGE::"Cash Receipt Voucher");
                        VoucherHeader."Voucher Type"::JV:
                            exit(PAGE::"Journal Voucher");
                        VoucherHeader."Voucher Type"::PettyCash:
                            exit(PAGE::"Petty Cash Voucher");
                    end;
                end;

            DATABASE::"Staff Advance Header":
                exit(PAGE::"Staff Advance Request");
            DATABASE::"Staff Advance Surrender Header":
                exit(PAGE::"Staff Advance Accounting");
            DATABASE::"G/L Account":
                exit(PAGE::"G/L Account Card");
            DATABASE::"Staff Claims Header":
                exit(PAGE::"Staff Claim");
            //DATABASE::"FA Budget Entry Transfer":
            //    exit(PAGE::"Capex Budget Transfer");
            //DATABASE::"FA Budget Entry Transfer":
            //    exit(PAGE::"Capex Budget Transfers");
            DATABASE::"HR Jobs":
                exit(PAGE::"HR Jobs Card");
            DATABASE::"HR Employees":
                exit(PAGE::"HR Employee Card");
            DATABASE::"HR HMO":
                exit(PAGE::"HR HMO Card");
            DATABASE::"HR Training Applications":    //JJ280922
                exit(PAGE::"HR Training Application Card");
            DATABASE::"HR Emp. Transaction Header":
                exit(PAGE::"Employee Transaction Header");
            DATABASE::"HR Leave Acknowledgement":
                exit(PAGE::"HR Leave Acknowledgement");
            DATABASE::"HR Employee Requisitions":
                exit(PAGE::"HR Employee Requisition Card");
            DATABASE::"Store Requisition Header":
                exit(PAGE::"Store Requisition Header");
            DATABASE::"HR Appraisal Goal Setting H":
                begin
                    RecordRef.SetTable(HRAppraisal);
                    case HRAppraisal."Appraisal Half" of
                        HRAppraisal."Appraisal Half"::Second:
                            exit(PAGE::"HR Appraisal Goal Setting H Se");
                        HRAppraisal."Appraisal Half"::First:
                            exit(PAGE::"HR Appraisal Goal Setting H");
                    end;
                end;
            DATABASE::"HR Leave Application":
                exit(PAGE::"HR Leave Application Card");
        end;
    end;

    local procedure GetVoucherHeaderPageID(RecordRef: RecordRef): Integer
    var
        VoucherHeader: Record "Voucher Header";
    begin
        RecordRef.SETTABLE(VoucherHeader);
        CASE VoucherHeader."Voucher Type" OF
            VoucherHeader."Voucher Type"::BPV:
                EXIT(PAGE::"Bank Payment Voucher");
            VoucherHeader."Voucher Type"::BRV:
                EXIT(PAGE::"Bank Receipt Voucher");
            VoucherHeader."Voucher Type"::CRV:
                EXIT(PAGE::"Cash Receipt Voucher");
            VoucherHeader."Voucher Type"::CPV:
                EXIT(PAGE::"Cash Payment Voucher");
            VoucherHeader."Voucher Type"::PettyCash:
                EXIT(PAGE::"Petty Cash Voucher");
            VoucherHeader."Voucher Type"::JV:
                EXIT(PAGE::"Journal Voucher");
        END;
    end;
    /*
        local procedure GetVoucherHeaderListPageID(RecRef: RecordRef): Integer
        var
            VoucherHeader: Record "Voucher Header";
        begin
            RecRef.SetTable(VoucherHeader);
            case VoucherHeader."Voucher Type" of
                VoucherHeader."Voucher Type"::BPV:
                    exit(PAGE::"Bank Payment List");
                VoucherHeader."Voucher Type"::BRV:
                    exit(PAGE::"Bank Receipt  List");
                VoucherHeader."Voucher Type"::Contra:
                    exit(PAGE::"Contra Voucher List");
                VoucherHeader."Voucher Type"::CPV:
                    exit(PAGE::"Cash Payment List");
                VoucherHeader."Voucher Type"::CRV:
                    exit(PAGE::"Cash Receipt  List");
                VoucherHeader."Voucher Type"::JV:
                    exit(PAGE::"Journal Voucher List");
                VoucherHeader."Voucher Type"::PettyCash:
                    exit(PAGE::"Petty Cash List");
            end;
        end;

        procedure GetConditionalListPageID(RecRef: RecordRef): Integer
        var
            PageID: Integer;
            IsHandled: Boolean;
        begin
            IsHandled := false;
            OnBeforeGetConditionalListPageID(RecRef, PageID, IsHandled);
            if IsHandled then
                exit(PageID);

            case RecRef.Number of
                DATABASE::"Voucher Header":
                    exit(GetVoucherHeaderListPageID(RecRef));
            end;
            exit(0);
        end;
    */
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetConditionalListPageID(RecRef: RecordRef; var PageID: Integer; var IsHandled: Boolean);
    begin
    end;
}

