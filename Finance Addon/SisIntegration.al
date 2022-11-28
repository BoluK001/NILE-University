/// <summary>
/// Codeunit SisIntegration (ID 50100).
/// </summary>
codeunit 51534403 SisIntegration
{
    trigger OnRun()
    begin
        //Message('Okay');
    end;

    /// <summary>
    /// getstudedetails.
    /// </summary>
    procedure getstudentdetails()
    var
        httpClt: HttpClient;
        httpmsgresp: HttpResponseMessage;
        url: Text;
        urlmsg: Text;
        Nurlmsg: Text;
        AuthString: Text;
        TypeHelper: Codeunit 4110;
        jobj: JsonObject;
        jtoken: JsonToken;
        Njtoken: jsontoken;
        NJobj: JsonObject;
        Jarray: JsonArray;
        stdetail: record StudentDetails;
        stcounter: Integer;

    begin
        AuthString := StrSubstNo('%1:%2', 'bcadmin@nileuniversity.edu.ng', 'Be$33@Zebr@Plac4');
        AuthString := TypeHelper.ToBase64(AuthString);
        AuthString := StrSubstNo('Basic %1', AuthString);
        httpClt.DefaultRequestHeaders.Add('Authorization', AuthString);
        url := 'https://sisclientweb-100974.campusnexus.cloud/ds/campusnexus/SaCustomerAccount?IntegrationStatus=0';
        if httpClt.Get(url, httpmsgresp) then begin
            httpmsgresp.Content.ReadAs(urlmsg);
            // jobj.ReadFrom(urlmsg);
            jtoken.ReadFrom(urlmsg);
            jobj := jtoken.AsObject();
            jobj.SelectToken('value', jtoken);
            Jarray := jtoken.AsArray();
            //jobj.WriteTo(Nurlmsg);

            foreach jtoken in Jarray do begin
                //jtoken.WriteTo(Nurlmsg);
                //Message(Nurlmsg);
                NJobj := jtoken.AsObject();
                NJobj.Get('Id', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.Id := njtoken.AsValue().AsInteger();
                NJobj.Get('IntegrationStatus', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.IntegrationStatus := njtoken.AsValue().AsInteger();
                //NJobj.get('StudentNo', njtoken);
                NJobj.get('Stud_ID', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.StudentNo := njtoken.AsValue().AsCode();
                NJobj.get('FullName', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.FullName := njtoken.AsValue().AsText();
                NJobj.get('Address', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.Address := CopyStr(njtoken.AsValue().AsText(), 1, 100);
                NJobj.get('City', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.City := CopyStr(njtoken.AsValue().AsText(), 1, 20);
                NJobj.get('Country', njtoken);
                if not Njtoken.AsValue().IsNull then
                    //stdetail.country := njtoken.AsValue().ascode;
                    stdetail.country := Text.CopyStr(njtoken.AsValue().ascode, 1, 30);
                NJobj.get('PostalCode', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Post Code" := njtoken.AsValue().AsText();
                NJobj.get('TelNo', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Telephone No." := njtoken.AsValue().AsText();
                NJobj.get('MobileNo', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Mobile No." := njtoken.AsValue().AsText();
                Njobj.get('Email', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."E-Mail" := njtoken.AsValue().AsText();
                NJobj.get('Category', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.Category := njtoken.AsValue().AsText();
                Njobj.get('DateAdded', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Date Created" := njtoken.AsValue().AsDateTime();
                NJobj.get('DateLstMod', njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Last Date Modified" := njtoken.AsValue().AsDateTime();
                NJobj.get('Department', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.Department := Njtoken.AsValue().AsText();
                NJobj.Get('Faculty', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail.Faculty := Njtoken.AsValue().AsText();
                NJobj.get('CurrentYearOfStudy', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Current Year Of Study" := Njtoken.AsValue().AsText();
                NJobj.get('ProgrammeDuration', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Programme Duration" := Njtoken.AsValue().AsText();
                NJobj.get('ReliefRate', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Relief Rate" := Njtoken.AsValue().AsText();
                njobj.get('ReliefType', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Relief Type" := Njtoken.AsValue().AsText();
                NJobj.Get('ReliefType2', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Relief Type2" := Njtoken.AsValue().AsText();
                NJobj.get('StudentStatus', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Student Statuse" := Njtoken.AsValue().AsText();
                NJobj.get('EnrollmentType', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stdetail."Enrollment Type" := Njtoken.AsValue().AsText();

                stdetail.Insert(true);
                stcounter += 1;
            end;
            message('%1 Record fetched', stcounter);
        end
    end;

    /// <summary>
    /// createstudentdetail.
    /// </summary>
    /// <param name="Var SisRec">Record StudentDetails.</param>
    procedure createstudentdetail(Var SisRec: Record StudentDetails)
    var
        CusRec: Record Customer;
    begin
        if not CusRec.get(SisRec.StudentNo) then begin
            CusRec.Init();
            CusRec."No." := SisRec.StudentNo;
            CusRec.Validate(Name, SisRec.FullName);
            CusRec.Address := sisrec.Address;
            cusrec."Phone No." := sisrec."Mobile No.";
            cusrec."Mobile Phone No." := SisRec."Telephone No.";
            CusRec.validate("Customer Posting Group", 'UG');
            CUSREC.Validate("Gen. Bus. Posting Group", 'STUDENT');
            CusRec."Customer Type" := CusRec."Customer Type"::Student;
            CUSREC."E-Mail" := SisRec."E-Mail";
            CusRec.City := SisRec.City;
            CusRec."Country/Region Code" := SisRec.Country;
            CusRec.insert(true);
        end;

    end;
    /// <summary>
    /// getstudentInvoice.
    /// </summary>
    procedure getstudentInvoice()
    var
        httpClt: HttpClient;
        httpmsgresp: HttpResponseMessage;
        url: Text;
        urlmsg: Text;
        AuthString: Text;
        TypeHelper: Codeunit 4110;
        Invjobj: JsonObject;
        jtoken: JsonToken;
        Njtoken: jsontoken;
        NJobj: JsonObject;
        Jarray: JsonArray;
        StuInvoice: record "SIS Invoices Details";
        stcounter: Integer;
        JRecDateTime: DateTime;

    begin
        AuthString := StrSubstNo('%1:%2', 'bcadmin@nileuniversity.edu.ng', 'Be$33@Zebr@Plac4');
        AuthString := TypeHelper.ToBase64(AuthString);
        AuthString := StrSubstNo('Basic %1', AuthString);
        httpClt.DefaultRequestHeaders.Add('Authorization', AuthString);
        //url := 'https://sisclientweb-test-100974.campusnexus.cloud/ds/campusnexus/Sainvoice?IntegrationStatus=0';
        //url := 'https://sisclientweb-100974.campusnexus.cloud/ds/campusnexus/Sainvoice?IntegrationStatus=0';
        url := 'https://sisclientweb-100974.campusnexus.cloud/ds/campusnexus/SaInvoiceTransaction?IntegrationStatus=0$filter=TransactionCode+ne+%27DATAMIG%27';
        if httpClt.Get(url, httpmsgresp) then begin
            httpmsgresp.Content.ReadAs(urlmsg);
            //Message(urlmsg);
            jtoken.ReadFrom(urlmsg);
            Invjobj := jtoken.AsObject();
            Invjobj.SelectToken('value', jtoken);
            Jarray := jtoken.AsArray();
            foreach jtoken in Jarray do begin
                //jtoken.WriteTo(Nurlmsg);
                //Message(Nurlmsg);
                clear(JRecDateTime);
                NJobj := jtoken.AsObject();
                NJobj.Get('Id', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.Id := njtoken.AsValue().AsInteger();
                //NJobj.Get('IntegrationStatus', njtoken);
                // if not Njtoken.AsValue().IsNull then
                //   StuInvoice.IntegrationStatus := njtoken.AsValue().AsInteger();
                NJobj.get('StudentNumber', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.StudentNo := njtoken.AsValue().AsCode();
                NJobj.get('InvoiceType', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.InvoiceType := njtoken.AsValue().AsInteger();
                NJobj.get('ReferenceDate', njtoken);
                if not Njtoken.AsValue().IsNull then begin
                    JRecDateTime := njtoken.AsValue().AsDateTime();
                    StuInvoice.ReferenceDate := DT2DATE(JRecDateTime);
                end;
                NJobj.get('CurrencyCode', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.CurrencyCode := njtoken.AsValue().AsCode();
                NJobj.get('Amount', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.Amount := njtoken.AsValue().AsDecimal();
                NJobj.get('ExchangeRate', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.ExchangeRate := njtoken.AsValue().AsDecimal();
                NJobj.get('InvDescription', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.Description := njtoken.AsValue().AsText();
                NJobj.get('ReferenceInvNo', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.ReferenceInvNo := njtoken.AsValue().AsText();
                Njobj.get('ProgramVersionCode', njtoken);
                if not Njtoken.AsValue().IsNull then
                    StuInvoice.ProgramVersionCode := njtoken.AsValue().AsText();
                StuInvoice.Insert(true);
                stcounter += 1;
            end;
            message('%1 Record fetched', stcounter);
        end
    end;

    /// <summary>
    /// getstudentInvoice.
    /// </summary>
    procedure getstudentPayment()
    var
        httpClt: HttpClient;
        httpmsgresp: HttpResponseMessage;
        url: Text;
        urlmsg: Text;
        Nurlmsg: Text;
        AuthString: Text;
        TypeHelper: Codeunit 4110;
        jobj: JsonObject;
        jtoken: JsonToken;
        Njtoken: jsontoken;
        NJobj: JsonObject;
        Jarray: JsonArray;
        stpaysdetail: record PaymentDetails;
        stcounter: Integer;

    begin
        AuthString := StrSubstNo('%1:%2', 'bcadmin@nileuniversity.edu.ng', 'Be$33@Zebr@Plac4');
        AuthString := TypeHelper.ToBase64(AuthString);
        AuthString := StrSubstNo('Basic %1', AuthString);
        httpClt.DefaultRequestHeaders.Add('Authorization', AuthString);
        url := 'https://sisclientweb-100974.campusnexus.cloud/ds/campusnexus/SaPayment?IntegrationStatus=0';
        if httpClt.Get(url, httpmsgresp) then begin
            httpmsgresp.Content.ReadAs(urlmsg);
            jtoken.ReadFrom(urlmsg);
            jobj := jtoken.AsObject();
            jobj.SelectToken('value', jtoken);
            Jarray := jtoken.AsArray();
            //jobj.WriteTo(Nurlmsg);

            foreach jtoken in Jarray do begin
                NJobj := jtoken.AsObject();
                NJobj.Get('Id', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.Id := Njtoken.AsValue().AsInteger();
                NJobj.get('ReceiptNumber', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.ReceiptNumber := Njtoken.AsValue().AsCode();
                NJobj.get('ReferenceNumber', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.ReferenceNumber := Njtoken.AsValue().AsCode();
                njobj.get('TransactionType', Njtoken);
                if not njtoken.AsValue().IsNull then
                    stpaysdetail."Transaction Type" := Njtoken.AsValue().AsInteger();
                NJobj.get('PaymentMethod', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Payment Method" := Njtoken.AsValue().AsCode();
                NJobj.get('BankAccount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Bank Account" := Njtoken.AsValue().AsCode();
                NJobj.get('ReceiptDate', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Receipt Date" := Njtoken.AsValue().AsDateTime();
                NJobj.get('CurrencyCode', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Currency Code" := Njtoken.AsValue().AsCode();
                NJobj.get('Amount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.Amount := Njtoken.AsValue().AsDecimal();
                NJobj.get('ExchangeRate', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Exchange Rate" := Njtoken.AsValue().AsDecimal();

                NJobj.get('StudentNumber', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.StudentNo := Njtoken.AsValue().AsCode();

                NJobj.get('TransactionAccount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Transaction Account" := Njtoken.AsValue().AsCode();

                NJobj.get('ReceiptReferenceNo', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.ReferenceNumber := Njtoken.AsValue().AsCode();


                NJobj.get('Remarks', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.Remark := Njtoken.AsValue().AsText();

                NJobj.get('PaymentDescription', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Payment Description" := Njtoken.AsValue().AsText();

                NJobj.get('BankCode', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Bank Code" := Njtoken.AsValue().AsCode();

                NJobj.get('IntegrationStatus', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.IntegrationStatus := Njtoken.AsValue().AsInteger();

                NJobj.get('LedgerName', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Ledger Name" := Njtoken.AsValue().AsText();

                NJobj.get('AmountAfterTax', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Amount After Tax" := Njtoken.AsValue().AsDecimal();

                NJobj.get('TaxAmount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Tax Amount" := Njtoken.AsValue().AsDecimal();

                NJobj.get('DebitAccount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Debit Amount" := Njtoken.AsValue().AsDecimal();

                NJobj.get('CreditAccount', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Credit Amount" := Njtoken.AsValue().AsDecimal();

                NJobj.get('Category', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail.Category := Njtoken.AsValue().AsCode();

                NJobj.get('CampusCode', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Campus Code" := Njtoken.AsValue().AsCode();

                NJobj.get('ProgramVersionCode', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Program Version" := Njtoken.AsValue().AsCode();

                NJobj.get('MiscRef1', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Misc. Ref. 1" := Njtoken.AsValue().AsCode();

                NJobj.get('MiscRef2', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Misc. Ref. 2" := Njtoken.AsValue().AsCode();

                NJobj.get('DateAdded', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Date Created" := Njtoken.AsValue().AsDateTime();

                NJobj.get('DateLstMod', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    stpaysdetail."Last Date Modified" := Njtoken.AsValue().AsDateTime();

                stpaysdetail.Insert(true);

            end;
        end
    end;

    /// <summary>
    /// AllocatePayment.
    /// </summary>
    /// <param name="PrDate">date.</param>
    procedure AllocatePayment(PrDate: date);
    var
        GenJnLine: Record "Gen. Journal Line";
        StuPayDet: record PaymentDetails;
        LineNo: Integer;
        DocNo: Code[20];
        TotalPayment: Decimal;
        BankAllPer: Record 51534404;
        BankAmt: Decimal;
    begin
        StuPayDet.reset;
        StuPayDet.SetFilter("BC Processed Date", '%1', PrDate);
        StuPayDet.SetFilter(StuPayDet."Payment Processed", '%1', false);
        if StuPayDet.FindFirst() then begin
            GenJnLine.reset;
            GenJnLine.Setfilter(GenJnLine."Journal Template Name", 'General');
            GenJnLine.Setfilter(GenJnLine."Journal Batch Name", 'PAYMENTALL');
            if GenJnLine.findfirst then
                GenJnLine.DeleteAll();
            DocNo := StuPayDet."Processed Code";
            repeat
                TotalPayment += StuPayDet.Amount;

            until StuPayDet.Next() = 0;
            //Message('Done');
        end;

        if TotalPayment > 0 then begin
            BankAllPer.reset;
            if BankAllPer.FindFirst() then
                repeat
                    BankAmt := 0;
                    BankAmt := Round(((BankAllPer."Distribution Percentage" / 100) * TotalPayment), 0.01);
                    LineNo += 1;
                    GenJnLine.Init();
                    GenJnLine.Validate(GenJnLine."Journal Template Name", 'General');
                    GenJnLine.validate(GenJnLine."Journal Batch Name", 'PAYMENTALL');
                    GenJnLine."Document No." := DocNo;
                    GenJnLine.Validate("Posting Date", today);
                    GenJnLine."Line No." := LineNo;
                    GenJnLine.Validate(GenJnLine."Account Type", GenJnLine."Account Type"::"Bank Account");
                    GenJnLine.validate(GenJnLine."Account No.", BankAllPer."Bank Code");
                    GenJnLine.Description := StrSubstNo('%1 Distribution for %2', BankAllPer."Bank Code", format(PrDate));
                    GenJnLine.Validate(GenJnLine."Debit Amount", BankAmt);
                    GenJnLine.Validate(GenJnLine."Bal. Account Type", GenJnLine."Bal. Account Type"::"Bank Account");
                    GenJnLine.Validate(GenJnLine."Bal. Account No.", 'COLLBANK');
                    GenJnLine.Insert();

                until BankAllPer.next = 0


        end;

    end;

    procedure getTramsactionCodes()
    var
        httpClt: HttpClient;
        httpmsgresp: HttpResponseMessage;
        url: Text;
        urlmsg: Text;
        Nurlmsg: Text;
        AuthString: Text;
        TypeHelper: Codeunit 4110;
        jobj: JsonObject;
        jtoken: JsonToken;
        Njtoken: jsontoken;
        NJobj: JsonObject;
        Jarray: JsonArray;
        TransCode: record SIS_Transactions_Codes;
        stcounter: Integer;

    begin
        AuthString := StrSubstNo('%1:%2', 'bcadmin@nileuniversity.edu.ng', 'Be$33@Zebr@Plac4');
        AuthString := TypeHelper.ToBase64(AuthString);
        AuthString := StrSubstNo('Basic %1', AuthString);
        httpClt.DefaultRequestHeaders.Add('Authorization', AuthString);
        url := 'https://sisclientweb-100974.campusnexus.cloud/ds/campusNexus/BillingTransactionCodes?$select=Id,Code,Name,IsActive,CreatedDateTime,LastModifiedDateTime';
        if httpClt.Get(url, httpmsgresp) then begin
            httpmsgresp.Content.ReadAs(urlmsg);
            // jobj.ReadFrom(urlmsg);
            jtoken.ReadFrom(urlmsg);
            jobj := jtoken.AsObject();
            jobj.SelectToken('value', jtoken);
            Jarray := jtoken.AsArray();
            //jobj.WriteTo(Nurlmsg);

            foreach jtoken in Jarray do begin
                //jtoken.WriteTo(Nurlmsg);
                //Message(Nurlmsg);
                NJobj := jtoken.AsObject();
                NJobj.Get('Id', Njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode.CodeID := njtoken.AsValue().AsInteger();
                NJobj.Get('Code', njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode.TransCode := njtoken.AsValue().AsCode();
                NJobj.get('Name', njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode.Description := njtoken.AsValue().AsText();
                NJobj.get('IsActive', njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode.IsActive := njtoken.AsValue().AsBoolean();
                NJobj.get('CreatedDateTime', njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode."Date Created" := njtoken.AsValue().AsDateTime();
                NJobj.get('LastModifiedDateTime', njtoken);
                if not Njtoken.AsValue().IsNull then
                    TransCode."Last Modified Date" := njtoken.AsValue().AsDateTime();

                TransCode.Insert(true);
                stcounter += 1;
            end;
            message('%1 Record fetched', stcounter);
        end
    end;

    var
        myInt: Integer;
}