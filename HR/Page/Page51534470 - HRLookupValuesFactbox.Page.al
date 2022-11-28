page 51534470 "HR Lookup Values Factbox"
{
    Caption = 'HR Lookup Values Factbox';
    PageType = CardPart;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            field(Type; Type)
            {
                ApplicationArea = all;
            }
            field("Code"; Code)
            {
                ApplicationArea = all;
            }
            field(Description; Description)
            {
                ApplicationArea = all;
            }
            field(Remarks; Remarks)
            {
                ApplicationArea = all;
            }
            field("Notice Period"; "Notice Period")
            {
                ApplicationArea = all;
            }
            field(Closed; Closed)
            {
                ApplicationArea = all;
            }
            field("Contract Length"; "Contract Length")
            {
                ApplicationArea = all;
            }
            field("Current Appraisal Period"; "Current Appraisal Period")
            {
                ApplicationArea = all;
                Visible = false;  //jj300922
            }
            field("Disciplinary Case Rating"; "Disciplinary Case Rating")
            {
                ApplicationArea = all;
                Visible = false;  //jj300922
            }
            field("Disciplinary Action"; "Disciplinary Action")
            {
                ApplicationArea = all;
                Visible = false;  //jj300922
            }
            field(From; From)
            {
                ApplicationArea = all;
            }
            field("To"; "To")
            {
                ApplicationArea = all;
            }
            field(Score; Score)
            {
                ApplicationArea = all;
            }
            field("Basic Salary"; "Basic Salary")
            {
                ApplicationArea = all;
                Visible = false;  //jj300922
            }
            field("To be cleared by"; "To be cleared by")
            {
                ApplicationArea = all;
                Visible = false;  //jj300922
            }
        }
    }

    actions
    {
    }
}

