page 51534407 "Hr Appraisal List"
{
    AdditionalSearchTerms = 'Appraisal List';
    ApplicationArea = basic, suite, RelationshipMgmt;
    CardPageID = "HR Appraisal Goal Setting H Se";
    PageType = List;
    SourceTable = "HR Appraisal Goal Setting H";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = all;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = all;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Recommendations 1"; Rec."Recommendations 1")
                {
                    ApplicationArea = all;
                }
                field("No Series"; Rec."No Series")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    ApplicationArea = all;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Development Plans"; Rec."Development Plans")
                {
                    ApplicationArea = all;
                }
                field(Confirmation; Rec.Confirmation)
                {
                    ApplicationArea = all;
                }
                field("Confirmation with Salary Reviw"; Rec."Confirmation with Salary Reviw")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = all;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Step; Rec.Step)
                {
                    ApplicationArea = all;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = all;
                }
                field("Appraisal Half"; Rec."Appraisal Half")
                {
                    ApplicationArea = all;
                }
                field(Queried; Rec.Queried)
                {
                    ApplicationArea = all;
                }
                field("Proposed Grade"; Rec."Proposed Grade")
                {
                    ApplicationArea = all;
                }
                field("Desired Department"; Rec."Desired Department")
                {
                    ApplicationArea = all;
                }
                field("Date Of Last Promotion/Notch"; Rec."Date Of Last Promotion/Notch")
                {
                    ApplicationArea = all;
                }
                field("Time In Present Position"; Rec."Time In Present Position")
                {
                    ApplicationArea = all;
                }
                field("Membership of Prof. Bodies"; Rec."Membership of Prof. Bodies")
                {
                    ApplicationArea = all;
                }
                field(Qualifications; Rec.Qualifications)
                {
                    ApplicationArea = all;
                }
                field("New Qualification in last 1 yr"; Rec."New Qualification in last 1 yr")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Reopen)

            {
                Caption = 'Re-Open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Rec.TestField("Status", Rec."Status"::HR);
                    Rec."Status" := Rec."Status"::Open;
                    Rec.Modify;
                    CurrPage.Close;
                end;
            }

        }
    }

    trigger OnOpenPage()
    begin

        FilterGroup(2);
        SetRange(Status, Status::HR);
        FilterGroup(0);
    end;
}

