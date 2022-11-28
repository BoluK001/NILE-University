page 51534360 "RFQ Header"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,Print/Send,Navigate';
    SourceTable = "Purchase Quote Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Expected Opening Date"; "Expected Opening Date")
                {
                    ApplicationArea = All;
                    Caption = 'RFQ Date';  //jj290522
                }
                field("Expected Closing Date"; "Expected Closing Date")
                {
                    ApplicationArea = All;
                    Caption = 'RFQ Deadline Date';   //jj290522
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            part("RFQ Subform"; "RFQ Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;

                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534351),
                              "No." = FIELD("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {

                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }

            part("Quotation Req. Vendors Fact"; "Quotation Req. Vendors")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
                //  "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(New)
            {
                action("Get Document Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Get Document Lines';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE(TRUE);
                        InsertRFQLines;
                    end;
                }
                action("Assign Vendor(s)")
                {
                    ApplicationArea = All;
                    Caption = 'Assign Vendor(s)';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Vends: Record "Quotation Request Vendors";
                    begin

                        Vends.RESET;
                        Vends.SETRANGE(Vends."Document Type", "Document Type");
                        Vends.SETRANGE(Vends."Document No.", "No.");

                        PAGE.RUN(PAGE::"Quotation Request Vendors", Vends);
                    end;
                }
                action("Print/Preview")
                {
                    ApplicationArea = All;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";


                    trigger OnAction()
                    begin

                        PQH.SETRECFILTER;
                        PQH.SETFILTER(PQH."Document Type", '%1', "Document Type");
                        PQH.SETFILTER("No.", "No.");
                        repvend.SETTABLEVIEW(PQH);
                        repvend.RUN;
                    end;
                }
                action("Create Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Create Vendor Quotes';
                    Image = VendorPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        RFQLines: Record "Purchase Quote Line";
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        Vends: Record "Quotation Request Vendors";
                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        Vends.SETRANGE(Vends."Document No.", "No.");

                        IF Vends.FINDSET THEN
                            REPEAT
                                //create header
                                PurchaseHeader.INIT;
                                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                                //`PurchaseHeader."Purchase Type" := PurchaseHeader."Purchase Type"::Quote;
                                PurchaseHeader."No." := NoSeriesMgt.GetNextNo('P-QUO', TODAY, TRUE);
                                PurchaseHeader."Responsibility Center" := "Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                PurchaseHeader.INSERT(TRUE);
                                PurchaseHeader.VALIDATE("Buy-from Vendor No.", Vends."Vendor No.");
                                PurchaseHeader."Responsibility Center" := "Responsibility Center";
                                PurchaseHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                                PurchaseHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                //PurchaseHeader.validate("RFQ No.","No.");
                                PurchaseHeader.MODIFY;
                                PurchaseHeader.INSERT(TRUE);

                                //create lines

                                RFQLines.SETRANGE(RFQLines."Document No.", "No.");
                                RFQLines.DeleteAll();
                                IF RFQLines.FINDSET THEN
                                    REPEAT
                                        PurchaseLines.INIT;
                                        PurchaseLines.TRANSFERFIELDS(RFQLines);
                                        PurchaseLines."Document Type" := PurchaseLines."Document Type"::Quote;
                                        PurchaseLines."Document No." := "No.";
                                        PurchaseLines.INSERT;
                                    /*
                                      ReqLines.VALIDATE(ReqLines."No.");
                                      ReqLines.VALIDATE(ReqLines.Quantity);
                                      ReqLines.VALIDATE(ReqLines."Direct Unit Cost");
                                      ReqLines.MODIFY;
                                    */
                                    UNTIL RFQLines.NEXT = 0;
                            UNTIL Vends.NEXT = 0;

                    end;
                }
                action("Bid Analysis")
                {
                    Caption = 'Bid Analysis';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bid Analysis Worksheet";
                    RunPageLink = "RFQ No." = FIELD("No.");
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLines: Record "Purchase Line";
                        ItemNoFilter: Text[250];
                        RFQNoFilter: Text[250];
                        InsertCount: Integer;
                        BidAnalysis: Record "Bid Analysis";
                    begin
                        //deletebidanalysis for this vendor
                        BidAnalysis.SETRANGE(BidAnalysis."RFQ No.", "No.");
                        BidAnalysis.DELETEALL;


                        //insert the quotes from vendors

                        PurchaseHeader.SETRANGE("RFQ No.", "No.");
                        PurchaseHeader.FINDSET;
                        REPEAT
                            PurchaseLines.RESET;
                            PurchaseLines.SETRANGE("Document No.", PurchaseHeader."No.");
                            IF PurchaseLines.FINDSET THEN
                                REPEAT
                                    BidAnalysis.INIT;
                                    BidAnalysis."RFQ No." := "No.";
                                    BidAnalysis."RFQ Line No." := PurchaseLines."Line No.";
                                    BidAnalysis."Quote No." := PurchaseLines."Document No.";
                                    BidAnalysis."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                                    BidAnalysis."Item No." := PurchaseLines."No.";
                                    BidAnalysis.Description := PurchaseLines.Description;
                                    BidAnalysis.Quantity := PurchaseLines.Quantity;
                                    BidAnalysis."Unit Of Measure" := PurchaseLines."Unit of Measure";
                                    BidAnalysis.Amount := PurchaseLines."Direct Unit Cost";
                                    BidAnalysis."Line Amount" := BidAnalysis.Quantity * BidAnalysis.Amount;
                                    BidAnalysis.INSERT(TRUE);
                                    InsertCount += 1;
                                UNTIL PurchaseLines.NEXT = 0;
                        UNTIL PurchaseHeader.NEXT = 0;
                        MESSAGE('%1 records have been inserted to the bid analysis', InsertCount);
                    end;
                }
            }
            group("Send Mail")
            {
                action("Send As Mail")
                {
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        SendEmail(Rec);
                        Message('Email Sent.');
                    end;
                }
            }


            group(Status)
            {
                Caption = 'Status';

                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Release document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        //check if the document has any lines
                        Lines.RESET;
                        Lines.SETRANGE(Lines."Document Type", "Document Type");
                        Lines.SETRANGE(Lines."Document No.", "No.");
                        IF Lines.FINDFIRST THEN BEGIN
                            REPEAT
                                Lines.TESTFIELD(Lines.Quantity);
                                //Lines.TESTFIELD(Lines."Direct Unit Cost");
                                Lines.TESTFIELD("No.");
                            UNTIL Lines.NEXT = 0;
                        END
                        ELSE BEGIN
                            ERROR('Document has no lines');
                        END;
                        Status := Status::Released;
                        "Released By" := USERID;
                        "Release Date" := TODAY;
                        MODIFY;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        PurchHeader.RESET;
                        //PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE("RFQ No.", "No.");
                        IF PurchHeader.FINDFIRST THEN BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                        END;

                        IF CONFIRM('Reopen Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Open;
                        MODIFY;
                    end;
                }
                action(Close)
                {
                    Caption = 'Close';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Closed;
                        MODIFY;

                    end;
                }

                action(Cancel)
                {
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;
                    Visible = false; //jj290522

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used
                        /*
                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type",PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."Request for Quote No.","No.");
                        IF PurchHeader.FINDFIRST THEN
                          BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                          END;
                        */
                        IF CONFIRM('Cancel Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Cancelled;
                        MODIFY;

                    end;
                }
                action(Stop)
                {
                    Caption = 'Stop';
                    Image = Stop;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;
                    Visible = false; //jj290522

                    trigger OnAction()
                    begin

                        //check if the quotation for request number has already been used

                        PurchHeader.RESET;
                        PurchHeader.SETRANGE(PurchHeader."Document Type", PurchHeader."Document Type"::Quote);
                        PurchHeader.SETRANGE(PurchHeader."RFQ No.", "No.");
                        IF PurchHeader.FINDFIRST THEN BEGIN
                            ERROR('The Quotation for request is already tied to a Quotation. Cannot be Reopened');
                        END;

                        IF CONFIRM('Close Document?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Status := Status::Closed;
                        MODIFY;

                    end;
                }

            }

        }
    }

    var
        PurchHeader: Record 38;
        PParams: Record "Purchase Quote Params";
        Lines: Record "Purchase Quote Line";
        PQH: Record "Purchase Quote Header";
        repvend: Report "RFQ Report";
        DocPrint: Codeunit "Document-Print";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";

    [Scope('OnPrem')]
    procedure InsertRFQLines()
    var
        Counter: Integer;
        Collection: Record "Purchase Line";
        //CollectionList: Page "PRF Lists"; Dennis
        CollectionList: Page "Approved PRF Lists"; //Dennis
    begin
        CollectionList.LOOKUPMODE(TRUE);
        IF CollectionList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            Collection.Setfilter("Document No.", '%1', Rec."PRF No");
            Collection.SetFilter("Purchase Type", '%1', "Purchase Type"::Requisition);
            CollectionList.SetSelection(Collection);
            Counter := Collection.COUNT;
            IF Counter > 0 THEN BEGIN
                IF Collection.FINDSET then begin
                    repeat
                        // Lines.SetRange("PRF No", Collection."Document No.");
                        // Lines.Deleteall;
                        Lines.Reset();
                        Lines.SetRange("PRF No", Collection."Document No.");
                        Lines.SetRange(Lines."No.", Collection."No.");
                        Lines.SetRange(Description, Collection.Description);
                        if Lines.Find('-') then
                            Lines.Delete;
                        //REPEAT

                        //Lines.Reset();
                        Lines.INIT;
                        Lines.TRANSFERFIELDS(Collection);
                        Lines."Document Type" := "Document Type";
                        Lines."Document No." := "No.";
                        Lines."Line No." := 0;
                        Lines."PRF No" := Collection."Document No.";
                        Lines."PRF Line No." := Collection."Line No.";
                        Lines."Expense No." := Collection."Expense No.";
                        Lines.Amount := Collection.Amount;
                        Lines."Shortcut Dimension 1 Code" := Collection."Shortcut Dimension 1 Code";
                        Lines."Shortcut Dimension 2 Code" := Collection."Shortcut Dimension 2 Code";
                        // Lines."Shortcut Dimension 3 Code" := Collection."Shortcut Dimension 3 Code";
                        //Lines."Shortcut Dimension 4 Code" := Collection."Shortcut Dimension 4 Code";
                        Lines."Description 2" := Collection."Description 2";
                        Lines."Location Code" := Collection."Location Code";

                        //Lines.Modify(true);
                        Lines.INSERT(TRUE);
                    //Collection.Copied:=TRUE;
                    //Collection.MODIFY;
                    UNTIL Collection.NEXT = 0;
                end;
            end;
        end;
    end;

    //Biyi 290422
    procedure SendEmail(var RFQ: Record "Purchase Quote Header")
    var
        TxtDefaultCCMailList: List of [Text];
        TxtDefaultBCCMailList: List of [Text];
        TxtRecepientsList: List of [Text];
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentInStream: Instream;
        AttachmentOutStream: OutStream;
        FileMgt: Codeunit "File Management";
        QVendor: Record "Quotation Request Vendors";
        Vendor: Record Vendor;
        RfqReport: Report "RFQ Report";
        RecRef: RecordRef;
        AttachName: text;
        RFQREC2: Record "Purchase Quote Header";
        //Base6CU: Codeunit "Base64 Convert";
        Ifile: File;
    begin
        //QVendor.Get();
        //QVendor.SetCurrentKey("Document No.");

        Message(RFQ."No.");
        QVendor.reset;
        QVendor.Setfilter(QVendor."Document Type", '%1', RFQ."Document Type");
        QVendor.Setfilter(QVendor."Document No.", '%1', RFQ."No.");
        //Message('Vendor No:', Vendor."E-Mail");
        if QVendor.FindFirst() then
            repeat
                clear(AttachName);
                Message(QVendor."Vendor No.");
                //sleep(1000);
                Vendor.Reset;
                Vendor.SetFilter("No.", '%1', QVendor."Vendor No.");
                If Vendor.FindFirst() then begin
                    if Vendor."E-Mail" <> '' then begin
                        Message('Vendor Email:', Vendor."E-Mail");
                        //sleep(1000);
                        AttachmentTempBlob.CreateOutStream(AttachmentOutStream);
                        AttachmentTempBlob.CreateInStream(AttachmentInStream);
                        AttachName := 'C:\RFQAttachments\' + format(RFQ."No.") + '_' + FORMAT(QVendor."Vendor No.") + '.pdf';
                        CLEAR(RfqReport);
                        clear(TxtRecepientsList);
                        clear(ifile);
                        RFQREC2.Reset();
                        RFQREC2.SetFILTER("Document Type", '%1', RFQ."Document Type");
                        RFQREC2.SETFILTER("No.", '%1', RFQ."No.");
                        IF RFQREC2.FindFirst() THEN begin
                            RecRef.GetTable(RFQREC2);
                            RfqReport.UseRequestPage(FALSE);
                            RfqReport.setVendornAme(Vendor.Name);
                            RfqReport.SetTableView(RFQREC2);
                            RfqReport.SaveAsPdf(AttachName);
                            //sleep(30000);
                            if Exists(AttachName) then begin
                                Ifile.Open(AttachName);
                                Ifile.CreateInStream(AttachmentInStream);

                            end;

                            //AttachmentOutStream.write(Base6CU.ToBase64(AttachName));
                            //RfqReport.SaveAs('', ReportFormat::Pdf, AttachmentOutStream, RecRef);
                            //    
                            //    Message('Attachment Saved');
                            //end;
                        END;

                        //Vendor.SetRange("No.", QVendor."Document No.");
                        //if vendor.Find('-') then

                        TxtRecepientsList.Add(Vendor."E-Mail");
                        // TxtDefaultCCMailList.Add('olajumokeo@reeltechsolutions.com');
                        // TxtDefaultBCCMailList.Add('dennisbalogun@reeltechsolutions.com');

                        EmailMsg.Create(TxtRecepientsList, 'Request For Quotations', 'Kindly find the attached pdf document.', True, TxtDefaultCCMailList, TxtDefaultBCCMailList);

                        // 



                        // Report.SaveAs(Report::"RFQ Report", '', ReportFormat::Pdf, AttachmentOutStream,RFQ);

                        EmailMsg.AddAttachment(
                            'RFQReport.pdf',
                            'PDF',
                            AttachmentInStream
                        );
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                        //Sleep(6000);
                    end;
                end;
            until QVendor.Next() = 0;
    end;
}