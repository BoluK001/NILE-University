page 51534446 "SIS Invoices"
{
    ApplicationArea = All;
    Caption = 'SIS Invoices';
    PageType = List;
    SourceTable = "SIS Invoices Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(CurrencyCode; Rec.CurrencyCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CurrencyCode field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(ExchangeRate; Rec.ExchangeRate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ExchangeRate field.';
                }
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id field.';
                }
                field(IntegrationStatus; Rec.IntegrationStatus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IntegrationStatus field.';
                }
                field(InvoiceType; Rec.InvoiceType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the InvoiceType field.';
                }
                field(MiscRef1; Rec.MiscRef1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MiscRef1 field.';
                }
                field(ProgramVersionCode; Rec.ProgramVersionCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProgramVersionCode field.';
                }
                field(ReferenceDate; Rec.ReferenceDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ReferenceDate field.';
                }
                field(ReferenceInvNo; Rec.ReferenceInvNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ReferenceInvNo field.';
                }
                field(ReferenceNo; Rec.ReferenceNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ReferenceNo field.';
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the StudentNo field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    Visible = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Visible = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                    Visible = false;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    Visible = false;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(RBS3)
            {
                ApplicationArea = All;
                Caption = 'Get Student Invoices';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getstudentInvoice();
                end;
            }

            action(PostInvoices)
            {
                ApplicationArea = All;
                Caption = 'Post Invoices';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    GenJnLine: Record "Gen. Journal Line";
                    StuPayDet: record "SIS Invoices Details";
                    LineNo: Integer;
                    StudProVer: Code[5];
                    SisTranCode: Record SIS_Transactions_Codes;
                begin
                    StuPayDet.reset;
                    StuPayDet.SetFilter("Invoice Posted", '%1', false);
                    if StuPayDet.FindFirst() then begin
                        GenJnLine.reset;
                        GenJnLine.Setfilter(GenJnLine."Journal Template Name", 'General');
                        GenJnLine.Setfilter(GenJnLine."Journal Batch Name", 'SISINVOICE');
                        if GenJnLine.findfirst then
                            GenJnLine.DeleteAll();

                        //DocNo := Format(Date2DMY(today, 1)) + Format(Date2DMY(today, 2)) + Format(Date2DMY(today, 3));
                        repeat
                            clear(StudProVer);
                            LineNo += 1;
                            GenJnLine.Init();
                            GenJnLine.Validate(GenJnLine."Journal Template Name", 'General');
                            GenJnLine.validate(GenJnLine."Journal Batch Name", 'SISINVOICE');
                            GenJnLine."Document No." := StuPayDet.ReferenceInvNo;
                            GenJnLine.Validate("Posting Date", StuPayDet.ReferenceDate);
                            GenJnLine."Line No." := LineNo;
                            GenJnLine.Validate(GenJnLine."Account Type", GenJnLine."Account Type"::Customer);
                            GenJnLine.validate(GenJnLine."Account No.", StuPayDet.StudentNo);
                            GenJnLine.Description := StuPayDet.Description;
                            GenJnLine.validate(GenJnLine."Debit Amount", StuPayDet.Amount);
                            GenJnLine."External Document No." := StuPayDet.StudentNo;
                            GenJnLine.Validate(GenJnLine."Bal. Account Type", GenJnLine."Bal. Account Type"::"G/L Account");
                            StudProVer := CopyStr(StuPayDet.ProgramVersionCode, 1, 2);
                            SisTranCode.Reset();
                            SisTranCode.setfilter(codeid, '%1', StuPayDet.InvoiceType);
                            if SisTranCode.FindFirst() then begin
                                if StudProVer <> 'UG' then
                                    GenJnLine.Validate(GenJnLine."Bal. Account No.", SisTranCode."Post Graduate GL Code")
                                ELSE
                                    GenJnLine.Validate(GenJnLine."Bal. Account No.", SisTranCode."Under Graduate GL Code");
                            end;

                            GenJnLine.Insert();
                            StuPayDet."Invoice Posted" := true;
                            StuPayDet.Modify()
                        until StuPayDet.Next() = 0;
                        Message('Done');
                    end;

                end;
            }
        }
    }
}