table 51534659 "Hr Interview Evaluation"
{

    fields
    {
        field(10; "Interview No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Interview No." <> xRec."Interview No." THEN BEGIN
                  HRSetup.GET;
                  NoSeriesMgt.TestManual(HRSetup."Job Interview Nos");
                 // "No series" := '';
                  //NoSeriesMgt.InitSeries(HRSetup."Job Interview Nos",xRec."No series",0D,"Interview No.","No series");
                END;
                
                HROralTemplate.SETRANGE("Entry No.");
                IF HROralTemplate.FINDFIRST THEN BEGIN
                 REPEAT
                  HROral.INIT;
                  HROral."Interview No.":="Interview No.";
                  HROral."Interview Group":=HROralTemplate."Oral Interview Group";
                  HROral."Interview Code":=HROralTemplate."Oral Interview Code";
                  HROral."Line No.":=0;
                  HROral."Target Score":=HROralTemplate."Target Score";
                  HROral.INSERT;
                 UNTIL HROralTemplate.NEXT = 0;
                END;
                  */

            end;
        }
        field(20; "Application No."; Code[20])
        {
            TableRelation = "HR Job Applications"."Application No" WHERE("Job Applied For" = FIELD("Job Title"),
                                                                          Qualified = CONST(true));

            trigger OnValidate()
            begin
                jobApp.Get("Application No.");
                if jobApp."Interview Invitation Sent" = false then
                    Error('Applicant must be notified prior to this process');


                HrJobs.Reset;
                if HrJobs.Get("Application No.") then begin
                    "First Name" := HrJobs."First Name";
                    "Middle Name" := HrJobs."Middle Name";
                    "Last Name" := HrJobs."Last Name";
                    Initial := HrJobs.Initials;
                    "Date Applied" := HrJobs."Date Applied";
                    Email := HrJobs."E-Mail";
                    "Requisition No." := HrJobs."Employee Requisition No";
                    "Pass Mark (%)" := HrJobs.Score;
                    "Current Salary (N) P/A" := HrJobs."Current Salary";
                    "Expected Salary (N) P/A" := HrJobs."Expected Salary";
                end;

                EmpReq.SetRange(EmpReq."Requisition No.", HrJobs."Employee Requisition No");
                if EmpReq.FindFirst then begin
                    "Experience Level" := EmpReq."Experience Level";
                    if EmpReq."Experience Level" = EmpReq."Experience Level"::"0-4 Years" then begin

                        HROral.SetRange(HROral."Interview No.", "Interview No.");
                        if HROral.FindFirst then
                            HROral.DeleteAll;

                        HROralTemplate.SetCurrentKey(HROralTemplate."Experience Level");
                        HROralTemplate.SetRange("Entry No.");
                        HROralTemplate.SetRange(HROralTemplate."Experience Level", HROralTemplate."Experience Level"::"0-4 Years");
                        if HROralTemplate.FindFirst then begin
                            repeat
                                HROral.Init;
                                HROral."Interview No." := "Interview No.";
                                HROral."Interview Group" := HROralTemplate."Oral Interview Group";
                                HROral."Interview Code" := HROralTemplate."Oral Interview Code";
                                HROral."Line No." := 0;
                                HROral."Target Score" := HROralTemplate."Target Score";
                                HROral."Experience Level" := HROralTemplate."Experience Level";
                                HROral.Insert;
                            until HROralTemplate.Next = 0;
                        end;
                    end else
                        if EmpReq."Experience Level" = EmpReq."Experience Level"::"5 Years & Above" then begin

                            HROral.SetRange(HROral."Interview No.", "Interview No.");
                            if HROral.FindFirst then
                                HROral.DeleteAll;

                            HROralTemplate.SetCurrentKey(HROralTemplate."Experience Level");
                            HROralTemplate.SetRange("Entry No.");
                            HROralTemplate.SetRange(HROralTemplate."Experience Level", HROralTemplate."Experience Level"::"5 Years & Above");
                            if HROralTemplate.FindFirst then begin
                                repeat
                                    HROral.Init;
                                    HROral."Interview No." := "Interview No.";
                                    HROral."Interview Group" := HROralTemplate."Oral Interview Group";
                                    HROral."Interview Code" := HROralTemplate."Oral Interview Code";
                                    HROral."Line No." := 0;
                                    HROral."Target Score" := HROralTemplate."Target Score";
                                    HROral."Experience Level" := HROralTemplate."Experience Level";
                                    HROral.Insert;
                                until HROralTemplate.Next = 0;
                            end;
                        end;
                end;


                //VALIDATE("Requisition No.");
            end;
        }
        field(30; "First Name"; Text[30])
        {
            Editable = false;
        }
        field(40; "Middle Name"; Text[30])
        {
            Editable = false;
        }
        field(50; "Last Name"; Text[30])
        {
            Editable = false;
        }
        field(60; Initial; Text[30])
        {
            Editable = false;
        }
        field(70; "Date Applied"; Date)
        {
            Editable = false;
        }
        field(80; Email; Text[50])
        {
            Editable = false;
        }
        field(90; "Interview Date"; Date)
        {
        }
        field(100; "Interview Done By"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmp.Get("Interview Done By") then
                    "Interviewer Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(110; "Interviewer Name"; Text[50])
        {
            Editable = false;
        }
        field(115; "No series"; Code[20])
        {
        }
        field(120; "Job Title"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID" WHERE(Status = CONST(Approved));

            trigger OnValidate()
            begin
                if Hrjob1.Get("Job Title") then
                    "Job Position" := Hrjob1."Job Title";
                /*

               HROral.SETRANGE(HROral."Interview No.","Interview No.");
               IF HROral.FINDFIRST THEN
                HROral.DELETEALL;

               HROralTemplate.SETRANGE("Entry No.");
               IF HROralTemplate.FINDFIRST THEN BEGIN
                REPEAT
                 HROral.INIT;
                 HROral."Interview No.":="Interview No.";
                 HROral."Interview Group":=HROralTemplate."Oral Interview Group";
                 HROral."Interview Code":=HROralTemplate."Oral Interview Code";
                 HROral."Line No.":=0;
                 HROral."Target Score":=HROralTemplate."Target Score";
                 HROral.INSERT;
                UNTIL HROralTemplate.NEXT = 0;
               END;
                 */

            end;
        }
        field(130; "Job Position"; Text[30])
        {
        }
        field(140; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(150; "Job Acceptance"; Boolean)
        {
        }
        field(160; "Stage 1 Score"; Decimal)
        {
            CalcFormula = Sum("Hr Interview Specific Evaluatn"."Total Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                    Stage = CONST(Stage1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(170; "Stage 2 Score"; Decimal)
        {
            CalcFormula = Sum("Hr Interview Specific Evaluatn"."Total Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                    Stage = CONST(Stage2)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(180; "Stage 3 Score"; Decimal)
        {
            CalcFormula = Sum("Hr Interview Specific Evaluatn"."Total Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                    Stage = CONST(Stage3)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(190; "Recommend for Stage 2"; Boolean)
        {
        }
        field(200; "Recommend for Stage 3"; Boolean)
        {
        }
        field(210; "Recommendation for Hire"; Boolean)
        {
        }
        field(220; Comment; Text[250])
        {
        }
        field(230; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(231; "Stage 1 Pass Mark"; Decimal)
        {
            CalcFormula = Sum("HR Job Evaluation Areas"."Pass Mark" WHERE(Job = FIELD("Job Title"),
                                                                           Stage = CONST(Stage1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(232; "Stage 2 Pass Mark"; Decimal)
        {
            CalcFormula = Sum("HR Job Evaluation Areas"."Pass Mark" WHERE(Job = FIELD("Job Title"),
                                                                           Stage = CONST(Stage2)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(233; "Stage 3 Pass Mark"; Decimal)
        {
            CalcFormula = Sum("HR Job Evaluation Areas"."Pass Mark" WHERE(Job = FIELD("Job Title"),
                                                                           Stage = CONST(Stage3)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(234; "HMO Stage"; Boolean)
        {
        }
        field(235; "Current Salary (N) P/A"; Decimal)
        {
        }
        field(236; "Expected Salary (N) P/A"; Decimal)
        {
        }
        field(237; "Notice Period"; Text[30])
        {
        }
        field(238; "Offer Status"; Option)
        {
            Editable = false;
            OptionMembers = Initial,"Keep In-view",Successful,Revisited;
        }
        field(239; "Requisition No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*EmpReq.SETRANGE(EmpReq."Requisition No.","Requisition No.");
                IF EmpReq.FINDFIRST THEN BEGIN
                  "Experience Level":= EmpReq."Experience Level";
                 IF EmpReq."Experience Level"=EmpReq."Experience Level"::"0-4 Years" THEN BEGIN
                
                HROral.SETRANGE(HROral."Interview No.","Interview No.");
                IF HROral.FINDFIRST THEN
                 HROral.DELETEALL;
                
                HROralTemplate.SETCURRENTKEY(HROralTemplate."Experience Level");
                HROralTemplate.SETRANGE("Entry No.");
                HROralTemplate.SETRANGE(HROralTemplate."Experience Level",HROralTemplate."Experience Level"::"0-4 Years");
                IF HROralTemplate.FINDFIRST THEN BEGIN
                 REPEAT
                  HROral.INIT;
                  HROral."Interview No.":="Interview No.";
                  HROral."Interview Group":=HROralTemplate."Oral Interview Group";
                  HROral."Interview Code":=HROralTemplate."Oral Interview Code";
                  HROral."Line No.":=0;
                  HROral."Target Score":=HROralTemplate."Target Score";
                  HROral.INSERT;
                 UNTIL HROralTemplate.NEXT = 0;
                END;
                END ELSE IF EmpReq."Experience Level"=EmpReq."Experience Level"::"5 Years & Above" THEN BEGIN
                
                HROral.SETRANGE(HROral."Interview No.","Interview No.");
                IF HROral.FINDFIRST THEN
                 HROral.DELETEALL;
                
                HROralTemplate.SETCURRENTKEY(HROralTemplate."Experience Level");
                HROralTemplate.SETRANGE("Entry No.");
                HROralTemplate.SETRANGE(HROralTemplate."Experience Level",HROralTemplate."Experience Level"::"5 Years & Above");
                IF HROralTemplate.FINDFIRST THEN BEGIN
                 REPEAT
                  HROral.INIT;
                  HROral."Interview No.":="Interview No.";
                  HROral."Interview Group":=HROralTemplate."Oral Interview Group";
                  HROral."Interview Code":=HROralTemplate."Oral Interview Code";
                  HROral."Line No.":=0;
                  HROral."Target Score":=HROralTemplate."Target Score";
                  HROral.INSERT;
                 UNTIL HROralTemplate.NEXT = 0;
                END;
                END;
                END;
                */

            end;
        }
        field(240; "Experience Level"; Option)
        {
            OptionCaption = ' ,0-4 Years,5 Years & Above';
            OptionMembers = " ","0-4 Years","5 Years & Above";
        }
        field(241; "Technical Knowledge/Competence"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Interview Group" = CONST('TECHNICAL KNOWLEDGE/COMPETENCY')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(242; "Culture Fit"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Interview Group" = CONST('CULTURE FIT')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(243; "Communication & Oral Presentat"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Interview Group" = CONST('COMMUNICATION/ORAL PRESENTATION')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(244; "Personal Value"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Interview Group" = CONST('PERSONAL VALUES')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(245; "Interview Assessment"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Experience Level" = CONST("0-4 Years")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(246; Comment2; Text[150])
        {
        }
        field(247; "Total Evaluation Score"; Decimal)
        {
            CalcFormula = Sum("HR Oral Interview Evaluation"."Candidate Score" WHERE("Interview No." = FIELD("Interview No."),
                                                                                      "Experience Level" = CONST("5 Years & Above")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(248; "Pass Mark (%)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(249; "Interview Process"; Option)
        {
            OptionMembers = " ","Requires ED & MD Approval","Not Applicable";
        }
        field(250; "Interview Invitation (Stage 2)"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Interview No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Interview No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Job Interview Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Job Interview Nos", xRec."No series", 0D, "Interview No.", "No series");
        end;
    end;

    var
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
        HrJobs: Record "HR Job Applications";
        Hrjob1: Record "HR Jobs";
        HREmp: Record "HR Employees";
        HROral: Record "HR Oral Interview Evaluation";
        HROralTemplate: Record "HR Oral Interview Template";
        MatrixRecord: Record "HR Job Evaluation Areas";
        MatrixRecords: array[32] of Record "HR Job Evaluation Areas";
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        RunNo: Code[20];
        Family: Record "HR Job Evaluation Areas";
        EmpIntV: Record "HR Job Evaluation Areas";
        i: Integer;
        MachineCenter: Record "Machine Center";
        EmpReq: Record "HR Employee Requisitions";
        jobApp: Record "HR Job Applications";

    local procedure UpdateLine(FieldRef: Integer)
    var
        HROralInt: Record "HR Oral Interview Evaluation";
    begin
        HROralInt.Locktable;
        HROralInt.Setrange("Interview No.", "Interview No.");
        if HROralInt.Find('-') then begin
            repeat
                CASE FieldRef OF
                    FIELDNO("Experience Level"):
                        HROralInt.VALIDATE("Experience Level", "Experience Level");
                End;
                HROralInt.MODIFY(TRUE);
            UNTIL HROralInt.NEXT = 0;
        end;
    end;
}

