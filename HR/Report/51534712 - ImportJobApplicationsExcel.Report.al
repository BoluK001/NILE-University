report 51534712 "Import Job Applications-Excel"
{
    // Ayuba's Research
    //   # Report to Simulate Excel Import

    ProcessingOnly = true;

    dataset
    {
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
                    field(ImportOption; ImportOption)
                    {
                        Caption = 'Option';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            /*
            if CloseAction = ACTION::OK then begin
                ServerFileName := FileMgt.UploadFile(Text006, ExcelExtensionTok);
                if ServerFileName = '' then
                    exit(false);

                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                if SheetName = '' then
                    exit(false);
            end;
            */
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        X: Integer;
    begin
        if ImportOption = ImportOption::"Replace entries" then
            ExcelImport.DeleteAll;

        ExcelBuf.LockTable;
        //ExcelBuf.OpenBook(ServerFileName, SheetName); RBS
        ExcelBuf.ReadSheet;
        GetLastRowandColumn;

        for X := 2 to TotalRows do
            InsertData(X);

        ExcelBuf.DeleteAll;

        Message('Import Completed.');
    end;

    var
        ImportOption: Option "Add entries","Replace entries";
        Text005: Label 'Imported from Excel ';
        ServerFileName: Text;
        SheetName: Text[250];
        FileMgt: Codeunit "File Management";
        Text006: Label 'Import Excel File';
        ExcelExtensionTok: Label '.xlsx', Locked = true;
        ExcelBuf: Record "Excel Buffer";
        Text010: Label 'Add entries,Replace entries';
        Window: Dialog;
        Text001: Label 'Do you want to create %1 %2.';
        Text003: Label 'Are you sure you want to %1 for %2 %3.';
        TotalColumns: Integer;
        TotalRows: Integer;
        ExcelImport: Record "HR Job Applications";

    [Scope('OnPrem')]
    procedure GetLastRowandColumn()
    begin
        ExcelBuf.SetRange("Row No.", 1);
        TotalColumns := ExcelBuf.Count;

        ExcelBuf.Reset;
        if ExcelBuf.FindLast then
            TotalRows := ExcelBuf."Row No.";
    end;

    [Scope('OnPrem')]
    procedure InsertData(RowNo: Integer)
    var
        ItemNo: Code[20];
        RecItem: Record Item;
        LMonth: Integer;
    begin
        ExcelImport.Init;
        Evaluate(ExcelImport."Application No", GetValueAtCell(RowNo, 1));
        Evaluate(ExcelImport."First Name", GetValueAtCell(RowNo, 2));
        Evaluate(ExcelImport."Middle Name", GetValueAtCell(RowNo, 3));
        Evaluate(ExcelImport."Last Name", GetValueAtCell(RowNo, 4));
        Evaluate(ExcelImport.Gender, GetValueAtCell(RowNo, 5));
        Evaluate(ExcelImport."Date Of Birth", GetValueAtCell(RowNo, 6));
        Evaluate(ExcelImport.Age, GetValueAtCell(RowNo, 7));
        Evaluate(ExcelImport."Applicant Type", GetValueAtCell(RowNo, 8));
        Evaluate(ExcelImport."Date Applied", GetValueAtCell(RowNo, 9));
        Evaluate(ExcelImport."Job Applied For", GetValueAtCell(RowNo, 10));
        Evaluate(ExcelImport."Marital Status", GetValueAtCell(RowNo, 11));
        Evaluate(ExcelImport."Ethnic Origin", GetValueAtCell(RowNo, 12));
        Evaluate(ExcelImport."Home Phone Number", GetValueAtCell(RowNo, 13));
        Evaluate(ExcelImport."Country Code", GetValueAtCell(RowNo, 14));
        Evaluate(ExcelImport."First Language (R/W/S)", GetValueAtCell(RowNo, 15));
        Evaluate(ExcelImport.Citizenship, GetValueAtCell(RowNo, 16));
        Evaluate(ExcelImport."Employee Requisition No", GetValueAtCell(RowNo, 17));
        Evaluate(ExcelImport."Current Job Role", GetValueAtCell(RowNo, 18));
        Evaluate(ExcelImport."Current Employer", GetValueAtCell(RowNo, 19));
        Evaluate(ExcelImport."Current Gross Salary (P/A)", GetValueAtCell(RowNo, 20));
        Evaluate(ExcelImport."E-Mail", GetValueAtCell(RowNo, 21));
        Evaluate(ExcelImport."Residential Address", GetValueAtCell(RowNo, 22));
        Evaluate(ExcelImport."Residential Address2", GetValueAtCell(RowNo, 23));
        Evaluate(ExcelImport."Residential Address3", GetValueAtCell(RowNo, 24));
        ExcelImport.Insert(true);
    end;

    [Scope('OnPrem')]
    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        ExcelBuf1: Record "Excel Buffer";
    begin
        ExcelBuf1.Get(RowNo, ColNo);
        exit(ExcelBuf1."Cell Value as Text");
    end;
}

