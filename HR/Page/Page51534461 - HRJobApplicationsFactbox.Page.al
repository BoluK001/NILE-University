page 51534461 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Job Applications";

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Application No"; "Application No")
            {
                ApplicationArea = all;
            }
            field("Date Applied"; "Date Applied")
            {
                ApplicationArea = all;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = all;
            }
            field("Middle Name"; "Middle Name")
            {
                ApplicationArea = all;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = all;
            }
            field(Qualified; Qualified)
            {
                ApplicationArea = all;
            }
            field("Interview Invitation Sent"; "Interview Invitation Sent")
            {
                ApplicationArea = all;
            }
            field("ID Number"; "ID Number")
            {
                ApplicationArea = all;
            }
            field(PersonalInfo; PersonalInfo)
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
            }
            field(Age; Age)
            {
                ApplicationArea = all;
            }
            field("Marital Status"; "Marital Status")
            {
                ApplicationArea = all;
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Cell Phone Number"; "Cell Phone Number")
            {
                ApplicationArea = all;
                ExtendedDatatype = PhoneNo;
            }
            field("E-Mail"; "E-Mail")
            {
                ExtendedDatatype = EMail;
                ApplicationArea = all;
            }
            field("Work Phone Number"; "Work Phone Number")
            {
                ApplicationArea = all;
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: Label 'General Applicant Information';
        PersonalInfo: Label 'Personal Infomation';
        CommunicationInfo: Label 'Communication Information';
}

