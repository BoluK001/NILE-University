page 51534408 "Employee Intranet List"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = CONST(Active));
    AdditionalSearchTerms = 'Employee Intranet List';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("First Name"; Rec."First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(BirthDay; Rec.BirthDay)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Location; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Location';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("SMS/WhatsApp Number"; Rec."Cell Phone Number")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //Rec.SETFILTER("Date Of Birth", '');

        Rec.SetFilter("Date Of Birth", '<>%1', 0D);
    end;

    var
        Birthday: Date;
        Day: Integer;
        Month: Text;
}

