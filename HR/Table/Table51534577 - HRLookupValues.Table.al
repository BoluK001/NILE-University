table 51534577 "HR Lookup Values"
{
    LookupPageID = "HR Lookup Values List";

    fields
    {
        field(1; Type; Option)
        {
            //  OptionCaption = 'Religion,Language,Medical Scheme,Location,Contract Type,Qualification Type,Stages,Scores,Institution,Appraisal Type,Appraisal Period,Urgency,Succession,Security,Disciplinary Case Rating,Disciplinary Case,Disciplinary Action,Next of Kin,Country,Grade,Checklist Item,Appraisal Sub Category,Appraisal Group Item,Transport Type,Grievance Cause,Grievance Outcome,Appraiser Recommendation,Results,Job Level,Employment Type,Gender';    //jj300922 I remmed
            // OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",Country,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Grievance Cause","Grievance Outcome","Appraiser Recommendation",Results,"Job Level","Employment Type",Gender;   //jj300922  I remmed
            OptionCaption = 'Religion,Language,,Location,Contract Type,Qualification Type,Stages,Scores,Institution,,Appraisal Period,,,,,,,Next of Kin,Country,Grade,Checklist Item,,,,,,,,Job Level,Employment Type,Gender';
            OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",Country,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Grievance Cause","Grievance Outcome","Appraiser Recommendation",Results,"Job Level","Employment Type",Gender;

        }
        field(2; "Code"; Code[70])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Notice Period"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
        }
        field(7; "Contract Length"; Integer)
        {
        }
        field(8; "Current Appraisal Period"; Boolean)
        {
        }
        field(9; "Disciplinary Case Rating"; Text[30])
        {
            //  TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Disciplinary Case Rating"));  //jj300922  I remmed becuase of the Option member
        }
        field(10; "Disciplinary Action"; Code[20])
        {
            //  TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));  //jj300922  I remmed becuase of the Option member
        }
        field(14; From; Date)
        {
        }
        field(15; "To"; Date)
        {
        }
        field(16; Score; Decimal)
        {
        }
        field(17; "Basic Salary"; Decimal)
        {
        }
        field(18; "To be cleared by"; Code[20])
        {
            TableRelation = "HR Lookup Values".Remarks;
        }
        field(19; Type1; Option)
        {
            OptionMembers = RG,LNG;
        }
        field(20; "Annual Leave Days"; Integer)
        {
        }
        field(21; "Exam Leave Days"; Integer)
        {
        }
        field(22; "HMO Beneficiaries"; Integer)
        {
        }
        field(23; "HMO Plan"; Option)
        {
            OptionCaption = ',High Lite,High Value';
            OptionMembers = " ","High Lite","High Value";
        }
    }

    keys
    {
        key(Key1; Type, "Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin


        Error('You cannot delete this record. Please contact your Systems Administrator');
    end;
}

