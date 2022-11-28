page 51534516 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Shortlisted Applicants";
    SourceTableView = WHERE("Shortlist Type" = CONST("Application Stage"));
    AdditionalSearchTerms = 'Shorlisted Candidates';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Qualified; Qualified)
                {
                    Caption = 'Qualified';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        "Manual Change" := true;
                        Modify;
                    end;
                }
                field("Job Application No"; "Job Application No")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = all;
                }
                field("Stage Score"; "Stage Score")
                {
                    ApplicationArea = all;
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                }
                field(Employ; Employ)
                {
                    Caption = 'Employed';
                    ApplicationArea = all;
                }
                field("Reporting Date"; "Reporting Date")
                {
                    ApplicationArea = all;
                }
                field("Manual Change"; "Manual Change")
                {
                    Caption = 'Manual Change';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;

    [Scope('OnPrem')]
    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

