/// <summary>
/// Table StudentDetails (ID 50100).
/// </summary>
table 51534410 StudentDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; IntegrationStatus; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; StudentNo; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; FullName; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Country; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Post Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Telephone No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Mobile No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "E-Mail"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Category; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Date Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Last Date Modified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Created on BC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Number Of Semesters Done"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Remaining Semester"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Level Of Study"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Bank Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Bank Account Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Record Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Integration Status"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Customer Id"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "MiscRef1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "MiscRef2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "MiscRef3"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "MiscRef4"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "User ID"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Error Description"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Prospective Id"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Stud_ID"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Gender"; Option)
        {
            OptionMembers = Male,Female;
            DataClassification = ToBeClassified;
        }
        field(36; "Department"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Faculty"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Current Year Of Study"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Programme Duration"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Relief Rate"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Relief Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Relief Type2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Student Statuse"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Birth_Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Other_Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Enrollment Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; id)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}