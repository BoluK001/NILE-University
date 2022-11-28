page 51534552 "HR Appraisal Goal SettingHS li"
{
    CardPageID = "HR Appraisal Goal Setting HS";
    InsertAllowed = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Appraisal No"; "Appraisal No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee No"; "Employee No")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Job Title"; "Job Title")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Send To Appraisee")
                {
                    Caption = 'Send To Appraisee';
                    Image = SendTo;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to send this Appraisal Form to the appraisee?', false) = true then begin
                            Status := 0;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
            }
        }
    }

    var
        Text19033494: Label 'Set your goals and objectives in line with your department''s strategy.';
}

