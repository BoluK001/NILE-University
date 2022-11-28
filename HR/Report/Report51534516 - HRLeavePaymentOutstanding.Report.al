report 51534516 "HR Leave Payment / Outstanding"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRLeavePaymentOutstanding.rdlc';

    dataset
    {
        dataitem("Voucher Header"; "Voucher Header")
        {
            DataItemTableView = WHERE("Leave Payment" = CONST(true));
            RequestFilterFields = "Posting Date";
            column(No_PaymentsHeader; "Voucher Header"."No.")
            {
            }
            column(Date_PaymentsHeader; Format("Posting Date", 0, 4))
            {
            }
            /*column(Payee_PaymentsHeader; "Voucher Header".Payee)
            {
            }
            column(PayMode_PaymentsHeader; "Voucher Header"."Pay Mode")
            {
            }
            */ //RBS Dennis
            column(PaymentReleaseDate_PaymentsHeader; "Voucher Header"."Document Date")
            {
            }
            column(PaymentNarration_PaymentsHeader; "Voucher Header"."Narration")
            {
            }
            column(ExternalDocNo_PaymentsHeader; "Voucher Header"."External Document No.")
            {
            }
            column(TotalPaymentAmount_PaymentsHeader; "Voucher Header".Amount)
            {
            }
            column(User; UserId)
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(Today; Format(Today, 0, 4))
            {
            }
            column(PayStatus; PaymentStatus)
            {
            }

            trigger OnAfterGetRecord()
            var
                PostedVHeader: Record "Posted Voucher Header";
            begin
                PaymentStatus := '';
                CalcFields("Voucher Header".Amount);
                //PostedVHeader.SetRange("No.";"No.");
                if Status = Status::Released then
                    PaymentStatus := 'Paid'
                else
                    PaymentStatus := 'Pending';
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

    trigger OnInitReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        PaymentStatus: Text[30];
}

