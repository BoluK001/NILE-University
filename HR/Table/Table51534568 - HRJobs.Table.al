table 51534568 "HR Jobs"
{
    LookupPageId = "HR Jobs List";

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Job Title"; Text[250])
        {
            Editable = true;
        }
        field(3; "No of Posts"; Integer)
        {

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then
                    "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID" WHERE(Status = CONST(Approved));
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE("Job Title" = FIELD("Job ID"),
                                                      Status = CONST(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Positions"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Vacant Positions" := "No of Posts" - "Occupied Positions";
            end;
        }
        field(7; "Score code"; Code[20])
        {
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; "Total Score"; Decimal)
        {
            Editable = false;
        }
        field(19; "Main Objective"; Text[250])
        {
        }
        field(21; "Key Position"; Boolean)
        {
        }
        field(22; Category; Code[20])
        {
        }
        field(23; Grade; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = Count("HR Employee Requisitions" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(27; "Created By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(28; "Supervisor/Manager"; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                HREmp.Get("Supervisor/Manager");
                "Supervisor Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(29; "Supervisor Name"; Text[30])
        {
            Editable = false;
        }
        field(30; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(31; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(32; "Date Created"; Date)
        {
        }
        field(33; "Is Supervisor"; Boolean)
        {
        }
        field(34; "Job Level"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Job Level"));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            /* trigger OnLookup()
            begin
                ShowDocDim;
            end; */
        }
        field(60002; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(60003; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(60004; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(60005; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(60006; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(60007; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            //Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(60008; "Department Level 2"; Code[20])
        {
            TableRelation = Department.Code where("Dim. Code" = field("Global Dimension 2 Code"));
        }
        field(60009; Unit; Code[20])
        {
            TableRelation = "Sub. Department".Code where("Dept. Code" = field("Department Level 2"));
        }
    }

    keys
    {
        key(Key1; "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", "Job Title")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Created" := Today;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        NoOfPosts: Decimal;
        HREmp: Record "HR Employees";
        HRJobsEvLines: Record "HR Job Evaluation Areas";

    [Scope('OnPrem')]
    procedure CheckHRJobsLinesExist(): Boolean
    begin
        HRJobsEvLines.Reset;
        HRJobsEvLines.SetRange(Job, "Job ID");
        exit(HRJobsEvLines.FindFirst);
    end;

    //[Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "Job ID" <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN
            MODIFY;

    end;
}

