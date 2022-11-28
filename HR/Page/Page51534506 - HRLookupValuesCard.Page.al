page 51534506 "HR Lookup Values Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field("Contract Length"; Rec."Contract Length")
                {
                    ApplicationArea = all;
                }
                label(Control1102755023)
                {
                    ApplicationArea = all;
                    CaptionClass = Text19024457;
                    ShowCaption = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                }
                field("Current Appraisal Period"; Rec."Current Appraisal Period")
                {
                    ApplicationArea = all;
                    //Visible = false;  //jj300922
                }
                field("Disciplinary Case Rating"; Rec."Disciplinary Case Rating")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj300922
                }
                field("Disciplinary Action"; Rec."Disciplinary Action")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj300922
                }
                field(From; Rec.From)
                {
                    ApplicationArea = all;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = all;
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj300922
                }
                field("To be cleared by"; Rec."To be cleared by")
                {
                    ApplicationArea = all;
                    Visible = false;  //jj300922
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    Editable = EmpEdit;
                    ApplicationArea = all;
                }
                field("Exam Leave Days"; Rec."Exam Leave Days")
                {
                    Editable = JobEdit;
                    ApplicationArea = all;
                }

                field("HMO Plan"; Rec."HMO Plan")
                {
                    ApplicationArea = All;
                }
                field("HMO Beneficiaries"; Rec."HMO Beneficiaries")
                {
                    Editable = JobEdit;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Type = Rec.Type::"Employment Type" then
            EmpEdit := false
        else
            if Rec.Type = Rec.Type::"Job Level" then
                JobEdit := false;
    end;

    trigger OnOpenPage()
    begin
        EmpEdit := true;
        JobEdit := true;

        if Rec.Type = Type::"Employment Type" then
            EmpEdit := false
        else
            if Rec.Type = Type::"Job Level" then
                JobEdit := false;
    end;

    var
        Text19024457: Label 'Months';
        EmpEdit: Boolean;
        JobEdit: Boolean;
}

