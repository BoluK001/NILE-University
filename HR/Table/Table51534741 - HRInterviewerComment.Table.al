table 51534741 "HR Interviewer Comment"
{

    fields
    {
        field(1; "Interview No."; Code[20])
        {
        }
        field(2; "Interviewer No."; Code[20])
        {
            TableRelation = "HR Job Evaluation Areas"."Employee Code" WHERE("Requisition No." = FIELD("Requisition No"));

            trigger OnValidate()
            begin
                HRInterviewerComment.SetRange(HRInterviewerComment."Interview No.", "Interview No.");
                HRInterviewerComment.SetRange(HRInterviewerComment."Interviewer No.", "Interviewer No.");
                if HRInterviewerComment.FindFirst then
                    Error('your comment/recommendation already exist for this candidate');

                EmpRec.Get("Interviewer No.");
                "Interviewer Name" := EmpRec."Last Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."First Name";
            end;
        }
        field(3; "Interviewer Name"; Text[100])
        {
        }
        field(4; Comment; Text[50])
        {
        }
        field(5; Recommendation; Option)
        {
            OptionMembers = "Not Suitable","Could  Be Considered",Suitable;
        }
        field(6; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Requisition No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Interview No.", "Line No.", "Requisition No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRJobEvaluationAreas: Record "HR Job Evaluation Areas";
        EmpRec: Record "HR Employees";
        HRInterviewerComment: Record "HR Interviewer Comment";
}

