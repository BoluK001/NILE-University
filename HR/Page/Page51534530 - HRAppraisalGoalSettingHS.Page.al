page 51534530 "HR Appraisal Goal Setting HS"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    AdditionalSearchTerms = 'HR Appraisal Goal Setting HS';
    SourceTable = "HR Appraisal Goal Setting H";
    SourceTableView = WHERE(Status = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            group(General)
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
                field("Appraisal Type"; "Appraisal Type")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = all;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    Caption = 'Current Salary Grade';
                    ApplicationArea = all;
                }
                field(Step; Step)
                {
                    Caption = 'Current Step';
                    ApplicationArea = all;
                }
                field(Picture; Picture)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = all;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = all;
                }
                field(Unit; Unit)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Company Score"; "Company Score")
                {
                    ApplicationArea = all;
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                }
                field(CompanyScoreAppraisee; CompanyScoreAppraisee)
                {
                    Caption = 'Appraisee Company Score';
                    ApplicationArea = all;
                    Editable = false;
                    ExtendedDatatype = None;
                }
                field("Bonus Point appraisee"; "Bonus Point appraisee")
                {
                    ApplicationArea = all;
                }
                field("KPIs Appraisee Score"; "KPIs Appraisee Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = all;
                }
                field("KPIs Appraiser Score"; "KPIs Appraiser Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = all;
                }
                field("KPIs Mgt Score"; "KPIs Mgt Score")
                {
                    ExtendedDatatype = None;
                    ApplicationArea = all;
                }
                field(KPIScoreMgt; KPIScoreMgt)
                {
                    Caption = 'KPI Score';
                    Editable = false;
                    ApplicationArea = all;
                    Enabled = false;
                    ExtendedDatatype = None;
                    Visible = false;
                }
                field("Performance Score Appraisee"; "Performance Score Appraisee")
                {
                    ExtendedDatatype = None;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Performance Score Appraiser"; "Performance Score Appraiser")
                {
                    ExtendedDatatype = None;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Performance Score Mgt"; "Performance Score Mgt")
                {
                    ExtendedDatatype = None;
                    Visible = false;
                    ApplicationArea = all;
                }
                field(PFScoreMgt; PFScoreMgt)
                {
                    Caption = 'Performance Score';
                    Enabled = false;
                    ApplicationArea = all;
                    ExtendedDatatype = None;
                    Visible = false;
                }
                field("Development Plans"; "Development Plans")
                {
                    Caption = 'Development Requirements Appraisee';
                    Editable = false;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Development Requirements Appra"; "Development Requirements Appra")
                {
                    Caption = 'Development Requirements Appraiser';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Development Requirements Mgt"; "Development Requirements Mgt")
                {
                    Editable = false;
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                }
                field("Comments Appraiser"; "Comments Appraiser")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Comments Mgt"; "Comments Mgt")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                }
            }
            part("Current Period's KPI"; "HR Appraisal Goal Setting L")
            {
                ApplicationArea = all;
                Caption = 'Current Period''s KPI';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
            }
            part(SF; "HR Appraiser Evaluation Lines")
            {
                ApplicationArea = all;
                Caption = 'Job Specific Evaluation(Performance Factors)';
                SubPageLink = "Employee No" = FIELD("Employee No"),
                              "Appraisal Period" = FIELD("Appraisal Period");
                Visible = false;
            }
            part(SF2; "HR Mgt Evaluation Lines")
            {
                ApplicationArea = all;
                Caption = 'Job Specific Evaluation(Performance Factors)mg';
                Enabled = false;
                Visible = false;
            }
            part("Next Period's KPI"; "HR Appraisal Next KPI")
            {
                ApplicationArea = all;
                Caption = 'Next Period''s KPI';
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Visible = false;
            }
            group("General Comments/Recommendations")
            {
                Caption = 'General Comments/Recommendations';
                Enabled = false;
                Visible = false;
                field("Recommendations 1"; "Recommendations 1")
                {
                    ApplicationArea = all;
                }
            }
            group("Evaluation Scores/Remarks")
            {
                Caption = 'Evaluation Scores/Remarks';
                Visible = true;
                field("Bonus Point Appraiser"; "Bonus Point Appraiser")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Bonus Point Mgt"; "Bonus Point Mgt")
                {
                    ApplicationArea = all;
                    Editable = MgtEditable;
                }
                field("Bonus Point Appraiser Remarks"; "Bonus Point Appraiser Remarks")
                {
                    ApplicationArea = all;
                    Editable = true;
                    MultiLine = true;
                }
                field("Bonus Point Mgt Remarks"; "Bonus Point Mgt Remarks")
                {
                    ApplicationArea = all;
                    Editable = MgtEditable;
                    MultiLine = true;
                }
                field("Recommendation Appraiser"; "Recommendation Appraiser")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Recommendation 2"; "Recommendation 2")
                {
                    ApplicationArea = all;
                    Editable = true;
                    MultiLine = true;
                }
                field("Recommendation Mgt"; "Recommendation Mgt")
                {
                    ApplicationArea = all;
                    Editable = MgtEditable;
                }
                field("Recommendation 3"; "Recommendation 3")
                {
                    ApplicationArea = all;
                    Editable = MgtEditable;
                    MultiLine = true;
                }
                field("Signature Appraisee"; "Signature Appraisee")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Signature Appraiser"; "Signature Appraiser")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Signature Mgt"; "Signature Mgt")
                {
                    ApplicationArea = all;
                    Editable = MgtEditable;
                }
                field("Overall Appraisee Score"; "Overall Appraisee Score")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Overall Appraiser Score"; "Overall Appraiser Score")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Overall Mgt Score"; "Overall Mgt Score")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Overal Rating Desc"; "Overal Rating Desc")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("MD's Recommendation & Comment")
            {
                field("MD's Recommendation"; "MD's Recommendation")
                {
                    ApplicationArea = all;
                    MultiLine = false;
                }
                field("MD's Comment"; "MD's Comment")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("MD's Remark"; "MD's Remark")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("MD's Signature"; "MD's Signature")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000001; Outlook)
            {
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
                action("Approve Appraisal")
                {
                    Caption = 'Approve Appraisal';
                    Image = Approve;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to approve this Appraisal Form ?', false) = true then begin
                            Status := Status::Approved;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                action("Return To Appraisee")
                {
                    Caption = 'Return To Appraisee';
                    Image = Return;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you want to return this Appraisal Form to the appraisee?', false) = true then begin
                            Status := Status::Open;
                            Modify;
                            Message('%1', 'Process Completed')
                        end;
                    end;
                }
                separator(Action1000000007)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries : Page "Approval Entries";
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        doctype: Enum "Approval Document Type";
                    begin
                        DocType := DocType::"Staff Advance";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"HR Appraisal Goal Setting H", DocType.AsInteger(), "Appraisal No");
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        IF NOT LinesExists THEN
                           ERROR('There are no Lines created for this Document');
                        
                        
                          IF NOT AllFieldsEntered THEN
                             ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                        
                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                          ERROR('There are some lines that have not been committed');
                        */
                        //Release the Imprest for Approval
                        // IF ApprovalMgt.SendAppraisalApprovalRequest(Rec) THEN;

                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt."--CoreTec--"(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EditPage(GetApprovalSequence);
        xRec := Rec;
        CurrPage.Update;

        CalcTotals;
    end;

    var
        Text19033494: Label 'Set your goals and objectives in line with your department''s strategy.';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        AppraiserEditable: Boolean;
        MgtEditable: Boolean;
        CompanyScoreAppraisee: Decimal;
        KPIScoreAppraisee: Decimal;
        PFScoreAppraisee: Decimal;
        PFBase: Decimal;
        HrRatings: Record "HR Appraisal Career Dev";
        UserSetup: Record "User Setup";
        SMTP: Codeunit "SMTP Mail";
        Approver: Record "User Setup";
        HREmp: Record "HR Employees";
        KPIScoreAppraiser: Decimal;
        KPIScoreMgt: Decimal;
        PFScoreAppraiser: Decimal;
        PFScoreMgt: Decimal;

    [Scope('OnPrem')]
    procedure GetApprovalSequence(): Integer
    var
        AppEntry: Record "Approval Entry";
        AppLevel: Integer;
    begin
        //get the approver sequence
        AppEntry.Reset;
        AppEntry.SetRange(AppEntry."Document No.", "Appraisal No");
        //AppEntry.SetRange(AppEntry."Table ID", 39005606);
        AppEntry.SetFilter(AppEntry.Status, '<>%1', AppEntry.Status::Canceled);
        if AppEntry.FindSet then
            repeat
                AppLevel += 1;
                //MESSAGE('%1',AppEntry."Sequence No.");
                if AppEntry."Approver ID" = UserId then
                    exit(AppLevel);
            until AppEntry.Next = 0;
        AppLevel := 100;
        exit(AppLevel);
        //Limit editable fields as per approval level
    end;

    [Scope('OnPrem')]
    procedure EditPage(AppLevel: Integer)
    begin
        if AppLevel = 1 then
            AppraiserEditable := true
        else
            AppraiserEditable := false;
        if AppLevel = 2 then
            MgtEditable := true
        else
            MgtEditable := false;
    end;
}

