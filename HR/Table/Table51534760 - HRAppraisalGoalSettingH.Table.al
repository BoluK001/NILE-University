table 51534605 "HR Appraisal Goal Setting H"
{

    fields
    {
        field(1; "Appraisal No"; Code[30])
        {
            Editable = false;
        }
        field(2; Supervisor; Code[50])
        {

            trigger OnValidate()
            begin
                /*
                Sup.RESET;
                Sup.SETRANGE(Sup."No.","Supervisor No.");
                IF Sup.FIND('-') THEN
                  BEGIN
                   "Supervisor Name":=Sup."First Name"+' '+Sup."Middle Name"+' '+Sup."Last Name";
                  END;
                */

            end;
        }
        field(3; "Appraisal Type"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Appraisal Type"));
        }
        field(4; "Appraisal Period"; Code[30])
        {
            Editable = false;
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"),
                                                           Closed = CONST(false));
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Closed,HR,Review';
            OptionMembers = Open,"Pending Approval",Approved,Closed,HR,Review;
        }
        field(6; "Recommendations 1"; Text[250])
        {
            Caption = '1st Line Supervisor';
        }
        field(7; "No Series"; Code[20])
        {
        }
        field(8; "Appraisal Stage"; Option)
        {
            OptionMembers = "Target Setting",FirstQuarter,SecondQuarter,ThirdQuarter,EndYearEvaluation;
        }
        field(9; Sent; Option)
        {
            OptionMembers = Appraisee,Supervisor;
        }
        field(10; "User ID"; Code[100])
        {
        }
        field(11; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(12; "Employee No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                /*
                Objectives.RESET;
                Objectives.SETRANGE(Objectives."No.","No.");
                Objectives.SETRANGE(Objectives.Status,Objectives.Status::Open);
                IF Objectives.FIND('-') THEN
                  BEGIN
                  ERROR('Please close precceding period first');
                  END

                ELSE BEGIN
               Emp.RESET;
               Emp.SETRANGE(Emp."No.","No.");
               IF Emp.FIND('-') THEN
               BEGIN
                  "Employee Name":=Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";
                   Department:=Emp."HR Department Name";
                  "Job Tittle":=Emp."Job Title";
                  //Gender:=Emp.Gender;
                  "Date of Join":=Emp."Date Of Join";

                 END;
                 END;
                */

            end;
        }
        field(13; "Employee Name"; Text[60])
        {
            Editable = false;
        }
        field(15; "Job Title"; Code[30])
        {
            Editable = false;
        }
        field(16; "Supervisors Overal Rating"; Code[20])
        {
            TableRelation = "HR Appraisal Career Dev"."Appraisal Code";

            trigger OnValidate()
            begin

                if HRAppraisalRatings.Get("Supervisors Overal Rating") then
                    "Overal Rating Desc" := HRAppraisalRatings.Question;
                // Recommendations:=HRAppraisalRatings."Line No.";
            end;
        }
        field(17; "Any Additional Comments"; Text[250])
        {
        }
        field(18; "Overal Rating Desc"; Text[30])
        {
        }
        field(19; "Evaluation Period Start"; Date)
        {
        }
        field(20; "Evaluation Period End"; Date)
        {
        }
        field(21; "Appraisal Date"; Date)
        {
        }
        field(22; Unit; Code[20])
        {
            Editable = false;
        }
        field(23; "Company Score"; Decimal)
        {
            Editable = false;
        }
        field(24; "Bonus Point Appraiser"; Decimal)
        {
        }
        field(25; "Bonus Point Mgt"; Decimal)
        {
        }
        field(26; "Bonus Point Appraiser Remarks"; Text[10])
        {
        }
        field(27; "Bonus Point Mgt Remarks"; Text[10])
        {
        }
        field(28; "Recommendation Appraiser"; Text[30])
        {
            TableRelation = "HR Lookup Values".Description WHERE(Type = CONST("Appraiser Recommendation"));
        }
        field(29; "Recommendation 2"; Text[250])
        {
            Caption = '2nd Line Supervisor';
        }
        field(30; "Recommendation Mgt"; Text[30])
        {
            TableRelation = "HR Lookup Values".Description WHERE(Type = CONST("Appraiser Recommendation"));
        }
        field(31; "Recommendation 3"; Text[150])
        {
            Caption = '3rd Line Supervisor';
        }
        field(32; "Development Requirements Appra"; Text[150])
        {
        }
        field(33; "Development Requirements Mgt"; Text[150])
        {
        }
        field(34; "Comments Appraisee"; Text[250])
        {
        }
        field(35; "Comments Appraiser"; Text[250])
        {
        }
        field(36; "Comments Mgt"; Text[50])
        {
        }
        field(37; "Performance Score Appraisee"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Evaluations"."Achievement % (Self)." WHERE("Employee No" = FIELD("Employee No"),
                                                                                        "Appraisal Period" = FIELD("Appraisal Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Performance Score Appraiser"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Evaluations"."Achievement % (Manager)." WHERE("Employee No" = FIELD("Employee No"),
                                                                                           "Appraisal Period" = FIELD("Appraisal Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Performance Score Mgt"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Evaluations"."Mgt Review Score" WHERE("Employee No" = FIELD("Employee No"),
                                                                                   "Appraisal Period" = FIELD("Appraisal Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "KPIs Appraisee Score"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Achievement % (Self)." WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                           "KPI Period" = CONST(Current)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "KPIs Appraiser Score"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Achievement % (Manager)." WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                              "KPI Period" = CONST(Current)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "KPIs Mgt Score"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Mgt Review Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                      "KPI Period" = CONST(Current)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Overall Appraisee Score"; Decimal)
        {
        }
        field(46; "Overall Appraiser Score"; Decimal)
        {
        }
        field(47; "Overall Mgt Score"; Decimal)
        {
        }
        field(48; "Bonus Point appraisee"; Decimal)
        {
        }
        field(49; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50; "Supervisor's Job Title"; Code[50])
        {
            Editable = false;
        }
        field(51; Department; Code[30])
        {
        }
        field(50000; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            Editable = true;   //jj271022
            TableRelation = "Responsibility Center";
        }
        field(50001; "Signature Appraisee"; Boolean)
        {
            Caption = 'I Agree';
        }
        field(50002; "Signature Appraiser"; Boolean)
        {
        }
        field(50003; "Signature Mgt"; Boolean)
        {
        }
        field(50004; "MD's Comment"; Text[10])
        {
        }
        field(50005; "MD's Recommendation"; Text[30])
        {
            TableRelation = "HR Lookup Values".Description WHERE(Type = CONST("Appraiser Recommendation"));
        }
        field(50006; "MD's Signature"; Boolean)
        {
        }
        field(50007; "MD's Remark"; Text[10])
        {
        }
        field(50008; "Development Plans"; Text[20])
        {
        }
        field(50009; Confirmation; Boolean)
        {
            Editable = false;
            InitValue = false;
        }
        field(50010; "Confirmation with Salary Reviw"; Boolean)
        {
        }
        field(50011; "Contract Type"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Contract Type"));
        }
        field(50012; "Salary Grade"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST(Grade));

            trigger OnValidate()
            begin
                /*HREmp.SETRANGE(HREmp."No.","Employee No");
                IF HREmp.FINDFIRST THEN
                BEGIN
                  HREmp.VALIDATE(Grade,"Salary Grade");
                  HREmp.MODIFY;
                END
                 */

            end;
        }
        field(50013; Step; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch";

            trigger OnValidate()
            begin
                /*HREmp.SETRANGE(HREmp."No.","Employee No");
                IF HREmp.FINDFIRST THEN
                BEGIN
                  HREmp.VALIDATE("Salary Step",Step);
                  HREmp.MODIFY;
                END
                  */

            end;
        }
        field(50014; Level; Option)
        {
            OptionCaption = ' ,1-4,5-8';
            OptionMembers = " ","1-4","5-8";
        }
        field(50015; "Behavioural First Half Score"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Evaluation Type" = CONST(Behavioural),
                                                                                  "Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  Half = CONST(First)));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //CALCFIELDS("Functional Assesment Score","Organisational Capability","Management Competencies");
                //"Behavioural Score":=("Functional Assesment Score"+"Organisational Capability"+"Management Competencies")*0.4;
            end;
        }
        field(50016; "KPI Score First Half"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50017; "KPI Score Second Half"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50018; "Functional Ass. First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('FUNCTIONAL ASSESSMENT'),
                                                                                  Half = CONST(First)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Org. Capability First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('ORGANISATIONAL CAPABILITY'),
                                                                                  Half = CONST(First)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Mgt. Competencies First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('MANAGEMENT COMPETENCIES'),
                                                                                  Half = CONST(First)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Behavioural Second Half Score"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Evaluation Type" = CONST(Behavioural),
                                                                                  "Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  Half = CONST(Second)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Functional Ass. Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('FUNCTIONAL ASSESSMENT'),
                                                                                  Half = CONST(Second)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Org. Capability Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('ORGANISATIONAL CAPABILITY'),
                                                                                  Half = CONST(Second)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Mgt. Competencies Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L"."Agreed Score" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                  "Appraisal Period" = FIELD("Appraisal Period"),
                                                                                  "Evaluation Type" = CONST(Behavioural),
                                                                                  "Behavioural Group" = CONST('MANAGEMENT COMPETENCIES'),
                                                                                  Half = CONST(Second)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Financial First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(First),
                                                                          "Behavioural Group" = CONST('FINANCIAL')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Customer First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(First),
                                                                          "Behavioural Group" = CONST('CUSTOMER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; "Internal Process First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(First),
                                                                          "Behavioural Group" = CONST('INTERNAL PROCESS')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50028; "Learning Growth First Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(First),
                                                                          "Behavioural Group" = CONST('LEARNING GROWTH')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "KPI First Half Aggregate"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(First)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Financial Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(Second),
                                                                          "Behavioural Group" = CONST('FINANCIAL')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Customer Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(Second),
                                                                          "Behavioural Group" = CONST('CUSTOMER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Internal Process Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(Second),
                                                                          "Behavioural Group" = CONST('INTERNAL PROCESS')));
            FieldClass = FlowField;
        }
        field(50033; "Learning Growth Second Half"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(Second),
                                                                          "Behavioural Group" = CONST('LEARNING GROWTH')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "KPI Second Half Aggregate"; Decimal)
        {
            CalcFormula = Sum("HR Appraisal Goal Setting L".Weight WHERE("Evaluation Type" = CONST(KPI),
                                                                          "Appraisal No" = FIELD("Appraisal No"),
                                                                          "Appraisal Period" = FIELD("Appraisal Period"),
                                                                          Half = CONST(Second)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Appraisal Half"; Option)
        {
            // OptionCaption = ' ,First,Second';  //jj271022
            // OptionMembers = " ",First,Second;    //jj271022
            OptionCaption = ' ,First,Second,Third,Fourth';
            OptionMembers = " ",First,Second,Third,Fourth;
        }
        field(50036; Queried; Boolean)
        {
        }
        field(50037; "Proposed Grade"; Code[20])
        {
            TableRelation = "Salary Grades";
        }
        field(50038; "Current Location"; Code[50])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("Appraisal No"),
                                                                       Status = CONST(Open)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50039; Comment1; Text[250])
        {
        }
        field(50040; Comment2; Text[250])
        {
        }
        field(50041; Comment3; Text[250])
        {
        }
        field(50042; Comment4; Text[250])
        {
        }
        field(50043; "Desired Department"; Code[20])
        {
            Caption = 'Desired department to change to';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50044; "Date Of Last Promotion/Notch"; Date)
        {
        }
        field(50045; "Time In Present Position"; Text[7])
        {
        }
        field(50046; "Membership of Prof. Bodies"; Text[10])
        {
        }
        field(50047; Qualifications; Text[10])
        {
        }
        field(50048; "New Qualification in last 1 yr"; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        HRGoalSettingL.SetRange(HRGoalSettingL."Appraisal No", "Appraisal No");
        if HRGoalSettingL.Find('-') then
            HRGoalSettingL.DeleteAll;
    end;

    trigger OnInsert()
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Appraisal No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Nos");
            NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos", xRec."No Series", 0D, "Appraisal No", "No Series");
        end;

        "Appraisal Date" := Today;
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            "Employee No" := HREmp."No.";
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Job Title" := HREmp."Job Title";
            "Contract Type" := HREmp."Contract Type";
            "Salary Grade" := HREmp.Grade;
            Step := HREmp."Job Level";   //this is wrong  //ok now
            "User ID" := UserId;
            //Supervisor:=HREmpF.GetSupervisor("User ID");
            HREmp.Get(HREmp."No.");
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
            //"Appraisal Period":=HRSetup."Appraisal Period";

            UserSetup.Get(UserId);
            "Responsibility Center" := UserSetup."Responsibility Center";
            Unit := HREmp."Global Dimension 2 Code";

            Supervisor := GetSupervisor("User ID");
            Emp.SetRange(Emp."User ID", Supervisor);
            if Emp.FindFirst then
                "Supervisor's Job Title" := Emp."Supervisor's Job Title";


            Department := HREmp."Department Code";
        end else begin
            Error('User ID' + ' ' + UserId + ' ' + 'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;


        if Step in ['LEVEL 1', 'LEVEL 2', 'LEVEL 3', 'LEVEL 4', 'LEVEL 5'] then
            Level := Level::"1-4"
        else
            if Step in ['LEVEL 6', 'LEVEL 7', 'LEVEL 8', 'AS', 'SNR-AS', 'CS'] then
                Level := Level::"5-8";

        //get Planned Obj
        //AddObjectives;

        //put the open appraisal period
        HRLookUpValues.Reset;
        HRLookUpValues.SetRange(HRLookUpValues.Type, HRLookUpValues.Type::"Appraisal Period");
        HRLookUpValues.SetRange(HRLookUpValues.Closed, false);
        HRLookUpValues.SetRange(HRLookUpValues."Current Appraisal Period", true);
        if HRLookUpValues.FindFirst then begin
            "Appraisal Period" := HRLookUpValues.Code;
            "Company Score" := HRLookUpValues.Score;
        end
        else
            if Confirm('There are no open Appraisal Periods, Do you want to proceed?', false) then exit;

        //get Planned Obj
        AddObjectives;
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRAppraisalRatings: Record "HR Appraisal Career Dev";
        HRAppraisalGoalSettingH: Record "HR Appraisal Goal Setting H";
        HRGoalSettingL: Record "HR Appraisal Goal Setting L";
        HRGoalSettingLNext: Record "HR Appraisal Goal Setting L";
        HRLookUpValues: Record "HR Lookup Values";
        LastAppraisal: Record "HR Appraisal Goal Setting H";
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";
        UserSetup: Record "User Setup";
        Approver: Record "User Setup";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;
        HRAppraisalGoal: Record "HR Appraisal Goal Setting H";
        HRDisciplinaryCases: Record "HR Disciplinary Cases";
        ApprovalUserSetup: Record "Approval User Setup";
        Emp: Record "HR Employees";
        HRAppraisalCareerDev: Record "HR Appraisal Career Dev";
        HRAppCareerDevTemplate: Record "HR App Career Dev Template";

    [Scope('OnPrem')]
    procedure CalcTotals()
    var
        Employee: Record "HR Employees";
        Job: Record "HR Jobs";
    begin
        /*//CALCFIELDS("Performance Score Appraisee","KPIs Appraisee Score");
        //"Overall Appraisee Score":="Bonus Point appraisee"+"Performance Score Appraisee"+"KPIs Appraisee Score";
        
        //CALCFIELDS("Performance Score Appraiser","KPIs Appraiser Score");
        //"Overall Appraiser Score":="Bonus Point Appraiser"+"Performance Score Appraiser"+"KPIs Appraiser Score";
        
        //CALCFIELDS("Performance Score Mgt","KPIs Mgt Score");
        //"Overall Mgt Score":="Bonus Point Mgt"+"Performance Score Mgt"+"KPIs Mgt Score";
        
        CompanyScoreAppraisee:=("Company Score"/100)*40;
        
        CALCFIELDS("KPIs Appraisee Score");
        KPIScoreAppraisee:=("KPIs Appraisee Score"/100)*30;
        
        CALCFIELDS("KPIs Appraiser Score");
        KPIScoreAppraiser:=("KPIs Appraiser Score"/100)*30;
        
        CALCFIELDS("KPIs Mgt Score");
        KPIScoreMgt:=("KPIs Mgt Score"/100)*30;
        
        PFBase:=44;
        IF Employee.GET("Employee No") THEN
          IF Job.GET(Employee."Job Title") THEN
          //IF Employee.Supervisor=TRUE THEN
          IF Job."Is Supervisor" = TRUE THEN
            PFBase:=64;
        
        CALCFIELDS("Performance Score Appraisee");
        PFScoreAppraisee:=("Performance Score Appraisee"/PFBase)*30;
        
        CALCFIELDS("Performance Score Appraiser");
        PFScoreAppraiser:=("Performance Score Appraiser"/PFBase)*30;
        
        CALCFIELDS("Performance Score Mgt");
        PFScoreMgt:=("Performance Score Mgt"/PFBase)*30;
        
        
        "Overall Appraisee Score":=CompanyScoreAppraisee + KPIScoreAppraisee + PFScoreAppraisee;
        
        "Overall Appraiser Score":="Bonus Point Appraiser"+CompanyScoreAppraisee+KPIScoreAppraiser+PFScoreAppraiser;
        
        "Overall Mgt Score":="Bonus Point Mgt"+CompanyScoreAppraisee+KPIScoreMgt+PFScoreMgt;
        
        IF "Overall Mgt Score">=90  THEN
           //IF  "Overall Mgt Score"<100 then
            "Overal Rating Desc":='A*'
            //end
         ELSE IF "Overall Mgt Score">=75 THEN
             "Overal Rating Desc":='A'
         ELSE IF "Overall Mgt Score">=60 THEN
             "Overal Rating Desc":='B'
         ELSE IF "Overall Mgt Score">=50 THEN
             "Overal Rating Desc":='C'
         ELSE IF "Overall Mgt Score"<50 THEN
             "Overal Rating Desc":='D';
            */

    end;

    local procedure AddObjectives()
    var
        HRAppraisalGoalSettingL: Record "HR Appraisal Goal Setting L";
        HRAppraisalObjTemplate: Record "HR Appraisal Obj Template";
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HRAppraisalCareerDev: Record "HR Appraisal Career Dev";
    begin
        //HRAppraisalObjTemplate.SETRANGE(HRAppraisalObjTemplate.Department,Rec.Department);
        HRSetup.Get;
        HRAppraisalObjTemplate.SetRange(HRAppraisalObjTemplate.Level, Rec.Level);
        if HRAppraisalObjTemplate.FindFirst then begin
            repeat
                HRAppraisalGoalSettingL.Init;
                HRAppraisalGoalSettingL."Appraisal No" := Rec."Appraisal No";
                HRAppraisalGoalSettingL."Appraisal Period" := Rec."Appraisal Period";
                HRAppraisalGoalSettingL."Planned Targets/Objectives" := HRAppraisalObjTemplate.Criteria;
                HRAppraisalGoalSettingL.Description := HRAppraisalObjTemplate.Description;
                HRAppraisalGoalSettingL."Behavioural Group" := HRAppraisalObjTemplate."Behavioural Category";
                HRAppraisalGoalSettingL."Evaluation Type" := HRAppraisalGoalSettingL."Evaluation Type"::Behavioural;
                HRAppraisalGoalSettingL.Weight := HRAppraisalObjTemplate."Weigthed Score";
                HRAppraisalGoalSettingL.Half := "Appraisal Half";
                HRAppraisalGoalSettingL.Insert(true);
            until HRAppraisalObjTemplate.Next = 0;
        end;

        //Added
        HRAppCareerDevTemplate.Reset;
        HRAppCareerDevTemplate.SetRange(HRAppCareerDevTemplate.Type, HRAppCareerDevTemplate.Type::"Career Development");
        if HRAppCareerDevTemplate.FindFirst then begin
            repeat
                HRAppraisalCareerDev.Init;
                HRAppraisalCareerDev."Appraisal Code" := Rec."Appraisal No";
                HRAppraisalCareerDev."Employee No." := Rec."Employee No";
                HRAppraisalCareerDev."Appraisal Period" := Rec."Appraisal Period";
                HRAppraisalCareerDev."Appraisal Half" := "Appraisal Half";
                HRAppraisalCareerDev.Question := HRAppCareerDevTemplate.Description;
                HRAppraisalCareerDev."Line No." := 0;
                HRAppraisalCareerDev.Insert;
            until HRAppCareerDevTemplate.Next = 0;
        end;
        //Added

        HRAppCareerDevTemplate.Reset;
        HRAppCareerDevTemplate.SetRange(HRAppCareerDevTemplate.Type, HRAppCareerDevTemplate.Type::"Self Evaluation");
        if HRAppCareerDevTemplate.FindFirst then begin
            repeat
                HRAppraisalEvaluations.Init;
                HRAppraisalEvaluations."Appraisal No." := Rec."Appraisal No";
                HRAppraisalEvaluations."Appraisal Period" := Rec."Appraisal Period";
                HRAppraisalEvaluations."Line No" := 0;
                HRAppraisalEvaluations.Description := HRAppCareerDevTemplate.Description;
                HRAppraisalEvaluations.Insert;
            until HRAppCareerDevTemplate.Next = 0;
        end;
    end;

    local procedure GetSupervisor(userI: Code[50]) ApproverID: Code[50]
    begin
        ApprovalUserSetup.Reset;
        ApprovalUserSetup.SetCurrentKey(ApprovalUserSetup."Sequence No.");
        ApprovalUserSetup.SetRange(ApprovalUserSetup."User ID", userI);
        if ApprovalUserSetup.FindFirst then
            ApproverID := ApprovalUserSetup."Approver ID"
        else
            Error('No approver setup for this user %1,please contact system administrator');
    end;
}

