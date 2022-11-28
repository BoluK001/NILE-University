page 51534778 "HR Employee List Self"
{
    CardPageID = "HR Employee Card Self";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Employee List Self';
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";

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
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("First Name"; "First Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Last Name"; "Last Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Contract Type"; "Contract Type")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Trips Status"; "Trips Status")
                {
                    ApplicationArea = All;
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
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = FIELD("No.");
                    Visible = false;
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = FIELD("No.");
                    Visible = false;
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = FIELD("No.");
                    Visible = false;
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = FIELD("No.");
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
                PromotedCategory = "Report";
                ApplicationArea = All;
                //RunObject = Report "IBS Notes";
                Visible = false;
            }
            action("Employee List")
            {
                Caption = 'Employee List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 5";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Assign. Item Info.")
            {
                Caption = 'Employee Assign. Item Info.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Misc. Article Info.";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Confidential Info.")
            {
                Caption = 'Employee Confidential Info.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Confidential Info.";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Labels")
            {
                Caption = 'Employee Labels';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Labels";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Staff Absences")
            {
                Caption = 'Employee Staff Absences';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Staff Absences";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Addresses")
            {
                Caption = 'Employee Addresses';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Addresses";
                Visible = false;
                ApplicationArea = All;
            }
            action(Action1102755015)
            {
                Caption = 'Employee Qualifications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Qualifications";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Alt. Addresses")
            {
                Caption = 'Employee Alt. Addresses';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Alt. Addresses";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee Phone Nos.")
            {
                Caption = 'Employee Phone Nos.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Phone Nos.";
                Visible = false;
                ApplicationArea = All;
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                //RunObject = Report "Fully Unprocessed Instruction";
                Visible = false;
            }
            action("Employee Birthday")
            {
                Caption = 'Employee Birthday';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Statutory Deductions";
                Visible = false;
                ApplicationArea = All;
            }
            action("Employee PaySlip")
            {
                Caption = 'Employee PaySlip';
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    HREmployee.SetRange(HREmployee."No.", "No.");
                    if HREmployee.FindFirst then
                        REPORT.Run(51534721, true, false, HREmployee);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("User ID",USERID);
        FilterGroup(2);
        SetRange("User ID", UserId);
        FilterGroup(0);
    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
        HREmployee: Record "HR-Employee";
}

