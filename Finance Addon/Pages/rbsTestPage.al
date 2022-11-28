/// <summary>
/// Page rbsTest (ID 50101).
/// </summary>
page 51534430 SISStudentDetails
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StudentDetails;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Id; rec.Id)
                {
                    ApplicationArea = All;
                }
                field(IntegrationStatus; Rec.IntegrationStatus)
                {
                    ApplicationArea = All;
                }
                field(StudentNo; Rec.StudentNo)
                {
                    ApplicationArea = All;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Telephone No."; Rec."Telephone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Number Of Semesters Done"; Rec."Number Of Semesters Done")
                {
                    ApplicationArea = All;
                }
                field("Remaining Semester"; Rec."Remaining Semester")
                {
                    ApplicationArea = All;
                }
                field("Level Of Study"; Rec."Level Of Study")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Date Added"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Date Last Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Created on BC"; Rec."Created on BC")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                }
                field("Record Type"; Rec."Record Type")
                {
                    ApplicationArea = All;
                }
                field("Integration Status"; Rec."Integration Status")
                {
                    ApplicationArea = All;
                }
                field("Customer Id"; Rec."Customer Id")
                {
                    ApplicationArea = All;
                }
                field(MiscRef1; Rec.MiscRef1)
                {
                    ApplicationArea = All;
                }
                field(MiscRef2; Rec.MiscRef2)
                {
                    ApplicationArea = All;
                }
                field(MiscRef3; Rec.MiscRef3)
                {
                    ApplicationArea = All;
                }
                field(MiscRef4; Rec.MiscRef4)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Prospective Id"; Rec."Prospective Id")
                {
                    ApplicationArea = All;
                }
                field(Stud_ID; Rec.Stud_ID)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field("Current Year Of Study"; Rec."Current Year Of Study")
                {
                    ApplicationArea = All;
                }
                field("Programme Duration"; Rec."Programme Duration")
                {
                    ApplicationArea = All;
                }
                field("Relief Rate"; Rec."Relief Rate")
                {
                    ApplicationArea = All;
                }
                field("Relief Type"; Rec."Relief Type")
                {
                    ApplicationArea = All;
                }
                field("Relief Type2"; Rec."Relief Type2")
                {
                    ApplicationArea = All;
                }
                field("Student Statuse"; Rec."Student Statuse")
                {
                    ApplicationArea = All;
                }
                field(Birth_Date; Rec.Birth_Date)
                {
                    ApplicationArea = All;
                }
                field(Other_Email; Rec.Other_Email)
                {
                    ApplicationArea = All;
                }
                field("Enrollment Type"; Rec."Enrollment Type")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action(RBS1)
            {
                ApplicationArea = All;
                Caption = 'Fetch Student Details';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getstudentdetails();
                    CurrPage.Update();
                end;

            }
            action(UpdatedCus)
            {
                ApplicationArea = All;
                Caption = 'Push to BC';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    urlcu: Codeunit SisIntegration;
                    sturec: Record StudentDetails;
                begin
                    sturec.reset;
                    sturec.SetFilter("Created on BC", '%1', false);
                    //sturec.SetFilter();
                    if sturec.FindFirst() then
                        repeat
                            urlcu.createstudentdetail(sturec);
                            sturec."Created on BC" := true;
                            sturec.Modify();
                        until sturec.next = 0;
                    CurrPage.Update();
                    Message('Done');
                end;

            }
            action(RBS2)
            {
                ApplicationArea = All;
                Caption = 'Student Invoices';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                //visible = false;


                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getstudentInvoice();
                end;
            }
            action(RBS3)
            {
                ApplicationArea = All;
                Caption = 'Student Payments';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = false;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getstudentPayment();
                end;

            }
            action(RBS4)
            {
                ApplicationArea = All;
                Caption = 'Transaction Codes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = false;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getTramsactionCodes();
                end;

            }
        }

    }
}