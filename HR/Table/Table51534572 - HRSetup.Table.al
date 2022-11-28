table 51534572 "HR Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Employee Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Training Application Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(4; "Leave Application Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Disciplinary Cases Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Base Calendar"; Code[20])
        {
            TableRelation = "Base Calendar";
        }
        field(13; "Transport Req Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Employee Requisition Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(15; "Leave Posting Period[FROM]"; Date)
        {
        }
        field(16; "Leave Posting Period[TO]"; Date)
        {
        }
        field(17; "Job Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Exit Interview Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Appraisal Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Company Activities"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21; "Default Leave Posting Template"; Code[20])
        {
            TableRelation = "HR Leave Journal Batch"."Journal Template Name";
        }
        field(22; "Default Leave Posting Batch"; Code[20])
        {
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(23; "Leave Template"; Code[20])
        {
            TableRelation = "HR Leave Journal Batch"."Journal Template Name";
        }
        field(24; "Leave Batch"; Code[20])
        {
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(25; "Job Interview Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "Ticket Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(27; "Career Event"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(28; "Loan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Annual Leave Qualification"; Code[20])
        {
        }
        field(30; "Meal Amount"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(31; "Leave Allowance Days"; Integer)
        {
        }
        field(32; "Training Need Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(33; "Leave Acknowledgement Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(34; "Forfeit Leave After"; Date)
        {
        }
        field(35; "Current Leave Period"; Code[20])
        {
            TableRelation = "HR Leave Periods"."Period Code";
        }
        field(36; "Employee ID Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "Transaction Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(38; "Loan Amount %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(39; "Current Path"; Text[100])
        {
        }
        field(40; "Maternity Leave Period"; Code[20])
        {
        }
        field(41; "Appraisal Period"; Code[20])
        {
        }
        field(42; "First Half Closed"; Boolean)
        {
            Editable = false;
        }
        field(43; "Second Half Closed"; Boolean)
        {
            Editable = false;
        }
        field(44; "Working Days"; Integer)
        {
            Description = 'Total number of working days in a month';
        }
        field(45; "Company's Group Email"; Text[50])
        {
        }
        field(46; "Shared Document  Path"; Text[150])
        {
        }
        field(47; "Confirmation Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(48; "Open Period"; Boolean)
        {
        }
        field(49; "Leave Application Before"; Integer)
        {
        }
        field(50; "Maternity Application Before"; Integer)
        {
        }
        field(51; "Training Application Before"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

