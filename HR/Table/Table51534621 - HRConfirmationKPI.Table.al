table 51534621 "HR Confirmation KPI"
{

    fields
    {
        field(50007; Weight; Decimal)
        {
            Caption = 'Agreed Score';
            DecimalPlaces = 0 : 5;
            Description = 'Weighted Score';
            Editable = false;

            trigger OnValidate()
            begin
                /*
                IF HRAppraisalGoalSettingH.GET("Appraisal No") THEN BEGIN
                  HRAppraisalGoalSettingH.CALCFIELDS(HRAppraisalGoalSettingH.TotalWeighting);
                 message('THE totakl %1',HRAppraisalGoalSettingH.TotalWeighting);
                 IF HRAppraisalGoalSettingH.TotalWeighting >100 THEN
                 ERROR(Text001);
                
                END;
                */
                /*CALCFIELDS(TotalWeighting );
                //message('THE Total INIT %1',TotalWeighting );
                //message('THE PREVIOUS VAL %1',xRec."Weighting %");
                TotalWeight:=TotalWeighting-xRec."Weighting %";
                //message('THE Total after Deducting Prev %1',TotalWeight);
                TotalWeight:=TotalWeight+"Weighting %";
                //message('THE Total on Adding Current %1',TotalWeight);
                IF TotalWeight >100 THEN
                 ERROR(Text001);*/

            end;
        }
        field(50014; "Behavioural Group"; Code[50])
        {
            Editable = false;
            TableRelation = "HR Appraisal Behaviourals";
        }
        field(50017; Ratings; Code[20])
        {
            TableRelation = "HR Ratings";

            trigger OnValidate()
            begin
                if HRRatings.Get(Ratings) then
                    Score := HRRatings.Score;
                Weight := (Score * "Target Score %") / 5;
            end;
        }
        field(50022; Score; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50024; "KPI Weighting"; Decimal)
        {
        }
        field(50025; "Document No."; Code[20])
        {
        }
        field(50026; "Target Score %"; Decimal)
        {
            Caption = 'Target Score';
        }
        field(50027; "Employee No."; Code[20])
        {
        }
        field(50028; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50029; Objectives; Text[150])
        {
        }
        field(50030; Description; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRRatings: Record "HR Ratings";
}

