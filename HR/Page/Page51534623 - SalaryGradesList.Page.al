page 51534623 "Salary Grades List"
{
    CardPageID = "Salary Grades";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Salary Grades";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Salary Grades List';

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Amount"; "Salary Amount")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        FilterPage2;
    end;

    var
        UserSetupMgt: Codeunit "User Setup Management";
        PayrollUserMgt: Codeunit "Payroll User Mgt";
        UserSetup: Record "User Setup";
        CurGroup: Text[100];

    local procedure FilterPage2()
    var
        UserSet: Record "User Setup";
    begin
        if PayrollUserMgt.GetGradeFilter <> '' then begin
            FilterGroup(2);
            SetRange("Grade Classification", PayrollUserMgt.GetGradeFilter);
            CurGroup := GetFilter("Grade Classification");
            FilterGroup(0);
        end;
    end;
}

