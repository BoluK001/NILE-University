page 51534625 "Salary Notches"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Salary Notch";
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Salary Notches';

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Salary Notch"; "Salary Notch")
                {
                    Editable = true;   //jj120422 I changed to true
                    ApplicationArea = All; //jj120422 I added
                }
                field(Description; Description)
                {
                    Editable = false;  //jj120422 I changed to true
                    ApplicationArea = All; //jj120422 I added
                }
                field("Position Clinic Allowance"; "Position Clinic Allowance")
                {
                    Caption = 'Position Clinical Allowance';
                    ApplicationArea = All;
                }
                field("Gross Annual Salary"; "Gross Annual Salary")
                {
                    ApplicationArea = All;
                }
                field("Basic  Pay"; "Basic  Pay")
                {
                    ApplicationArea = all;
                }

                field("Hourly Rate"; "Hourly Rate")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Salary Grade"; "Salary Grade")
                {
                    ApplicationArea = all;
                }
                field("Annual Salary Amount"; "Annual Salary Amount")
                {
                    Editable = false;
                    ApplicationArea = All; //jj120422 I added
                }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Notch)
            {
                Caption = 'Notch';
                action(Transactions)
                {
                    Caption = 'Transactions';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Salary Step/Notch Transactions";
                    RunPageLink = "Salary Grade" = FIELD("Salary Grade"),
                                  "Salary Step/Notch" = FIELD("Salary Notch");
                    ApplicationArea = All; //jj120422 I added
                }
                separator(Action1102755015)
                {
                }
                action("Update All Employees Transactions")
                {
                    Caption = 'Update All Employees Transactions';
                    Image = UpdateDescription;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All; //jj120422 I added

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to update all employees in this salary step/notch with the changes?', false) = false then
                            exit;

                        Employee.Reset;
                        Employee.SetRange(Employee."Salary Grade", "Salary Grade");
                        //Employee.SetRange(Employee."Salary Notch/Step", "Salary Notch");  //jj150522 I remmed so that all Notch can update at once for the salary grade
                        if Employee.Find('-') then begin
                            repeat
                                Employee.Validate(Employee."Salary Notch/Step");
                                Employee.Modify;

                            until Employee.Next = 0;
                        end;

                        Message('Update completed successfully.');
                    end;
                }
            }
        }
    }

    var
        Employee: Record "HR-Employee";
}

