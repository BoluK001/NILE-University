report 51534685 "HR Training Applications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRTrainingApplications.rdlc';

    dataset
    {
        dataitem("HR Training Applications"; "HR Training Applications")
        {
            DataItemTableView = SORTING("Application No");
            RequestFilterFields = "Application No";
            column(CourseTitle_HRTrainingApplications; "HR Training Applications"."Course Title")
            {
                IncludeCaption = true;
            }
            column(FromDate_HRTrainingApplications; "HR Training Applications"."From Date")
            {
                IncludeCaption = true;
            }
            column(ToDate_HRTrainingApplications; "HR Training Applications"."To Date")
            {
                IncludeCaption = true;
            }
            column(DurationUnits_HRTrainingApplications; "HR Training Applications"."Duration Units")
            {
                IncludeCaption = true;
            }
            column(Duration_HRTrainingApplications; "HR Training Applications".Duration)
            {
                IncludeCaption = true;
            }
            column(CostOfTraining_HRTrainingApplications; "HR Training Applications"."Cost Of Training")
            {
                IncludeCaption = true;
            }
            column(Location_HRTrainingApplications; "HR Training Applications".Location)
            {
                IncludeCaption = true;
            }
            column(ApplicationNo_HRTrainingApplications; "HR Training Applications"."Application No")
            {
                IncludeCaption = true;
            }
            column(EmployeeNo_HRTrainingApplications; "HR Training Applications"."Employee No.")
            {
                IncludeCaption = true;
            }
            column(EmployeeName_HRTrainingApplications; "HR Training Applications"."Employee Name")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRTrainingApplications; "HR Training Applications"."Application Date")
            {
                IncludeCaption = true;
            }
            column(EmployeeDepartment_HRTrainingApplications; "HR Training Applications"."Shortcut Dimension 1 Code")
            {
                IncludeCaption = true;
            }
            column(Description_HRTrainingApplications; "HR Training Applications".Description)
            {
            }
            column(PurposeofTraining_HRTrainingApplications; "HR Training Applications"."Reason for Training")
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            dataitem("Approval Comment Line"; "Approval Comment Line")
            {
                DataItemLink = "Document No." = FIELD("Application No");
                DataItemLinkReference = "HR Training Applications";
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.");
                column(UserID_ApprovalCommentLine; "Approval Comment Line"."User ID")
                {
                    IncludeCaption = true;
                }
                column(Comment_ApprovalCommentLine; "Approval Comment Line".Comment)
                {
                    IncludeCaption = true;
                }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("Application No");
                DataItemLinkReference = "HR Training Applications";
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.");
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                    IncludeCaption = true;
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                    IncludeCaption = true;
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                    IncludeCaption = true;
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    DataItemTableView = SORTING("User ID");
                }

                trigger OnAfterGetRecord()
                begin
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."User ID", "Approval Entry"."Approver ID");
                    if HREmp.Find('-') then
                        ApproverName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name"
                    else
                        ApproverName := '';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HREmp: Record "HR Employees";
        ApproverName: Text[30];
        HR_Training_ApplicationsCaptionLbl: Label 'HR Training Applications';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Training_Application_FormCaptionLbl: Label 'Training Application Form';
        Name_of_Training_CourseCaptionLbl: Label 'Name of Training Course';
        From__Date_CaptionLbl: Label 'From (Date)';
        Duration_CaptionLbl: Label 'Duration ';
        To__Date_CaptionLbl: Label 'To (Date)';
        Cost_of_TrainingCaptionLbl: Label 'Cost of Training';
        How_the_Training_Course_Will_Complement_Enhance_my_Skills_in_Relation_to_the_Job_RequirementsCaptionLbl: Label 'How the Training Course Will Complement/Enhance my Skills in Relation to the Job Requirements';
        Brief_Description_of_Training_CourseCaptionLbl: Label 'Brief Description of Training Course';
        CommentsCaptionLbl: Label 'Comments';
        Comments_By_CaptionLbl: Label 'Comments By:';
        End_of_CommentsCaptionLbl: Label 'End of Comments';
        Approved_ByCaptionLbl: Label 'Approved By';
        ApprovalsCaptionLbl: Label 'Approvals';
        SignatureCaptionLbl: Label 'Signature';
}

