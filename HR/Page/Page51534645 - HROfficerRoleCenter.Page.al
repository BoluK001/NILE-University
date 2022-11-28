page 51534645 "HR Officer Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                systempart(Control1901420308; Outlook)
                {
                    ApplicationArea = all;
                }
            }
            group(Approvals) // jj270922  I added to profile
            {
                part(ApprovalsActivities; "Approvals Activities")
                {
                    ApplicationArea = Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control17; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj270922
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj270922
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {

            action("Employee List")
            {
                Caption = 'Employee List';
                ApplicationArea = all;
                Image = "Report";
            }
            action("HR HMO List")
            {
                Caption = 'HR HMO List';
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report "HR HMO List";
            }



            separator(Action1000000001)
            {
            }

        }
        area(embedding)
        {

            action("HMO Hospitals")
            {
                Caption = 'HMO Hospitals';
                ApplicationArea = All;
                RunObject = Page "HR HMO Hospitals";
            }
            action(HMO)
            {
                Caption = 'HMO';
                RunObject = Page "HR HMO List";
                ApplicationArea = all;
                // RunPageView = WHERE(Status = FILTER(Approved));  //jj290922
            }
            action("Drivers List")
            {
                Caption = 'Drivers List';
                ApplicationArea = all;
                RunObject = Page "HR Drivers List";
            }
            /*  action("HR Exit Interview List")
              {
                  Caption = 'HR Exit Interview List';
                  ApplicationArea = all;
                  RunObject = Page "HR Exit Interview HR List";
              }
              action("Exit Interview")
              {
                  Caption = 'Exit Interview';
                  ApplicationArea = all;
                  RunObject = Page "HR Exit Interview List";
              }  */   //jj290922  Made it not visible to users
        }
        area(sections)
        {
            group("Employee Management")
            {
                Caption = 'Employee Management';
                action(Employees)
                {
                    Caption = 'Employees';
                    ApplicationArea = all;
                    RunObject = Page "HR Employee List";
                    Visible = false;
                }
                action("Employees Management")
                {
                    Caption = 'Employees Management';
                    ApplicationArea = all;
                    RunObject = Page "HR Employee List";
                }
                action("Employee Absence Registration")
                {
                    Caption = 'Employees Management';
                    ApplicationArea = all;
                    RunObject = Page "HR Employee List";
                    visible = false; //jj010322
                }

                action("Inactive Employees")
                {
                    Caption = 'Inactive Employees';
                    ApplicationArea = all;
                    RunObject = Page "HR Inactive Employees";
                }
            }

            group("Recruitment Manager")
            {
                Caption = 'Recruitment Manager';
                action(Jobs)
                {
                    Caption = 'Jobs';
                    ApplicationArea = all;
                    RunObject = Page "HR Jobs List";
                }
                action("Employee Requisitons")
                {
                    Caption = 'Employee Requisitons';
                    RunObject = Page "HR Employee Requisitions List";
                    ApplicationArea = all;
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    Visible = false;
                }
                action("Job Applications")
                {
                    Caption = 'Job Applications';
                    ApplicationArea = all;
                    RunObject = Page "HR Job Applications List";
                }
                action("Applicants Test")
                {
                    Caption = 'Applicants Test';
                    ApplicationArea = all;
                    RunObject = Page "Hr Test List";
                    Visible = false;
                }
                action(Shortlisting)
                {
                    Caption = 'Shortlisting';
                    ApplicationArea = all;
                    RunObject = Page "HR Shortlisting List";
                }
                action("Shortlisted Applicants")
                {
                    Caption = 'Shortlisted Applicants';
                    ApplicationArea = all;
                    RunObject = Page "Hr Shortlisted Applicant";
                }
                action("Interview Evaluation")
                {
                    Caption = 'Interview Evaluation';
                    ApplicationArea = all;
                    RunObject = Page "Hr interview Evaluation List";
                }
                action("<Page Keep In-view Evaluation ")
                {
                    Caption = 'Keep In-view';
                    ApplicationArea = all;
                    RunObject = Page "Keep In-view Evaluation List";
                    Visible = false;
                }
                action("Shortlisting List (Test)")
                {
                    Caption = 'Shortlisting List (Test)';
                    RunObject = Page "HR Shortlisting List Test";
                }
                action("HR Interview Evaluation Areas")
                {
                    Caption = 'HR Interview Evaluation Areas';
                    ApplicationArea = all;
                    RunObject = Page "Hr Interview Evaluation Areas";
                }
                action("Shortlisting List Interview")
                {
                    Caption = 'Shortlisting List Interview';
                    ApplicationArea = all;
                    RunObject = Page "HR Shortlisting List Int";
                    Visible = false;
                }
                action("Shortlisted Candidates Interview")
                {
                    Caption = 'Shortlisted Candidates Interview';
                    ApplicationArea = all;
                    RunObject = Page "Shortlisted Candidates Intvw";
                    Visible = false;

                }
            }
            group("Training Management")
            {
                Caption = 'Training Management';
                action("Training Needs")
                {
                    Caption = 'Training Needs';
                    ApplicationArea = all;
                    RunObject = Page "HR Training Needs";
                }
                action("Training Application")
                {
                    Caption = 'HR Training Application';
                    ApplicationArea = all;
                    RunObject = Page "HR Training Application List";
                    // RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    Visible = True;  //jj040522 I added for Nile
                }
                action("HR Training Request")
                {
                    Caption = 'HR Training Request';
                    ApplicationArea = all;
                    RunObject = Page "Hr Training Request List";
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval")); //jj270422 I remmed
                    Visible = false; //jj290922
                }
                action("HOD Training Request")
                {
                    Caption = 'HOD Training Request';
                    ApplicationArea = all;
                    RunObject = Page "HR HOD Training Needs";
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                    Visible = false;  //jj040522 I added for Nile
                }
                action("Staff Training Evaluation")
                {
                    Caption = 'Staff Training Evaluation';
                    ApplicationArea = all;
                    RunObject = Page "Emp. Training Evaluation";
                    //RunPageView = WHERE("Send to Hr" = CONST(true));
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                action("Leave Types")
                {
                    Caption = 'Leave Types';
                    ApplicationArea = all;
                    RunObject = Page "HR Leave Types";
                }
                action("Leave Journal")
                {
                    Caption = 'Leave Journal';
                    ApplicationArea = All;
                    RunObject = Page "HR Leave Journal Lines";
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    ApplicationArea = all;
                    RunObject = Page "HR Leave Applications List";
                    // RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                }
                action("Leave Acknowledgements")
                {
                    Caption = 'Leave Acknowledgements';
                    ApplicationArea = all;
                    RunObject = Page "HR Leave Acknowledgments";
                    //RunPageView = WHERE(Status = FILTER(Approved | Open));
                }
                action(aaa)
                {
                    Caption = 'Approved Leave Applications';
                    ApplicationArea = all;
                    RunObject = Page "HR Leave Applications Admin";
                }
                action("Posted Leave Applications")
                {
                    RunObject = Page "Posted Leave Applications";
                    ApplicationArea = all;
                }
            }
            group("Appraisal Evaluation")    //jj290922  Made it not visible to users
            {
                Caption = 'Appraisal Evaluation';
                action("Approver User Setup")   //jj270422
                {
                    Caption = 'Approver User Setup';
                    RunObject = Page "Approver User Setup List";
                    ApplicationArea = all;
                }
                action("<Page Appraisal Goal Setting Lish")
                {
                    Caption = 'Page Appraisal Goal Setting First';
                    ApplicationArea = all;
                    RunObject = Page "Appraisal Goal Setting List";
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                }
                action("Appraisal Goal Setting List Second ")
                {
                    Caption = 'Appraisal Goal Setting List Second ';
                    ApplicationArea = all;
                    RunObject = Page "Appraisal Goal Setting Second";
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                }
                action("Appraisal Goal Setting Supervisor First")
                {
                    Caption = 'Appraisal Goal Setting Supervisor First';
                    RunObject = Page "Appraisal Goal Setting Fi";
                    ApplicationArea = all;
                    ///RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                }
                action("Appraisal Goal Setting Supervisor Second")
                {
                    Caption = 'Appraisal Goal Setting Supervisor Second';
                    ApplicationArea = all;
                    RunObject = Page "Appraisal Goal Setting List Se";
                    //RunPageView = WHERE(Status = FILTER(Approved | "Pending Approval"));
                }
                action("Appraisal Evaluation Areas")
                {
                    Caption = 'Appraisal Evaluation Areas';
                    ApplicationArea = all;
                    RunObject = Page "HR Appraisal Goal EV list";
                }
                action("Appraisal Rating")
                {
                    Caption = 'Appraisal Rating';
                    ApplicationArea = all;
                    RunObject = Page "HR Appraisal Ratings";
                }
                action("Self Evaluation")    //jj220622  I added page for visibility
                {
                    Caption = 'Self Evaluation';
                    ApplicationArea = all;
                    RunObject = Page "Self Evaluation";
                }
                action("HR Appraisal Objective List")      //jj220622  I added page for visibility
                {
                    Caption = 'HR Appraisal Objective List';
                    ApplicationArea = all;
                    RunObject = Page "HR Appraisal Objective List";
                }
                action("HR Ratings List")
                {
                    Caption = 'HR Ratings List';
                    ApplicationArea = All;
                    RunObject = page "HR Ratings List";
                }
                action("HR Career Questions")
                {
                    Caption = 'Appraisal Career Dev Questions';
                    ApplicationArea = All;
                    RunObject = page "HR Appraisal Career Dev Ques";
                }
                action("Appraiser:-Evaluation & Approval")
                {
                    Caption = 'Appraiser:-Evaluation & Approval';
                    ApplicationArea = all;
                    RunObject = Page "HR Appraisal Goal Setting HSL1";
                    Visible = false;
                }
                action("Appraisal:- Mngt Evaluation Form")
                {
                    Caption = 'Appraisal:- Mngt Evaluation Form';
                    RunObject = Page "HR Appraisal Goal EV list";
                    ApplicationArea = all;
                    Visible = false;
                }
                action("Appraisal:- MD's Comment & Evaluation")
                {
                    Caption = 'Appraisal:- MD''s Comment & Evaluation';
                    ApplicationArea = all;
                    RunObject = Page "HR Appaisal Goal EV list MD";
                    Visible = false;
                }
                action("Approved Appraisal")
                {
                    Caption = 'Approved Appraisal';
                    ApplicationArea = all;
                    RunObject = Page "HR Approved Appraisal";
                    Visible = false;
                }
                action("Appraisal History")
                {
                    Caption = 'Appraisal History';
                    ApplicationArea = all;
                    RunObject = Page "HR Approved Appraisal History";
                    Visible = false;
                }
                action("Completed Appraisal List")
                {
                    Caption = 'Completed Appraisal List';
                    ApplicationArea = All;
                    RunObject = page "Hr Appraisal List";
                }
                action("Job Responsibilities")
                {
                    Caption = 'Job Responsibilities';
                    ApplicationArea = all;
                    RunObject = Page "HR Appraisal Goal SettingHS li";
                    Visible = false;
                }

            }      //jj271022  Made it visible to users
                   /*group("Disciplinary Case Mgt")   //jj290922  Made it not visible to users
                   {
                       Caption = 'Disciplinary Case Mgt';
                       action("HR Query List")
                       {
                           Caption = 'HR Query List';
                           ApplicationArea = All;
                           RunObject = Page "HR Query List";
                       }
                       action("Disciplinary Cases")
                       {
                           Caption = 'Disciplinary Cases';
                           ApplicationArea = all;
                           RunObject = Page "HR Disciplinary Cases List";
                       }
                       action("Query")
                       {
                           Caption = 'Query';
                           RunObject = Page "HR Query List";
                           ApplicationArea = all;
                           RunPageView = WHERE("Send to Hr" = CONST(true));
                       }


                   }   */   //jj290922  Made it not visible to users
                            /* group("Human Resources")   //jj290922  Made it not visible to users
                             {
                                 Caption = 'Human Resources';

                                 action("Company Activities")
                                 {
                                     Caption = 'Company Activities';
                                     ApplicationArea = all;
                                     RunObject = Page "HR Company Activities List";
                                     Visible = false;
                                 }
                                 action("HR Staff Activities")
                                 {
                                     Caption = 'HR Staff Activities';
                                     ApplicationArea = all;
                                     RunObject = Page "HR Staff Activities List";
                                     Visible = false;
                                 }


                                 action("Canteen Application")
                                 {
                                     Caption = 'Canteen Application';
                                     ApplicationArea = all;
                                     RunObject = Page "HR Canteen Application List";
                                 }
                                 action("Posted Canteen Applications")
                                 {
                                     Caption = 'Posted Canteen Applications';
                                     ApplicationArea = All;
                                     RunObject = page "Posted Canteen Applications";
                                 }

                             }   */   //jj290922  Made it not visible to users
                                      /*group("Self Service")  jj280922  I remmed group as Self service portal will be used
                                      {
                                          Caption = 'Self Service';
                                          /*  action("Staff Claims")
                                            {
                                                Caption = 'Staff Claims';
                                                RunObject = Page "Staff Claims List";
                                                RunPageMode = Create;
                                            }
                                            action("Work Advance Requests")
                                            {
                                                Caption = 'Work Advance Requests';
                                                RunObject = Page "Staff Advance Surrender List";
                                                RunPageMode = Create;
                                            }

                                          action("Work Advance Retire")
                                          {
                                              Caption = 'Work Advance Retire';
                                              Image = Reconcile;
                                              Promoted = false;
                                              //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                                              //PromotedCategory = Process;
                                              RunObject = Page "Staff Advance Surrender List";
                                              RunPageMode = Create;
                                          } */
                                      /*
                                     action("Staff Activities")
                                     {
                                         Caption = 'Staff Activities';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Staff Activities List";
                                     }
                                     action("Employee Details")
                                     {
                                         Caption = 'Employee Details';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Employee List Self";
                                     }
                                     action("Employee Requisition")
                                     {
                                         Caption = 'Employee Requisitions';
                                         ApplicationArea = All;
                                         RunObject = Page "HR Employee Requisitions Self";
                                     }
                                     action(Action63)
                                     {
                                         Caption = 'Training Application';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Training Application Self";
                                     }
                                     action(Action62)
                                     {
                                         Caption = 'Staff Training Evaluation';
                                         ApplicationArea = all;
                                         RunObject = Page "Emp. Training Evaluation Self";
                                     }
                                     action("Leave Application")
                                     {
                                         Caption = 'Leave Application';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Leave Applications Self";
                                     }
                                     action("Leave Acknowledgment")
                                     {
                                         Caption = 'Leave Acknowledgment';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Leave Acknowledgments Self";
                                     }
                                     action("Comfirmation & Probation")  //jj270422
                                     {
                                         Caption = 'Comfirmation & Probation';
                                         RunObject = Page 51534416;
                                         ApplicationArea = all;
                                     }

                                     
                                     action("Appraisal First Half")
                                     {
                                         Caption = 'Appraisal First Half';
                                         ApplicationArea = all;
                                         RunObject = Page "Appraisal First Half Self";
                                     }
                                     action("Appraisal Second Half")
                                     {
                                         Caption = 'Appraisal Second Half';
                                         ApplicationArea = all;
                                         RunObject = Page "Appraisal Second Half";
                                     }
                                     action("Appraisal Supervisor Review List (First) ")  ////jj270422
                                     {
                                         Caption = 'Appraisal Supervisor Review List (First) ';
                                         RunObject = Page 51534694;
                                         ApplicationArea = all;
                                     }
                                     action("Appraisal Supervisor Review List (Second)")  ////jj270422
                                     {
                                         Caption = 'Appraisal Supervisor Review List (Second)';
                                         RunObject = Page 51534695;
                                         ApplicationArea = all;
                                     }
                                     action(Action57)
                                     {
                                         Caption = 'HMO';
                                         ApplicationArea = all;
                                         RunObject = Page "HR HMO List Self";
                                     }
                                     action("Page HR Canteen Application Card")
                                     {
                                         Caption = 'Canteen Application Card';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Canteen App List Self";
                                     }
                                     action("HR Exit Interview List Self")
                                     {
                                         Caption = 'HR Exit Interview List Self';
                                         ApplicationArea = all;
                                         RunObject = Page "HR Exit Interview List Self";
                                     }
                                 }    */
            group("HR Setup")
            {
                Caption = 'HR Setup';
                action(Setup)
                {
                    Caption = 'Setup';
                    ApplicationArea = all;
                    RunObject = Page "HR Setup List";
                }
                action("LookUp Values")
                {
                    Caption = 'LookUp Values';
                    ApplicationArea = all;
                    RunObject = Page "HR Lookup Values List";
                }
                /* action(Committees)   //jj290922  Made it not visible to users
                 {
                     Caption = 'Committees';
                     ApplicationArea = all;
                     RunObject = Page "HR Committees";
                 }  */
                action("Training Evaluation Template")
                {
                    Caption = 'Training Evaluation Template';
                    RunObject = Page "HR Training Eva. Template";
                    ApplicationArea = all;
                }
                /*action("HR Career Development Template")    //jj290922  Made it not visible to users
                {
                    Caption = 'HR Career Development Template';
                    RunObject = Page "HR Career Development Template";
                    ApplicationArea = all;
                } */
                action("HR Email Parameter")
                {
                    Caption = 'HR Email Parameter';
                    RunObject = Page "HR Email Parameter List";
                    ApplicationArea = all;
                }
                action("Units Of Measure")
                {
                    Caption = 'Units Of Measure';
                    ApplicationArea = all;
                    RunObject = Page "Human Res. Units of Measure";
                    Visible = false;
                }
                action("Causes Of Abscence")
                {
                    ApplicationArea = all;
                    Caption = 'Causes Of Abscence';
                    RunObject = Page "Causes of Absence";
                    Visible = false;
                }
                action("Causes Of Inactivity")
                {
                    Caption = 'Causes Of Inactivity';
                    ApplicationArea = all;
                    RunObject = Page "Causes of Inactivity";
                    Visible = false;
                }
                action("Misc. Articles")
                {
                    Caption = 'Misc. Articles';
                    ApplicationArea = all;
                    RunObject = Page "Misc. Articles";
                    Visible = false;
                }
                action(Confidential)
                {
                    Caption = 'Confidential';
                    ApplicationArea = all;
                    RunObject = Page Confidential;
                    Visible = false;
                }
                action("Leave Periods")
                {
                    Caption = 'Leave Periods';
                    ApplicationArea = all;
                    RunObject = Page "HR Leave Period List";
                    Visible = false;
                }
                action("Job Requirements")
                {
                    Caption = 'Job Requirements';
                    ApplicationArea = all;
                    RunObject = Page "HR Job Requirement Lines";
                    Visible = false;
                }
                action(Qualifications)
                {
                    Caption = 'Qualifications';
                    ApplicationArea = all;
                    RunObject = Page "HR Qualifications";
                    Visible = false;
                }
            }

            group("Approvals")
            {

                action("Approval Request Entries")
                {
                    Caption = 'Approval Request Entries';
                    ApplicationArea = all;
                    RunObject = Page "Approval Request Entries";
                }
                action("Requests to Approve")
                {
                    RunObject = page "Requests to Approve";
                    ApplicationArea = All;
                }
            }


        }
        area(creation)
        {   /*
            action(Employee)
            {
                Caption = 'Employee';
                Image = Employee;
                ApplicationArea = all;
                RunObject = Page "HR Employee Card";
                RunPageMode = Create;
            }
            action(Staff)
            {
                Caption = 'Staff';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Customer Card";
                RunPageMode = Create;
            }   */    //jj290922  I remmed  action
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }


            action("Rates & Ceilings")
            {
                Caption = 'Rates & Ceilings';
                Image = PayrollStatistics;
                ApplicationArea = all;
                RunObject = Page "prRates & Ceilings";
            }



            separator(Reset)
            {
                Caption = 'Reset';
            }



        }
    }
}

