report 51534699 "HR Exit Interview"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HRExitInterview.rdlc';

    dataset
    {
        dataitem("HR Employee Exit Interviews"; "HR Employee Exit Interviews")
        {
            RequestFilterFields = "Exit Interview No";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employee_Exit_Interviews__Employee_No__; "Employee No.")
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Interview_; "Date Of Interview")
            {
            }
            column(HR_Employee_Exit_Interviews__Interview_Done_By_; "Interview Done By")
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Leaving_; "Date Of Leaving")
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving_; "Reason For Leaving")
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving__Other__; "Reason For Leaving (Other)")
            {
            }
            column(HR_Employee_Exit_Interviews__Exit_Interview_No_; "Exit Interview No")
            {
            }
            column(HR_Employee_Exit_InterviewsCaption; HR_Employee_Exit_InterviewsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Exit_Interview_ChecklistCaption; Exit_Interview_ChecklistCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employee_Exit_Interviews__Employee_No__Caption; FieldCaption("Employee No."))
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Interview_Caption; FieldCaption("Date Of Interview"))
            {
            }
            column(HR_Employee_Exit_Interviews__Exit_Interview_No_Caption; FieldCaption("Exit Interview No"))
            {
            }
            column(HR_Employee_Exit_Interviews__Interview_Done_By_Caption; FieldCaption("Interview Done By"))
            {
            }
            column(HR_Employee_Exit_Interviews__Date_Of_Leaving_Caption; FieldCaption("Date Of Leaving"))
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving_Caption; FieldCaption("Reason For Leaving"))
            {
            }
            column(HR_Employee_Exit_Interviews__Reason_For_Leaving__Other__Caption; FieldCaption("Reason For Leaving (Other)"))
            {
            }
            dataitem("Misc. Article Information"; "Misc. Article Information")
            {
                DataItemLink = "Employee No." = FIELD ("Employee No.");
                DataItemTableView = SORTING ("Employee No.", "Misc. Article Code", "Line No.");
                column(Misc__Article_Information__Misc__Article_Code_; "Misc. Article Code")
                {
                }
                column(Misc__Article_Information_Description; Description)
                {
                }
                column(Misc__Article_Information_Returned; Returned)
                {
                }
                column(Misc__Article_Information__Date_Returned_; "Date Returned")
                {
                }
                column(Misc__Article_Information__Status_On_Return_; "Status On Return")
                {
                }
                column(Misc__Article_Information_Recommendations; Recommendations)
                {
                }
                column(Misc__Article_Information__Received_By_; "Received By")
                {
                }
                column(Misc__Article_Information__Misc__Article_Code_Caption; FieldCaption("Misc. Article Code"))
                {
                }
                column(Misc__Article_Information_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Misc__Article_Information_ReturnedCaption; FieldCaption(Returned))
                {
                }
                column(Misc__Article_Information__Status_On_Return_Caption; FieldCaption("Status On Return"))
                {
                }
                column(Misc__Article_Information__Date_Returned_Caption; FieldCaption("Date Returned"))
                {
                }
                column(Misc__Article_Information_RecommendationsCaption; FieldCaption(Recommendations))
                {
                }
                column(Misc__Articles_Clearance_Caption; Misc__Articles_Clearance_CaptionLbl)
                {
                }
                column(Misc__Article_Information__Received_By_Caption; FieldCaption("Received By"))
                {
                }
                column(Misc__Article_Information_Employee_No_; "Employee No.")
                {
                }
                column(Misc__Article_Information_Line_No_; "Line No.")
                {
                }
            }
            dataitem("HR Exit Interview Checklist"; "HR Exit Interview Checklist")
            {
                DataItemLink = "Employee No" = FIELD ("Employee No.");
                DataItemTableView = SORTING ("Exit Interview No", "Line No");
                column(HR_Exit_Interview_Checklist__Clearance_Date_; "Clearance Date")
                {
                }
                column(HR_Exit_Interview_Checklist__CheckList_Item_; "CheckList Item")
                {
                }
                column(HR_Exit_Interview_Checklist_Cleared; Cleared)
                {
                }
                column(HR_Exit_Interview_Checklist__Cleared_By_; "Cleared By")
                {
                }
                column(HR_Exit_Interview_Checklist__Clearance_Date_Caption; FieldCaption("Clearance Date"))
                {
                }
                column(HR_Exit_Interview_Checklist__CheckList_Item_Caption; FieldCaption("CheckList Item"))
                {
                }
                column(HR_Exit_Interview_Checklist_ClearedCaption; FieldCaption(Cleared))
                {
                }
                column(Departmental_Clearance_Caption; Departmental_Clearance_CaptionLbl)
                {
                }
                column(HR_Exit_Interview_Checklist__Cleared_By_Caption; FieldCaption("Cleared By"))
                {
                }
                column(HR_Exit_Interview_Checklist_Exit_Interview_No; "Exit Interview No")
                {
                }
                column(HR_Exit_Interview_Checklist_Line_No; "Line No")
                {
                }
                column(HR_Exit_Interview_Checklist_Employee_No; "Employee No")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD ("Cleared By");
                    DataItemTableView = SORTING ("User ID");
                    column(SignatureCaption; SignatureCaptionLbl)
                    {
                    }
                    column(User_Setup_User_ID; "User ID")
                    {
                    }
                }
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
        HR_Employee_Exit_InterviewsCaptionLbl: Label 'HR Employee Exit Interviews';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Exit_Interview_ChecklistCaptionLbl: Label 'Exit Interview Checklist';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        Misc__Articles_Clearance_CaptionLbl: Label 'Misc. Articles Clearance:';
        Departmental_Clearance_CaptionLbl: Label 'Departmental Clearance:';
        SignatureCaptionLbl: Label 'Signature';
}

