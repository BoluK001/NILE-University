page 51534541 "HR Employee Card"
{
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
                    Importance = Promoted;
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Old Employee No."; "Old Employee No.")
                {
                    ApplicationArea = All;
                    visible = false;  //jj010322
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("ID Number"; "ID Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    /* trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end; */
                }
                field("Passport Number"; "Passport Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = all;
                }
                field("Citizenship Text"; "Citizenship Text")
                {
                    Caption = 'Country / Region Code';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Description"; Rec."Job Description")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    //Caption = '<Global Dimension 2 Code>';
                    ApplicationArea = all;
                    ShowMandatory = True;
                    //Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Code';
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Department Level 2"; "Department Level 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Unit; Unit)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Title; Title)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = all;
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
                    Caption = 'Nationalty Group';
                    ApplicationArea = all;
                    // Visible = false; //jj010322
                }
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    /* trigger OnValidate()
                     begin
                         //SupervisorNames := GetSupervisor("User ID");
                     end;  */   //jj22092022 I remmed the block as the Supervisor name coming after is that on Approval User setup
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = all;
                }
                field("Supervisor/Manager"; "Supervisor/Manager")
                {
                    Caption = 'Supervisor ID';
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        Emp: Record "HR Employees";
                    begin
                        Emp.SetRange(Emp."No.", Rec."Supervisor/Manager");
                        if Emp.FindFirst then begin
                            SupervisorNames := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
                            Rec."Supervisor's Job Title" := Emp."Job Title";
                        end;
                    end;
                }
                field(SupervisorNames; SupervisorNames)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Supervisor's Job Title"; "Supervisor's Job Title")
                {
                    ApplicationArea = all;
                    Editable = false;   //22092022
                }
                field("Second Line Supervisor ID"; "Second Line Supervisor ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; Status)
                {
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approval Status"; "Approval Status")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Available; Available)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date of Last Promotion"; "Alt. Address Start Date")
                {
                    Caption = 'Date of Last Promotion';
                    ApplicationArea = all;
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';

                field("Home Phone Number"; "Home Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cell Phone Number"; "Cell Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Fax Number"; "Fax Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Work Phone Number"; "Work Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = all;
                }
                field("Ext."; "Ext.")
                {
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Personal E-Mail"; "Personal E-Mail")
                {
                    ExtendedDatatype = EMail;
                    ApplicationArea = all;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Alt. Address Code"; "Alt. Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Alt. Address End Date"; "Alt. Address End Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Gender)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Marital Status"; "Marital Status")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Religion; Religion)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("First Language (R/W/S)"; "First Language (R/W/S)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("First Language Read"; "First Language Read")
                {
                    ApplicationArea = all;
                }
                field("First Language Write"; "First Language Write")
                {
                    ApplicationArea = all;
                }
                field("First Language Speak"; "First Language Speak")
                {
                    ApplicationArea = all;
                }
                field("Second Language (R/W/S)"; "Second Language (R/W/S)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Second Language Read"; "Second Language Read")
                {
                    ApplicationArea = all;
                }
                field("Second Language Write"; "Second Language Write")
                {
                    ApplicationArea = all;
                }
                field("Second Language Speak"; "Second Language Speak")
                {
                    ApplicationArea = all;
                }
                field("Additional Language"; "Additional Language")
                {
                    ApplicationArea = all;
                }
                field("Has Driving Licence"; "Has Driving Licence")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration Number"; "Vehicle Registration Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = all;
                }
                field("Disability Details"; "Disability Details")
                {
                    ApplicationArea = all;
                }
                field("Health Assesment?"; "Health Assesment?")
                {
                    ApplicationArea = all;

                }
                field("Medical Scheme No."; "Medical Scheme No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Medical Scheme Plan"; "Medical Scheme Plan")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Medical Sch. Hospital Code"; "Medical Sch. Hospital Code")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj300922
                }
                field("Medical Scheme Hospital"; "Medical Scheme Hospital")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Number Of Dependants"; "Number Of Dependants")
                {
                    Editable = false;
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("-"; "-")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; "Main Bank")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Branch Bank"; "Branch Bank")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Account Number"; "Bank Account Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;

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
                    ApplicationArea = all;
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Date Of Joining the Company"; "Date Of Joining the Company")
                {
                    Importance = Promoted;
                    ShowMandatory = True;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        DService := Dates.DetermineAge("Date Of Joining the Company", Today);
                    end;
                }
                field(DService; DService)
                {
                    ApplicationArea = all;
                    Caption = 'Length of Service';
                    Editable = false;
                    Enabled = false;
                }
                field("Probation Date 3mnths"; "Probation Date 3mnths")
                {
                    ApplicationArea = all;
                }
                field("Confirmation Date"; "Confirmation Date")
                {
                    ApplicationArea = all;
                }
                field("Probation Form Filled"; "Probation Form Filled")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Confirmation Form Filled"; "Confirmation Form Filled")
                {
                    Editable = false;
                    ApplicationArea = all;
                }

                field("End of Probation Date"; "End of Probation Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Pension Scheme Join Date"; "Pension Scheme Join Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        DPension := Dates.DetermineAge("Pension Scheme Join Date", Today);
                    end;
                }
                field(DPension; DPension)
                {
                    Enabled = false;
                }
                field("Medical Scheme Join Date"; "Medical Scheme Join Date")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        DMedical := Dates.DetermineAge("Medical Scheme Join Date", Today);
                    end;
                }
                field(DMedical; DMedical)
                {
                    ApplicationArea = all;
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                }
                field("Wedding Anniversary"; "Wedding Anniversary")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field(Grade; Grade)
                {
                    Importance = Promoted;
                    Visible = false;
                }
                field("Job Level"; "Job Level")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Resource Type"; "Resource Type")
                {
                    Visible = false;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Payroll Posting Group"; Rec."Payroll Posting Group")
                {
                    ApplicationArea = All;
                    ShowMandatory = True;
                    ToolTip = 'Specifies the value of the Payroll Posting Group field.';
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Salary Step"; "Salary Step")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
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
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Payroll Filter Group"; "Payroll Filter Group")
                {
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Employment Type"; "Employment Type")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Contract Type"; "Contract Type")
                {
                    Importance = Promoted;
                    //Visible = false;
                    ApplicationArea = all;
                }
                field("Contract Start Date"; "Contract Start Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Contract End Date"; "Contract End Date")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Notice Period"; "Notice Period")
                {
                    ApplicationArea = all;
                }
                field("Send Alert to"; "Send Alert to")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Full / Part Time"; "Full / Part Time")
                {
                    Importance = Promoted;
                    Visible = true;
                    ApplicationArea = all;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN Number"; "PIN Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Caption = 'RSA PIN Number';  //jj270422
                }
                field("Pension Fund Administrator"; "Pension Fund Administrator")
                {
                    ApplicationArea = all;
                }
                field("NSSF No."; "NSSF No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("NHIF No."; "NHIF No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("TAX ID No"; "Social Security No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; "Date Of Leaving the Company")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Termination Grounds"; "Termination Grounds")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Exit Interview Date"; "Exit Interview Date")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Exit Interview Done by"; "Exit Interview Done by")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                field("Reimbursed Leave Days"; "Reimbursed Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Allocated Leave Days"; "Allocated Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Total (Leave Days)"; "Total (Leave Days)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Total Leave Taken"; "Total Leave Taken")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; "Leave Balance")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Acrued Leave Days"; "Acrued Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cash per Leave Day"; "Cash per Leave Day")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cash - Leave Earned"; "Cash - Leave Earned")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Status"; "Leave Status")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Type Filter"; "Leave Type Filter")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Period Filter"; "Leave Period Filter")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            group(Pass)
            {
                field(Password; Password)
                {
                    ApplicationArea = ALL;
                    Visible = false;
                }

            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(51534578), "No." = FIELD("No.");
            }
            part(Control24; "Log Sheet")
            {
                ApplicationArea = all;
                SubPageLink = "Table name" = CONST(Employee), "No." = FIELD("No.");
            }
            part("HR Employees Factbox"; "HR Employees Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Outlook; Outlook)
            {
                ApplicationArea = all;
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
                    ApplicationArea = all;


                    trigger OnAction()
                    begin
                        /*HREmp.RESET;
                        HREmp.SETRANGE(HREmp."No.","No.");
                        IF HREmp.FIND('-') THEN
                        REPORT.RUN(39003916,,FALSE,HREmp);
                        
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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = all;

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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    Visible = false;
                    ApplicationArea = all;

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
                    Visible = false;
                    ApplicationArea = all;

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
                    ApplicationArea = all;


                    trigger OnAction()
                    begin

                        if "Posting Group" = '' then Error('Please specify the posting group for this employee');

                        if Confirm('Update Payroll Data?', true) = false then exit;

                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.SetRange(HREmp."Approval Status", "Approval Status"::Approved);
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
                                prEmployees."Budget Code" := HREmp."Global Dimension 2 Code";
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
                                prEmployees."Bank Account Number" := HREmp."Bank Account Number";
                                prEmployees."Main Bank" := HREmp."Main Bank";
                                prEmployees.Office := HREmp."Shortcut Dimension 1 Code";
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
                                prEmployees."Job Specification" := HREmp."Job Description";
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
                                prEmployees."Job Title" := HREmp."Job Title";
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
                                prEmployees."Budget Code" := HREmp."Global Dimension 2 Code";
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
                                prEmployees."Job Specification" := HREmp."Job Description";
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
                                prEmployees."Job Title" := HREmp."Job Title";
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
                                prEmployees."Budget Code" := HREmp."Global Dimension 2 Code";

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


                        //Update Default Employee
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.SetRange(HREmp."Approval Status", "Approval Status"::Approved);
                        if HREmp.Find('-') then begin
                            repeat
                            begin
                                //CHECK IF EMPLOYEE IS ALREADY IN THE DEFAULT EMPLOYEES TABLE
                                //IF HE IS MODIFY INFORMATION TO REFLECT ANY CHANGES MADE
                                EmpRec.Reset;
                                EmpRec.SetRange(EmpRec."No.", HREmp."No.");
                                if EmpRec.Find('-') then begin
                                    EmpRec."First Name" := HREmp."First Name";
                                    EmpRec."Middle Name" := HREmp."Middle Name";
                                    EmpRec."Last Name" := HREmp."Last Name";
                                    EmpRec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                                    EmpRec."Search Name" := HREmp."Search Name";
                                    EmpRec.City := HREmp.City;
                                    EmpRec."Post Code" := HREmp."Post Code";
                                    EmpRec.County := HREmp.County;
                                    EmpRec."Mobile Phone No." := HREmp."Home Phone Number";
                                    EmpRec."Phone No." := HREmp."Work Phone Number";
                                    EmpRec."E-Mail" := HREmp."Personal E-Mail";
                                    EmpRec."Bank Account No." := HREmp."Bank Account Number";
                                    //EmpRec."Main Bank" := HREmp."Main Bank";
                                    EmpRec."Global Dimension 1 Code" := HREmp."Shortcut Dimension 1 Code";
                                    //HREmp.Get("No.");
                                    HREmp.CalcFields(Picture);
                                    //EmpRec.Image := HREmp.Picture;
                                    EmpRec."Union Code" := HREmp."Union Code";
                                    EmpRec.Gender := HREmp.Gender;
                                    EmpRec.Status := HREmp.Status;
                                    EmpRec."Resource No." := HREmp."Resource No.";
                                    EmpRec."Last Date Modified" := HREmp."Last Date Modified";
                                    EmpRec."Company E-Mail" := HREmp."Company E-Mail";
                                    //EmpRec.Title := HREmp.Title;
                                    EmpRec."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                    EmpRec."No. Series" := HREmp."No. Series";
                                    EmpRec."Birth Date" := HREmp."Date Of Birth";
                                    EmpRec."Job Title" := HREmp."Job Title";
                                    EmpRec."Employee Posting Group" := 'STAFFADVANCE';
                                    EmpRec.Comment := HREmp.Comment;
                                    EmpRec."No." := HREmp."No.";
                                    EmpRec.Modify;
                                    EmpRec.Validate("No.");
                                end else begin
                                    EmpRec.Init;
                                    EmpRec."No." := HREmp."No.";
                                    //EmpRec.Modify();
                                    EmpRec."First Name" := HREmp."First Name";
                                    EmpRec."Middle Name" := HREmp."Middle Name";
                                    EmpRec."Last Name" := HREmp."Last Name";
                                    EmpRec."Search Name" := HREmp."Search Name";
                                    EmpRec.City := City;
                                    EmpRec."Post Code" := HREmp."Post Code";
                                    EmpRec.County := HREmp.County;
                                    EmpRec."Mobile Phone No." := HREmp."Home Phone Number";
                                    EmpRec."Phone No." := HREmp."Work Phone Number";
                                    EmpRec."E-Mail" := HREmp."Personal E-Mail";
                                    //EmpRec.Image := HREmp.Picture;
                                    EmpRec.Gender := HREmp.Gender;
                                    EmpRec.Status := HREmp.Status;
                                    EmpRec."Resource No." := HREmp."Resource No.";
                                    EmpRec."Last Date Modified" := HREmp."Last Date Modified";
                                    EmpRec."Company E-Mail" := HREmp."Company E-Mail";
                                    //EmpRec.Title := HREmp.Title;
                                    EmpRec."Salespers./Purch. Code" := HREmp."Salespers./Purch. Code";
                                    EmpRec."No. Series" := HREmp."No. Series";
                                    EmpRec."Birth Date" := HREmp."Date Of Birth";
                                    // EmpRec."Job Title" := HREmp."Job Title";
                                    EmpRec."Employee Posting Group" := 'STAFFADVANCE';
                                    EmpRec.Comment := HREmp.Comment;
                                    EmpRec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                                    EmpRec.Insert;
                                    //EmpRec.Validate("No.");
                                end;
                            end;
                            until HREmp.Next = 0;
                        end;

                        Message('Employees data Successfully Updated');
                        //
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
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("No."),
                                  "Document Type" = CONST(Employee);
                    Visible = false;
                }
                action("Next of Kin")
                {
                    ApplicationArea = All;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Visible = false;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = WHERE(Type = FILTER(Beneficiary));
                }
                action("Change Log Entries")
                {
                    Caption = 'Change Log Entries';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    Visible = false;
                    RunObject = Page "Employee Log Entries";
                    RunPageLink = "Table No." = filter(51534578),
                                  "Type of Change" = FILTER(Modification | Deletion);
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Employment History")
                {
                    Caption = 'Employment History';
                    Image = History;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Alternative Addresses")
                {
                    Caption = 'Alternative Addresses';
                    Image = AlternativeAddress;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Alternative Address Card";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
                action("Assigned Items")
                {
                    Caption = 'Assigned Items';
                    Image = ExternalDocument;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
                action("Assigned Items Overview")
                {
                    Caption = 'Assigned Items Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
                    Visible = false;
                }
                action("&Confidential Information")
                {
                    Caption = '&Confidential Information';
                    Image = SNInfo;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
                action("Co&nfidential Info. Overview")
                {
                    Caption = 'Co&nfidential Info. Overview';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Confidential Info. Overview";
                    Visible = false;
                    ApplicationArea = all;
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = AbsenceCalendar;
                    Promoted = false;
                    ApplicationArea = all;
                    Visible = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    ApplicationArea = all;
                    Visible = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category6;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                }
                action("Hr Career Event")
                {
                    Caption = 'Career Event';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ApplicationArea = all;
                    RunObject = Page "Hr Test List";
                    ///RunPageLink = Field7 = FIELD("No.");
                    RunPageMode = View;
                    RunPageView = WHERE(Score = CONST('3'));
                }
            }
            group(Action21)
            {
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        DocType := DocType::Employee;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Employees", DocType.AsInteger(), "No.");
                        // WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Sales Header", "Document Type".AsInteger(), "No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                        GenLedgSetup: Record "General Ledger Setup";
                    //NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        TestField("Approval Status", "Approval Status"::New);
                        //if "Global Dimension 2 Code" = '' then
                        //  FieldError("Global Dimension 2 Code");



                        TestField("Department Code");

                        LogLine.Reset;
                        LogLine.SetRange(LogLine."Table Name", LogLine."Table Name"::Employee);
                        LogLine.SetRange(LogLine."No.", "No.");
                        if PAGE.RunModal(5222, LogLine) = ACTION::LookupOK then

                            /// IF ApprovalMgt.SendEmployeeApprovalRequest(Rec) THEN;
                            if ApprovalMgt.CheckEmpApprovalsWorkflowEnable(rec) then
                                ApprovalMgt.OnSendEMPForApproval(rec);

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgmt. ExtCal";
                    begin
                        //IF ApprovalMgt.CancelEmployeeAppApprovalReq(Rec,TRUE,TRUE) THEN;
                        ApprovalMgt.OnCancelEmpForApproval(Rec);
                    end;
                }
                action("<Action1102755042>")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        TestField("Approval Status", "Approval Status"::Approved);
                        "Approval Status" := "Approval Status"::New;
                        Modify;
                        CurrPage.Close;
                    end;
                }
                action("Deactivate")   //jj I added to change Status form Active to Inactive
                {
                    Caption = 'Deactivate';
                    Image = close;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        SalEMP: record "HR-Employee";

                    begin
                        Status := Status::Inactive;
                        Modify;
                        //Deactivate the Payroll record
                        if salEmp.Get("No.") then
                            SalEMP.SetRange("No.", "No.");
                        if SalEMP.Find('-') then begin
                            SalEMP.Init();
                            SalEMP.validate(Status, Status);
                            SalEMP."Status Change Date" := WorkDate();
                            SalEMP.Modify()
                        end;
                        //----
                        CurrPage.Close;
                    end;
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
        // SupervisorNames := GetSupervisor("User ID");  //jj22092022


        if "Approval Status" <> "Approval Status"::New then
            CurrPage.Editable := false
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Password := 'OPT90322';
    end;

    trigger OnOpenPage()
    begin
        CalcFields("Total Leave Taken");
        //"Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
        //SUM UP LEAVE LEDGER ENTRIES
        "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";

        if "Approval Status" <> "Approval Status"::New then
            CurrPage.Editable := false
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //if "Global Dimension 2 Code" = '' then
        //FieldError("Global Dimension 2 Code");
        TestField("Department Code");
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
        ApprovalMgt: Integer;
        //DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",JV,"Payment Voucher","Petty Cash",Requisition,InterBank,"Staff Claim","Staff Advance",AdvanceSurrender,Capex,IJ,"Hr Job","Emp Loan","Leave Application","Employee Requisition","Interview Evaluation","Training Requisition",Appraisal,HMO,Canteen,EmpTransaction,LeaveAck,PFAMod,PFATransfer,Confirmation,Employee;
        DocType: Enum "Approval Document Type";
        LogLine: Record "Human Resource Comment Line";
        EmpRec: Record Employee;

    //  [Scope('OnPrem')]
    /* procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
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
   end;   */     //jj22092022  I remmed 
}

