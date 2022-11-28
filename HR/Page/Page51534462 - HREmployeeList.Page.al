page 51534462 "HR Employee List"
{
    CardPageID = "HR Employee Card";
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Employee List';
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = filter(Active));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Old Employee No."; "Old Employee No.")
                {
                    ApplicationArea = All;
                    Visible = false;   //jj200922
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Coupled to CRM"; "Coupled to CRM")
                {
                    ApplicationArea = all;
                    visible = false;  //jj010322
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Approval Status"; "Approval Status")  //jj22092022
                {
                    ApplicationArea = all;
                }
                field("Trips Status"; Rec."Trips Status")
                {
                    ApplicationArea = all;
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
            part(Control1102755002; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = all;
            }
            systempart(Control1102755003; Outlook)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action("Kin/Beneficiaries")
                {
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Deductions Account";
                    RunPageLink = Code = FIELD("No.");
                    Visible = false;
                    ApplicationArea = all;
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attachments;
                    Visible = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = all;
                }
                action("Report HR Employee Kin")
                {
                    Caption = 'Report HR Employee Kin';
                    //RunObject = Report Report39003941;
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Update Payroll Data")
                {
                    Caption = 'Update Payroll Data';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = all;
                    Visible = false; //jj300922

                    trigger OnAction()
                    begin
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
                                    EmpRec."Job Title" := HREmp."Job Description";
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
                                    EmpRec."Job Title" := HREmp."Job Title";
                                    EmpRec.Comment := HREmp.Comment;
                                    EmpRec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                                    EmpRec.Insert;
                                    //EmpRec.Validate("No.");
                                end;
                            end;
                            until HREmp.Next = 0;
                        end;

                        Message('Default Employee data Successfully Updated.');
                        //
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Employee PIF")
            {
                Caption = 'Employee PIF';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes";
            }
            action("Employee List")
            {
                Caption = 'Employee List';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                // //RunObject = Report "IBS Notes 5";
            }
            action("Employee Assign. Item Info.")
            {
                Caption = 'Employee Assign. Item Info.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Misc. Article Info.";
                ApplicationArea = all;
            }
            action("Employee Confidential Info.")
            {
                Caption = 'Employee Confidential Info.';
                Image = "Report";
                Visible = false;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Confidential Info.";
                ApplicationArea = all;
            }
            action("Employee Labels")
            {
                Caption = 'Employee Labels';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Labels";
                Visible = false;
                ApplicationArea = all;
            }
            action("Employee Staff Absences")
            {
                Caption = 'Employee Staff Absences';
                Image = "Report";
                Visible = false;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Staff Absences";
                ApplicationArea = all;
            }
            action("Employee Addresses")
            {
                Caption = 'Employee Addresses';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Addresses";
                Visible = false;
                ApplicationArea = all;
            }
            action(Action1102755015)
            {
                Caption = 'Employee Qualifications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Qualifications";
                Visible = false;
                ApplicationArea = all;
            }
            action("Employee Alt. Addresses")
            {
                Caption = 'Employee Alt. Addresses';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Alt. Addresses";
                Visible = false;
                ApplicationArea = all;
            }
            action("Employee Phone Nos.")
            {
                Caption = 'Employee Phone Nos.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Phone Nos.";
                Visible = false;
                ApplicationArea = all;
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                // RunObject = Report "Fully Unprocessed Instruction";
            }
            action("Employee Birthday")
            {
                Caption = 'Employee Birthday';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = report "HR Employee - Birthdays";
                ApplicationArea = all;
            }
            action(Action2)
            {
                Caption = 'Report HR Employee Kin';
                ApplicationArea = All;
                Visible = false;
                //RunObject = Report Report39003941;
            }
        }
        area(Processing)
        {
            group(ActionGroupCDS)
            {
                Caption = 'Dataverse';
                Visible = CDSIntegrationEnabled;


                action(CDSGotoHREmployees)
                {
                    Caption = 'HR Employees';
                    Image = CoupledOpportunitiesList;
                    ToolTip = 'Open the coupled Dataverse Employee.';
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CDSSynchronizeNow)
                {
                    Caption = 'Synchronize';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Refresh;
                    Enabled = CDSIsCoupledToRecord;
                    ToolTip = 'Send or get updated data to or from Microsoft Dataverse.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.UpdateOneNow(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    Caption = 'Synchronization Log';
                    ApplicationArea = All;
                    Visible = true;
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the Employee table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Microsoft Dataverse row.';

                    action(ManageCDSCoupling)
                    {
                        Caption = 'Set Up Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Microsoft Dataverse lab book.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(Rec.RecordId);
                        end;
                    }
                    action(DeleteCDSCoupling)
                    {
                        Caption = 'Delete Coupling';
                        ApplicationArea = All;
                        Visible = true;
                        Image = UnLinkAccount;
                        Enabled = CDSIsCoupledToRecord;
                        ToolTip = 'Delete the coupling to a Microsoft Dataverse Employee.';

                        trigger OnAction()
                        var
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                        begin
                            CRMCouplingManagement.RemoveCoupling(Rec.RecordId);
                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if CDSIntegrationEnabled then
            CDSIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
    end;

    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        CDSIntegrationEnabled: Boolean;
        CDSIsCoupledToRecord: Boolean;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
        EmpRec: Record Employee;
}

