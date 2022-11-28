page 51534378 "HR Employee Card (Inactive)"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments';
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = CONST(Inactive));
    Editable = false;

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Old Employee No."; Rec."Old Employee No.")
                {
                    ApplicationArea = All;
                    visible = false;  //jj010322
                }
                field("First Name"; Rec."First Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    /* trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end; */
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = all;
                }
                field("Citizenship Text"; Rec."Citizenship Text")
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    //Caption = '<Global Dimension 2 Code>';
                    ApplicationArea = all;
                    //Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Level 2"; Rec."Department Level 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Unit; Rec.Unit)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    Caption = 'Nationalty Group';
                    ApplicationArea = all;
                    // Visible = false; //jj010322
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    Importance = Promoted;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //SupervisorNames := GetSupervisor("User ID");
                    end;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    Caption = 'Supervisor ID';
                    ApplicationArea = all;
                    Visible = false;

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
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Supervisor's Job Title"; Rec."Supervisor's Job Title")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Second Line Supervisor ID"; Rec."Second Line Supervisor ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = True; //jj010322  I made it true to approved to see on payroll
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Available; Rec.Available)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date of Last Promotion"; Rec."Alt. Address Start Date")
                {
                    Caption = 'Date of Last Promotion';
                    ApplicationArea = all;
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';

                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = all;
                }
                field("Ext."; Rec."Ext.")
                {
                    ExtendedDatatype = PhoneNo;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Personal E-Mail"; Rec."Personal E-Mail")
                {
                    ExtendedDatatype = EMail;
                    ApplicationArea = all;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Alt. Address Code"; Rec."Alt. Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Alt. Address End Date"; Rec."Alt. Address End Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Religion; Rec.Religion)
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    ApplicationArea = all;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = all;
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = all;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ApplicationArea = all;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = all;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = all;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = all;
                }
                field("Has Driving Licence"; Rec."Has Driving Licence")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = all;
                }
                field("Disability Details"; Rec."Disability Details")
                {
                    ApplicationArea = all;
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ApplicationArea = all;

                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Medical Scheme Plan"; Rec."Medical Scheme Plan")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Medical Sch. Hospital Code"; Rec."Medical Sch. Hospital Code")
                {
                    ApplicationArea = all;
                }
                field("Medical Scheme Hospital"; Rec."Medical Scheme Hospital")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    Editable = false;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("-"; Rec."-")
                {
                    ApplicationArea = all;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; Rec."Main Bank")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = all;

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
                field("Date Of Joining the Company"; Rec."Date Of Joining the Company")
                {
                    Importance = Promoted;
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
                field("Probation Date 3mnths"; Rec."Probation Date 3mnths")
                {
                    ApplicationArea = all;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = all;
                }
                field("Probation Form Filled"; Rec."Probation Form Filled")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Confirmation Form Filled"; Rec."Confirmation Form Filled")
                {
                    Editable = false;
                    ApplicationArea = all;
                }

                field("End of Probation Date"; Rec."End of Probation Date")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Pension Scheme Join Date"; Rec."Pension Scheme Join Date")
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
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
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
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field(Grade; Rec.Grade)
                {
                    Importance = Promoted;
                    Visible = false;
                }
                field("Job Level"; Rec."Job Level")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Resource Type"; Rec."Resource Type")
                {
                    Visible = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = all;
                }
                field("Salary Step"; Rec."Salary Step")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if not Confirm('Changing the Grade will affect the Basic Salary and the salary notch\step transactions. ' +
                                        'Do you wish to continue?', false) then begin
                            "Salary Step" := '';
                            Error('You have opted to abort the process.');

                        end;
                    end;
                }
                field("Employee Classification"; Rec."Employee Classification")
                {
                    ApplicationArea = all;
                }
                field("Payroll Filter Group"; Rec."Payroll Filter Group")
                {
                    ApplicationArea = all;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Employment Type"; Rec."Employment Type")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    Importance = Promoted;
                    //Visible = false;
                    ApplicationArea = all;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = all;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    Importance = Promoted;
                    Visible = true;
                    ApplicationArea = all;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN Number"; Rec."PIN Number")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                    Caption = 'RSA PIN Number';  //jj270422
                }
                field("Pension Fund Administrator"; Rec."Pension Fund Administrator")
                {
                    ApplicationArea = all;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("TAX ID No"; Rec."Social Security No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; Rec."Date Of Leaving the Company")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Termination Grounds"; Rec."Termination Grounds")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Acrued Leave Days"; Rec."Acrued Leave Days")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cash per Leave Day"; Rec."Cash per Leave Day")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Cash - Leave Earned"; Rec."Cash - Leave Earned")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Type Filter"; Rec."Leave Type Filter")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Leave Period Filter"; Rec."Leave Period Filter")
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
                SubPageLink = "Table ID" = CONST(51534578),
                              "No." = FIELD("No."), "Document Type" = filter('Employee');
            }
            part(Control24; "Log Sheet")
            {
                ApplicationArea = all;
                SubPageLink = "Table Name" = CONST(Employee),
                              "No." = FIELD("No.");
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
                    Visible = false;

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
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Attachments SF";
                    RunPageLink = "Employee No" = FIELD("No."),
                                  "Document Type" = CONST(Employee);
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
                    RunObject = Page "Employee Log Entries";
                    /*RunPageLink = "Table No." = CONST(39005575),
                                  "Type of Change" = FILTER(Modification | Deletion),
                                  "Primary Key Field 1 Value" = FIELD("No.");*/
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
                }
                action("Assigned Items Overview")
                {
                    Caption = 'Assigned Items Overview';
                    Image = ViewSourceDocumentLine;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category6;
                    RunObject = Page "Misc. Articles Overview";
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
                        // ApprovalEntries.Setfilters(DATABASE::"HR Employees", DocType, "No.");
                        // ApprovalEntries.Run;
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Employees", DocType.AsInteger(), "No.");

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
                        ///if PAGE.RunModal(5222, LogLine) = ACTION::LookupOK then
                        ///IF ApprovalMgt.SendEmployeeApprovalRequest(Rec) THEN; RBS DEnnis
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
                    Visible = false;  //jj300922
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        "Approval Status" := "Approval Status"::New;
                        Modify;
                        CurrPage.Close;
                    end;
                }
                action("Activate")   //biyi I added to change Status form Inactive to Active
                {
                    Caption = 'Activate';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        SalEMP: record "HR-Employee";
                    begin
                        Status := Status::Active;
                        Modify;

                        //Activate the Payroll record
                        if salEmp.Get("No.") then
                            SalEMP.SetRange("No.", "No.");
                        if SalEMP.Find('-') then begin
                            SalEMP.Init();
                            SalEMP.validate(Status, Status);
                            SalEMP."Status Change Date" := WorkDate();
                            SalEMP.Modify()
                        end;

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
        //SupervisorNames := GetSupervisor("User ID");  //jj03102022


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

    /*  [Scope('OnPrem')]
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
      end;  */  //jj03102022 
}

