/// <summary>
/// Page Payments Detail (ID 50103).
/// </summary>
page 51534435 "Payments Detail"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PaymentDetails;

    layout
    {
        area(Content)
        {
            group(Option)
            {
                field(allodate; allodate)
                {
                    ApplicationArea = all;

                }
            }
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = All;

                }
                field("Receipt Number"; Rec.ReceiptNumber)
                {
                    ApplicationArea = all;
                }
                field("Reference Number"; rec.ReferenceNumber)
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = all;
                }
                field("Bank Acount"; Rec."Bank Account")
                {
                    ApplicationArea = all;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = all;
                }
                field("Student Number"; Rec.StudentNo)
                {
                    ApplicationArea = All;
                }
                field("Transaction Account"; Rec."Transaction Account")
                {
                    ApplicationArea = all;
                }
                field("Receipt Reference No"; Rec."Receipt Reference No")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remark)
                {
                    ApplicationArea = all;
                }
                field("Payment Description"; Rec."Payment Description")
                {
                    ApplicationArea = all;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = all;
                }
                field("Integration Status"; Rec.IntegrationStatus)
                {
                    ApplicationArea = all;
                }
                field("Ledger Name"; Rec."Ledger Name")
                {
                    ApplicationArea = all;
                }
                field("Amount After Tax"; Rec."Amount After Tax")
                {
                    ApplicationArea = all;
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ApplicationArea = all;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = all;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = all;
                }
                field("Program Version Code"; Rec."Program Version")
                {
                    ApplicationArea = all;
                }
                field("Misc Ref1"; Rec."Misc. Ref. 1")
                {
                    ApplicationArea = all;
                }
                field("Misc Ref2"; Rec."Misc. Ref. 2")
                {
                    ApplicationArea = all;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("Processed Code"; Rec."Processed Code")
                {

                    ApplicationArea = all;
                    Editable = false;
                }
                field("BC Processed Date"; Rec."BC Processed Date")
                {

                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment Processed"; Rec."Payment Processed")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                Caption = 'Get Student Payments';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getstudentPayment();
                end;
            }

            action(AllocatePayment)
            {
                ApplicationArea = All;
                Caption = 'Allocate Student Payments';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.AllocatePayment(allodate);
                end;
            }

            action(PostPayment)
            {
                ApplicationArea = All;
                Caption = 'Post Payments';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    GenJnLine: Record "Gen. Journal Line";
                    StuPayDet: record PaymentDetails;
                    LineNo: Integer;
                    DocNo: Code[20];
                begin
                    StuPayDet.reset;
                    StuPayDet.SetFilter("BC Processed Date", '%1', 0D);
                    if StuPayDet.FindFirst() then begin
                        GenJnLine.reset;
                        GenJnLine.Setfilter(GenJnLine."Journal Template Name", 'General');
                        GenJnLine.Setfilter(GenJnLine."Journal Batch Name", 'SISPAYMENT');
                        if GenJnLine.findfirst then
                            GenJnLine.DeleteAll();

                        DocNo := Format(Date2DMY(today, 1)) + Format(Date2DMY(today, 2)) + Format(Date2DMY(today, 3));
                        repeat
                            LineNo += 1;
                            GenJnLine.Init();
                            GenJnLine.Validate(GenJnLine."Journal Template Name", 'General');
                            GenJnLine.validate(GenJnLine."Journal Batch Name", 'SISPAYMENT');
                            GenJnLine."Document No." := StuPayDet.ReceiptNumber;  //DocNo;   //jj021122
                            GenJnLine."External Document No." := Text.CopyStr(StuPayDet.ReferenceNumber, 1, 35);  //jj021122
                            GenJnLine.Validate("Posting Date", DT2Date((StuPayDet."Date Created")));
                            GenJnLine."Document Date" := Today;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine.Validate(GenJnLine."Account Type", GenJnLine."Account Type"::Customer);
                            GenJnLine.validate(GenJnLine."Account No.", StuPayDet.StudentNo);
                            GenJnLine.Description := StuPayDet."Payment Description";
                            GenJnLine.validate("Credit Amount", StuPayDet.Amount);
                            GenJnLine.Validate(GenJnLine."Bal. Account Type", GenJnLine."Bal. Account Type"::"Bank Account");
                            GenJnLine.Validate(GenJnLine."Bal. Account No.", 'COLLBANK');
                            GenJnLine.Insert();
                            StuPayDet."BC Processed Date" := Today;
                            StuPayDet."Processed Code" := DocNo;
                            StuPayDet.Modify()
                        until StuPayDet.Next() = 0;
                        Message('Done');
                    end;

                end;
            }
        }
    }
    var
        allodate: Date;

}