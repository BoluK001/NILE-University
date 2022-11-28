report 51534352 "Purch. Import Sheet"
{
    //Import sheet for importing any table
    DefaultLayout = RDLC;
    RDLCLayout = './ImportSheetXXXXXXXXXxxxx.rdlc';


    dataset
    {
        dataitem(Integer; Integer)
        {

            trigger OnAfterGetRecord()
            begin
                /*ImportSheet(Number);
                
                
                JVRec.INIT;
                
                JVRec.INSERT;
                */

                /*TransferRecitHd.INIT;
                
                TransferRecitHd.INSERT;
                 */

                /*
                DummyTable.INIT;
                DummyTable."Item No":= ColText[1];
                EVALUATE(DummyTable."LOL PRICE",ColText[2]);
                DummyTable."HSE CODE":=ColText[3];
                DummyTable.Product:=ColText[4];
                DummyTable."OEM SubCategory":= ColText[5];
                DummyTable."Manufcturing Part No":= ColText[6];
                DummyTable."Application model":=ColText[7];
                //EVALUATE(DummyTable."Weight Kg",ColText[8]);
                DummyTable.INSERT;
                 */




                /*HSCode.INIT;
                HSCode."HS Code" :=  ColText[1];
                EVALUATE(HSCode."Duty Rate",ColText[2]);
                EVALUATE(HSCode."Duty Surcharge Rate",ColText[3]);
                EVALUATE(HSCode.Status,ColText[4]);
                HSCode.Product :=ColText[5];
                HSCode.INSERT;*/



                /*
                FARec.INIT;
                FARec."No." := ColText[1];
                //FARec."No. 2" := ColText[2];
                //FARec.Description     := ColText[2];
                //FARec."Search Description"  := ColText[3];
                FARec."FA Class Code"      := ColText[4];
                FARec."Global Dimension 1 Code"    := ColText[5];
                //FARec."Global Dimension 2 Code"     := ColText[6];
                //FARec."Location Code" := ColText[7];
                //FARec."FA Class Code" := ColText[8];
                FARec."Serial No."  := ColText[9];
                //FARec."FA Posting Group" := ColText[10];
                //FARec."User Of Asset":= ColText[11];
                FARec."Engine No." := ColText[12];
                FARec."Chassis No." := ColText[13];
                FARec.INSERT;
                */

                /*IF NOT FAClass.GET(FARec."FA Class Code") THEN BEGIN
                  FAClass.Code := FARec."FA Class Code";
                  FAClass.INSERT;
                END;
                FARec."FA Subclass Code" := ColText[5];
                IF NOT FASubClass.GET(FARec."FA Subclass Code") THEN BEGIN
                  FASubClass.Code := FARec."FA Subclass Code";
                  FASubClass.INSERT;
                END;
                FARec."FA Posting Group"  := ColText[6];
                IF NOT FAPG.GET(FARec."FA Posting Group") THEN BEGIN
                  FAPG.Code := FARec."FA Posting Group";
                  FAPG.INSERT;
                END; */





                /*
               SaleslinePrice.INIT;
               EVALUATE(SaleslinePrice."Sales Type",ColText[1]);
               SaleslinePrice."Sales Code" := ColText[2];
               SaleslinePrice."Item No." := ColText[3];
               EVALUATE(SaleslinePrice."Starting Date",ColText[4]);
               EVALUATE(SaleslinePrice."Unit Price",ColText[5]);

               IF NOT SaleslinePrice.INSERT THEN
                 SaleslinePrice.MODIFY;
                 */

                /*Employee.INIT;
              Employee."No." := ColText[1];
              Employee.Name:= ColText[2];
              Employee.Address := ColText[3];
              Employee."Phone No." := ColText[4];
              Employee."Customer Number" := ColText[5];
              //EVALUATE(Employee."Employment Date",ColText[8]);
              Employee."Mode of Payment":= ColText[6];
              Employee.Manager:= ColText[7];
              Employee."Marital Status":= ColText[8];
              Employee."Tax Number":= ColText[9];
              Employee."Training Cost":= ColText[10];
              Employee."Mode of Payment":= ColText[11];
              EVALUATE(Employee."Mode of Payment",ColText[12]);
              Employee."Annual Tax FreePay":= ColText[13];
              Employee."Individual Earning Details":= ColText[14];
              Employee."Industry Code":= ColText[15];
              Employee."Sub Solution Code":= ColText[16];
              Employee."Execute Type":= ColText[17];
              Employee."Pension Fund Acc. No.":= ColText[18];
              Employee."Bonus Setup":= ColText[19];
              Employee."Life Assurance":= ColText[20];
              EVALUATE(Employee."Staff Type",ColText[21]);
              EVALUATE(Employee."Employment Date",ColText[22]);

              IF NOT Employee.INSERT THEN
                Employee.MODIFY;
               */

                /*
                DimVal3.INIT;
                DimVal3."Dimension Code" := 'EMPLOYEE';
                DimVal3.Code := ColText[1];
                DimVal3.Name := ColText[2];
                DimVal3."Global Dimension No." := 4;
                IF DimVal3.INSERT THEN;
                */


                /*
                DefDim.INIT;
                DefDim.VALIDATE("Table ID" ,DATABASE:: Employee);
                DefDim.VALIDATE("No.",ColText[1]);
                DefDim.VALIDATE("Dimension Code", 'EMPLOYEE');
                DefDim.VALIDATE("Dimension Value Code" ,ColText[1]);
                IF NOT DefDim.INSERT THEN
                DefDim.MODIFY;
                
                DefDim2.INIT;
                DefDim2.VALIDATE("Table ID" ,DATABASE:: Employee);
                DefDim2.VALIDATE("No.",ColText[1]);
                DefDim2.VALIDATE("Dimension Code", 'PROCESSGROUP');
                DefDim2.VALIDATE("Dimension Value Code" ,ColText[4]);
                IF NOT DefDim2.INSERT THEN
                DefDim2.MODIFY;
                */



                /*
                lAccount.INIT;
                GlAccount."No." := ColText[1];
                GlAccount.Name := ColText[2];
                EVALUATE(GlAccount."Account Type",ColText[3]);
                EVALUATE(GlAccount."Income/Balance",ColText[4]);
                EVALUATE(GlAccount.Totaling,ColText[5]);
                GlAccount.INSERT;
                
                
                Item.INIT;
                Item."No."  := ColText[1];
                Item.Description := ColText[2];
                //Item."Description 2" := ColText[3];
                Item."Base Unit of Measure" := ColText[3];
                Item."Item Category Code"   := ColText[4];
                Item."Product Group Code"   := ColText[5];
                Item."Gen. Prod. Posting Group" := ColText[6];
                Item."Inventory Posting Group" := ColText[7];
                EVALUATE(Item."Costing Method" , ColText[8]);
                Item."VAT Prod. Posting Group"  := ColText[9];
                Item.INSERT;
                
                
                
                IF NOT IUOM.GET(Item."No.",Item."Base Unit of Measure") THEN BEGIN
                  IUOM."Item No." := Item."No.";
                  IUOM.Code := Item."Base Unit of Measure";
                  IUOM."Qty. per Unit of Measure" := 1;
                  IUOM.INSERT;
                END;
                
                
                IF NOT ItemCategory.GET(Item."Item Category Code") THEN BEGIN
                 ItemCategory.Code := Item."Item Category Code";
                 ItemCategory."Def. Costing Method" := ItemCategory."Def. Costing Method"::FIFO;
                 ItemCategory.INSERT;
                END;
                
                IF NOT ProductGroup.GET(Item."Item Category Code",Item."Product Group Code") THEN BEGIN
                 ProductGroup."Item Category Code" := Item."Item Category Code";
                 ProductGroup.Code := Item."Product Group Code";
                 ProductGroup.INSERT;
                END;
                
                IF NOT GenProdPstGrp.GET(Item."Gen. Prod. Posting Group") THEN BEGIN
                 GenProdPstGrp.Code := Item."Gen. Prod. Posting Group";
                 GenProdPstGrp."Def. VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                 GenProdPstGrp."Auto Insert Default" := TRUE;
                 GenProdPstGrp.INSERT;
                END;
                
                IF NOT InvPostingGrp.GET(Item."Inventory Posting Group") THEN BEGIN
                 InvPostingGrp.Code := Item."Inventory Posting Group";
                 InvPostingGrp.INSERT;
                END;
                */
                /*
                CustRec.INIT;
                CustRec."No." := ColText[1];
                CustRec.VALIDATE(Name  , ColText[2]);
                CustRec.VALIDATE(CustRec."Payment Terms Code",ColText[3]);
                CustRec.VALIDATE(CustRec."Search Name",ColText[4]);
                CustRec.Address  := ColText[5];
                CustRec."Address 2" := ColText[6];
                CustRec.VALIDATE(City ,ColText[7]);
                CustRec.Contact     := ColText[8];
                CustRec."Phone No." := ColText[9];
                CustRec."Telex No." :=  ColText[10];
                CustRec."Territory Code" := ColText[11];
                CustRec.VALIDATE("Global Dimension 1 Code",ColText[12]);
                CustRec."Salesperson Code" := ColText[13];
                CustRec."Country/Region Code" := ColText[14];
                CustRec."Fax No." := ColText[15];
                CustRec."Gen. Bus. Posting Group" := ColText[16];
                CustRec."Post Code" := ColText[17];
                CustRec."E-Mail" := ColText[18];
                CustRec."Home Page" := ColText[19];
                CustRec."VAT Bus. Posting Group" := ColText[20];
                CustRec."No. 2" := ColText[21];
                EVALUATE(CustRec."Customer Type",ColText[22]);
                CustRec."Customer Posting Group" := ColText[23];
                CustRec.MODIFY;
                */

                /*
                UOM.INIT;
                UOM.Code := ColText[1];
                UOM.Description := ColText[2];
                UOM.INSERT;
                
                ProductGroup.INIT;
                ProductGroup."Item Category Code" := ColText[1];
                ProductGroup.Code  := ColText[2];
                ProductGroup.Description  := ColText[3];
                ProductGroup.INSERT;
                */
                /*
                GlAccount."No." := ColText[1];
                GlAccount.Name := ColText[2];
                EVALUATE(GlAccount."Account Type",ColText[3]);
                EVALUATE(GlAccount."Income/Balance",ColText[4]);
                EVALUATE(GlAccount.Totaling,ColText[5]);
                GlAccount.INSERT;
                */
                /*
                ItemJnLine.INIT;
                ItemJnLine."Journal Template Name"  := ColText[1];
                ItemJnLine."Journal Batch Name"     := ColText[2];
                EVALUATE(ItemJnLine."Line No." , ColText[3]);
                ItemJnLine.VALIDATE("Entry Type" , ItemJnLine."Entry Type"::"Positive Adjmt.");
                ItemJnLine.VALIDATE("Posting Date" , DMY2DATE(31,12,2012));
                ItemJnLine.VALIDATE("Document No." , 'OpbalStock01/01/13');
                ItemJnLine.VALIDATE(ItemJnLine."Item No." , ColText[4]);
                ItemJnLine.VALIDATE("Location Code" , ColText[7]);
                EVALUATE(ItemJnLine.Quantity, ColText[5]);
                ItemJnLine.VALIDATE(Quantity);
                EVALUATE(ItemJnLine."Unit Amount" , ColText[6]);
                ItemJnLine.VALIDATE("Unit Amount");
                ItemJnLine.Description := 'Stock Opening Balance for 01/01/2013';
                ItemJnLine."Reason Code" := 'OPBAL';
                ItemJnLine.INSERT;
                */
                /*
               VendRec.INIT;
               VendRec."No." := ColText[1];
               VendRec."No. 2" := ColText[2];
               VendRec.Name  := ColText[3];
               VendRec.Address := ColText[4];
               VendRec."Address 2" := ColText[5];
               VendRec.City := ColText[6];
               VendRec.Contact := ColText[7];
               VendRec."Phone No." := ColText[8];
               VendRec."Currency Code" := ColText[9];
               VendRec."Country/Region Code" := ColText[10];
               VendRec."Fax No."  := ColText[11];
               VendRec."E-Mail"   := ColText[12];
               VendRec."Home Page" := ColText[13];
               EVALUATE(VendRec."Vendor Type" , ColText[14]);
               VendRec."Vendor Posting Group" := ColText[15];
               VendRec."Payment Method Code"  := ColText[16];
               VendRec."Payment Terms Code"  := ColText[17];
               VendRec."Post Code"   := ColText[18];
               VendRec."Gen. Bus. Posting Group"  := ColText[19];
               VendRec."VAT Bus. Posting Group"  := ColText[20];
               VendRec.INSERT;
               */

                /*
                BankAcc.INIT;
                BankAcc."No." := ColText[1];
                BankAcc."No 2" := ColText[2];
                BankAcc.Name  := ColText[3];
                EVALUATE(BankAcc."Account Type" , ColText[4]);
                BankAcc."Currency Code" := ColText[5];
                BankAcc.City   := ColText[6];
                BankAcc."Bank Acc. Posting Group"  := ColText[7];
                BankAcc.Address := ColText[8];
                BankAcc."Address 2" := ColText[9];
                BankAcc."Phone No." := ColText[10];
                BankAcc.Contact     := ColText[11];
                BankAcc.INSERT;
                */
                /*
                CustRec.INIT;
                CustRec."No." := ColText[1];
                CustRec."No. 2" := ColText[2];
                CustRec.Name := ColText[3];
                CustRec.VALIDATE(Name);
                //CustRec."Gen. Bus. Posting Group" := ColText[4];
                CustRec."Customer Posting Group" := ColText[4];
                //CustRec."VAT Bus. Posting Group" := ColText[6];
                CustRec.INSERT;
                */

                /*
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := 'general';
                GenJnlLine."Journal Batch Name" := 'CUSTOPBAL';
                EVALUATE(GenJnlLine."Line No." , ColText[1]);
                GenJnlLine.VALIDATE("Line No.");
                EVALUATE(GenJnlLine."Posting Date",ColText[2]);
                GenJnlLine.VALIDATE("Posting Date");
                //EVALUATE(GenJnlLine."Document Type",ColText[3]);
                //GenJnlLine.VALIDATE("Document Type");
                EVALUATE(GenJnlLine."Account Type",ColText[3]);
                GenJnlLine.VALIDATE("Account Type");
                GenJnlLine.VALIDATE("Account No.",ColText[4]);
                GenJnlLine.VALIDATE("Document No." ,ColText[5]);
                GenJnlLine.VALIDATE("Currency Code",ColText[6]);
                //GenJnlLine.VALIDATE(GenJnlLine."External Document No.",ColText[7]);
                EVALUATE(GenJnlLine.Amount,ColText[7]);
                GenJnlLine.VALIDATE(Amount);
                GenJnlLine.Narration := ColText[8];
                //GenJnlLine.VALIDATE("Salespers./Purch. Code",ColText[9]);
                //GenJnlLine.VALIDATE(Narration,ColText[12]);
                GenJnlLine.VALIDATE("Bal. Account Type" ,GenJnlLine."Bal. Account Type" :: "G/L Account");
                GenJnlLine.VALIDATE("Bal. Account No.",'9999990');
                //GenJnlLine.VALIDATE("Shortcut Dimension 2 Code",ColText[10]);
                //GenJnlLine.VALIDATE("Shortcut Dimension 5 Code",ColText[11]);
                GenJnlLine.Description := 'Opening Entry CUSTOMER 01/01/13';
                //GenJnlLine.Narration := 'Staff Loan Opening Balance as of 01/01/2013';
                GenJnlLine.INSERT;
                */

                /*
                FARec.INIT;
                FARec."No."           := ColText[1];
                FARec."No. 2"         := ColText[2];
                FARec.Description     := ColText[3];
                FARec."FA Class Code" := ColText[4];
                IF NOT FAClass.GET(FARec."FA Class Code") THEN BEGIN
                  FAClass.Code := FARec."FA Class Code";
                  FAClass.INSERT;
                END;
                FARec."FA Subclass Code" := ColText[5];
                IF NOT FASubClass.GET(FARec."FA Subclass Code") THEN BEGIN
                  FASubClass.Code := FARec."FA Subclass Code";
                  FASubClass.INSERT;
                END;
                FARec."FA Posting Group"  := ColText[6];
                IF NOT FAPG.GET(FARec."FA Posting Group") THEN BEGIN
                  FAPG.Code := FARec."FA Posting Group";
                  FAPG.INSERT;
                END;
                FARec.INSERT;
                */

                /*
                FADepBook.INIT;
                FADepBook."FA No." := ColText[1];
                FADepBook."Depreciation Book Code" := ColText[2];
                FADepBook."FA Posting Group"  := ColText[3];
                //EVALUATE(FADepBook."Acquisition Date" , ColText[4]);
                //FADepBook.VALIDATE("Acquisition Date");
                //EVALUATE(FADepBook."Depreciation Starting Date" ,  ColText[3]);
                //FADepBook.VALIDATE("Depreciation Starting Date");
                //EVALUATE(FADepBook."Depreciation Ending Date", ColText[4]);
                //FADepBook.VALIDATE("Depreciation Ending Date");
                //FADepBook."FA Posting Group"  := ColText[5];
                FADepBook.INSERT;
                */
                /*
                TempItemOPBAL.INIT;
                TempItemOPBAL."No."     := ColText[1];
                TempItemOPBAL.Description := ColText[2];
                TempItemOPBAL.Group  := ColText[3];
                EVALUATE(TempItemOPBAL.Quantity , ColText[4]);
                EVALUATE(TempItemOPBAL."Unit Cost" , ColText[5]);
                EVALUATE(TempItemOPBAL.Value  , ColText[6]);
                TempItemOPBAL.INSERT;
                */

                /*
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := 'general';
                GenJnlLine."Journal Batch Name" := 'FAOPBAL';
                EVALUATE(GenJnlLine."Line No." ,ColText[1]);
                GenJnlLine.VALIDATE("Line No.");
                GenJnlLine.VALIDATE("Account Type" ,GenJnlLine."Account Type"::"Fixed Asset");
                GenJnlLine.VALIDATE(GenJnlLine."Account No.",ColText[2]);
                EVALUATE(GenJnlLine."Posting Date" , ColText[3]);
                GenJnlLine.VALIDATE("Posting Date");
                GenJnlLine."Document No." := 'FAOPBAL010113';
                EVALUATE(GenJnlLine.Amount,ColText[4]);
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                EVALUATE(GenJnlLine."FA Posting Date" ,ColText[5]);
                GenJnlLine."Bal. Account Type" := 0;
                GenJnlLine.VALIDATE("Bal. Account No.",'9999999');
                GenJnlLine.Description := 'Opening Entry FA010113';
                GenJnlLine.VALIDATE(GenJnlLine."FA Posting Type",GenJnlLine."FA Posting Type"::"Acquisition Cost" );
                GenJnlLine.Narration := 'Fixed Asset Opening Balance as of 01/01/2013';
                GenJnlLine.INSERT;
                */


                /*CustRec.INIT;
                CustRec."No."  := ColText[1];
                CustRec.VALIDATE("Payment Terms Code"  , ColText[2]);
                CustRec.MODIFY;
                */




                /*
                
                
                JobTask.INIT;
                JobTask."Job No."  := ColText[1];
                JobTask."Job Task No." :=  ColText[2];
                JobTask.Description := ColText[3];
                JobTask.VALIDATE("Global Dimension 2 Code", ColText[4]);
                JobTask.VALIDATE("Global Dimension 2 Code");
                Job.GET(JobTask."Job No.");
                JobTask.VALIDATE(JobTask."Global Dimension 1 Code",Job."Global Dimension 1 Code");
                JobTask.VALIDATE(JobTask."Shortcut Dimension 5 Code",Job."Shortcut Dimension 5 Code");
                JobTask.VALIDATE(JobTask."Shortcut Dimension 6 Code",Job."Shortcut Dimension 6 Code");
                IF JobTask.INSERT THEN;
                */

                /*
                JobsOnOrder.INIT;
                JobsOnOrder."Job No." := ColText[1];
                EVALUATE(JobsOnOrder."LPO Value" , ColText[2]);
                EVALUATE(JobsOnOrder."Biz Won Cost" , ColText[3]);
                EVALUATE(JobsOnOrder."Usage Cost" , ColText[4]);
                JobsOnOrder.INSERT;
                */

                /*GLEntry.INIT;
                GLEntry."G/L Account No." := ColText[1];
                EVALUATE(GLEntry."Posting Date",ColText[2]);
                GLEntry."Document No.":=  ColText[3];
                GLEntry.Description:=  ColText[4];
                EVALUATE(GLEntry."Debit Amount",ColText[5]);
                EVALUATE(GLEntry."Credit Amount",ColText[6]);
                EVALUATE(GLEntry."Source Code",ColText[7]);
                GLEntry."Source No.":= ColText[8];
                GLEntry.INSERT;
                 */


                // TripsRec.INIT;
                // TripsRec."No." := ColText[1];
                // TripsRec."CUSTOMER OPERATION" := ColText[2];
                // EVALUATE(TripsRec.Operation, ColText[3]);
                // TripsRec."Loading Loc." := ColText[4];
                // TripsRec."Trip(Plant-Depot-Plant)" := ColText[5];
                // EVALUATE(TripsRec.Mileage, ColText[5]);
                // EVALUATE(TripsRec."TAT Target (Hours)", ColText[6]);
                // EVALUATE(TripsRec."Defaut Fuel Ltrs", ColText[7]);
                // EVALUATE(TripsRec."Trip Type", ColText[8]);
                // TripsRec.INSERT;





                /*
                JVLines.INIT;
                JVLines."Document No." := ColText[1];
                EVALUATE(JVLines."Line No.",ColText[2]);
                EVALUATE(JVLines."Account Type",ColText[3]);
                JVLines."Account No."  :=ColText[4];
                JVLines.Description    :=ColText[5];
                EVALUATE(JVLines.Amount,ColText[6]);
                EVALUATE(JVLines."Shortcut Dimension 4 Code",ColText[7]);
                JVLines.VALIDATE(JVLines."Shortcut Dimension 1 Code",ColText[8]);
                JVLines.VALIDATE(JVLines."Shortcut Dimension 2 Code",ColText[9]);
                JVLines.VALIDATE(JVLines."Shortcut Dimension 3 Code",ColText[10]);
                JVLines.INSERT;
                */

                /*
                ImportJobS.INIT;
                EVALUATE(ImportJobS.SN, ColText[1]);
                ImportJobS."Job No"  := ColText[2];
                EVALUATE(ImportJobS."Posting Date",ColText[3]);
                ImportJobS."Service Item No."  := ColText[4];
                EVALUATE(ImportJobS.Quantity , ColText[5]);
                EVALUATE(ImportJobS."ShippedNot Invoiced" ,ColText[6]);
                EVALUATE(ImportJobS."Quantity Shipped" , ColText[7]);
                ImportJobS.INSERT;
                          */




                /*
                DailtTATFlash.INIT;
                DailtTATFlash."Cust. Waybill Ref." := ColText[1];
                //EVALUATE(DailtTATFlash."Plant Departure Date",ColText[2]);
                DailtTATFlash."Nav Vehicle No" := ColText[3];
                DailtTATFlash."Trip Description" := ColText[5];
                DailtTATFlash."Product Type" := ColText[6];
                EVALUATE(DailtTATFlash."Product Qty",ColText[7]);
                EVALUATE(DailtTATFlash."Breakage (Cases)" ,ColText[8]);
                EVALUATE(DailtTATFlash."Short Delivery (Cases)",ColText[9]);
                EVALUATE(DailtTATFlash."Fuel Litres",ColText[11]);
                EVALUATE(DailtTATFlash."Start Odometer",ColText[15]);
                EVALUATE(DailtTATFlash."End Odometer",ColText[16]);
                EVALUATE(DailtTATFlash."Plant Arrival Date",ColText[18]);
                EVALUATE(DailtTATFlash."Plant Arrival Time",ColText[19]);
                EVALUATE(DailtTATFlash."Plant Departure Date",ColText[20]);
                EVALUATE(DailtTATFlash."Plant Departure Time",ColText[21]);
                //EVALUATE(DailtTATFlash."Return Plant Arrival  Date",ColText[19]);
                EVALUATE(DailtTATFlash."Depot Arrival Date",ColText[24]);
                EVALUATE(DailtTATFlash."Depot Arrival Time",ColText[25]);
                EVALUATE(DailtTATFlash."Depot Departure Date",ColText[26]);
                EVALUATE(DailtTATFlash."Deport Departure Time",ColText[27]);
                EVALUATE(DailtTATFlash."Return Plant Arrival  Date",ColText[30]);
                EVALUATE(DailtTATFlash."Return Plant Arrival Time",ColText[31]);
                DailtTATFlash.Remarks:=ColText[33];
                DailtTATFlash.INSERT;        */

            end;

            trigger OnPreDataItem()
            begin
                ExcelBuf.RESET;
                ExcelBuf.DELETEALL;
                ExcelBuf.OpenBook(ServerFileName, SheetName);
                ExcelBuf.ReadSheet;
                IF ExcelBuf.FINDLAST THEN
                    SETRANGE(Number, 2, ExcelBuf."Row No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Import from")
                    {
                        Caption = 'Import from';
                        field(FileName; FileName)
                        {
                            Caption = 'Workbook File Name';
                            Editable = false;

                            trigger OnAssistEdit()
                            begin
                                RequestFile;
                                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                            end;

                            trigger OnValidate()
                            begin
                                //FileNameOnAfterValidate;
                            end;
                        }
                        field(SheetName; SheetName)
                        {
                            Caption = 'Worksheet Name';
                            Editable = false;

                            trigger OnAssistEdit()
                            begin
                                IF ServerFileName = '' THEN BEGIN
                                    RequestFile;
                                END;

                                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseHeader: Record "Purchase Header";
        TransferRecitHd: Record 5746;
        ExcelBuf: Record 370 temporary;
        ColText: array[100] of Text[250];
        FileMgt: Codeunit 419;
        FileName: Text;
        ServerFileName: Text;
        SheetName: Text[250];
        Text005: Label 'Imported from Excel ';
        Text006: Label 'Import Excel File';
        Employee: Record 5200;
        GlAccount: Record 15;
        Item: Record 27;
        ItemCategory: Record 5722;
        //ProductGroup: Record 5723;
        GenProdPstGrp: Record 251;
        InvPostingGrp: Record 94;
        IUOM: Record 5404;
        CustRec: Record 18;
        VendRec: Record 23;
        UOM: Record 204;
        ItemJnLine: Record 83;
        GenJnlLine: Record 81;
        BankAcc: Record 270;
        FARec: Record 5600;
        FAClass: Record 5607;
        FASubClass: Record 5608;
        FAPG: Record 5606;
        FADepBook: Record 5612;
        JobTask: Record 1001;
        JobTask2: Record 1001;
        JobPlanningLines: Record 1003;
        Job: Record 167;
        Emp: Record 5200;
        DimVal: Record 349;
        DimVal2: Record 349;
        DimVal3: Record 349;
        DefDim: Record 352;
        DefDim2: Record 352;
        GLEntry: Record 17;

    [Scope('Internal')]
    procedure ImportSheet(RowNumber: Integer)
    begin
        CLEAR(ColText);
        ExcelBuf.SETRANGE(ExcelBuf."Row No.", RowNumber);
        IF ExcelBuf.FINDFIRST THEN BEGIN
            REPEAT
                ColText[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
            UNTIL ExcelBuf.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure RequestFile()
    begin
        IF FileName <> '' THEN
            ServerFileName := FileMgt.UploadFile(Text006, FileName)
        ELSE
            ServerFileName := FileMgt.UploadFile(Text006, '.xlsx');

        FileName := FileMgt.GetFileName(ServerFileName);
    end;
}

