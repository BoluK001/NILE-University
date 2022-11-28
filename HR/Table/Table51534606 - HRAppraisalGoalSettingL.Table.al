table 51534606 "HR Appraisal Goal Setting L"
{

    fields
    {
        field(1; "Appraisal No"; Code[30])
        {
            TableRelation = "HR Appraisal Goal Setting H"."Appraisal No";
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER ("Appraisal Period"));
        }
        field(7; "Agreement With Rating"; Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
        }
        field(8; "Planned Targets/Objectives"; Text[250])
        {
        }
        field(9; "Sub Category"; Code[100])
        {
            TableRelation = "HR Lookup Values".Code WHERE (Type = CONST ("Appraisal Sub Category"));
        }
        field(10; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Employees";
        }
        field(11; "Measurement Criteria"; Text[250])
        {
        }
        field(12; "Target Score %"; Decimal)
        {
            Caption = 'Weighting %';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                /*//check that total for the period does not exceed 100
                AppraisalScores.RESET;
                AppraisalScores.SETRANGE(AppraisalScores."Appraisal No","Appraisal No");
                AppraisalScores.SETRANGE(AppraisalScores."KPI Period",AppraisalScores."KPI Period"::Current);
                AppraisalScores.CALCSUMS("Weighting % (Total=100)");
                //IF AppraisalScores."Target Points (Total=100)"+"Target Points (Total=100)" > 100 THEN ERROR('Target Points can not be greater than 100');
                
                
                //--Dave
                
                CALCFIELDS(TotalWeighting );
                //message('THE Total INIT %1',TotalWeighting );
                //message('THE PREVIOUS VAL %1',xRec."Weighting %");
                TotalWeight:=TotalWeighting-xRec."Weighting % (Total=100)";
                //message('THE Total after Deducting Prev %1',TotalWeight);
                TotalWeight:=TotalWeight+"Weighting % (Total=100)";
                //message('THE Total on Adding Current %1',TotalWeight);
                IF TotalWeight >100 THEN
                 ERROR(Text001);*/


                Validate(Ratings);

            end;
        }
        field(13; "Achievement % (Self)."; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                /*IF "Achievement % (Self).">"Weighting % (Total=100)" THEN ERROR('The score %1 is greater than Target Score %2',"Achievement % (Self).","Weighting % (Total=100)");*/

            end;
        }
        field(14; "Appraisal Rating"; Code[40])
        {
            Enabled = false;
            TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER (Grade));
        }
        field(15; "Key Outputs"; Text[250])
        {
        }
        field(17; "Development Area Description"; Text[250])
        {
        }
        field(50000; "Achievement % (Manager)."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Stores when the user was diagnosed';

            trigger OnValidate()
            begin
                /*IF "Achievement % (Manager).">"Weighting % (Total=100)" THEN ERROR('The score %1 is greater than Target Score %2',"Achievement % (Manager).","Weighting % (Total=100)");*/

            end;
        }
        field(50001; "Mgt Review Score"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Stores when the user was diagnosed';

            trigger OnValidate()
            begin
                /*IF "Mgt Review Score">"Weighting % (Total=100)" THEN ERROR('The score %1 is greater than Target Score %2',"Mgt Review Score","Weighting % (Total=100)");*/

            end;
        }
        field(50002; "Appraiser Remarks"; Text[30])
        {
        }
        field(50003; "Mgt Review Remarks"; Text[30])
        {
        }
        field(50004; Description; Text[250])
        {
        }
        field(50005; "KPI Period"; Option)
        {
            OptionMembers = Current,Next;
        }
        field(50006; Timing; Option)
        {
            OptionMembers = ,Hourly,Daily,Weekly,Monthly,Quarterly,"All Year",Biannual;
        }
        field(50007; Weight; Decimal)
        {
            Caption = 'Weighted Score';
            DecimalPlaces = 0 : 5;
            Description = 'Weighted Score';
            Editable = true;

            trigger OnValidate()
            begin
                //VALIDATE(Ratings);

                if "Evaluation Type" = "Evaluation Type"::KPI then begin
                    if Weight > ((Score * "Target Score %") / 5) then
                        Error('Supervisor score can not be greater than the weighted score %1', (Score * "Target Score %") / 5);

                end;
            end;
        }
        field(50008; "Actual Results (Self)"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Actual Results (Self)" > Weight then
                    Error('Score can not be greater than Weighthing');

                if HRAppraisalGoalSettingH.Get("Appraisal No") then begin
                    if HRAppraisalGoalSettingH.Status = HRAppraisalGoalSettingH.Status::Open then
                        "Agreed Score" := "Actual Results (Self)";
                end;
            end;
        }
        field(50009; "Achievement % (Self)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50010; "Agreed Score"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Agreed Score" > Weight then
                    Error('Score can not be greater than Weighthing');
            end;
        }
        field(50011; TotalWeighting; Decimal)
        {
            CalcFormula = Sum ("HR Appraisal Goal Setting L".Weight WHERE ("Appraisal No" = FIELD ("Appraisal No")));
            FieldClass = FlowField;
        }
        field(50012; "Serial No."; Integer)
        {
            AutoIncrement = false;
        }
        field(50013; "Actual Results (Manager)"; Text[250])
        {
        }
        field(50014; "Behavioural Group"; Code[50])
        {
            Editable = false;
            TableRelation = "HR Appraisal Behaviourals";
            ValidateTableRelation = false;
        }
        field(50015; "Evaluation Type"; Option)
        {
            OptionMembers = " ",Behavioural,KPI;
        }
        field(50016; Half; Option)
        {
            OptionCaption = ' ,First,Second';
            OptionMembers = " ",First,Second;
        }
        field(50017; Ratings; Code[20])
        {
            TableRelation = "HR Ratings";

            trigger OnValidate()
            begin
                if HRAppraisalGoalSettingH.Get("Appraisal No") then begin
                    if HRRatings.Get(Ratings) then begin
                        Score := HRRatings.Score;
                        Weight := (Score * "Target Score %") / 5;
                        if HRAppraisalGoalSettingH.Status = HRAppraisalGoalSettingH.Status::Open then
                            "Self Rating" := Weight;
                    end;
                end;

                if HRAppraisalGoalSettingH.Get("Appraisal No") then begin    //User ID
                    if ("Self Rating" = 0) and (UserId = HRAppraisalGoalSettingH."User ID") then
                        "Self Rating" := Weight;
                end;
            end;
        }
        field(50022; Score; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50023; "Submit to HR"; Boolean)
        {
        }
        field(50024; "KPI Weighting"; Decimal)
        {
        }
        field(50025; "Manager Score"; Decimal)
        {
        }
        field(50026; Nil; Text[90])
        {
        }
        field(50027; Below; Text[90])
        {
        }
        field(50028; Threshold; Text[90])
        {
        }
        field(50029; "On target"; Text[90])
        {
        }
        field(50030; Above; Text[90])
        {
        }
        field(50031; Outstanding; Text[90])
        {
        }
        field(50032; "Self Rating"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Serial No.", "Appraisal No", "Appraisal Period", Half)
        {
            Clustered = true;
        }
        key(Key2; "Appraisal No", "KPI Period")
        {
            SumIndexFields = Weight;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        LineNo := 1;
        HRGoalLine.Reset;
        HRGoalLine.SetRange(HRGoalLine."Appraisal No", "Appraisal No");
        if HRGoalLine.FindLast then
            "Serial No." := HRGoalLine."Serial No." + LineNo;
    end;

    var
        Employee: Record "HR Employees";
        HRAppraisalGoalSettingH: Record "HR Appraisal Goal Setting H";
        AppraisalScores: Record "HR Appraisal Goal Setting L";
        Text001: Label 'Weighting should not exceed 100%';
        HRGoalLine: Record "HR Appraisal Goal Setting L";
        TotalWeight: Decimal;
        LineNo: Integer;
        HRRatings: Record "HR Ratings";
}

