page 51534478 "HR Jobs List"
{
    CardPageID = "HR Jobs Card";
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = false;
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Jobs List';
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Administration';
    RefreshOnActivate = true;
    SourceTable = "HR Jobs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Job ID"; "Job ID")
                {
                    Importance = Promoted;
                    ApplicationArea = all;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = all;
                }
                field("No of Posts"; "No of Posts")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field(Status; Status)
                {
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
                ApplicationArea = all;
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,WorkOrder,Job,Trip,Fuel,Diversion,HSSEQ,VehicleRelease,DriverAllowance,TruckVerification,BatteryJV,Towing,Interchange,TyreReplacement,LCAdvance,APRAF,FuelRecon,"Job Approval","Employee Requisition","Interview Evaluation","Training Requisition","Leave Application",Appraisal;
                        DocumentType: Enum "Approval Document Type";
                        ApprovalEntries : Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                    begin
                        DocumentType := DocumentType::Jobs;
                        //ApprovalEntries.Setfilters(DATABASE::"HR Jobs", DocumentType, "Job ID");
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Jobs", DocumentType.AsInteger(), "Job ID");

                        //ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        if Confirm('Send this job position for Approval?', true) = false then exit;
                        if AppMgmt.CheckHRJobsApprovalsWorkflowEnable(rec) then
                            AppMgmt.OnSendHRJobsForApproval(rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        if Confirm('Cancel Approval Request?', true) = false then exit;
                        AppMgmt.OnCancelHRJobsForApproval(rec);
                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action("Job Card")
                {
                    ApplicationArea = all;
                    Caption = 'Job Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Jobs Card";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Raise Requisition")
                {
                    Caption = 'Raise Requisition';
                    Image = Job;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    RunPageOnRec = false;

                    trigger OnAction()
                    begin
                        CurrPage.Close;
                    end;
                }
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = Card;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action(Occupants)
                {
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
            }
        }
        area(navigation)
        {
            action("Job Requirements")
            {
                Caption = 'Job Requirements';
                Image = ApplicationWorksheet;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Requirements";
                RunPageLink = "Job ID" = FIELD("Job ID");
            }
            action("Job Qualifications")
            {
                Caption = 'Job Qualifications';
                ApplicationArea = all;
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Qualifications";
            }
            action("Job Responsibilities")
            {
                Caption = 'Job Responsibilities';
                Image = Relationship;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Job Responsibilities";
                RunPageLink = "Job ID" = FIELD("Job ID");
            }
            action("Appraisal Evaluation Areas")
            {
                ApplicationArea = all;
                Caption = 'Appraisal Evaluation Areas';
                Image = Evaluate;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Appraisal Evaluation Areas";
            }
            action("Lookup Values")
            {
                Caption = 'Lookup Values';
                ApplicationArea = all;
                Image = List;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HR Lookup Values List";
            }
        }
        area(reporting)
        {
            action(Jobs)
            {
                Caption = 'Jobs';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                ///RunObject = Report "prAnnual Income And Ta"; RBS
            }
            action("Job Occupants")
            {
                Caption = 'Job Occupants';
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "51534687";   //jj100322  not the right report found here, changed to this report
            }
            action("Vacant Jobs")
            {
                ApplicationArea = all;
                Caption = 'Vacant Jobs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Approval Entry Report";
                Visible = false;  //jj100322
            }
            action("Occupied Jobs")
            {
                Caption = 'Occupied Jobs';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Probation Notification";
                Visible = false;  //jj100322
            }
            action(Action1102755009)
            {/*
                Caption = 'Job Responsibilities';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "IBS Notes 6";
                Visible = false;
                ApplicationArea = All;
                */
            }
            action(Action1102755013)
            {
                /*
                Caption = 'Job Requirements';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "IBS Notes 7";
                Visible = false;
                ApplicationArea = All;
                */
            }
        }
    }

    var
        AppMgmt: Codeunit "Approval Mgmt. ExtCal";
}

