report 51534705 "HR Applicant to Employee"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Job Applications"; "HR Job Applications")
        {
            RequestFilterFields = "Application No", Qualified;
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
            column(HR_Job_Applications__Application_No_; "Application No")
            {
            }
            column(HR_Job_Applications__FullName; "HR Job Applications".FullName)
            {
            }
            column(HR_Job_Applications__Postal_Address_; "Postal Address")
            {
            }
            column(HR_Job_Applications_City; City)
            {
            }
            column(HR_Job_Applications__Post_Code_; "Post Code")
            {
            }
            column(HR_Job_ApplicationsCaption; HR_Job_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Job_Applications__Application_No_Caption; FieldCaption("Application No"))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(HR_Job_Applications__Postal_Address_Caption; FieldCaption("Postal Address"))
            {
            }
            column(HR_Job_Applications_CityCaption; FieldCaption(City))
            {
            }
            column(HR_Job_Applications__Post_Code_Caption; FieldCaption("Post Code"))
            {
            }

            trigger OnPostDataItem()
            begin
                mLineNo := 0;
                "HR Job Applications".Reset;
                "HR Job Applications".SetRange("HR Job Applications"."Application No", JopAppNo);
                if "HR Job Applications".Find('-') then begin

                    if Confirm('Are you sure you want to upload qualified applicant information to the Employee card?', true) = false then exit;
                    begin
                        repeat
                            if "Employee No" = '' then
                                HRSetup.Get;
                            //HRSetup.TESTFIELD("Employee Nos.");

                            objEmReq.Reset;
                            objEmReq.SetRange(objEmReq."Requisition No.", "HR Job Applications"."Employee Requisition No");
                            if objEmReq.Find('-') then begin
                                if objEmReq."Recruitment Type" = objEmReq."Recruitment Type"::External then begin
                                    JobID := objEmReq."Job ID";
                                    GlobalDim2 := objEmReq."Shortcut Dimension 2 Code";

                                    /*  objNoSeries.RESET;
                                      objNoSeries.SETRANGE(objNoSeries.Code,HRSetup."Employee Nos.");
                                      //objNoSeries.SETRANGE(objNoSeries."Series Filter",objEmReq."Global Dimension 2 Code");
                                      IF objNoSeries.FIND('-') THEN BEGIN
                                       //NoSeriesMgt.InitSeries(objNoSeries."Series Code","HR Job Applications"."No. Series",0D,"Employee No","No. Series");
                                      END; */
                                    // END;
                                    HREmp.Init;
                                    //HREmp."No.":="HR Job Applications"."Employee No";
                                    HREmp."First Name" := "First Name";
                                    HREmp."Middle Name" := "Middle Name";
                                    HREmp."Last Name" := "Last Name";
                                    HREmp."Search Name" := "Search Name";
                                    HREmp."Postal Address" := "Postal Address";
                                    HREmp."Residential Address" := "Residential Address";
                                    HREmp.City := City;
                                    HREmp."Post Code" := "Post Code";
                                    HREmp.County := County;
                                    HREmp."Home Phone Number" := "Home Phone Number";
                                    HREmp."Cell Phone Number" := "Cell Phone Number";
                                    HREmp."Work Phone Number" := "Work Phone Number";
                                    HREmp."Ext." := "Ext.";
                                    HREmp."Personal E-Mail" := "E-Mail";
                                    HREmp."ID Number" := "ID Number";
                                    HREmp.Gender := Gender;
                                    HREmp.Citizenship := "Country Code";
                                    HREmp.Validate(Citizenship);
                                    HREmp."Fax Number" := "Fax Number";
                                    HREmp."Marital Status" := "Marital Status";
                                    HREmp."Ethnic Origin" := "Ethnic Origin";
                                    HREmp."First Language (R/W/S)" := "First Language (R/W/S)";
                                    //HREmp."Has Driving Licence":=HREmp."Has Driving Licence"::"Driving Licence";
                                    HREmp.Disabled := Disabled;
                                    //HREmp."Health Assesment?:="Health Assesment?";
                                    HREmp."-" := "Health Assesment Date";
                                    HREmp."Date Of Birth" := "Date Of Birth";
                                    HREmp.Age := Age;
                                    HREmp."Second Language (R/W/S)" := "Second Language (R/W/S)";
                                    HREmp."Additional Language" := "Additional Language";
                                    HREmp."Postal Address 2" := "Postal Address2";
                                    HREmp."Postal Address 3" := "Postal Address3";
                                    HREmp."Residential Address 2" := "Residential Address2";
                                    HREmp."Residential Address 3" := "Residential Address3";
                                    HREmp."Post Code 2" := "Post Code2";
                                    HREmp.Citizenship := Citizenship;
                                    HREmp."Passport Number" := "Passport Number";
                                    HREmp."First Language Read" := "First Language Read";
                                    HREmp."First Language Write" := "First Language Write";
                                    HREmp."First Language Speak" := "First Language Speak";
                                    HREmp."Second Language Read" := "Second Language Read";
                                    HREmp."Second Language Write" := "Second Language Write";
                                    HREmp."Second Language Speak" := "Second Language Speak";
                                    HREmp."PIN Number" := "PIN Number";
                                    HREmp."Global Dimension 2 Code" := GlobalDim2;
                                    HREmp.Validate("Global Dimension 2 Code");
                                    HREmp.County := County;
                                    HREmp.City := City;
                                    HREmp.Religion := Region;
                                    HREmp."Job Title" := JobID;
                                    HREmp.Validate("Job Title");
                                    HREmp.Grade := JobGrade;
                                    HREmp.Validate(Grade);
                                    HREmp."Supervisor/Manager" := "Supervisor/Manager";
                                    HREmp.Validate("Supervisor/Manager");
                                    HREmp."Supervisor's Job Title" := "Supervisor's Job Title";
                                    HREmp.Validate("Supervisor's Job Title");
                                    "HR Job Applications".Modify;
                                    HREmp.Insert(true);

                                    //Fill the Qualifications************************************* HREmp."No."
                                    EmpQualifications.Reset;
                                    EmpQualifications.SetRange(EmpQualifications."Line No.");
                                    if EmpQualifications.Find('+') then mLineNo := EmpQualifications."Line No.";

                                    mLineNo := mLineNo + 1;
                                    AppQualification.Reset;
                                    AppQualification.SetRange(AppQualification."Application No", "HR Job Applications"."Application No");
                                    if AppQualification.Find('-') then
                                        repeat
                                            EmpQualifications.Init;
                                            EmpQualifications."Employee No." := "HR Job Applications"."Employee No";
                                            EmpQualifications."From Date" := EmpQualifications."From Date";
                                            EmpQualifications."To Date" := EmpQualifications."To Date";
                                            EmpQualifications."Line No." := mLineNo;
                                            EmpQualifications.Type := EmpQualifications.Type;
                                            EmpQualifications.Description := EmpQualifications.Description;
                                            EmpQualifications."Institution/Company" := EmpQualifications."Institution/Company";
                                            EmpQualifications."Qualification Type" := AppQualification."Qualification Type";
                                            EmpQualifications."Qualification Code" := AppQualification."Qualification Code";
                                            EmpQualifications."Qualification Description" := AppQualification."Qualification Description";
                                            EmpQualifications.Insert;
                                            mLineNo := mLineNo + 1;
                                        until AppQualification.Next = 0;
                                end else
                                    if objEmReq."Recruitment Type" = objEmReq."Recruitment Type"::Internal then begin
                                        if HREmp.Get("HR Job Applications"."Employee No") then begin
                                            //HREmp."Department Code":=
                                            HREmp."Job Title" := objEmReq."Job ID";
                                            HREmp.Validate("Job Title");
                                            HREmp.Modify;


                                        end;
                                    end;
                            end;
                        until "HR Job Applications".Next = 0;


                        Message('Applicants Information successfully uploaded.');
                    end;

                end else begin
                    Message('No qualified applicants were found');
                end;

            end;

            trigger OnPreDataItem()
            begin
                /*IF JopAppNo='' THEN BEGIN
                //UPLOAD ALL QUALIFIED APPLICANTS WHO HAVE NOT ALREADY BEEN EMPLOYED
                "HR Job Applications".RESET;
                "HR Job Applications".SETRANGE("HR Job Applications".Qualified,TRUE);
                //"HR Job Applications".SETRANGE("HR Job Applications"."Employee No",'<>%1','');
                
                END ELSE BEGIN
                //UPLOAD THE SELECTED APPLICANT
                "HR Job Applications".RESET;
                "HR Job Applications".SETRANGE("HR Job Applications"."Application No",JopAppNo);
                END;
                 */

            end;
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
        JopAppNo := "HR Job Applications".GetFilter("HR Job Applications"."Application No");
    end;

    var
        HREmp: Record "HR Employees";
        HRSetup: Record "HR Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        JopAppNo: Code[20];
        HR_Job_ApplicationsCaptionLbl: Label 'HR Job Applications';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        EmpQualifications: Record "HR Employee Qualifications";
        AppQualification: Record "HR Applicant Qualifications";
        mLineNo: Integer;
        objNoSeries: Record "No. Series Relationship";
        objEmReq: Record "HR Employee Requisitions";
        HRJobs: Record "HR Jobs";
        JobID: Code[20];
        GlobalDim2: Code[20];
        JobGrade: Code[20];
}

