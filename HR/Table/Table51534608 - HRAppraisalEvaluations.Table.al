table 51534608 "HR Appraisal Evaluations"
{

    fields
    {
        field(2; "Employee No"; Code[20])
        {
            Description = 'Stores the admission number of the record in the database';
            TableRelation = "HR Employees"."No.";
        }
        field(3; "Evaluation Code"; Code[80])
        {
            Description = 'Stores the code of the medical condition in the database';
            TableRelation = "HR Appraisal Evaluation Areas".Code;

            trigger OnValidate()
            begin
                HRAppEvaluationAreas.SetRange(HRAppEvaluationAreas.Code, "Evaluation Code");
                if HRAppEvaluationAreas.Find('-') then begin
                    Category := HRAppEvaluationAreas."Categorize As";
                    "Sub Category" := HRAppEvaluationAreas."Sub Category";
                    Group := HRAppEvaluationAreas.Group;
                    "Line No" := HRAppEvaluationAreas."Line No";
                    //"Appraisal Period":="Appraisal Period"

                end;
            end;
        }
        field(4; "Evaluation Description"; Text[250])
        {
            CalcFormula = Lookup ("HR Appraisal Evaluation Areas".Description WHERE ("Line No" = FIELD ("Line No")));
            Description = 'Stores the name of the medical condition';
            FieldClass = FlowField;

            trigger OnValidate()
            begin

                CalcFields("Evaluation Description");
            end;
        }
        field(6; "Achievement % (Self)."; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'Stores when the user was diagnosed';
            TableRelation = "HR Appraisal Career Dev".Answer;
        }
        field(7; "Appraisal Rating"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER (Grade));
        }
        field(8; "Total Score"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = Normal;
        }
        field(9; "Appraisal Period"; Code[30])
        {
        }
        field(10; Category; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(11; "Sub Category"; Code[100])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Appraisal Sub Category"));
        }
        field(12; Group; Code[80])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Appraisal Group Item"));
        }
        field(14; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(15; Strength; Text[250])
        {
        }
        field(16; "Development Areas"; Code[30])
        {
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin
                if HRTrainNeed.Get("Development Areas") then
                    "Development Area Description" := HRTrainNeed.Description;
            end;
        }
        field(17; "Development Area Description"; Text[250])
        {
        }
        field(50000; "Achievement % (Manager)."; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'Stores when the user was diagnosed';
            TableRelation = "HR Appraisal Career Dev".Answer;
        }
        field(50001; "Mgt Review Score"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'Stores when the user was diagnosed';
            TableRelation = "HR Appraisal Career Dev".Answer;
        }
        field(50002; "Appraiser Remarks"; Text[30])
        {
        }
        field(50003; "Msg Review Remarks"; Text[30])
        {
        }
        field(50010; "Total Target"; Decimal)
        {
        }
        field(50011; "Key Results Area"; Text[250])
        {
        }
        field(50012; "KRA Individual objectives"; Text[250])
        {
            Description = 'Individual objectives related to this KRA';
        }
        field(50013; "KRA (Self)"; Text[30])
        {
        }
        field(50014; "KRA (Manager)"; Time)
        {
        }
        field(50015; "Rating (Self)"; Option)
        {
            OptionCaption = 'EP,FP,NYF,TE';
            OptionMembers = EP,FP,NYF,TE;
        }
        field(50016; "Rating (Manager)"; Option)
        {
            OptionCaption = 'EP,FP,NYF,TE';
            OptionMembers = EP,FP,NYF,TE;
        }
        field(50017; "Self Evaluation"; Text[100])
        {
        }
        field(50018; Description; Text[250])
        {
        }
        field(50019; "Appraisal No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Period", "Appraisal No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        HRAppraisalGoalSettingH.SetRange(HRAppraisalGoalSettingH."Employee No", "Employee No");
        HRAppraisalGoalSettingH.SetFilter(HRAppraisalGoalSettingH."Appraisal Period", "Appraisal Period");
        if HRAppraisalGoalSettingH.Find('-') then
            if (HRAppraisalGoalSettingH."Responsibility Center" = 'HOD') or (HRAppraisalGoalSettingH."Appraisal Type" <> 'PERFORMANCE APPRAISAL') then begin
                "Mgt Review Score" := "Achievement % (Manager).";
                "Msg Review Remarks" := "Appraiser Remarks";
            end;
    end;

    var
        HRLookupValues: Record "HR Lookup Values";
        TotalScore: Integer;
        HRAppEvaluationAreas: Record "HR Appraisal Evaluation Areas";
        HRAppraisalGoalSettingH: Record "HR Appraisal Goal Setting H";
        HRTrainNeed: Record "HR Training Needs";
}

