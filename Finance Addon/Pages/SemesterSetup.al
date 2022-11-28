/// <summary>
/// Page Semester Setup (ID 50106).
/// </summary>
page 51534443 "Semester Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Semester Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }

                field("Semester Year"; Rec."Semester Year")
                {
                    ApplicationArea = all;
                }
                field("Semester Districption"; Rec."Semester Districption")
                {
                    ApplicationArea = all;

                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field("Days in Semester"; Rec."Days in Semester")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}