page 51534486 "HR Employee-List PR"
{
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Employee-List PR';
    UsageCategory = Lists;
    SourceTable = "HR Employee PR";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = FILTER(Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field(Initials; Initials)
                {
                    ApplicationArea = all;
                }
                field("Length Of Service"; "Length Of Service")
                {
                    ApplicationArea = all;
                }
                field("Date Of Join"; "Date Of Join")
                {
                    ApplicationArea = all;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = all;
                }
                field("Postal Address"; "Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Postal Address2"; "Postal Address2")
                {
                    ApplicationArea = all;
                }
                field("Postal Address3"; "Postal Address3")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; "Residential Address")
                {
                    ApplicationArea = all;
                }
                field("Residential Address2"; "Residential Address2")
                {
                    ApplicationArea = all;
                }
                field("Residential Address3"; "Residential Address3")
                {
                    ApplicationArea = all;
                }
                field("Post Code2"; "Post Code2")
                {
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    ApplicationArea = all;
                }
                field(County; County)
                {
                    ApplicationArea = all;
                }
                field("Home Phone Number"; "Home Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Cellular Phone Number"; "Cellular Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Ext."; "Ext.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; "ID Number")
                {
                    ApplicationArea = all;
                }
                field("Union Code"; "Union Code")
                {
                    ApplicationArea = all;
                }
                field("UIF Number"; "UIF Number")
                {
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = all;
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field(Office; Office)
                {
                    ApplicationArea = all;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("Fax Number"; "Fax Number")
                {
                    ApplicationArea = all;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Title; Title)
                {
                    ApplicationArea = all;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                }
                field("Known As"; "Known As")
                {
                    ApplicationArea = all;
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                }
                field("Full / Part Time"; "Full / Part Time")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = all;
                }
                field("Contract End Date"; "Contract End Date")
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                }
                field("Union Member?"; "Union Member?")
                {
                    ApplicationArea = all;
                }
                field("Shift Worker?"; "Shift Worker?")
                {
                    ApplicationArea = all;
                }
                field("Contracted Hours"; "Contracted Hours")
                {
                    ApplicationArea = all;
                }
                field("Pay Period"; "Pay Period")
                {
                    ApplicationArea = all;
                }
                field("Cost Code"; "Cost Code")
                {
                    ApplicationArea = all;
                }
                field("PAYE Number"; "PAYE Number")
                {
                    ApplicationArea = all;
                }
                field("UIF Contributor?"; "UIF Contributor?")
                {
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = all;
                }
                field("Ethnic Origin"; "Ethnic Origin")
                {
                    ApplicationArea = all;
                }
                field("First Language (R/W/S)"; "First Language (R/W/S)")
                {
                    ApplicationArea = all;
                }
                field("Driving Licence"; "Driving Licence")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration Number"; "Vehicle Registration Number")
                {
                    ApplicationArea = all;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = all;
                }
                field("Health Assesment?"; "Health Assesment?")
                {
                    ApplicationArea = all;
                }
                field("Health Assesment Date"; "Health Assesment Date")
                {
                    ApplicationArea = all;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = all;
                }
                field(Age; Age)
                {
                    ApplicationArea = all;
                }
                field("End Of Probation Date"; "End Of Probation Date")
                {
                    ApplicationArea = all;
                }
                field("Pension Scheme Join"; "Pension Scheme Join")
                {
                    ApplicationArea = all;
                }
                field("Time Pension Scheme"; "Time Pension Scheme")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Join"; "Medical Scheme Join")
                {
                    ApplicationArea = all;
                }
                field("Time Medical Scheme"; "Time Medical Scheme")
                {
                    ApplicationArea = all;
                }
                field("Date Of Leaving"; "Date Of Leaving")
                {
                    ApplicationArea = all;
                }
                field(Paterson; Paterson)
                {
                    ApplicationArea = all;
                }
                field(Peromnes; Peromnes)
                {
                    ApplicationArea = all;
                }
                field(Hay; Hay)
                {
                    ApplicationArea = all;
                }
                field(Castellion; Castellion)
                {
                    ApplicationArea = all;
                }
                field("Allow Overtime"; "Allow Overtime")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme No."; "Medical Scheme No.")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Head Member"; "Medical Scheme Head Member")
                {
                    ApplicationArea = all;
                }
                field("Number Of Dependants"; "Number Of Dependants")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Name"; "Medical Scheme Name")
                {
                    ApplicationArea = all;
                }
                field("Receiving Car Allowance ?"; "Receiving Car Allowance ?")
                {
                    ApplicationArea = all;
                }
                field("Second Language (R/W/S)"; "Second Language (R/W/S)")
                {
                    ApplicationArea = all;
                }
                field("Additional Language"; "Additional Language")
                {
                    ApplicationArea = all;
                }
                field("Cell Phone Reimbursement?"; "Cell Phone Reimbursement?")
                {
                    ApplicationArea = all;
                }
                field("Amount Reimbursed"; "Amount Reimbursed")
                {
                    ApplicationArea = all;
                }
                field("UIF Country"; "UIF Country")
                {
                    ApplicationArea = all;
                }
                field("Direct/Indirect"; "Direct/Indirect")
                {
                    ApplicationArea = all;
                }
                field("Primary Skills Category"; "Primary Skills Category")
                {
                    ApplicationArea = all;
                }
                field(Level; Level)
                {
                    ApplicationArea = all;
                }
                field("Termination Category"; "Termination Category")
                {
                    ApplicationArea = all;
                }
                field("Job Specification"; "Job Specification")
                {
                    ApplicationArea = all;
                }
                field(DateOfBirth; DateOfBirth)
                {
                    ApplicationArea = all;
                }
                field(DateEngaged; DateEngaged)
                {
                    ApplicationArea = all;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = all;
                }
                field("Name Of Manager"; "Name Of Manager")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Disabling Details"; "Disabling Details")
                {
                    ApplicationArea = all;
                }
                field("Disability Grade"; "Disability Grade")
                {
                    ApplicationArea = all;
                }
                field("Passport Number"; "Passport Number")
                {
                    ApplicationArea = all;
                }
                field("2nd Skills Category"; "2nd Skills Category")
                {
                    ApplicationArea = all;
                }
                field("3rd Skills Category"; "3rd Skills Category")
                {
                    ApplicationArea = all;
                }
                field(PensionJoin; PensionJoin)
                {
                    ApplicationArea = all;
                }
                field(DateLeaving; DateLeaving)
                {
                    ApplicationArea = all;
                }
                field(Region; Region)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*
        IF (DepCode <> '') THEN
           SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
           SETFILTER(Office, ' = %1', OfficeCode);
             */

    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[20];
        OfficeCode: Code[20];

    [Scope('OnPrem')]
    procedure SetNewFilter(var DepartmentCode: Code[20]; var "Office Code": Code[20])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

