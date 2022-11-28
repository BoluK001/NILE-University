page 51534389 EmployeeAPI
{
    APIGroup = 'Employee';
    APIPublisher = 'Reeltech';
    APIVersion = 'v1.0';
    Caption = 'employeeAPI';
    DelayedInsert = true;
    EntityName = 'Employee';
    EntitySetName = 'Employees';
    PageType = API;
    SourceTable = Employee;
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(jobTitle; Rec."Job Title")
                {
                    Caption = 'Job Title';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
                field(managerNo; Rec."Manager No.")
                {
                    Caption = 'Manager No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
