codeunit 51534353 "Import Excel to Requisition"
{

    trigger OnRun()

    begin

        ImportRequisitionExcel();

    end;



    procedure ImportRequisitionExcel()

    begin

        Rec_ExcelBuffer.DeleteAll();

        Rows := 0;

        Columns := 0;

        DialogCaption := 'Select File to upload';



        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);



        If Name <> '' then
            Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)

        else
            exit;

        Rec_ExcelBuffer.Reset();

        Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);

        Rec_ExcelBuffer.ReadSheet();

        Commit();

        //Message('sheet %1', Sheetname);



        //finding total number of Rows to Import

        Rec_ExcelBuffer.Reset();

        Rec_ExcelBuffer.SetRange("Column No.", 1);

        If Rec_ExcelBuffer.FindFirst() then
            repeat

                Rows := Rows + 1;

            until Rec_ExcelBuffer.Next() = 0;

        Message('No. of rows %1', Rows);



        //Finding total number of columns to import

        Rec_ExcelBuffer.Reset();

        Rec_ExcelBuffer.SetRange("Row No.", 1);

        if Rec_ExcelBuffer.FindFirst() then
            repeat

                Columns := Columns + 1;

            until Rec_ExcelBuffer.Next() = 0;




        //Function to Get the last line number in Job Journal

        LineNo := FindLineNo();

        for RowNo := 2 to Rows do begin
            PLineRec.Init();
            Evaluate(PLineRec."No.", GetValueAtIndex(RowNo, 1));
            Evaluate(PLineRec."Document Type", GetValueAtIndex(RowNo, 2));
            PLineRec."Line No." := LineNo;
            Evaluate(PLineRec.Description, GetValueAtIndex(RowNo, 3));
            Evaluate(PLineRec."Location Code", GetValueAtIndex(RowNo, 4));
            PLineRec.Validate(PLineRec."Location Code");
            Evaluate(PLineRec."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 5));
            PLineRec.Validate(PLineRec."Shortcut Dimension 1 Code");
            Evaluate(PLineRec."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 6));
            PLineRec.Validate(PLineRec."Shortcut Dimension 2 Code");
            Evaluate(PLineRec.Quantity, GetValueAtIndex(RowNo, 7));
            PLineRec.Validate(PLineRec.Quantity);
            Evaluate(PLineRec."Type", GetValueAtIndex(RowNo,7));
            PLineRec.Validate(PLineRec.Type);
            PLineRec.Insert();
            LineNo := LineNo + 10000;
        end;
        Message('Import Completed');

    end;

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
    var
        Rec_ExcelBuffer: Record "Excel Buffer";

    begin
        Rec_ExcelBuffer.Reset();
        If Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");
    end;

    local procedure FindLineNo(): Integer

    var
        PurchLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        PurchLine.Reset();
        PurchLine.SetCurrentKey("Line No.");
        If PurchLine.FindLast() then
            LineNo := PurchLine."Line No." + 10000
        else
            LineNo := 10000;
        Message('Line number %1', LineNo);
        exit(LineNo);
    end;

    var
        Rec_ExcelBuffer: Record "Excel Buffer";
        Rows: Integer;
        Columns: Integer;
        Fileuploaded: Boolean;
        UploadIntoStream: InStream;
        FileName: Text;
        Sheetname: Text;
        UploadResult: Boolean;
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        PLineRec: Record "Purchase Line";
        RowNo: Integer;
        TxtDate: Text;
        DocumentDate: Date;
        LineNo: Integer;
}
