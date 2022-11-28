page 51534581 "HR Driver List"
{
    CardPageID = "HR Employee Card";
    ApplicationArea = all;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    UsageCategory = Lists;
    AdditionalSearchTerms = 'HR Driver List';
    SourceTable = "HR Employees";
    SourceTableView = WHERE("Job Title" = CONST('DRIVER'));

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
                    ApplicationArea = all;
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
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    RunObject = Page "HR Deductions Account";
                }
                action("Employee Attachments")
                {
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                }
                action("Employement History")
                {
                    Caption = 'Employement History';
                    Image = History;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employment History";
                }
                action("Employee Qualifications")
                {
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Qualifications";
                }
                action("Import Date Of Join")
                {
                    Caption = 'Import Date Of Join';
                    ApplicationArea = all;
                    Image = Import;
                    //RunObject = XMLport XMLport50063;
                }
                action(Trips)
                {
                    Caption = 'Trips';
                    ApplicationArea = all;
                    Image = SalesShipment;
                    Promoted = true;
                    // RunObject = Page Page39006159;
                    ///RunPageLink = Field27 = FIELD ("No.");
                }
                action("Scheduled Trips")
                {
                    Caption = 'Scheduled Trips';
                    Image = Relationship;
                    ApplicationArea = all;
                    Promoted = true;
                    //RunObject = Page "IBS Notes List";
                    //RunPageLink = MarketValue = FIELD ("No.");
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
                //RunObject = Report "IBS Notes 5";
            }
            action("Employee Misc. Information")
            {
                Caption = 'Employee Misc. Information';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = all;
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
            }
            action(Action1102755015)
            {
                Caption = 'Employee Qualifications';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Qualifications";
            }
            action("Employee Alt. Addresses")
            {
                Caption = 'Employee Alt. Addresses';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Alt. Addresses";
            }
            action("Employee Phone Nos.")
            {
                Caption = 'Employee Phone Nos.';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee - Phone Nos.";
            }
            action("Leave Statement")
            {
                Caption = 'Leave Statement';
                Image = "Report";
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = "Report";
                ///RunObject = Report "Fully Unprocessed Instruction";
            }
        }
    }

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}

