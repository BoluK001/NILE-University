page 51534467 "HR Job Requirements"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group("Job Specification")
            {
                Caption = 'Job Details';
                field("Job ID"; "Job ID")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
            }
            part("Job Requirement Lines"; "HR Job Requirement Lines")
            {
                Caption = 'Job Requirements';
                SubPageLink = "Job Id" = FIELD("Job ID");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job Requirements")
            {
                Image = PrintReport;
                ApplicationArea = all;
                // PromotedCategory = "Report";
                //RunObject = Report Report39003924;

                trigger OnAction()
                begin
                    HRJobReq.Reset;
                    HRJobReq.SetRange(HRJobReq."Job Id", "Job ID");
                    if HRJobReq.Find('-') then begin
                        REPORT.RUN(51534524, true, true, HRJobReq);
                    end;
                end;
            }
        }
    }

    var
        HRJobReq: Record "HR Job Requirements";
}

