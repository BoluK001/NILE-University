table 51534620 "HR Jobs1"
{

    fields
    {
        field(1; "Job ID"; Code[30])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF "Job ID" <> xRec."Job ID" THEN BEGIN
                  HRSetup.GET;
                  NoSeriesMgt.TestManual(HRSetup."Company Jobs");
                  "No. series" := '';
                END;
                   */

            end;
        }
        field(2; "Job Description"; Text[250])
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
            TableRelation = "HR Jobs1"."Job ID";
        }
        field(5; "Occupied Positions"; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE("Job Title" = FIELD("Job ID")));
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
            FieldClass = Normal;
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
        }
        field(24; "Employee Requisitions"; Integer)
        {
            CalcFormula = Count("HR Employee Requisitions" WHERE("Job ID" = FIELD("Job ID")));
            FieldClass = FlowField;
        }
        field(27; UserID; Code[50])
        {
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
        field(30; "No. series"; Code[20])
        {
        }
        field(40; "Responsibility Center"; Code[20])
        {
            TableRelation = "HR Entitlement Lines";
        }
        field(41; Requestor; Code[50])
        {
            Editable = false;
        }
        field(42; "Entry Date"; Date)
        {

            trigger OnValidate()
            begin
                /*IF (Rec."Entry Date" - TODAY) < 0 THEN
                 MESSAGE('Days in the past are not allowed');
                   */

            end;
        }
        field(43; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved';
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(44; "Is Supervisor"; Boolean)
        {
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
    }

    trigger OnDelete()
    begin
        if Status <> Status::New then
            Error(mcontent + ' ' + "Job ID" + ' ' + mcontent2);


        /*IF Jobs.FIND('-') THEN
          ERROR(
            Text000,
            Jobs.TABLECAPTION,Jobs."Job ID");
           */

    end;

    trigger OnInsert()
    begin
        /*            UserID:=UserID;

//GENERATE DOCUMENT NUMBER
IF "Job ID" = '' THEN BEGIN
HRSetup.GET;
HRSetup.TESTFIELD(HRSetup."Company Jobs");
//NoSeriesMgt.InitSeries(HRSetup."Company Jobs",xRec."No. series",0D,"Job ID","No. series");
END;

//POPULATE FIELDS
Requestor:=UserID;
"Entry Date":=TODAY;
*/

    end;

    var
        NoOfPosts: Decimal;
        HREmp: Record "HR Employees";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: Label 'You cannot delete HR jobs if occupied';
        Jobs: Record "HR Jobs1";
        mcontent: Label 'Status must be new on Job ID No.';
        mcontent2: Label '. Please change status of  the approval and try again';
}

