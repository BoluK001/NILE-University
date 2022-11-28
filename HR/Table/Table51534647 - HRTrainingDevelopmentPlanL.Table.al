table 51534647 "HR Training Development Plan L"
{

    fields
    {
        field(1; "Training Application No."; Code[30])
        {
            TableRelation = "HR Training Applications"."Application No";
        }
        field(2; "Key Development Area"; Code[30])
        {
            TableRelation = "HR Training Needs".Code;

            trigger OnValidate()
            begin
                //HRJobs.RESET;
                //IF HRJobs.GET("Job ID") THEN BEGIN
                //"Job Description":=HRJobs."Job Description";
                //HRTrainNeeds.RESET;
                if HRTrainNeeds.Get("Key Development Area") then
                    "KDA Description" := HRTrainNeeds.Description;
            end;
        }
        field(3; "KDA Description"; Text[250])
        {
        }
        field(4; "Purpose of Training"; Text[250])
        {
        }
        field(5; "Start Date"; Date)
        {
        }
        field(6; "End Date"; Date)
        {
        }
        field(7; "Duration Units"; Option)
        {
            OptionMembers = " ",Hours,Days,Weeks,Months,Years;
        }
        field(8; Duration; Decimal)
        {

            trigger OnValidate()
            begin
                begin
                    if (Duration <> 0) and ("Start Date" <> 0D) then
                        "End Date" := HRLeaveApp.DetermineLeaveReturnDate("Start Date", Duration);

                    //---------------------------------------------------------
                    "End Date" := CalcDate('-1D', "End Date");
                    mDay := 0;
                    mDay := Date2DWY("End Date", 1);
                    if mDay = 6 then "End Date" := CalcDate('+2D', "End Date");
                    if mDay = 7 then "End Date" := CalcDate('+1D', "End Date");
                    //---------------------------------------------------------
                    Modify;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Training Application No.", "Key Development Area")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        mDay: Integer;
        HRLeaveApp: Record "HR Leave Application";
        HRTrainNeeds: Record "HR Training Needs";
}

