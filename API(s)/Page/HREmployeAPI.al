page 51534396 "HR Employe API"
{
    APIGroup = 'Employee';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'hrEmployeAPI';
    DelayedInsert = true;
    EntityName = 'HRemployee';
    EntitySetName = 'HREmployeeApi';
    PageType = API;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(firstName; Rec."First Name")
                {
                    Caption = 'First Name';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
            }
        }
    }
}
