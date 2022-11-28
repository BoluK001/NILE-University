report 51534726 "Staff Claims Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StaffClaimsVoucher.rdl';

    dataset
    {
        dataitem("Payments Header"; "Staff Claims Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Payments_Header__No__; "No.")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Cheque No.")
            {
            }
            column(Payments_Header_Payee; Payee)
            {
            }
            column(Amountinword; Amountinword + ' ONLY')
            {
            }
            column(Payments_Header__Payments_Header__Date; "Payments Header".Date)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Account_No_________Payee; "Account No." + ' : ' + Payee)
            {
            }
            column(Payments_Header_Purpose; Purpose)
            {
            }
            column(USERID; USERID)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756004; CurrCode)
            {
            }
            column(STAFF_CLAIM_REQUESTCaption; STAFF_CLAIM_REQUESTCaptionLbl)
            {
            }
            column(PAYEMENT_DETAILSCaption; PAYEMENT_DETAILSCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Document_No__Caption; Document_No__CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(PURPOSECaption; PURPOSECaptionLbl)
            {
            }
            column(Payee_Caption; Payee_CaptionLbl)
            {
            }
            column(Purpose_Caption; Purpose_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAdd; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            dataitem("Payment Line"; "Staff Claim Lines")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.", "No.")
                                    ORDER(Ascending);
                column(Payment_Line_Amount; Amount)
                {
                }
                column(Account_No________Account_Name_; "Account No." + ':' + "Account Name")
                {
                }
                column(Payment_Line__Payment_Line__Purpose; "Payment Line".Purpose)
                {
                }
                column(Payment_Line_Line_No_; "Line No.")
                {
                }
                column(Payment_Line_No; "No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DimVal.RESET;
                    DimVal.SETRANGE(DimVal."Global Dimension No.", 2);
                    DimVal.SETRANGE(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    IF DimVal.FINDFIRST THEN BEGIN
                        DimValName := DimVal.Name;
                    END;

                    TTotal := TTotal + "Payment Line".Amount;
                end;
            }
            dataitem(DataItem1102755009; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(SequenceNo_ApprovalEntry; "Sequence No.")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Last Date-Time Modified")
                {
                }
                column(ApproverID_ApprovalEntry; "Approver ID")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                StrCopyText := '';
                IF "No. Printed" >= 1 THEN BEGIN
                    StrCopyText := 'DUPLICATE';
                END;
                TTotal := 0;


                //Set currcode to Default if blank
                GLSetup.GET();
                IF "Payments Header"."Currency Code" = '' THEN BEGIN
                    CurrCode := GLSetup."LCY Code";
                END ELSE
                    CurrCode := "Payments Header"."Currency Code";

                //For Inv Curr Code
                IF "Payments Header"."Invoice Currency Code" = '' THEN BEGIN
                    InvoiceCurrCode := GLSetup."LCY Code";
                END ELSE
                    InvoiceCurrCode := "Payments Header"."Invoice Currency Code";

                //End;
                CALCFIELDS("Total Net Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Total Net Amount"), "Currency Code");


                IF "Currency Code" = '' THEN BEGIN
                    CurrText := 'NAIRA';
                    CurrText1 := 'KOBO';
                END;

                Amountinword := AmtInWord.figure("Total Net Amount", CurrText, CurrText1);

            end;

            trigger OnPostDataItem()
            begin
                IF CurrReport.PREVIEW = FALSE THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("No.");
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

    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[20];
        CurrCode: Code[20];
        GLSetup: Record "General Ledger Setup";
        STAFF_CLAIM_REQUESTCaptionLbl: Label 'STAFF CLAIM REQUEST';
        PAYEMENT_DETAILSCaptionLbl: Label 'PAYEMENT DETAILS';
        AmountCaptionLbl: Label 'Amount';
        Document_No__CaptionLbl: Label 'Document No.:';
        Currency_CaptionLbl: Label 'Currency:';
        Payment_To_CaptionLbl: Label 'Payment To:';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Cheque_No__CaptionLbl: Label 'Cheque No.:';
        PURPOSECaptionLbl: Label 'PURPOSE';
        Payee_CaptionLbl: Label 'Payee:';
        Purpose_CaptionLbl: Label 'Purpose:';
        TotalCaptionLbl: Label 'Total';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        RecipientCaptionLbl: Label 'Recipient';
        Name_CaptionLbl: Label 'Name:';
        Date_CaptionLbl: Label 'Date:';
        Signature_CaptionLbl: Label 'Signature:';
        CompanyInfo: Record "Company Information";
        Amountinword: Text[250];
        CurrText: Code[10];
        CurrText1: Code[10];
        AmtInWord: Codeunit AmountInWord;
}

