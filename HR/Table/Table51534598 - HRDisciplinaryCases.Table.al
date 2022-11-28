table 51534598 "HR Disciplinary Cases"
{
    LookupPageID = "HR Disciplinary Cases List";

    fields
    {
        field(1; "Case Number"; Code[20])
        {

        }
        field(3; "Date of Complaint"; Date)
        {
        }
        field(4; "Type of Disciplinary Case"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Disciplinary Case"));
        }
        field(5; "Recommended Action"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));
        }
        field(6; "Case Description"; Text[250])
        {
        }
        field(7; Accuser; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(8; "Witness #1"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(9; "Witness #2"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = CONST("Disciplinary Action"));
        }
        field(11; "Date To Discuss Case"; Date)
        {
        }
        field(12; "Document Link"; Text[200])
        {
        }
        field(13; "Disciplinary Remarks"; Code[50])
        {
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Case Discussion"; Boolean)
        {
        }
        field(16; "Body Handling The Complaint"; Code[20])
        {
        }
        field(17; Recomendations; Option)
        {
            OptionCaption = ' ,Warning,Suspension';
            OptionMembers = " ",Warning,Suspension;
        }
        field(18; "HR/Payroll Implications"; Integer)
        {
        }
        field(19; "Support Documents"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(20; "Policy Guidlines In Effect"; Code[20])
        {
            TableRelation = "HR Policies".Code;
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        }
        field(22; "Mode of Lodging the Complaint"; Text[30])
        {
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(24; "Employee No"; Code[30])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if Emp.Get("Employee No") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(25; Selected; Boolean)
        {
        }
        field(26; "Closed By"; Code[20])
        {
        }
        field(3963; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(3964; "Employee Name"; Text[100])
        {
        }
        field(3965; "Supervisor No."; Code[50])
        {
        }
        field(3966; "Supervisor Name"; Text[100])
        {
        }
        field(3967; "Disciplinary Action Taken"; Option)
        {
            OptionCaption = ' ,Dismissal,Termination,Financial Sanction';
            OptionMembers = " ",Dismissal,Termination,"Financial Sanction";
        }
        field(3968; "Send to Hr"; Boolean)
        {
        }
        field(3969; "Send to Others"; Boolean)
        {
        }
        field(3970; "Query"; Boolean)
        {
        }
        field(3971; "Query Body"; Text[250])
        {
        }
        field(3972; "User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(3973; "Query Date"; Date)
        {
        }
        field(3974; "Appraisal Period"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Case Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //GENERATE NEW NUMBER FOR THE DOCUMENT
        if "Case Number" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Disciplinary Cases Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Disciplinary Cases Nos.", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;

        if UserSetup.Get(UserId) then begin
            HrEmp.SetRange("User ID", UserId);
            if HrEmp.FindFirst then begin
                "Supervisor No." := HrEmp."No.";
                "Supervisor Name" := HrEmp."First Name" + ' ' + HrEmp."Last Name" + ' ' + HrEmp."Last Name";
            end;
        end;

        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        if Status = Status::"Pending Approval" then
            Error('You cannot modify a closed case');
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Emp: Record "HR Employees";
        UserSetup: Record "User Setup";
        HrEmp: Record "HR Employees";
}

