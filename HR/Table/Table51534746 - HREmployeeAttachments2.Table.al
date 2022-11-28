table 51534746 "HR Employee Attachments2"
{

    fields
    {
        field(1; "Employee No"; Code[50])
        {
            NotBlank = true;
        }
        field(2; "Document Description"; Text[200])
        {
            NotBlank = true;
        }
        field(3; "Document Link"; Text[250])
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
        field(9; "Application No"; Code[20])
        {
            Editable = false;
        }
        field(10; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(11; "Document Type"; Option)
        {
            OptionMembers = Employee,"Exit",Leave,Job,Training,"Staff Activity",Finance,Evaluation,HMO;
        }
        field(12; ObjectStoreId; Text[250])
        {
        }
        field(13; DocId; Text[250])
        {
        }
        field(15; DocVersionId; Text[250])
        {
        }
        field(39004253; "Interaction Template Code"; Code[20])
        {
        }
        field(39004254; "Folder Type"; Option)
        {
            OptionCaption = ' ,HR,Finance,Others';
            OptionMembers = " ",HR,Finance,Others;
        }
        field(39004255; ObjectStore; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Document Type", "Application No", "Attachment No.", "Folder Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DocLink: Record "HR Employee Attachments";
        DocNo: Code[30];

    [Scope('OnPrem')]
    procedure PlaceFilter(prompt: Boolean; EmployeeNo: Code[20]): Boolean
    begin
        if prompt then begin
            SetFilter("Employee No", EmployeeNo);
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
            DocNo := "Employee No" + Format("Attachment No.");
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
            DocNo := "Employee No" + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.OpenAttachment;
        end;

        [Scope('OnPrem')]
        procedure ImportAttachment()
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Employee No" + Format("Attachment No.");
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
            DocNo := "Employee No" + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.ExportAttachment;
        end;

        [Scope('OnPrem')]
        procedure RemoveAttachment(Prompt: Boolean)
        var
            SegInteractLanguage: Record "Segment Interaction Language";
        begin
            DocNo := "Employee No" + Format("Attachment No.");
            if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
                if SegInteractLanguage."Attachment No." <> 0 then
                    SegInteractLanguage.RemoveAttachment(Prompt);
            Attachment := false;
            Modify;
        end;
        */
}

