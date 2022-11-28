table 51534740 "HR Oral Interview Evaluation"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Interview Group"; Code[50])
        {
            //TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Country));
            TableRelation = "HR Oral Interview Template"."Oral Interview Group";  //jj

            trigger OnValidate()
            var
                HROralInt: record "HR Oral Interview Template";

            begin
                //HROralInt.SetCurrentKey("Oral Interview Group");
                if HROralInt.Get("Interview Group") then
                    HROralInt.SetRange("Oral Interview Group", Rec."Interview Group");
                if HROralInt.Find('-') then begin
                    Rec."Interview Code" := HROralInt."Oral Interview Code";
                    Rec."Target Score" := HROralInt."Target Score";
                    rec."Experience Level" := HROralInt."Experience Level";

                    // Message('%1:',);
                end;
            end;

        }
        field(3; "Interview Code"; Code[50])
        {
            //TableRelation = "HR Oral Interview Template"."Oral Interview Code";
        }
        field(4; "Interview No."; Code[20])
        {
        }
        field(5; "Target Score"; Decimal)
        {
        }
        field(6; "Candidate Score"; Decimal)
        {
            FieldClass = Normal;
        }
        field(7; Emp1; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp1);
                "Candidate Score" := Emp1 / 1;
            end;
        }
        field(8; Emp2; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp2);
                "Candidate Score" := (Emp1 + Emp2) / 2;
            end;
        }
        field(9; Emp3; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp3);
                "Candidate Score" := (Emp1 + Emp2 + Emp3) / 3;
            end;
        }
        field(10; Emp4; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp4);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4) / 4;
            end;
        }
        field(11; Emp5; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp5);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4 + Emp5) / 5;
            end;
        }
        field(12; Emp6; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp6);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4 + Emp5 + Emp6) / 6;
            end;
        }
        field(13; Emp7; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp7);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4 + Emp5 + Emp6 + Emp7) / 7;
            end;
        }
        field(14; Emp8; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp8);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4 + Emp5 + Emp6 + Emp7 + Emp8) / 8;
            end;
        }
        field(15; Emp9; Decimal)
        {

            trigger OnValidate()
            begin
                CheckTarget(Emp9);
                "Candidate Score" := (Emp1 + Emp2 + Emp3 + Emp4 + Emp5 + Emp6 + Emp7 + Emp8 + Emp9) / 9;
            end;
        }
        field(16; Emp10; Decimal)
        {
        }
        field(17; Rating; Option)
        {
            OptionCaption = 'Below,Good/Average,Above Average,Outstanding,Foundation,Last Stage/Progress,Qualified';
            OptionMembers = Below,"Good/Average","Above Average",Outstanding,Foundation,"Last Stage/Progress",Qualified;
        }
        field(18; "Experience Level"; Option)
        {
            OptionCaption = ' ,0-4 Years,5 Years & Above';
            OptionMembers = " ","0-4 Years","5 Years & Above";
        }
        field(19; Comment; Text[200])
        {
            Caption = 'Comment/Observation';
        }
        field(20; Recommendation; Option)
        {
            OptionMembers = "Not Suitable","Could be considered","Suitable for hire";
        }
        field(21; "Interview Date"; date)
        {

        }
        field(22; "Job Position Employed For"; code[20])
        {

        }
        field(23; "Monthly Income"; Decimal)
        {

        }
        field(24; "Currency Code"; Code[20])
        {

        }
        field(25; "Sales Income"; Decimal)
        {

        }
        field(26; "Target Agreed"; Decimal)
        {

        }
        field(27; "Effective On"; date)
        {

        }
        field(28; "Training Resumption"; date)
        {

        }
    }
    keys
    {
        key(Key1; "Interview No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        empCnt1: Integer;
        empCnt2: Integer;
        empCnt3: Integer;
        empCnt4: Integer;
        empCnt5: Integer;
        empCnt6: Integer;
        empCnt7: Integer;
        empCnt8: Integer;
        empCnt9: Integer;
        empCnt10: Integer;
        empCnt: Integer;

    local procedure CalcAverage()
    begin
    end;

    local procedure CheckTarget(Score: Decimal)
    begin
        if Score > "Target Score" then
            Error('Score can not be greater than target score');
    end;


}

