table 51534599 "HR Employee Attachments"
{

    fields
    {
        field(1; "Employee No"; Code[20])
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
        field(9; "Application No"; Code[20])
        {
            Editable = false;
            TableRelation = "HR Job Applications"."Application No";
        }
        field(10; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(11; "Document Type"; Option)
        {
            OptionMembers = Employee,"Exit",Leave,Job,Training,"Staff Activity";
        }
        field(39004253; "Interaction Template Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Document Type", "Attachment No.")
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
        //SegInteractLanguage.CreateAttachment;RBS
        Rec.Attachment := true;
        Rec.Modify;
    end;

    [Scope('OnPrem')]
    procedure OpenAttachment()
    var
        SegInteractLanguage: Record "Segment Interaction Language";
    begin
        /* DocNo := "Employee No" + Format("Attachment No.");
         if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
             if SegInteractLanguage."Attachment No." <> 0 then
                 SegInteractLanguage.OpenAttachment;
                 */
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
        //SegInteractLanguage.ImportAttachment; RBS
        Attachment := true;
        Modify;
    end;

    [Scope('OnPrem')]
    procedure ExportAttachment()
    var
        SegInteractLanguage: Record "Segment Interaction Language";
    begin
        /* DocNo := "Employee No" + Format("Attachment No.");
         if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
             if SegInteractLanguage."Attachment No." <> 0 then
                 SegInteractLanguage.ExportAttachment;
                 */
    end;

    [Scope('OnPrem')]
    procedure RemoveAttachment(Prompt: Boolean)
    var
        SegInteractLanguage: Record "Segment Interaction Language";
    begin
        /*
        DocNo := "Employee No" + Format("Attachment No.");
        if SegInteractLanguage.Get(DocNo, 0, "Language Code (Default)") then
            if SegInteractLanguage."Attachment No." <> 0 then
                SegInteractLanguage.RemoveAttachment(Prompt);
        Attachment := false;
        Modify;
        */
    end;

}

