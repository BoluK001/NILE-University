table 51534626 "HR HOD Training Needs"
{
    DrillDownPageID = "HR Training Needs";
    LookupPageID = "HR Training Needs";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Training Needs";
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
        field(5; "Duration Units"; Option)
        {
            OptionMembers = Hours,Days,Weeks,Months,Years;
        }
        field(6; Duration; Decimal)
        {

            trigger OnValidate()
            begin
                begin
                    if (Duration <> 0) and ("Start Date" <> 0D) then
                        //"Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
                        //"End Date" := DeterminethisLeaveEndDate("Return Date");
                        "End Date" := HRLeaveApp.DetermineLeaveReturnDate("Start Date", Duration);
                    Modify;
                end;
            end;
        }
        field(7; "Cost Of Training"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF Posted THEN BEGIN
                IF Duration <> xRec.Duration THEN BEGIN
                MESSAGE('%1','You cannot change the costs after posting');
                Duration := xRec.Duration;
                END
                END
                */

            end;
        }
        field(8; Location; Text[100])
        {
        }
        field(10; "Re-Assessment Date"; Date)
        {
        }
        field(12; "Need Source"; Option)
        {
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal,Succesion,Training,Employee,"Employee Skill Plan";
        }
        field(13; Provider; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", Provider);
                if Vend.Find('-') then begin
                    "Provider Name" := Vend.Name;
                end;
            end;
        }
        field(15; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Qualification Code"; Code[20])
        {
            TableRelation = "HR Qualifications".Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                HRQualifications.SetRange(HRQualifications.Code, "Qualification Code");
                if HRQualifications.Find('-') then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(20; "Qualification Type"; Code[30])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Qualification Type"));
        }
        field(21; "Qualification Description"; Text[80])
        {
        }
        field(22; "Training Applicants"; Integer)
        {
            CalcFormula = Count("HR Training Applications" WHERE("Course Title" = FIELD(Code)));
            FieldClass = FlowField;
        }
        field(23; "Training Applicants (Passed)"; Integer)
        {
            CalcFormula = Count("HR Training Applications" WHERE("Course Title" = FIELD(Code),
                                                                  "Training Evaluation Results" = CONST(Passed)));
            FieldClass = FlowField;
        }
        field(24; "Training Applicants (Failed)"; Integer)
        {
            CalcFormula = Count("HR Training Applications" WHERE("Course Title" = FIELD(Code),
                                                                  "Training Evaluation Results" = CONST(Failed)));
            FieldClass = FlowField;
        }
        field(25; "Provider Name"; Text[50])
        {
        }
        field(26; "Responsibility Center"; Code[20])
        {
        }
        field(27; "No."; Code[20])
        {
        }
        field(28; "No series"; Code[20])
        {
        }
        field(29; "No. of Applicants"; Integer)
        {
        }
        field(30; Type; Option)
        {
            OptionMembers = " ",HR,HOD;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Training Need Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Training Need Nos", xRec."No series", 0D, "No.", "No series");
        end;
    end;

    var
        HRLeaveApp: Record "HR Leave Application";
        HRQualifications: Record "HR Qualifications";
        Vend: Record Vendor;
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

