report 51534984 "Journal Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './JournalVoucher.rdl';

    dataset
    {
        dataitem(DataItem1000000034; "Voucher Header")
        {
            CalcFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount";
            DataItemTableView = SORTING("Voucher Type", "No.")
                                WHERE("Voucher Type" = FILTER(JV));
            RequestFilterFields = "No.";
            column(SourceDesc; SourceDesc)
            {
            }
            column(No_VoucherHeader; "No.")
            {
                IncludeCaption = true;
            }
            column(AccountName_VoucherHeader; "Account Name")
            {
                IncludeCaption = true;
            }
            column(AmountLCY_VoucherHeader; "Amount (LCY)")
            {
                IncludeCaption = true;
            }
            column(PostingDate_VoucherHeader; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(DebitAmount_VoucherHeader; "Debit Amount")
            {
            }
            column(CreditAmount_VoucherHeader; "Credit Amount")
            {
            }
            column(Date______FORMAT__Posting_Date__; 'Date: ' + FORMAT("Posting Date"))
            {
            }
            column(ABS_Voucher_Header__Amount_LCY; ABS("Amount (LCY)"))
            {
            }
            column(ABS_Voucher_Header_DebitAmount; ABS("Debit Amount"))
            {
            }
            column(ABS_Voucher_Header_CreditAmount; ABS("Credit Amount"))
            {
            }
            column(Rs____NumberText_1_______NumberText_2_; ToWords.ToWords("Debit Amount", 'NAIRA', 'KOBO', 0, ''))
            {
            }
            column(Narration_VoucherHeader; Narration)
            {
                IncludeCaption = true;
            }
            column(CrText; CrText)
            {
            }
            dataitem(DataItem1000000019; "Voucher Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Voucher Type", "Document No.", "Line No.")
                                    WHERE("Voucher Type" = FILTER(JV));
                column(DocumentNo_VoucherLine; "Document No.")
                {
                }
                column(DebitAmount_VoucherLine; "Debit Amount")
                {
                }
                column(CreditAmount_VoucherLine; "Credit Amount")
                {
                }
                column(ABS_Voucher_Line_DebitAmount; ABS("Debit Amount"))
                {
                }
                column(ABS_Voucher_Line_CreditAmount; ABS("Credit Amount"))
                {
                }
                column(AccountName_VoucherLine; "Account Name")
                {
                    IncludeCaption = true;
                }
                column(ABS_Voucher_Line__Amount_LCY; ABS("Amount (LCY)"))
                {
                }
                column(DrText; DrText)
                {
                }
                column(CrText1; CrText1)
                {
                }
                dataitem(DataItem1000000009; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
                    {
                        IncludeCaption = true;
                    }
                    column(Address_CompanyInformation; Address)
                    {
                        IncludeCaption = true;
                    }
                    column(Address2_CompanyInformation; "Address 2")
                    {
                        IncludeCaption = true;
                    }
                    column(Picture_CompanyInformation; Picture)
                    {
                    }
                    column(HomePage_CompanyInformation; "Home Page")
                    {
                    }
                    column(PhoneNo_CompanyInformation; "Phone No.")
                    {
                    }
                    column(EMail_CompanyInformation; "E-Mail")
                    {
                    }
                    dataitem(DataItem1000000000; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Integer_Number; Number)
                        {
                        }


                        trigger OnAfterGetRecord()
                        begin
                            PageLoop := PageLoop - 1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            VoucherLine.SETRANGE("Voucher Type", VoucherType);
                            VoucherLine.SETRANGE("Document No.", VoucherDocNo);
                            VoucherLine.FINDLAST;
                            IF NOT (VoucherLine."Line No." = VoucherLineNo) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, PageLoop)
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    VoucherType := "Voucher Type";
                    VoucherDocNo := "Document No.";
                    VoucherLineNo := "Line No.";
                end;
            }

            trigger OnAfterGetRecord()
            begin

                DrText := 'Dr';
                CrText := 'To';
                CrText1 := 'Cr';

                SourceDesc := '';
                IF "Source Code" <> '' THEN BEGIN
                    SourceCode.GET("Source Code");
                    SourceDesc := SourceCode.Description;
                END;

                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;
            end;

            trigger OnPreDataItem()
            begin

                /*NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;*/

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
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ToWords: Codeunit Library;
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        CrText1: Text[2];
        VoucherLine: Record "Voucher Line";

        VoucherL: Record "Voucher Line";
        IntegerOccurces: Integer;
        SourceCode: Record "Source Code";
        VoucherType: Option JV,CPV,CRV,BPV,BRV,Contra,PettyCash;
        VoucherDocNo: Code[20];
        VoucherLineNo: Integer;
}

