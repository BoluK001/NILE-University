table 51534616 "HR Journal Line"
{
    Caption = 'HR Journal Line';

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "HR Leave Journal Template";
        }
        field(2; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "HR Leave Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; "Leave Period"; Code[20])
        {
            Caption = 'Leave Period';

            trigger OnValidate()
            begin
                /*IF "Leave Application No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                Insurance.GET("Leave Application No.");
                //Insurance.TESTFIELD(Blocked,FALSE);
                Description := Insurance.Description;
                "Leave Approval Date":=Insurance."HOD Start Date";
                "No. of Days":=Insurance."HOD Approved Days";
                "Leave Type Code":=Insurance."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                  */

            end;
        }
        field(6; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if "Staff No." = '' then begin
                    "Staff Name" := '';
                    exit;
                end;
                FA.Get("Staff No.");
                "Staff Name" := FA."First Name" + ' ' + FA."Middle Name" + ' ' + FA."Last Name";
            end;
        }
        field(7; "Staff Name"; Text[50])
        {
            Caption = 'Staff Name';
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "Leave Entry Type"; Option)
        {
            Caption = 'Leave Entry Type';
            Editable = true;
            OptionCaption = 'Positive,Negative';
            OptionMembers = Positive,Negative;
        }
        field(10; "Leave Approval Date"; Date)
        {
            Caption = 'Leave Approval Date';
            Editable = false;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(12; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(13; "No. of Days"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'No. of Days';
            Editable = true;

            trigger OnValidate()
            begin
                if LeaveType.Get("Leave Type") then begin
                    if (LeaveType."Fixed Days" = true) then begin
                        if "No. of Days" > LeaveType.Days then
                            Error(Text001, "Leave Type");

                    end;
                end;
            end;
        }
        field(14; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
                MODIFY;
                */

            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
                MODIFY;*/

            end;
        }
        field(17; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(18; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(20; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(21; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(22; "Leave Type"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Leave Types".Code;

            trigger OnValidate()
            begin
                if HRLeaveTypes.Get("Leave Type") then
                    "No. of Days" := HRLeaveTypes.Days;
            end;
        }
        field(23; "Leave Recalled No."; Code[20])
        {
            Caption = 'Leave Application No.';

            trigger OnValidate()
            begin
                /*IF "Document No." = '' THEN BEGIN
                  CreateDim(DATABASE::Table5628,"Leave Application No.");
                  EXIT;
                END;
                
                Insurance.GET("Leave Application No.");
                //Insurance.TESTFIELD(Blocked,FALSE);
                Description := Insurance.Description;
                "Leave Approval Date":=Insurance."HOD Start Date";
                "No. of Days":=Insurance."HOD Approved Days";
                "Leave Type Code":=Insurance."Leave Code";
                CreateDim(DATABASE::Table5628,"Leave Application No.");
                */

            end;
        }
        field(26; "Leave Period Start Date"; Date)
        {

            trigger OnValidate()
            begin


                //"Leave Period End Date":=CALCDATE('-1D',CALCDATE('12M',"Leave Period Start Date"));
            end;
        }
        field(27; "Leave Period End Date"; Date)
        {
        }
        field(28; "Positive Transaction Type"; Option)
        {
            OptionCaption = ' ,Leave Allocation,Leave Recall,OverTime';
            OptionMembers = " ","Leave Allocation","Leave Recall",OverTime;
        }
        field(29; "Negative Transaction Type"; Option)
        {
            OptionCaption = ' ,Leave Taken,Leave Forfeited ';
            OptionMembers = " ","Leave Taken","Leave Forfeited ";
        }
        field(30; "Leave Application No."; Code[20])
        {
            Caption = 'Leave Application No.';
            TableRelation = "HR Leave Application"."Application Code";

            trigger OnValidate()
            begin
                if "Leave Application No." = '' then begin
                    CreateDim(DATABASE::Insurance, "Leave Application No.");
                    exit;
                end;
                Insurance.Reset;
                Insurance.SetRange(Insurance."Application Code", "Leave Application No.");
                if Insurance.Find('-') then begin
                    //Insurance.GET("Leave Application No.");
                    //Insurance.TESTFIELD(Blocked,FALSE);
                    Description := Insurance."Applicant Comments";
                    "Leave Approval Date" := Insurance."Start Date";
                    "No. of Days" := Insurance."Approved days";
                    "Leave Type" := Insurance."Leave Type";
                end;
                CreateDim(DATABASE::Insurance, "Leave Application No.");
            end;
        }
        field(31; "Maximum Leave Days"; Decimal)
        {
        }
        field(32; "No. of days (Allw)"; Decimal)
        {
        }
        field(33; "Leave Period Closed"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*DimMgt.DeleteJnlLineDim(
          DATABASE::"HR Journal Line",
          "Journal Template Name","Journal Batch Name","Line No.",0);
            */

    end;

    trigger OnInsert()
    begin
        //JnlLineDim.LOCKTABLE;
        //LOCKTABLE;
        /*InsuranceJnlTempl.GET("Journal Template Name");
        "Source Code" := InsuranceJnlTempl."Source Code";
        InsuranceJnlBatch.GET("Journal Template Name","Journal Batch Name");
        "Reason Code" := InsuranceJnlBatch."Reason Code";
        
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        DimMgt.InsertJnlLineDim(
          DATABASE::"HR Journal Line",
          "Journal Template Name","Journal Batch Name","Line No.",0,
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */

        HR.Reset;
        if HR.Find('-') then begin
            "Leave Period Start Date" := HR."Leave Posting Period[FROM]";
            "Leave Period End Date" := HR."Leave Posting Period[TO]";
        end;
        Validate("Leave Period Start Date");
        Validate("Leave Period End Date");

    end;

    var
        Insurance: Record "HR Leave Application";
        FA: Record "HR Employees";
        InsuranceJnlTempl: Record "HR Leave Journal Template";
        InsuranceJnlBatch: Record "HR Leave Journal Batch";
        InsuranceJnlLine: Record "HR Journal Line";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit 408;
        LeaveType: Record "HR Leave Types";
        Text001: Label 'You can not post more than maximum days allowed for this leave type %1';
        LeavePeriod: Record "Leave Group";
        HRLeaveTypes: Record "HR Leave Types";
        HR: Record "HR Setup";

    [Scope('OnPrem')]
    procedure SetUpNewLine(LastInsuranceJnlLine: Record "HR Journal Line")
    begin
        /*InsuranceJnlTempl.GET("Journal Template Name");
        InsuranceJnlBatch.GET("Journal Template Name","Journal Batch Name");
        InsuranceJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        InsuranceJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        IF InsuranceJnlLine.FIND('-') THEN BEGIN
          "Posting Date" := LastInsuranceJnlLine."Posting Date";
          "Document No." := LastInsuranceJnlLine."Document No.";
        END ELSE BEGIN
          "Posting Date" := WORKDATE;
          IF InsuranceJnlBatch."No. Series" <> '' THEN BEGIN
            CLEAR(NoSeriesMgt);
            "Document No." := NoSeriesMgt.TryGetNextNo(InsuranceJnlBatch."No. Series","Posting Date");
          END;
        END;
        "Source Code" := InsuranceJnlTempl."Source Code";
        "Reason Code" := InsuranceJnlBatch."Reason Code";
        "Posting No. Series" := InsuranceJnlBatch."Posting No. Series";
        */

    end;

    [Scope('OnPrem')]
    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        /*TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        DimMgt.GetDefaultDim(
          TableID,No,"Source Code",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateJnlLineDefaultDim(
            DATABASE::Table5635,
            "Journal Template Name","Journal Batch Name","Line No.",0,
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
          */

    end;

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          IF MODIFY THEN;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
         */

    end;

    [Scope('OnPrem')]
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode);
          MODIFY;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */

    end;

    [Scope('OnPrem')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        /*IF "Line No." <> 0 THEN
          DimMgt.ShowJnlLineDim(
            DATABASE::Table5635,"Journal Template Name",
            "Journal Batch Name","Line No.",0,ShortcutDimCode)
        ELSE
          DimMgt.ShowTempDim(ShortcutDimCode);
        */

    end;

    [Scope('OnPrem')]
    procedure ValidateOpenPeriod(LeavePeriod: Record "HR Journal Line")
    var
        Rec1: Record "Leave Group";
    begin
        /*WITH LeavePeriod DO
        BEGIN
         Rec1.RESET;
        IF Rec1.FIND('-')THEN BEGIN
        "Leave Period Start Date":=Rec1."Starting Date";
        VALIDATE("Leave Period Start Date");    `
        END;
        END;*/

    end;
}

