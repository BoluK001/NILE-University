page 51534653 "HR Employee List Self1"
{
    CardPageID = "HR Employee Card";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    UsageCategory = Lists;
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
                field("Contract Type"; "Contract Type")
                {
                    Enabled = false;
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
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Trips Status"; "Trips Status")
                {
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
                    ApplicationArea = all;
                    Promoted = true;
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
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Import Date Of Join")
                {
                    Caption = 'Import Date Of Join';
                    Image = Import;
                    ApplicationArea = all;
                    //RunObject = XMLport XMLport50063;
                }
                action(Trips)
                {
                    Caption = 'Trips';
                    ApplicationArea = all;
                    Image = SalesShipment;
                    Promoted = true;
                    //RunObject = Page Page39006159;
                    ///RunPageLink = Field27 = FIELD("No.");
                }
                action("Scheduled Trips")
                {
                    Caption = 'Scheduled Trips';
                    Image = Relationship;
                    ApplicationArea = all;
                    Promoted = true;
                    //RunObject = Page "IBS Notes List";
                    //RunPageLink = MarketValue = FIELD("No.");
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
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report "IBS Notes 5";
            }
            action("Employee Assign. Item Info.")
            {
                Caption = 'Employee Assign. Item Info.';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Misc. Article Info.";
            }
            action("Employee Confidential Info.")
            {
                Caption = 'Employee Confidential Info.';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Confidential Info.";
            }
            action("Employee Labels")
            {
                Caption = 'Employee Labels';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Labels";
                Visible = false;
            }
            action("Employee Staff Absences")
            {
                Caption = 'Employee Staff Absences';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Staff Absences";
            }
            action("Employee Addresses")
            {
                Caption = 'Employee Addresses';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Addresses";
                Visible = false;
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
            action("Employee Phone Nos.")
            {
                Caption = 'Employee Phone Nos.';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Phone Nos.";
                Visible = false;
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                //RunObject = Report "Fully Unprocessed Instruction";
            }
            action("Employee Birthday")
            {
                Caption = 'Employee Birthday';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Statutory Deductions";
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetFilter("User ID", UserId);
        FilterGroup(0);
    end;

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}

