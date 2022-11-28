table 51534558 "Training Eval. question line"
{
    DrillDownPageID = "Hr Hmo Picture";
    LookupPageID = "Hr Hmo Picture";

    fields
    {
        field(3; "Training Eval Question No."; Integer)
        {
            BlankZero = true;
            MinValue = 1;

            trigger OnValidate()
            begin
                TestField("Training Category");
            end;
        }
        field(4; "Training Category"; Option)
        {
            OptionCaption = ' ,Pre,Post,3 Months Post';
            OptionMembers = " ",Pre,Post,"3 Months Post";

            trigger OnValidate()
            begin
                //TESTFIELD("Question Ref No.");
            end;
        }
        field(5; "Training Eval. Question"; Text[250])
        {

            trigger OnValidate()
            begin
                if "Training Eval Question No." <= 0 then
                    FieldError("Training Eval Question No.", '0');


                TestField("Training Eval. Question");
            end;
        }
    }

    keys
    {
        key(Key1; "Training Eval Question No.", "Training Category")
        {
            Clustered = true;
        }
        key(Key2; "Training Category", "Training Eval Question No.")
        {
        }
    }

    fieldgroups
    {
    }
}

