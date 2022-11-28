page 51534659 "HR HMO Beneficiary ListPart"
{
    Caption = 'Beneficiaries';
    PageType = ListPart;
    SourceTable = "HR HMO Beneficiary";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; "Staff No.")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj300922
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;  //jj300922
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
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = all;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = all;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Active")
            {
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    SetFilter(Active, '=%1', true);
                end;
            }
            action(Picture)
            {
                RunObject = Page "Hr Hmo Picture";
                RunPageLink = "Staff No." = FIELD("Staff No."),
                              "Line No." = FIELD("Line No.");
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CheckActive;
    end;
}

