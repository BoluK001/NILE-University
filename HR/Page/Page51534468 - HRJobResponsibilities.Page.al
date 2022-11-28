page 51534468 "HR Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field("Job ID"; Rec."Job ID")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = all;
                }
            }
            part("Job Responsibilities"; "HR Job Responsiblities Lines")
            {
                Caption = 'Job Responsibilities';
                //SubPageLink = "Job ID" = FIELD ("Job ID");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                Image = Import;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID", rec."Job ID");
                    if HRJobResponsibilities.Find('-') then
                        HRJobResponsibilities.DeleteAll;

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset;
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."Assign To", rec."Job ID");
                    if HRAppraisalEvaluationAreas.Find('-') then
                        HRAppraisalEvaluationAreas.FindFirst;
                    begin
                        HRJobResponsibilities.Reset;
                        repeat
                            HRJobResponsibilities.Init;
                            HRJobResponsibilities."Job ID" := rec."Job ID";
                            //HRJobResponsibilities."Responsibility Code":=HRAppraisalEvaluationAreas.Code;
                            HRJobResponsibilities."Responsibility Description" := HRAppraisalEvaluationAreas.Description;
                            HRJobResponsibilities.Insert();
                        until HRAppraisalEvaluationAreas.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
}

