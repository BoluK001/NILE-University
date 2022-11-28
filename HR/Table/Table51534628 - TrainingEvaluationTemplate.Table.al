table 51534628 "Training Evaluation Template"
{

    fields
    {
        field(1; "Request No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Question; Text[250])
        {
        }
        field(4; Answer; Option)
        {
            OptionCaption = ' ,Excellent,Good,Poor,Fair';
            OptionMembers = " ",Excellent,Good,Poor,Fair;
        }
        field(5; Remarks; Text[250])
        {
        }
        field(6; Type; Option)
        {
            OptionCaption = ' ,Pre,Post,3 Months Post';
            OptionMembers = " ",Pre,Post,"3 Months Post";
        }
    }

    keys
    {
        key(Key1; "Request No.", "Line No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

