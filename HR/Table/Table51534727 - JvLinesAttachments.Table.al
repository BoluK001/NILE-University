table 51534727 "Jv Lines Attachments"
{
    DataCaptionFields = "Customer Name";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[200])
        {
        }
        field(6; "Attachment No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7; "Language Code (Default)"; Code[20])
        {
            TableRelation = Language;
        }
        field(8; Attachment; Boolean)
        {
            Editable = false;
        }
        field(25; "Schedule Location"; Text[70])
        {
            Caption = 'Schedule Location';
        }
        field(39004253; "Interaction Template Code"; Code[20])
        {
        }
        field(39004255; Attached; Boolean)
        {
        }
        field(39004256; "Hard Copy"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Hard Copy" = true then begin
                    TestField("Soft Copy", false);
                    TestField("Scanned Copy", false);
                end;
            end;
        }
        field(39004257; "Soft Copy"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Soft Copy" = true then begin
                    TestField("Hard Copy", false);
                    TestField("Scanned Copy", false);
                end;
            end;
        }
        field(39004258; "Scanned Copy"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Scanned Copy" = true then begin
                    TestField("Soft Copy", false);
                    TestField("Hard Copy", false);
                end;
            end;
        }
        field(39004259; "Contribution Start Date"; Text[30])
        {
            Editable = true;
        }
        field(39004260; "Contribution End Date"; Text[30])
        {
        }
        field(39004262; Comment; Text[30])
        {
        }
        field(39004263; "Date Received"; Date)
        {
            Caption = 'Schedule Received Date';
        }
        field(39004266; "No. of Employees"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(39004267; "Entry No."; Integer)
        {
            AutoIncrement = false;
        }
        field(39004268; "Customer No."; Code[20])
        {
            Editable = false;
        }
        field(39004269; "Customer Name"; Text[100])
        {
            Editable = false;
        }
        field(39004270; "Schedule Remark"; Text[150])
        {
            Caption = 'Other Contribution Period';
        }
        field(39004271; ContriDate; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                "Contribution Start Date" := CopyStr(Format(ContriDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(ContriDate, 3));
            end;
        }
        field(39004272; ContriEndDate; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                "Contribution End Date" := CopyStr(Format(ContriEndDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(ContriEndDate, 3));
            end;
        }
        field(39004273; "CRU Comment"; Text[250])
        {
        }
        field(39004275; DocId; Text[200])
        {
        }
        field(39004277; DocVersionId; Text[250])
        {
        }
        field(39004278; ObjectStoreId; Text[250])
        {
        }
        field(39004279; ObjectStore; Text[250])
        {
        }
        field(39004280; "Folder Type"; Option)
        {
            OptionCaption = ' ,HR,Finance,Others,FA';
            OptionMembers = " ",HR,Finance,Others,FA;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Attachment No.", "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Folder Type" := "Folder Type"::FA;
    end;

    var
        DocLink: Record "HR Employee Attachments";
        DocNo: Code[30];

    [Scope('OnPrem')]
    procedure PlaceFilter(prompt: Boolean; EmployeeNo: Code[20]): Boolean
    begin
        if prompt then begin
            SetFilter("Document No.", EmployeeNo);
        end;
    end;

    [Scope('OnPrem')]
    procedure MaintainAttachment()
    begin
        /*
        IF "Interaction Template Code" = '' THEN
          EXIT;
        
        IF "Attachment No." <> 0 THEN
          OpenAttachment
        ELSE BEGIN
          CreateAttachment;
          CALCFIELDS("Attachment No.");
        END;
        */

    end;
    /*
        [Scope('OnPrem')]
        procedure CreateAttachment()
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Document No." + Format("Attachment No.");
            if not SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then begin
                SegInteractLanguage.Init;
                SegInteractLanguage."Segment No." := DocNo;
                SegInteractLanguage."Segment Line No." := 0;
                SegInteractLanguage."Language Code" := "Language Code (Default)";
                SegInteractLanguage.Description := Format("Interaction Template Code") + ' ' + Format("Language Code (Default)");
                SegInteractLanguage.Subject := "Document Description";
            end;
            SegInteractLanguage.CreateAttachment;
            Rec.Attachment := true;
            Rec.Modify;
        end;

        [Scope('OnPrem')]
        procedure OpenAttachment()
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Document No." + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.OpenAttachment;
        end;

        [Scope('OnPrem')]
        procedure ImportAttachment()
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Document No." + Format("Attachment No.");
            if not SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then begin
                SegInteractLanguage.Init;
                SegInteractLanguage."Segment No." := DocNo;
                SegInteractLanguage."Segment Line No." := 0;
                SegInteractLanguage."Language Code" := "Language Code (Default)";
                SegInteractLanguage.Description :=
                  Format("Interaction Template Code") + ' ' + Format("Language Code (Default)");
                SegInteractLanguage.Insert(true);
            end;
            SegInteractLanguage.ImportAttachment;
            Attachment := true;
            Modify;
        end;

        [Scope('OnPrem')]
        procedure ExportAttachment()
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Document No." + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.ExportAttachment;
        end;

        [Scope('OnPrem')]
        procedure RemoveAttachment(Prompt: Boolean)
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Document No." + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.RemoveAttachment(Prompt);
            Attachment := false;
            Modify;
        end;
        */
}

