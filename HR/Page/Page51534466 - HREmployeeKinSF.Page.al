page 51534466 "HR Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Employee Kin & Beneficiaries';
    SourceTable = "HR Employee Kin";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = all;
                }
                field(SurName; SurName)
                {
                    ApplicationArea = all;
                }
                field("Other Names"; "Other Names")
                {
                    ApplicationArea = all;
                }
                field("ID No/Passport No"; "ID No/Passport No")
                {
                    ApplicationArea = all;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        FrmCalendar.SetDate("Date Of Birth");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Birth" := D;
                        */

                    end;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                }
                field("Office Tel No"; "Office Tel No")
                {
                    ApplicationArea = all;
                }
                field("Home Tel No"; "Home Tel No")
                {
                    ApplicationArea = all;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee Code"),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}

