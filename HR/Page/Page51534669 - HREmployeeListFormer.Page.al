page 51534669 "HR Employee List (Former)"
{
    CardPageID = "HR Employee Card Former";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Employee List (Former)';
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = CONST(Inactive));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("First Name"; "First Name")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Employment Type"; "Employment Type")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Employees Factbox")
            {
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1102755003; Outlook)
            {
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
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Kin/Beneficiaries")
                {
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Deductions Account";
                    RunPageLink = Code = FIELD("No.");
                    Visible = false;
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Report HR Employee Kin")
                {
                    Caption = 'Report HR Employee Kin';
                    ApplicationArea = all;
                    //RunObject = Report Report39003941;
                }
            }
        }
        area(reporting)
        {
            action("Employee PIF")
            {
                Caption = 'Employee PIF';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes";
            }
            action("Employee List")
            {
                Caption = 'Employee List';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 5";
            }
            action(Action1102755015)
            {
                Caption = 'Employee Qualifications';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Qualifications";
                Visible = false;
            }
            action("Employee Alt. Addresses")
            {
                Caption = 'Employee Alt. Addresses';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Alt. Addresses";
                Visible = false;
            }
            action(Action2)
            {
                Caption = 'Report HR Employee Kin';
                //RunObject = Report Report39003941;
            }
            action("View Payslip")
            {
                Caption = 'View Payslip';
                Image = Payment;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HrEmployee: Record "HR-Employee";
                    ObjPeriod: Record "prPayroll Periods";
                    SelectedPeriod: Date;
                begin

                    ObjPeriod.Reset;
                    ObjPeriod.SetRange(ObjPeriod.Closed, false);
                    if ObjPeriod.Find('-') then;
                    SelectedPeriod := ObjPeriod."Date Opened";

                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", "No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    REPORT.Run(51534718, true, false, HrEmployee);
                end;
            }
        }
    }

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}

