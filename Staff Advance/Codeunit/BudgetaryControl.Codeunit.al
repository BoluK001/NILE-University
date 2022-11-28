// codeunit 51534520 "Budgetary Control"
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         BCSetup: Record 51534654;
//         DimMgt: Codeunit 408;
//         ShortcutDimCode: array[8] of Code[20];
//         BudgetGL: Code[20];
//         Text0001: Label 'You Have exceeded the Budget by ';
//         Text0002: Label ' Do you want to Continue?';
//         Text0003: Label 'There is no Budget to Check against do you wish to continue?';

//     [Scope('OnPrem')]
//     procedure CheckPurchase(var PurchHeader: Record "Purchase Header")
//     var
//         PurchLine: Record "Purchase Line";
//         Commitments: Record Committment;
//         Amount: Decimal;
//         GLAcc: Record 15;
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record 366;
//         BudgetAmount: Decimal;
//         Actuals: Record 365;
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record 5600;
//         FAPostingGRP: Record 5606;
//         EntryNo: Integer;
//     //Capex: Record "39005948"
//     begin
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         //IF BCSetup.Mandatory THEN//budgetary control is mandatory
//         BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (PurchHeader."Document Date" < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (PurchHeader."Document Date" > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3', PurchHeader."Document Date",
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");
//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PurchLine.RESET;
//             PurchLine.SETRANGE(PurchLine."Document Type", PurchHeader."Document Type");
//             PurchLine.SETRANGE(PurchLine."Document No.", PurchHeader."No.");
//             IF PurchLine.FINDFIRST THEN BEGIN
//                 REPEAT

//                     //Get the Dimension Here
//                     IF PurchLine."Line No." <> 0 THEN
//                         DimMgt.GetShortcutDimensions(PurchLine."Dimension Set ID", ShortcutDimCode);

//                     //DimMgt.ShowDocDim(
//                     //DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Document No.",
//                     //PurchLine."Line No.",ShortcutDimCode)
//                     //ELSE
//                     //DimMgt.ClearDimSetFilter(ShortcutDimCode);
//                     //Had to be put here for the sake of Calculating Individual Line Entries

//                     //check the type of account in the payments line
//                     //Item
//                     IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
//                         Item.RESET;
//                         IF NOT Item.GET(PurchLine."No.") THEN
//                             ERROR('Item Does not Exist');

//                         Item.TESTFIELD("Item G/L Budget Account");
//                         BudgetGL := Item."Item G/L Budget Account";
//                     END;

//                     IF PurchLine.Type = PurchLine.Type::"Fixed Asset" THEN BEGIN
//                         FixedAssetsDet.RESET;
//                         FixedAssetsDet.SETRANGE(FixedAssetsDet."No.", PurchLine."No.");
//                         IF FixedAssetsDet.FIND('-') THEN BEGIN
//                             FAPostingGRP.RESET;
//                             FAPostingGRP.SETRANGE(FAPostingGRP.Code, FixedAssetsDet."FA Posting Group");
//                             IF FAPostingGRP.FIND('-') THEN
//                                 IF PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Maintenance THEN BEGIN
//                                     BudgetGL := FAPostingGRP."Maintenance Expense Account";
//                                     IF BudgetGL = '' THEN
//                                         ERROR('Ensure Fixed Asset No %1 has the Maintenance G/L Account', PurchLine."No.");
//                                 END ELSE BEGIN
//                                     IF PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::"Acquisition Cost" THEN BEGIN
//                                         BudgetGL := FAPostingGRP."Acquisition Cost Account";
//                                         IF BudgetGL = '' THEN
//                                             ERROR('Ensure Fixed Asset No %1 has the Acquisition G/L Account', PurchLine."No.");
//                                     END;
//                                     //To Accomodate any Additional Item under Custom 1 and Custom 2
//                                     IF PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::"3" THEN BEGIN
//                                         BudgetGL := FAPostingGRP."Custom 2 Account";
//                                         IF BudgetGL = '' THEN
//                                             ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account', PurchLine."No.",
//                                             FAPostingGRP."Custom 1 Account");
//                                     END;

//                                     IF PurchLine."FA Posting Type" = PurchLine."FA Posting Type"::Appreciation THEN BEGIN
//                                         BudgetGL := FAPostingGRP."Custom 2 Account";
//                                         IF BudgetGL = '' THEN
//                                             ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account', PurchLine."No.",
//                                             FAPostingGRP."Custom 1 Account");
//                                     END;
//                                     //To Accomodate any Additional Item under Custom 1 and Custom 2

//                                 END;
//                         END;
//                     END;

//                     IF PurchLine.Type = PurchLine.Type::"G/L Account" THEN BEGIN
//                         BudgetGL := PurchLine."No.";
//                         IF GLAcc.GET(PurchLine."No.") THEN
//                             GLAcc.TESTFIELD("Budget Controlled", TRUE);
//                     END;
//                     /*
//                                         IF PurchLine.Type = PurchLine.Type::Capex THEN BEGIN
//                                             Capex.GET(PurchLine."No.");
//                                             BudgetGL := Capex."G/L Account";
//                                             IF GLAcc.GET(BudgetGL) THEN
//                                                 GLAcc.TESTFIELD("Budget Controlled", TRUE);
//                                         END;
//                     */
//                     //End Checking Account in Payment Line

//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(PurchHeader."Document Date", 2), DATE2DMY(PurchHeader."Document Date", 3));
//                     CurrMonth := DATE2DMY(PurchHeader."Document Date", 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(PurchHeader."Document Date", 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(PurchHeader."Document Date", 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;
//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PurchLine."Shortcut Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PurchLine."Shortcut Dimension 2 Code");
//                     //Budget.SETRANGE(Budget."Dimension 3 Value Code",ShortcutDimCode[3]);
//                     //Budget.SETRANGE(Budget."Dimension 4 Value Code",ShortcutDimCode[4]);
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PurchLine."Shortcut Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PurchLine."Shortcut Dimension 2 Code");
//                     //Actuals.SETRANGE(Actuals."Dimension 3 Value Code",ShortcutDimCode[3]);
//                     //Actuals.SETRANGE(Actuals."Dimension 4 Value Code",ShortcutDimCode[4]);
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     CommitmentAmount := 0;
//                     Commitments.RESET;
//                     Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
//                     //Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ShortcutDimCode[3]);
//                     //Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ShortcutDimCode[4]);
//                     Commitments.CALCSUMS(Commitments.Amount);
//                     CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against here');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)") + ActualsAmount > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount On Order No %1  %2 %3  Exceeds The Budget By %4',
//                         PurchLine."Document No.", PurchLine.Type, PurchLine."No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Outstanding Amount (LCY)"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)") + ActualsAmount > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PurchLine."Outstanding Amount (LCY)")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                         //END ADDING CONFIRMATION
//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := PurchHeader."Document Date";
//                         IF PurchHeader."Purchase Type" = PurchHeader."Purchase Type"::Purchase THEN
//                             Commitments."Document Type" := Commitments."Document Type"::LPO
//                         ELSE
//                             Commitments."Document Type" := Commitments."Document Type"::Requisition;

//                         IF PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice THEN
//                             Commitments."Document Type" := Commitments."Document Type"::PurchInvoice;

//                         Commitments."Document No." := PurchHeader."No.";
//                         Commitments.Amount := PurchLine."Outstanding Amount (LCY)";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := PurchHeader."Document Date";
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := ShortcutDimCode[3];
//                         Commitments."Shortcut Dimension 4 Code" := ShortcutDimCode[4];
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.Type := Commitments.Type::Vendor;
//                         Commitments."Vendor/Cust No." := PurchHeader."Buy-from Vendor No.";
//                         Commitments.INSERT;
//                         //Tag the Purchase Line as Committed
//                         PurchLine.Committed := TRUE;
//                         PurchLine.MODIFY;
//                         //End Tagging PurchLines as Committed
//                     END;
//                 UNTIL PurchLine.NEXT = 0;
//             END;
//         END
//         /*
//         ELSE//budget control not mandatory
//           BEGIN

//           END;
//         */

//         /*
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") THEN
//               BEGIN
//                 ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
//                 BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
//               END
//             ELSE IF (PurchHeader."Document Date">BCSetup."Current Budget End Date") THEN
//               BEGIN
//                 ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
//                 BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");

//               END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");
//             //Get Commitment Lines
//                  IF Commitments.FIND('+') THEN
//                 EntryNo:=Commitments."Line No.";

//             //get the lines related to the payment header
//               PurchLine.RESET;
//               PurchLine.SETRANGE(PurchLine."Document Type",PurchHeader."Document Type");
//               PurchLine.SETRANGE(PurchLine."Document No.",PurchHeader."No.");
//               IF PurchLine.FINDFIRST THEN
//                 BEGIN
//                   REPEAT

//                  //Get the Dimension Here
//                    IF PurchLine."Line No." <> 0 THEN
//                        DimMgt.GetShortcutDimensions(PurchLine."Dimension Set ID",ShortcutDimCode);

//                         //DimMgt.ShowDocDim(
//                           //DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Document No.",
//                           //PurchLine."Line No.",ShortcutDimCode)
//                       //ELSE
//                         //DimMgt.ClearDimSetFilter(ShortcutDimCode);
//                  //Had to be put here for the sake of Calculating Individual Line Entries

//                     //check the type of account in the payments line
//                   //Item
//                       IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
//                           Item.RESET;
//                           IF NOT Item.GET(PurchLine."No.") THEN
//                              ERROR('Item Does not Exist');

//                           Item.TESTFIELD("Item G/L Budget Account");
//                           BudgetGL:=Item."Item G/L Budget Account";
//                        END;

//                        IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
//                                FixedAssetsDet.RESET;
//                                FixedAssetsDet.SETRANGE(FixedAssetsDet."No.",PurchLine."No.");
//                                  IF FixedAssetsDet.FIND('-') THEN BEGIN
//                                      FAPostingGRP.RESET;
//                                      FAPostingGRP.SETRANGE(FAPostingGRP.Code,FixedAssetsDet."FA Posting Group");
//                                      IF FAPostingGRP.FIND('-') THEN
//                                        IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN
//                                         BEGIN
//                                            BudgetGL:=FAPostingGRP."Maintenance Expense Account";
//                                              IF BudgetGL ='' THEN
//                                                ERROR('Ensure Fixed Asset No %1 has the Maintenance G/L Account',PurchLine."No.");
//                                        END ELSE BEGIN
//                                          IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Acquisition Cost" THEN BEGIN
//                                            BudgetGL:=FAPostingGRP."Acquisition Cost Account";
//                                               IF BudgetGL ='' THEN
//                                                  ERROR('Ensure Fixed Asset No %1 has the Acquisition G/L Account',PurchLine."No.");
//                                          END;
//                                          //To Accomodate any Additional Item under Custom 1 and Custom 2
//                                          IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"3" THEN BEGIN
//                                            BudgetGL:=FAPostingGRP."Custom 2 Account";
//                                               IF BudgetGL ='' THEN
//                                                  ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
//                                                  FAPostingGRP."Custom 1 Account");
//                                          END;

//                                          IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Currency THEN BEGIN
//                                            BudgetGL:=FAPostingGRP."Custom 2 Account";
//                                               IF BudgetGL ='' THEN
//                                                  ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
//                                                  FAPostingGRP."Custom 1 Account");
//                                          END;
//                                          //To Accomodate any Additional Item under Custom 1 and Custom 2

//                                         END;
//                                  END;
//                        END;

//                        IF PurchLine.Type=PurchLine.Type::"G/L Account" THEN BEGIN
//                           BudgetGL:=PurchLine."No.";
//                           IF GLAcc.GET(PurchLine."No.") THEN
//                              GLAcc.TESTFIELD("Budget Controlled",TRUE);
//                        END;

//                     //End Checking Account in Payment Line

//                                //check the votebook now
//                                FirstDay:=DMY2DATE(1,DATE2DMY(PurchHeader."Document Date",2),DATE2DMY(PurchHeader."Document Date",3));
//                                CurrMonth:=DATE2DMY(PurchHeader."Document Date",2);
//                                IF CurrMonth=12 THEN
//                                 BEGIN
//                                   LastDay:=DMY2DATE(1,1,DATE2DMY(PurchHeader."Document Date",3) +1);
//                                   LastDay:=CALCDATE('-1D',LastDay);
//                                 END
//                                ELSE
//                                 BEGIN
//                                   CurrMonth:=CurrMonth +1;
//                                   LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(PurchHeader."Document Date",3));
//                                   LastDay:=CALCDATE('-1D',LastDay);
//                                 END;
//                                //check the summation of the budget in the database
//                                BudgetAmount:=0;
//                                Budget.RESET;
//                                Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
//                                Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
//                                Budget."Dimension 4 Value Code");
//                                Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
//                                Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
//                                Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
//                                Budget.SETRANGE(Budget."Dimension 1 Value Code",PurchLine."Shortcut Dimension 1 Code");
//                                Budget.SETRANGE(Budget."Dimension 2 Value Code",PurchLine."Shortcut Dimension 2 Code");
//                                Budget.SETRANGE(Budget."Dimension 3 Value Code",ShortcutDimCode[3]);
//                                Budget.SETRANGE(Budget."Dimension 4 Value Code",ShortcutDimCode[4]);
//                                    Budget.CALCSUMS(Budget.Amount);
//                                    BudgetAmount:= Budget.Amount;

//                           //get the summation on the actuals
//                             ActualsAmount:=0;
//                             Actuals.RESET;
//                             Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
//                             Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
//                             Actuals."Posting Date",Actuals."Account No.");
//                             Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
//                             Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PurchLine."Shortcut Dimension 1 Code");
//                             Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PurchLine."Shortcut Dimension 2 Code");
//                             Actuals.SETRANGE(Actuals."Dimension 3 Value Code",ShortcutDimCode[3]);
//                             Actuals.SETRANGE(Actuals."Dimension 4 Value Code",ShortcutDimCode[4]);
//                             Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
//                             Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
//                                Actuals.CALCSUMS(Actuals.Amount);
//                                ActualsAmount:= Actuals.Amount;

//                           //get the committments
//                             CommitmentAmount:=0;
//                             Commitments.RESET;
//                             Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
//                             Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
//                             Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
//                             Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
//                             Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
//                             Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
//                             Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
//                             Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
//                             Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ShortcutDimCode[3]);
//                             Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ShortcutDimCode[4]);
//                                Commitments.CALCSUMS(Commitments.Amount);
//                                CommitmentAmount:= Commitments.Amount;

//                            //check if there is any budget
//                            IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
//                               ERROR('No Budget To Check Against');
//                            END ELSE BEGIN
//                             IF (BudgetAmount<=0) THEN BEGIN
//                              IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                              END;
//                             END;
//                            END;

//                            //check if the actuals plus the amount is greater then the budget amount
//                            IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)")+ ActualsAmount>BudgetAmount)
//                            AND NOT (BCSetup."Allow OverExpenditure") THEN
//                             BEGIN
//                               ERROR('The Amount On Order No %1  %2 %3  Exceeds The Budget By %4',
//                               PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
//                                 FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Outstanding Amount (LCY)"))));
//                             END ELSE BEGIN
//                                 //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                                 IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)")+ ActualsAmount>BudgetAmount) THEN BEGIN
//                                     IF NOT CONFIRM(Text0001+
//                                     FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Outstanding Amount (LCY)")))
//                                     +Text0002,TRUE) THEN BEGIN
//                                        ERROR('Budgetary Checking Process Aborted');
//                                     END;
//                                 END;
//                                 //END ADDING CONFIRMATION
//                                 Commitments.RESET;
//                                 Commitments.INIT;
//                                 EntryNo+=1;
//                                 Commitments."Line No.":=EntryNo;
//                                 Commitments.Date:=TODAY;
//                                 Commitments."Posting Date":=PurchHeader."Document Date";
//                                 IF PurchHeader."Purchase Type"=PurchHeader."Purchase Type"::Purchase THEN
//                                     Commitments."Document Type":=Commitments."Document Type"::LPO
//                                 ELSE
//                                     Commitments."Document Type":=Commitments."Document Type"::Requisition;

//                                 IF PurchHeader."Document Type"=PurchHeader."Document Type"::Invoice THEN
//                                     Commitments."Document Type":=Commitments."Document Type"::PurchInvoice;

//                                 Commitments."Document No.":=PurchHeader."No.";
//                                 Commitments.Amount:=PurchLine."Outstanding Amount (LCY)";
//                                 Commitments."Month Budget":=BudgetAmount;
//                                 Commitments."Month Actual":=ActualsAmount;
//                                 Commitments.Committed:=TRUE;
//                                 Commitments."Committed By":=USERID;
//                                 Commitments."Committed Date":=PurchHeader."Document Date";
//                                 Commitments."G/L Account No.":=BudgetGL;
//                                 Commitments."Committed Time":=TIME;
//         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                                 Commitments."Shortcut Dimension 1 Code":=PurchLine."Shortcut Dimension 1 Code";
//                                 Commitments."Shortcut Dimension 2 Code":=PurchLine."Shortcut Dimension 2 Code";
//                                 Commitments."Shortcut Dimension 3 Code":=ShortcutDimCode[3];
//                                 Commitments."Shortcut Dimension 4 Code":=ShortcutDimCode[4];
//                                 Commitments.Budget:=BCSetup."Current Budget Code";
//                                 Commitments.Type:=Commitments.Type::Vendor;
//                                 Commitments."Vendor/Cust No.":=PurchHeader."Buy-from Vendor No.";
//                                 Commitments.INSERT;
//                                 //Tag the Purchase Line as Committed
//                                   PurchLine.Committed:=TRUE;
//                                   PurchLine.MODIFY;
//                                 //End Tagging PurchLines as Committed
//                             END;
//                   UNTIL PurchLine.NEXT=0;
//                 END;
//           END
//         ELSE//budget control not mandatory
//           BEGIN

//           END;
//         */

//     end;

//     [Scope('OnPrem')]
//     procedure CheckPayments(var PaymentHeader: Record "Voucher Header")
//     var
//         PayLine: Record "Voucher Line";
//         //Commitments: Record Committment;
//         Amount: Decimal;
//         GLAcc: Record "G/L Account";
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record "Analysis View Budget Entry";
//         BudgetAmount: Decimal;
//         Actuals: Record "Analysis View Entry";
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record "Fixed Asset";
//         FAPostingGRP: Record "FA Posting Group";
//         EntryNo: Integer;
//     begin

//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (PaymentHeader.Date < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (PaymentHeader.Date > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3', PaymentHeader.Date,
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");

//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PayLine.RESET;
//             PayLine.SETRANGE(PayLine."No.", PaymentHeader."No.");
//             PayLine.SETRANGE(PayLine."Account Type", PayLine."Account Type"::"G/L Account");
//             PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
//             IF PayLine.FINDFIRST THEN BEGIN
//                 REPEAT
//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(PaymentHeader.Date, 2), DATE2DMY(PaymentHeader.Date, 3));
//                     CurrMonth := DATE2DMY(PaymentHeader.Date, 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(PaymentHeader.Date, 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(PaymentHeader.Date, 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;

//                     BudgetGL := PayLine."Account No.";
//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PayLine."shortcut Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Budget.SETRANGE(Budget."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Budget.SETRANGE(Budget."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PayLine."Shortcut Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     // CommitmentAmount := 0;
//                     // Commitments.RESET;
//                     // Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     // Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     // Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     // Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     // Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     // Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     // Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
//                     // Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
//                     // Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code", PayLine."Shortcut Dimension 3 Code");
//                     // Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code", PayLine."Shortcut Dimension 4 Code");
//                     // Commitments.CALCSUMS(Commitments.Amount);
//                     // CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PayLine."NetAmount LCY" + ActualsAmount) > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
//                         PayLine."No.", PayLine.Type, PayLine."No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."NetAmount LCY"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PayLine."NetAmount LCY" + ActualsAmount) > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."NetAmount LCY")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;

//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := PaymentHeader.Date;
//                         IF PaymentHeader."Payment Type" = PaymentHeader."Payment Type"::Normal THEN
//                             Commitments."Document Type" := Commitments."Document Type"::"Payment Voucher"
//                         ELSE
//                             Commitments."Document Type" := Commitments."Document Type"::PettyCash;
//                         Commitments."Document No." := PaymentHeader."No.";
//                         Commitments.Amount := PayLine."NetAmount LCY";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := PaymentHeader.Date;
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
//                         Commitments."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.INSERT;
//                         //Tag the Payment Line as Committed
//                         PayLine.Committed := TRUE;
//                         PayLine.MODIFY;
//                         //End Tagging Payment Lines as Committed
//                     END;

//                 UNTIL PayLine.NEXT = 0;
//             END;
//         END
//         ELSE//budget control not mandatory
//           BEGIN

//         END;
//         MESSAGE('Budgetary Checking Completed Successfully');
//     end;

//     [Scope('OnPrem')]
//     procedure CheckImprest(var ImprestHeader: Record "51534706")
//     var
//         PayLine: Record "51534707";
//         Commitments: Record "51534655";
//         Amount: Decimal;
//         GLAcc: Record "G/L Account";
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record "Analysis View Budget Entry";
//         BudgetAmount: Decimal;
//         Actuals: Record "Analysis View Entry";
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record "5600";
//         FAPostingGRP: Record "5606";
//         EntryNo: Integer;
//     begin
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (ImprestHeader.Date < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (ImprestHeader.Date > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");

//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PayLine.RESET;
//             PayLine.SETRANGE(PayLine."No.", ImprestHeader."No.");
//             PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
//             IF PayLine.FINDFIRST THEN BEGIN
//                 REPEAT
//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(ImprestHeader.Date, 2), DATE2DMY(ImprestHeader.Date, 3));
//                     CurrMonth := DATE2DMY(ImprestHeader.Date, 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(ImprestHeader.Date, 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(ImprestHeader.Date, 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;

//                     //The GL Account
//                     BudgetGL := PayLine."Account No.";

//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Budget.SETRANGE(Budget."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Budget.SETRANGE(Budget."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     CommitmentAmount := 0;
//                     Commitments.RESET;
//                     Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code", PayLine."Shortcut Dimension 3 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code", PayLine."Shortcut Dimension 4 Code");
//                     Commitments.CALCSUMS(Commitments.Amount);
//                     CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
//                         PayLine."No.", 'Staff Imprest', PayLine."No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;

//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := ImprestHeader.Date;
//                         Commitments."Document Type" := Commitments."Document Type"::Imprest;
//                         Commitments."Document No." := ImprestHeader."No.";
//                         Commitments.Amount := PayLine."Amount LCY";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := ImprestHeader.Date;
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
//                         Commitments."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.Type := ImprestHeader."Account Type";
//                         Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
//                         Commitments.INSERT;
//                         //Tag the Imprest Line as Committed
//                         PayLine.Committed := TRUE;
//                         PayLine.MODIFY;
//                         //End Tagging Imprest Lines as Committed
//                     END;

//                 UNTIL PayLine.NEXT = 0;
//             END;
//         END
//         ELSE//budget control not mandatory
//           BEGIN

//         END;
//         MESSAGE('Budgetary Checking Completed Successfully');
//     end;

//     [Scope('OnPrem')]
//     procedure ReverseEntries(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance; DocNo: Code[20])
//     var
//         Commitments: Record Committment;
//         EntryNo: Integer;
//         CommittedLines: Record Committment;
//     begin
//         //Get Commitment Lines
//         Commitments.RESET;
//         IF Commitments.FIND('+') THEN
//             EntryNo := Commitments."Line No.";

//         CommittedLines.RESET;
//         CommittedLines.SETRANGE(CommittedLines."Document Type", DocumentType);
//         CommittedLines.SETRANGE(CommittedLines."Document No.", DocNo);
//         CommittedLines.SETRANGE(CommittedLines.Committed, TRUE);
//         IF CommittedLines.FIND('-') THEN BEGIN
//             REPEAT
//                 Commitments.RESET;
//                 Commitments.INIT;
//                 EntryNo += 1;
//                 Commitments."Line No." := EntryNo;
//                 Commitments.Date := TODAY;
//                 Commitments."Posting Date" := CommittedLines."Posting Date";
//                 Commitments."Document Type" := CommittedLines."Document Type";
//                 Commitments."Document No." := CommittedLines."Document No.";
//                 Commitments.Amount := -CommittedLines.Amount;
//                 Commitments."Month Budget" := CommittedLines."Month Budget";
//                 Commitments."Month Actual" := CommittedLines."Month Actual";
//                 Commitments.Committed := FALSE;
//                 Commitments."Committed By" := USERID;
//                 Commitments."Committed Date" := CommittedLines."Committed Date";
//                 Commitments."G/L Account No." := CommittedLines."G/L Account No.";
//                 Commitments."Committed Time" := TIME;
//                 //     Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                 Commitments."Shortcut Dimension 1 Code" := CommittedLines."Shortcut Dimension 1 Code";
//                 Commitments."Shortcut Dimension 2 Code" := CommittedLines."Shortcut Dimension 2 Code";
//                 Commitments."Shortcut Dimension 3 Code" := CommittedLines."Shortcut Dimension 3 Code";
//                 Commitments."Shortcut Dimension 4 Code" := CommittedLines."Shortcut Dimension 4 Code";
//                 Commitments.Budget := CommittedLines.Budget;
//                 Commitments.INSERT;

//             UNTIL CommittedLines.NEXT = 0;
//         END;
//     end;

//     [Scope('OnPrem')]
//     procedure CheckFundsAvailability(Payments: Record "51534677")
//     var
//         BankAcc: Record "270";
//         "Current Source A/C Bal.": Decimal;
//     begin
//         //get the source account balance from the database table
//         BankAcc.RESET;
//         BankAcc.SETRANGE(BankAcc."No.", Payments."Paying Bank Account");
//         BankAcc.SETRANGE(BankAcc."Bank Type", BankAcc."Bank Type"::Cash);
//         IF BankAcc.FINDFIRST THEN BEGIN
//             BankAcc.CALCFIELDS(BankAcc.Balance);
//             "Current Source A/C Bal." := BankAcc.Balance;
//             IF ("Current Source A/C Bal." - Payments."Total Net Amount") < 0 THEN BEGIN
//                 ERROR('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2', BankAcc."No.",
//                 BankAcc.Name);
//             END;
//         END;
//     end;

//     [Scope('OnPrem')]
//     procedure UpdateAnalysisView()
//     var
//         UpdateAnalysisView: Codeunit "410";
//         BudgetaryControl: Record "Budgetary Control Setup";
//         AnalysisView: Record "363";
//     begin
//         //Update Budget Lines
//         IF BudgetaryControl.GET THEN BEGIN
//             IF BudgetaryControl."Analysis View Code" <> '' THEN BEGIN
//                 AnalysisView.RESET;
//                 AnalysisView.SETRANGE(AnalysisView.Code, BudgetaryControl."Analysis View Code");
//                 IF AnalysisView.FIND('-') THEN
//                     UpdateAnalysisView.UpdateAnalysisView_Budget(AnalysisView);
//             END;
//         END;
//     end;

//     [Scope('OnPrem')]
//     procedure UpdateDim(DimCode: Code[20]; DimValueCode: Code[20])
//     var
//         GLBudgetDim: Integer;
//     begin
//         //In 2013 this is not applicable table 361 not supported
//         /*IF DimCode = '' THEN
//           EXIT;
//         WITH GLBudgetDim DO BEGIN
//           IF GET(Rec."Entry No.",DimCode) THEN
//             DELETE;
//           IF DimValueCode <> '' THEN BEGIN
//             INIT;
//             "Entry No." := Rec."Entry No.";
//             "Dimension Code" := DimCode;
//             "Dimension Value Code" := DimValueCode;
//             INSERT;
//           END;
//         END; */

//     end;

//     [Scope('OnPrem')]
//     procedure CheckIfBlocked(BudgetName: Code[20])
//     var
//         GLBudgetName: Record "95";
//     begin
//         GLBudgetName.GET(BudgetName);
//         GLBudgetName.TESTFIELD(Blocked, FALSE);
//     end;

//     [Scope('OnPrem')]
//     procedure CheckStaffClaim(var ImprestHeader: Record "51534709")
//     var
//         PayLine: Record "39005937";
//         Commitments: Record Committment;
//         Amount: Decimal;
//         GLAcc: Record "G/L Account";
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record "Analysis View Budget Entry";
//         BudgetAmount: Decimal;
//         Actuals: Record "Analysis View Entry";
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record "5600";
//         FAPostingGRP: Record "5606";
//         EntryNo: Integer;
//     begin
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (ImprestHeader.Date < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (ImprestHeader.Date > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");

//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PayLine.RESET;
//             PayLine.SETRANGE(PayLine."No.", ImprestHeader."No.");
//             PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
//             IF PayLine.FINDFIRST THEN BEGIN
//                 REPEAT
//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(ImprestHeader.Date, 2), DATE2DMY(ImprestHeader.Date, 3));
//                     CurrMonth := DATE2DMY(ImprestHeader.Date, 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(ImprestHeader.Date, 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(ImprestHeader.Date, 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;

//                     //The GL Account
//                     BudgetGL := PayLine."Account No.";

//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Budget.SETRANGE(Budget."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Budget.SETRANGE(Budget."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     CommitmentAmount := 0;
//                     Commitments.RESET;
//                     Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code", PayLine."Shortcut Dimension 3 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code", PayLine."Shortcut Dimension 4 Code");
//                     Commitments.CALCSUMS(Commitments.Amount);
//                     CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
//                         PayLine."No.", 'Staff Imprest', PayLine."No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;

//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := ImprestHeader.Date;
//                         Commitments."Document Type" := Commitments."Document Type"::StaffClaim;
//                         Commitments."Document No." := ImprestHeader."No.";
//                         Commitments.Amount := PayLine."Amount LCY";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := ImprestHeader.Date;
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
//                         Commitments."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.Type := ImprestHeader."Account Type";
//                         Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
//                         Commitments.INSERT;
//                         //Tag the Imprest Line as Committed
//                         PayLine.Committed := TRUE;
//                         PayLine.MODIFY;
//                         //End Tagging Imprest Lines as Committed
//                     END;

//                 UNTIL PayLine.NEXT = 0;
//             END;
//         END
//         ELSE//budget control not mandatory
//           BEGIN

//         END;
//         MESSAGE('Budgetary Checking Completed Successfully');
//     end;

//     [Scope('OnPrem')]
//     procedure CheckStaffAdvance(var ImprestHeader: Record "51534711")
//     var
//         PayLine: Record "Staff Advance Lines";
//         Commitments: Record Committment;
//         Amount: Decimal;
//         GLAcc: Record "G/L Account";
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record "Analysis View Budget Entry";
//         BudgetAmount: Decimal;
//         Actuals: Record "Analysis View Entry";
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record "5600";
//         FAPostingGRP: Record "5606";
//         EntryNo: Integer;
//     begin
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (ImprestHeader.Date < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (ImprestHeader.Date > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader.Date,
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");

//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PayLine.RESET;
//             PayLine.SETRANGE(PayLine."No.", ImprestHeader."No.");
//             PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
//             IF PayLine.FINDFIRST THEN BEGIN
//                 REPEAT
//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(ImprestHeader.Date, 2), DATE2DMY(ImprestHeader.Date, 3));
//                     CurrMonth := DATE2DMY(ImprestHeader.Date, 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(ImprestHeader.Date, 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(ImprestHeader.Date, 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;

//                     //The GL Account
//                     BudgetGL := PayLine."Account No.";

//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Budget.SETRANGE(Budget."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Budget.SETRANGE(Budget."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PayLine."Global Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     CommitmentAmount := 0;
//                     Commitments.RESET;
//                     Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PayLine."Global Dimension 1 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code", PayLine."Shortcut Dimension 3 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code", PayLine."Shortcut Dimension 4 Code");
//                     Commitments.CALCSUMS(Commitments.Amount);
//                     CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
//                         PayLine."No.", 'Staff Imprest', PayLine."No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;

//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := ImprestHeader.Date;
//                         Commitments."Document Type" := Commitments."Document Type"::StaffAdvance;
//                         Commitments."Document No." := ImprestHeader."No.";
//                         Commitments.Amount := PayLine."Amount LCY";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := ImprestHeader.Date;
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                       // Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
//                         Commitments."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.Type := ImprestHeader."Account Type";
//                         Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
//                         Commitments.INSERT;
//                         //Tag the Imprest Line as Committed
//                         PayLine.Committed := TRUE;
//                         PayLine.MODIFY;
//                         //End Tagging Imprest Lines as Committed
//                     END;

//                 UNTIL PayLine.NEXT = 0;
//             END;
//         END
//         ELSE//budget control not mandatory
//           BEGIN

//         END;
//         MESSAGE('Budgetary Checking Completed Successfully');
//     end;

//     [Scope('OnPrem')]
//     procedure CheckStaffAdvSurr(var ImprestHeader: Record "51534713")
//     var
//         PayLine: Record "Voucher Line";
//         //Commitments: Record Committment;
//         Amount: Decimal;
//         GLAcc: Record "G/L Account";
//         Item: Record Item;
//         FirstDay: Date;
//         LastDay: Date;
//         CurrMonth: Integer;
//         Budget: Record "Analysis View Budget Entry";
//         BudgetAmount: Decimal;
//         Actuals: Record "Analysis View Entry";
//         ActualsAmount: Decimal;
//         CommitmentAmount: Decimal;
//         FixedAssetsDet: Record "Fixed Asset";
//         FAPostingGRP: Record "FA Posting Group";
//         EntryNo: Integer;
//     begin
//         //First Update Analysis View
//         UpdateAnalysisView();

//         //get the budget control setup first to determine if it mandatory or not
//         BCSetup.RESET;
//         BCSetup.GET();
//         IF BCSetup.Mandatory THEN//budgetary control is mandatory
//           BEGIN
//             //check if the dates are within the specified range in relation to the payment header table
//             IF (ImprestHeader."Surrender Date" < BCSetup."Current Budget Start Date") THEN BEGIN
//                 ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader."Surrender Date",
//                 BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");
//             END
//             ELSE
//                 IF (ImprestHeader."Surrender Date" > BCSetup."Current Budget End Date") THEN BEGIN
//                     ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3', ImprestHeader."Surrender Date",
//                     BCSetup."Current Budget Start Date", BCSetup."Current Budget End Date");

//                 END;
//             //Is budget Available
//             CheckIfBlocked(BCSetup."Current Budget Code");

//             //Get Commitment Lines
//             IF Commitments.FIND('+') THEN
//                 EntryNo := Commitments."Line No.";

//             //get the lines related to the payment header
//             PayLine.RESET;
//             PayLine.SETRANGE(PayLine."Surrender Doc No.", ImprestHeader."No.");
//             PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
//             IF PayLine.FINDFIRST THEN BEGIN
//                 REPEAT
//                     //check the votebook now
//                     FirstDay := DMY2DATE(1, DATE2DMY(ImprestHeader."Surrender Date", 2), DATE2DMY(ImprestHeader."Surrender Date", 3));
//                     CurrMonth := DATE2DMY(ImprestHeader."Surrender Date", 2);
//                     IF CurrMonth = 12 THEN BEGIN
//                         LastDay := DMY2DATE(1, 1, DATE2DMY(ImprestHeader."Surrender Date", 3) + 1);
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END
//                     ELSE BEGIN
//                         CurrMonth := CurrMonth + 1;
//                         LastDay := DMY2DATE(1, CurrMonth, DATE2DMY(ImprestHeader."Surrender Date", 3));
//                         LastDay := CALCDATE('-1D', LastDay);
//                     END;

//                     //The GL Account
//                     BudgetGL := PayLine."Account No.";

//                     //check the summation of the budget in the database
//                     BudgetAmount := 0;
//                     Budget.RESET;
//                     Budget.SETCURRENTKEY(Budget."Budget Name", Budget."Posting Date", Budget."G/L Account No.",
//                     Budget."Dimension 1 Value Code", Budget."Dimension 2 Value Code", Budget."Dimension 3 Value Code",
//                     Budget."Dimension 4 Value Code");
//                     Budget.SETRANGE(Budget."Budget Name", BCSetup."Current Budget Code");
//                     Budget.SETRANGE(Budget."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Budget.SETRANGE(Budget."G/L Account No.", BudgetGL);
//                     Budget.SETRANGE(Budget."Dimension 1 Value Code", PayLine."Shortcut Dimension 1 Code");
//                     Budget.SETRANGE(Budget."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Budget.SETRANGE(Budget."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Budget.SETRANGE(Budget."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Budget.CALCSUMS(Budget.Amount);
//                     BudgetAmount := Budget.Amount;

//                     //get the summation on the actuals
//                     ActualsAmount := 0;
//                     Actuals.RESET;
//                     Actuals.SETCURRENTKEY(Actuals."Analysis View Code", Actuals."Dimension 1 Value Code",
//                     Actuals."Dimension 2 Value Code", Actuals."Dimension 3 Value Code", Actuals."Dimension 4 Value Code",
//                     Actuals."Posting Date", Actuals."Account No.");
//                     Actuals.SETRANGE(Actuals."Analysis View Code", BCSetup."Analysis View Code");
//                     Actuals.SETRANGE(Actuals."Dimension 1 Value Code", PayLine."Shortcut Dimension 1 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 2 Value Code", PayLine."Shortcut Dimension 2 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 3 Value Code", PayLine."Shortcut Dimension 3 Code");
//                     Actuals.SETRANGE(Actuals."Dimension 4 Value Code", PayLine."Shortcut Dimension 4 Code");
//                     Actuals.SETRANGE(Actuals."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Actuals.SETRANGE(Actuals."Account No.", BudgetGL);
//                     Actuals.CALCSUMS(Actuals.Amount);
//                     ActualsAmount := Actuals.Amount;

//                     //get the committments
//                     CommitmentAmount := 0;
//                     Commitments.RESET;
//                     Commitments.SETCURRENTKEY(Commitments.Budget, Commitments."G/L Account No.",
//                     Commitments."Posting Date", Commitments."Shortcut Dimension 1 Code", Commitments."Shortcut Dimension 2 Code",
//                     Commitments."Shortcut Dimension 3 Code", Commitments."Shortcut Dimension 4 Code");
//                     Commitments.SETRANGE(Commitments.Budget, BCSetup."Current Budget Code");
//                     Commitments.SETRANGE(Commitments."G/L Account No.", BudgetGL);
//                     Commitments.SETRANGE(Commitments."Posting Date", BCSetup."Current Budget Start Date", LastDay);
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code", PayLine."Shortcut Dimension 1 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code", PayLine."Shortcut Dimension 2 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code", PayLine."Shortcut Dimension 3 Code");
//                     Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code", PayLine."Shortcut Dimension 4 Code");
//                     Commitments.CALCSUMS(Commitments.Amount);
//                     CommitmentAmount := Commitments.Amount;

//                     //check if there is any budget
//                     IF (BudgetAmount <= 0) AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('No Budget To Check Against');
//                     END ELSE BEGIN
//                         IF (BudgetAmount <= 0) THEN BEGIN
//                             IF NOT CONFIRM(Text0003, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;
//                     END;

//                     //check if the actuals plus the amount is greater then the budget amount
//                     IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount)
//                     AND NOT (BCSetup."Allow OverExpenditure") THEN BEGIN
//                         ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
//                         PayLine."Surrender Doc No.", 'Staff Imprest', PayLine."Surrender Doc No.",
//                           FORMAT(ABS(BudgetAmount - (CommitmentAmount + PayLine."Amount LCY"))));
//                     END ELSE BEGIN
//                         //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
//                         IF ((CommitmentAmount + PayLine."Amount LCY" + ActualsAmount) > BudgetAmount) THEN BEGIN
//                             IF NOT CONFIRM(Text0001 +
//                             FORMAT(ABS(BudgetAmount - (CommitmentAmount + ActualsAmount + PayLine."Amount LCY")))
//                             + Text0002, TRUE) THEN BEGIN
//                                 ERROR('Budgetary Checking Process Aborted');
//                             END;
//                         END;

//                         Commitments.RESET;
//                         Commitments.INIT;
//                         EntryNo += 1;
//                         Commitments."Line No." := EntryNo;
//                         Commitments.Date := TODAY;
//                         Commitments."Posting Date" := ImprestHeader."Surrender Date";
//                         Commitments."Document Type" := Commitments."Document Type"::StaffSurrender;
//                         Commitments."Document No." := ImprestHeader."No.";
//                         Commitments.Amount := PayLine."Amount LCY";
//                         Commitments."Month Budget" := BudgetAmount;
//                         Commitments."Month Actual" := ActualsAmount;
//                         Commitments.Committed := TRUE;
//                         Commitments."Committed By" := USERID;
//                         Commitments."Committed Date" := ImprestHeader."Surrender Date";
//                         Commitments."G/L Account No." := BudgetGL;
//                         Commitments."Committed Time" := TIME;
//                         //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
//                         Commitments."Shortcut Dimension 1 Code" := PayLine."Shortcut Dimension 1 Code";
//                         Commitments."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
//                         Commitments."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
//                         Commitments."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
//                         Commitments.Budget := BCSetup."Current Budget Code";
//                         Commitments.Type := ImprestHeader."Account Type";
//                         Commitments."Vendor/Cust No." := ImprestHeader."Account No.";
//                         Commitments.INSERT;
//                         //Tag the Imprest Line as Committed
//                         PayLine.Committed := TRUE;
//                         PayLine.MODIFY;
//                         //End Tagging Imprest Lines as Committed
//                     END;

//                 UNTIL PayLine.NEXT = 0;
//             END;
//         END
//         ELSE//budget control not mandatory
//           BEGIN

//         END;
//         MESSAGE('Budgetary Checking Completed Successfully');
//     end;
// }

