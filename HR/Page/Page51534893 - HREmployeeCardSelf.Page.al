page 51534893 "HR Employee Card Self"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("No."; "No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("ID Number"; "ID Number")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Passport Number"; "Passport Number")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Citizenship; Citizenship)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Citizenship Text"; "Citizenship Text")
                {
                    Caption = 'Country / Region Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department Code"; "Department Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Caption = '<Global Dimension 2 Code>';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Title; Title)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Postal Address"; "Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; "Residential Address")
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
                field(Picture; Picture)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SupervisorNames := GetSupervisor("User ID");
                    end;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Supervisor/Manager"; "Supervisor/Manager")
                {
                    Caption = 'Supervisor ID';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Emp: Record "HR Employees";
                    begin
                        Emp.SetRange("User ID", "Supervisor/Manager");
                        if Emp.FindFirst then begin
                            SupervisorNames := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
                            "Supervisor's Job Title" := Emp."Job Title";
                        end;
                    end;
                }
                field(SupervisorNames; SupervisorNames)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Supervisor's Job Title"; "Supervisor's Job Title")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Available; Available)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Home Phone Number"; "Home Phone Number")
                {
                    Editable = true;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    Editable = true;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Fax Number"; "Fax Number")
                {
                    Editable = false;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    Editable = false;
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = All;
                }
                field("Ext."; "Ext.")
                {
                    Editable = false;
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = All;
                }
                field("Personal E-Mail"; "Personal E-Mail")
                {
                    Editable = false;
                    ExtendedDatatype = EMail;
                    ApplicationArea = All;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    Editable = false;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Gender)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Marital Status"; "Marital Status")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Religion; Religion)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("First Language (R/W/S)"; "First Language (R/W/S)")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("First Language Read"; "First Language Read")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Language Write"; "First Language Write")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("First Language Speak"; "First Language Speak")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Language (R/W/S)"; "Second Language (R/W/S)")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Second Language Read"; "Second Language Read")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Language Write"; "Second Language Write")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Second Language Speak"; "Second Language Speak")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Additional Language"; "Additional Language")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Has Driving Licence"; "Has Driving Licence")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vehicle Registration Number"; "Vehicle Registration Number")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Disabled; Disabled)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Disability Details"; "Disability Details")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Health Assesment?"; "Health Assesment?")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Medical Scheme No."; "Medical Scheme No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Medical Scheme Plan"; "Medical Scheme Plan")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Medical Sch. Hospital Code"; "Medical Sch. Hospital Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Medical Scheme Hospital"; "Medical Scheme Hospital")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Number Of Dependants"; "Number Of Dependants")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-"; "-")
                {
                    ApplicationArea = all;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; "Main Bank")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Branch Bank"; "Branch Bank")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Bank Account Number"; "Bank Account Number")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; "Date Of Birth")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if "Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        DAge := Dates.DetermineAge("Date Of Birth", Today);
                    end;
                }
                field(DAge; DAge)
                {
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Date Of Joining the Company"; "Date Of Joining the Company")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DService := Dates.DetermineAge("Date Of Joining the Company", Today);
                    end;
                }
                field(DService; DService)
                {
                    Caption = 'Length of Service';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Probation Date 3mnths"; "Probation Date 3mnths")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Confirmation Date"; "Confirmation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Probation Form Filled"; "Probation Form Filled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Confirmation Form Filled"; "Confirmation Form Filled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("End of Probation Date"; "End of Probation Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Pension Scheme Join Date"; "Pension Scheme Join Date")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
                    end;
                }
                field(DPension; DPension)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Medical Scheme Join Date"; "Medical Scheme Join Date")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
                    end;
                }
                field(DMedical; DMedical)
                {
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Wedding Anniversary"; "Wedding Anniversary")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job Title"; "Job Title")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Job Description"; "Job Description")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Grade; Grade)
                {
                    Editable = false;
                    Importance = Promoted;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Level"; "Job Level")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Resource Type"; "Resource Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Group"; "Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Salary Step"; "Salary Step")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if not Confirm('Changing the Grade will affect the Basic Salary and the salary notch\step transactions. ' +
                                        'Do you wish to continue?', false) then begin
                            "Salary Step" := '';
                            Error('You have opted to abort the process.');

                        end;
                    end;
                }
                field("Employee Classification"; "Employee Classification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll Filter Group"; "Payroll Filter Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Employment Type"; "Employment Type")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Contract Type"; "Contract Type")
                {
                    Editable = false;
                    Importance = Promoted;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Contract End Date"; "Contract End Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Notice Period"; "Notice Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Send Alert to"; "Send Alert to")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Full / Part Time"; "Full / Part Time")
                {
                    Editable = false;
                    Importance = Promoted;
                    Visible = true;
                    ApplicationArea = All;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN Number"; "PIN Number")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Pension Fund Administrator"; "Pension Fund Administrator")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("NSSF No."; "NSSF No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("NHIF No."; "NHIF No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; "Date Of Leaving the Company")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Termination Grounds"; "Termination Grounds")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; "Exit Interview Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Exit Interview Done by"; "Exit Interview Done by")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                field("Reimbursed Leave Days"; "Reimbursed Leave Days")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Allocated Leave Days"; "Allocated Leave Days")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Total (Leave Days)"; "Total (Leave Days)")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Total Leave Taken"; "Total Leave Taken")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Leave Balance"; "Leave Balance")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Acrued Leave Days"; "Acrued Leave Days")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Cash per Leave Day"; "Cash per Leave Day")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Cash - Leave Earned"; "Cash - Leave Earned")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Leave Status"; "Leave Status")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Leave Type Filter"; "Leave Type Filter")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Leave Period Filter"; "Leave Period Filter")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(LastLeaveCode; LastLeaveCode)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = all;
            }
            systempart(Control1102755002; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Personal Information File")
                {
                    Caption = 'Personal Information File';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(51534516,,FALSE,HREmp);
                        
                         */
                        Reset;
                        SetFilter("No.", "No.");
                        REPORT.Run(51534690, true, true, Rec);
                        Reset;

                    end;
                }
                action("Assigned Item Info")
                {
                    Caption = 'Assigned Item Info';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Report "Employee - Misc. Article Info.";
                    Visible = false;

                    trigger OnAction()
                    begin
                        Misc.Reset;
                        Misc.SetRange(Misc."Employee No.", "No.");
                        if Misc.Find('-') then
                            REPORT.Run(5202, true, true, Misc);
                    end;
                }
                action("Confidential Info")
                {
                    Caption = 'Confidential Info';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Conf.Reset;
                        Conf.SetRange(Conf."Employee No.", "No.");
                        if Conf.Find('-') then
                            REPORT.Run(5203, true, true, Conf);
                    end;
                }
                action(Label)
                {
                    Caption = 'Label';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            REPORT.Run(5200, true, true, HREmp);
                    end;
                }
                action(Addresses)
                {
                    Caption = 'Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            REPORT.Run(5207, true, true, HREmp);
                    end;
                }
                action("Alt. Addresses")
                {
                    Caption = 'Alt. Addresses';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            REPORT.Run(5213, true, true, HREmp);
                    end;
                }
                action("Phone Nos")
                {
                    Caption = 'Phone Nos';
                    Image = PrintReport;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        HREmp.Reset;
                        HREmp.SetRange(HREmp."No.", "No.");
                        if HREmp.Find('-') then
                            REPORT.Run(5210, true, true, HREmp);
                    end;
                }
                action("Value Change Report")
                {
                    Caption = 'Value Change Report';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        HRValueChange.Reset;
                        HRValueChange.SetRange(HRValueChange."Employee No", "No.");
                        if HRValueChange.Find('-') then
                            REPORT.Run(51534510, true, true, HRValueChange)
                        else
                            Error('No value changes have been recorded for this employee');
                    end;
                }
            }
            group("&Functions")
            {
                Caption = '&Functions';
                action("Update Payroll Data")
                {
                    Caption = 'Update Payroll Data';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        if "Posting Group" = '' then Error('Please specify the posting group for this employee');

                        if Confirm('Update Payroll Data?', true) = false then exit;

                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.FindFirst;

                        repeat

                        begin
                            //CHECK IF EMPLOYEE IS ALREADY IN THE PAYROLL TABLE
                            //IF HE IS MODIFY INFORMATION TO REFLECT ANY CHANGES MADE
                            prEmployees.Reset;
                            prEmployees.SetRange(prEmployees."No.", HREmp."No.");
                            if prEmployees.Find('-') then begin
                                prEmployees."First Name" := HREmp."First Name";
                                prEmployees."Middle Name" := HREmp."Middle Name";
                                prEmployees."Last Name" := HREmp."Last Name";
                                prEmployees.Office := HREmp."Global Dimension 2 Code";
                                prEmployees."Search Name" := HREmp."Search Name";
                                prEmployees."Postal Address" := HREmp."Postal Address";
                                prEmployees."Residential Address" := HREmp."Residential Address";
                                prEmployees.City := HREmp.City;
                                prEmployees."Post Code" := HREmp."Post Code";
                                prEmployees.County := HREmp.County;
                                prEmployees."Home Phone Number" := HREmp."Home Phone Number";
                                prEmployees."Work Phone Number" := HREmp."Work Phone Number";
                                prEmployees."Ext." := HREmp."Ext.";
                                prEmployees."E-Mail" := HREmp."Personal E-Mail";
                                prEmployees."ID Number" := HREmp."ID Number";
                                HREmp.Get(HREmp."No.");
                                HREmp.CalcFields(HREmp.Picture);
                                prEmployees.Picture := HREmp.Picture;
                                prEmployees."Union Code" := HREmp."Union Code";
                                prEmployees."UIF Number" := HREmp."UIF Number";
                                prEmployees.Gender := HREmp.Gender;
                                prEmployees.Status := HREmp.Status;
                                prEmployees."Salary Grade" := HREmp."Salary Grade";
                                prEmployees."Salary Notch/Step" := HREmp."Salary Step";
                                prEmployees."Department Code" := HREmp."Department Code";
                                prEmployees."Payment Mode" := HREmp."Payment Mode";
                                prEmployees."Payroll Filter Group" := HREmp."Payroll Filter Group";
                                prEmployees."Resource No." := HREmp."Resource No.";
                                prEmployees."Last Date Modified" := HREmp."Last Date Modified";
                                prEmployees."Fax Number" := HREmp."Fax Number";
                                prEmployees."Company E-Mail" := HREmp."Company E-Mail";
                                prEmployees.Title := HREmp.Title;
                                prEmployees."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                prEmployees."No. Series" := HREmp."No. Series";
                                prEmployees."Known As" := HREmp."Also Known As";
                                prEmployees."Full / Part Time" := HREmp."Full / Part Time";
                                prEmployees."Contract End Date" := HREmp."Contract End Date";
                                prEmployees."Notice Period" := HREmp."Notice Period";
                                prEmployees."Union Member?" := HREmp."Is Union Member";
                                prEmployees."Shift Worker?" := HREmp."Is Shift Worker";
                                prEmployees."Contracted Hours" := HREmp."Contracted Hours";
                                prEmployees."Pay Period" := HREmp."Pay Period";
                                prEmployees."Pay Per Period" := HREmp."Pay Per Period";
                                prEmployees."Cost Code" := HREmp."Cost Code";
                                prEmployees."PAYE Number" := HREmp."PAYE Number";
                                prEmployees."Marital Status" := HREmp."Marital Status";
                                prEmployees."Ethnic Origin" := HREmp."Ethnic Origin";
                                prEmployees."First Language (R/W/S)" := HREmp."First Language (R/W/S)";
                                prEmployees."Vehicle Registration Number" := HREmp."Vehicle Registration Number";
                                prEmployees.Disabled := HREmp.Disabled;
                                prEmployees."Health Assesment?" := HREmp."Health Assesment?";
                                prEmployees."Health Assesment Date" := HREmp."-";
                                prEmployees."Date Of Birth" := HREmp."Date Of Birth";
                                prEmployees.Age := HREmp.Age;
                                prEmployees."Date Of Join" := HREmp."Date Of Joining the Company";
                                prEmployees."Length Of Service" := HREmp."Length Of Service";
                                prEmployees."End Of Probation Date" := HREmp."End of Probation Date";
                                prEmployees."Branch Bank" := HREmp."Branch Bank";
                                prEmployees."Main Bank" := HREmp."Main Bank";
                                prEmployees."Bank Account Number" := HREmp."Bank Account Number";
                                prEmployees."Per Annum" := HREmp."Per Annum";
                                prEmployees."Allow Overtime" := HREmp."Allow Overtime";
                                prEmployees."Medical Scheme No." := HREmp."Medical Scheme No.";
                                prEmployees."Medical Scheme Plan" := HREmp."Medical Scheme Plan";
                                prEmployees."Number Of Dependants" := HREmp."Number Of Dependants";
                                prEmployees."Medical Scheme Name" := HREmp."Medical Scheme Hospital";
                                prEmployees."Amount Paid By Employee" := HREmp."Amount Paid By Employee";
                                prEmployees."Amount Paid By Company" := HREmp."Amount Paid By Company";
                                prEmployees."Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
                                prEmployees."Additional Language" := HREmp."Additional Language";
                                prEmployees."UIF Country" := HREmp."UIF Country";
                                prEmployees."Primary Skills Category" := HREmp."Primary Skills Category";
                                prEmployees.Level := HREmp.Level;
                                prEmployees."Termination Category" := HREmp."Termination Grounds";
                                prEmployees."Job Specification" := HREmp."Job Title";
                                prEmployees."Postal Address2" := HREmp."Postal Address 2";
                                prEmployees."Postal Address3" := HREmp."Postal Address 3";
                                prEmployees."Residential Address2" := HREmp."Residential Address 2";
                                prEmployees."Residential Address3" := HREmp."Residential Address 3";
                                prEmployees."Post Code2" := HREmp."Post Code 2";
                                prEmployees.Citizenship := HREmp.Citizenship;
                                prEmployees."Name Of Manager" := HREmp."Name Of Manager";
                                prEmployees."User ID" := HREmp."User ID";
                                prEmployees."Disabling Details" := HREmp."Disability Details";
                                prEmployees."Passport Number" := HREmp."Passport Number";
                                prEmployees."2nd Skills Category" := HREmp."2nd Skills Category";
                                prEmployees."3rd Skills Category" := HREmp."3rd Skills Category";
                                prEmployees."Pension House" := HREmp."Pension Fund Administrator";
                                prEmployees.Temp := HREmp.Temp;
                                prEmployees."Contract Location" := HREmp."Contract Location";
                                prEmployees."First Language Read" := HREmp."First Language Read";
                                prEmployees."First Language Write" := HREmp."First Language Write";
                                prEmployees."First Language Speak" := HREmp."First Language Speak";
                                prEmployees."Second Language Read" := HREmp."Second Language Read";
                                prEmployees."Second Language Write" := HREmp."Second Language Write";
                                prEmployees."Second Language Speak" := HREmp."Second Language Speak";
                                prEmployees."Custom Grading" := HREmp."Custom Grading";
                                prEmployees."PIN No." := HREmp."PIN Number";
                                prEmployees."NSSF No." := HREmp."NSSF No.";
                                prEmployees."NHF No." := HREmp."NHIF No.";
                                prEmployees."Cause of Inactivity Code" := HREmp."Cause of Inactivity Code";
                                prEmployees."Payroll Code" := HREmp."No.";
                                prEmployees."HELB No" := HREmp."HELB No";
                                prEmployees."Co-Operative No" := HREmp."Co-Operative No";
                                prEmployees."Wedding Anniversary" := HREmp."Wedding Anniversary";
                                prEmployees."Position To Succeed" := HREmp."Position To Succeed";
                                prEmployees."Succesion Date" := HREmp."Succesion Date";
                                prEmployees."Send Alert to" := HREmp."Send Alert to";
                                prEmployees.Tribe := HREmp.Tribe;
                                prEmployees.Religion := HREmp.Religion;
                                prEmployees."Job Title" := HREmp."Job Description";
                                prEmployees."Posting Group" := HREmp."Posting Group";
                                prEmployees."Payroll Posting Group" := HREmp."Payroll Posting Group";
                                prEmployees."Served Notice Period" := HREmp."Served Notice Period";
                                prEmployees."Exit Interview Date" := HREmp."Exit Interview Date";
                                prEmployees."Exit Interview Done by" := HREmp."Exit Interview Done by";
                                prEmployees."Allow Re-Employment In Future" := HREmp."Allow Re-Employment In Future";
                                prEmployees."Medical Scheme Name #2" := HREmp."Medical Scheme Name #2";
                                prEmployees."Payroll Departments" := HREmp."Payroll Departments";
                                prEmployees.Comment := HREmp.Comment;
                                prEmployees."Competency Area" := HREmp."Competency Area";
                                prEmployees."Employee Qty" := HREmp."Employee Qty";
                                prEmployees."Employee Classification" := HREmp."Employee Classification";
                                prEmployees."Employee Act. Qty" := HREmp."Employee Act. Qty";
                                prEmployees."Employee Arc. Qty" := HREmp."Employee Arc. Qty";
                                prEmployees."Department Code" := HREmp."Department Code";
                                prEmployees.Office := HREmp."Global Dimension 2 Code";
                                prEmployees."Payroll Code" := HREmp."No.";
                                prEmployees.Modify;
                                prEmployees.Validate("No.");

                            end else begin
                                prEmployees.Init;
                                prEmployees."No." := HREmp."No.";
                                prEmployees."First Name" := HREmp."First Name";
                                prEmployees."Middle Name" := HREmp."Middle Name";
                                prEmployees."Last Name" := HREmp."Last Name";
                                prEmployees."Search Name" := HREmp."Search Name";
                                prEmployees."Postal Address" := HREmp."Postal Address";
                                prEmployees."Residential Address" := HREmp."Residential Address";
                                prEmployees.City := HREmp.City;
                                prEmployees."Post Code" := HREmp."Post Code";
                                prEmployees.County := HREmp.County;
                                prEmployees."Home Phone Number" := HREmp."Home Phone Number";
                                prEmployees."Work Phone Number" := HREmp."Work Phone Number";
                                prEmployees."Ext." := HREmp."Ext.";
                                prEmployees."Salary Grade" := HREmp."Salary Grade";
                                prEmployees."Salary Notch/Step" := HREmp."Salary Step";
                                prEmployees."Department Code" := HREmp."Department Code";
                                prEmployees."Payment Mode" := HREmp."Payment Mode";
                                prEmployees."E-Mail" := HREmp."Personal E-Mail";
                                prEmployees."ID Number" := HREmp."ID Number";
                                prEmployees.Picture := HREmp.Picture;
                                prEmployees."Union Code" := HREmp."Union Code";
                                prEmployees."UIF Number" := HREmp."UIF Number";
                                prEmployees.Gender := HREmp.Gender;
                                prEmployees.Status := HREmp.Status;
                                prEmployees."Resource No." := HREmp."Resource No.";
                                prEmployees."Last Date Modified" := HREmp."Last Date Modified";
                                prEmployees."Fax Number" := HREmp."Fax Number";
                                prEmployees."Company E-Mail" := HREmp."Company E-Mail";
                                prEmployees.Title := HREmp.Title;
                                prEmployees."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                prEmployees."No. Series" := HREmp."No. Series";
                                prEmployees."Known As" := HREmp."Also Known As";
                                prEmployees."Full / Part Time" := HREmp."Full / Part Time";
                                prEmployees."Contract End Date" := HREmp."Contract End Date";
                                prEmployees."Notice Period" := HREmp."Notice Period";
                                prEmployees."Union Member?" := HREmp."Is Union Member";
                                prEmployees."Shift Worker?" := HREmp."Is Shift Worker";
                                prEmployees."Contracted Hours" := HREmp."Contracted Hours";
                                prEmployees."Pay Period" := HREmp."Pay Period";
                                prEmployees."Pay Per Period" := HREmp."Pay Per Period";
                                prEmployees."Cost Code" := HREmp."Cost Code";
                                prEmployees."PAYE Number" := HREmp."PAYE Number";
                                prEmployees."Marital Status" := HREmp."Marital Status";
                                prEmployees."Ethnic Origin" := HREmp."Ethnic Origin";
                                prEmployees."First Language (R/W/S)" := HREmp."First Language (R/W/S)";
                                prEmployees."Vehicle Registration Number" := HREmp."Vehicle Registration Number";
                                prEmployees.Disabled := HREmp.Disabled;
                                prEmployees."Health Assesment?" := HREmp."Health Assesment?";
                                prEmployees."Health Assesment Date" := HREmp."-";
                                prEmployees."Date Of Birth" := HREmp."Date Of Birth";
                                prEmployees.Age := HREmp.Age;
                                prEmployees."Date Of Join" := HREmp."Date Of Joining the Company";
                                prEmployees."Length Of Service" := HREmp."Length Of Service";
                                prEmployees."End Of Probation Date" := HREmp."End of Probation Date";
                                prEmployees."Per Annum" := HREmp."Per Annum";
                                prEmployees."Allow Overtime" := HREmp."Allow Overtime";
                                prEmployees."Medical Scheme No." := HREmp."Medical Scheme No.";
                                prEmployees."Medical Scheme Plan" := HREmp."Medical Scheme Plan";
                                prEmployees."Number Of Dependants" := HREmp."Number Of Dependants";
                                prEmployees."Medical Scheme Name" := HREmp."Medical Scheme Hospital";
                                prEmployees."Amount Paid By Employee" := HREmp."Amount Paid By Employee";
                                prEmployees."Amount Paid By Company" := HREmp."Amount Paid By Company";
                                prEmployees."Second Language (R/W/S)" := HREmp."Second Language (R/W/S)";
                                prEmployees."Additional Language" := HREmp."Additional Language";
                                prEmployees."UIF Country" := HREmp."UIF Country";
                                prEmployees."Primary Skills Category" := HREmp."Primary Skills Category";
                                prEmployees.Level := HREmp.Level;
                                prEmployees."Termination Category" := HREmp."Termination Grounds";
                                prEmployees."Job Specification" := HREmp."Job Title";
                                prEmployees."Postal Address2" := HREmp."Postal Address 2";
                                prEmployees."Postal Address3" := HREmp."Postal Address 3";
                                prEmployees."Residential Address2" := HREmp."Residential Address 2";
                                prEmployees."Residential Address3" := HREmp."Residential Address 3";
                                prEmployees."Post Code2" := HREmp."Post Code 2";
                                prEmployees.Citizenship := HREmp.Citizenship;
                                prEmployees."Name Of Manager" := HREmp."Name Of Manager";
                                prEmployees."User ID" := HREmp."User ID";
                                prEmployees."Disabling Details" := HREmp."Disability Details";
                                prEmployees."Passport Number" := HREmp."Passport Number";
                                prEmployees."2nd Skills Category" := HREmp."2nd Skills Category";
                                prEmployees."3rd Skills Category" := HREmp."3rd Skills Category";
                                prEmployees."Pension House" := HREmp."Pension Fund Administrator";
                                prEmployees.Temp := HREmp.Temp;
                                prEmployees."Contract Location" := HREmp."Contract Location";
                                prEmployees."First Language Read" := HREmp."First Language Read";
                                prEmployees."First Language Write" := HREmp."First Language Write";
                                prEmployees."First Language Speak" := HREmp."First Language Speak";
                                prEmployees."Second Language Read" := HREmp."Second Language Read";
                                prEmployees."Second Language Write" := HREmp."Second Language Write";
                                prEmployees."Second Language Speak" := HREmp."Second Language Speak";
                                prEmployees."Custom Grading" := HREmp."Custom Grading";
                                prEmployees."PIN No." := HREmp."PIN Number";
                                prEmployees."NSSF No." := HREmp."NSSF No.";
                                prEmployees."NHF No." := HREmp."NHIF No.";
                                prEmployees."Cause of Inactivity Code" := HREmp."Cause of Inactivity Code";
                                prEmployees."Payroll Code" := HREmp."Payroll No";
                                prEmployees."HELB No" := HREmp."HELB No";
                                prEmployees."Co-Operative No" := HREmp."Co-Operative No";
                                prEmployees."Wedding Anniversary" := HREmp."Wedding Anniversary";
                                prEmployees."Position To Succeed" := HREmp."Position To Succeed";
                                prEmployees."Succesion Date" := HREmp."Succesion Date";
                                prEmployees."Send Alert to" := HREmp."Send Alert to";
                                prEmployees.Tribe := HREmp.Tribe;
                                prEmployees.Religion := HREmp.Religion;
                                prEmployees."Job Title" := HREmp."Job Description";
                                prEmployees."Posting Group" := HREmp."Posting Group";
                                prEmployees."Payroll Posting Group" := HREmp."Payroll Posting Group";
                                prEmployees."Served Notice Period" := HREmp."Served Notice Period";
                                prEmployees."Exit Interview Date" := HREmp."Exit Interview Date";
                                prEmployees."Exit Interview Done by" := HREmp."Exit Interview Done by";
                                prEmployees."Allow Re-Employment In Future" := HREmp."Allow Re-Employment In Future";
                                prEmployees."Medical Scheme Name #2" := HREmp."Medical Scheme Name #2";
                                prEmployees."Payroll Departments" := HREmp."Payroll Departments";
                                prEmployees.Comment := HREmp.Comment;
                                prEmployees."Employee Classification" := HREmp."Employee Classification";
                                prEmployees."Competency Area" := HREmp."Competency Area";
                                prEmployees."Employee Qty" := HREmp."Employee Qty";
                                prEmployees."Payroll Filter Group" := HREmp."Payroll Filter Group";
                                prEmployees."Employee Act. Qty" := HREmp."Employee Act. Qty";
                                prEmployees."Employee Arc. Qty" := HREmp."Employee Arc. Qty";
                                prEmployees."Payroll Code" := HREmp."No.";
                                prEmployees."Department Code" := HREmp."Department Code";
                                prEmployees.Office := HREmp."Global Dimension 2 Code";

                                prEmployees.Insert;
                                prEmployees.Validate("No.");

                                prPayrollType.Reset;
                                prPayrollType.SetRange(prPayrollType."Payroll Code", HREmp."No.");
                                if prPayrollType.Find('-') then begin
                                    prPayrollType."Payroll Code" := HREmp."No.";
                                    prPayrollType."Payroll Name" := HREmp."First Name" + '' + HREmp."Middle Name" + '' + HREmp."Last Name";
                                    prPayrollType.Modify;
                                end else begin
                                    prPayrollType.Init;
                                    prPayrollType."Payroll Code" := HREmp."No.";
                                    prPayrollType."Payroll Name" := HREmp."First Name" + '' + HREmp."Middle Name" + '' + HREmp."Last Name";
                                    prPayrollType.Insert;
                                end;


                            end;

                        end;
                        until HREmp.Next = 0;

                        Message('Payroll data Successfully Updated.');
                    end;
                }
            }
            group("&Employee")
            {
                Caption = '&Employee';
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = All;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("No."),
                                  "Document Type" = CONST(Employee);
                }
                action("Next of Kin")
                {
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    ApplicationArea = All;
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER(Beneficiary));
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Alternative Addresses")
                {
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Assigned Items")
                {
                    Caption = 'Assigned Items';
                    Image = ExternalDocument;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Assigned Items Overview")
                {
                    Caption = 'Assigned Items Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                    ApplicationArea = All;
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Hr Career Event")
                {
                    Caption = 'Career Event';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Hr Test List";
                    ApplicationArea = All;
                    ///RunPageLink = Field7 = FIELD("No.");
                    RunPageMode = View;
                    RunPageView = WHERE(Score = CONST('3'));
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields("Total Leave Taken");
        //"Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
        //SUM UP LEAVE LEDGER ENTRIES
        "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
    end;

    trigger OnAfterGetRecord()
    begin
        HRSetup.Get;
        if HRSetup."Open Period" then
            FieldEditable := true
        else
            FieldEditable := false;

        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        if ("Date Of Leaving the Company" = 0D) then begin
            if ("Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge("Date Of Birth", Today);
            if ("Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge("Date Of Joining the Company", Today);
            if ("Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
            if ("Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
            //MODIFY;
        end else begin
            if ("Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge("Date Of Birth", "Date Of Leaving the Company");
            if ("Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge("Date Of Joining the Company", "Date Of Leaving the Company");
            if ("Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge("Pension Scheme Join Date", "Date Of Leaving the Company");
            if ("Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge("Medical Scheme Join Date", "Date Of Leaving the Company");
            //MODIFY;
        end;

        //Recalculate Leave Days
        Validate("Allocated Leave Days");
        SupervisorNames := GetSupervisor("User ID");
    end;

    trigger OnOpenPage()
    begin
        CalcFields("Total Leave Taken");
        //"Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
        //SUM UP LEAVE LEDGER ENTRIES
        "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";


        HRSetup.Get;
        if HRSetup."Open Period" then
            FieldEditable := true
        else
            FieldEditable := false;
    end;

    var
        PictureExists: Boolean;
        Text001: Label 'Do you want to replace the existing picture of %1 %2?';
        Text002: Label 'Do you want to delete the picture of %1 %2?';
        Dates: Codeunit "HR Dates No Permission Restric";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        DoclLink: Record "HR Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HR-Employee";
        prPayrollType: Record "prPayroll Type";
        Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Code[50];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        HRValueChange: Record "HR Value Change";
        FieldEditable: Boolean;
        HRSetup: Record "HR Setup";

    [Scope('OnPrem')]
    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;
}

