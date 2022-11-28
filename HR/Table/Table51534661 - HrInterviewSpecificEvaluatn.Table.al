table 51534661 "Hr Interview Specific Evaluatn"
{

    fields
    {
        field(10; "Evaluation Code"; Code[50])
        {
            TableRelation = "Hr Interview Evaluation Areas"."Evaluation Code";

            trigger OnValidate()
            begin
                HRINTVIEW.Reset;
                /*HRINTVIEW.SETRANGE(HRINTVIEW."Default Receipts Bank","Evaluation Code");
                IF HRINTVIEW.FIND('-') THEN
                  BEGIN
                    "Evaluation Description":=  HRINTVIEW."Imprest  Batch"     ;
                    HrRating.FINDLAST ;
                    "Total Target":= HrRating.Score
                  END;
                    */
                HRINTVIEW.Reset;
                if HRINTVIEW.Get("Evaluation Code") then
                    "Evaluation Description" := HRINTVIEW."Evaluation Description";
                /*  BEGIN
                  //  "Evaluation Description":=  HRINTVIEW."Evaluation Description"     ;
                    HrRating.FINDLAST ;
                  //  "Total Target":= HrRating.Score
                  END;
                
                 // HrRating.RESET ;
                  //IF HrRating.FIND('+')     THEN
                  //HRAppraisalEvaluations."Total Target":=HrRatings.Score;
                 */


                // HrRating.RESET ;
                //IF HrRating.FIND('+')     THEN
                // HRAppraisalEvaluations."Total Target":=HrRatings.Score;

            end;
        }
        field(15; "Interview No."; Code[30])
        {
        }
        field(20; "Evaluation Description"; Text[250])
        {
        }
        field(30; "Interview Rating"; Code[20])
        {
        }
        field(40; "Interview1 Stage 1 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;
        }
        field(41; "Interview2 Stage 1 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;

            trigger OnValidate()
            begin
                "Average Score" := ("Interview1 Stage 1 Score" + "Interview2 Stage 1 Score") / 2;
                Validate("Average Score");
            end;
        }
        field(50; "Interview1 Stage 2 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;
        }
        field(51; "Interview2 Stage 2 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;

            trigger OnValidate()
            begin
                "Average Score" := ("Interview1 Stage 2 Score" + "Interview2 Stage 2 Score") / 2;
                Validate("Average Score");
            end;
        }
        field(55; "Interview1 Stage 3 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;
        }
        field(60; "Total Target"; Decimal)
        {
            Editable = false;
        }
        field(61; Stage; Option)
        {
            OptionCaption = 'Stage1,Stage2,Stage3';
            OptionMembers = Stage1,Stage2,Stage3;
        }
        field(62; "Evaluation Score"; Integer)
        {
        }
        field(63; "Interview2 Stage 3 Score"; Decimal)
        {
            TableRelation = "Hr Interview Evalution Rating".Score;

            trigger OnValidate()
            begin
                "Average Score" := ("Interview1 Stage 3 Score" + "Interview2 Stage 3 Score") / 2;
                Validate("Average Score");
            end;
        }
        field(64; Weight; Decimal)
        {
        }
        field(65; "Average Score"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Score" := "Average Score" * Weight;
            end;
        }
        field(66; "Total Score"; Decimal)
        {
        }
        field(67; "Entry No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Interview1 Stage 1 Score", "Interview1 Stage 2 Score", "Interview1 Stage 3 Score";
        }
    }

    fieldgroups
    {
    }

    var
        HRINTVIEW: Record "Hr Interview Evaluation Areas";
        HrRating: Record "Hr Interview Evalution Rating";
        HrEval: Record "Hr Interview Specific Evaluatn";
}

