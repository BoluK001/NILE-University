page 51534457 "HR Leave Journal Lines"
{
    AutoSplitKey = false;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;

                    //Rec.RESET;

                    InsuranceJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    InsuranceJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                }
                field("Leave Period"; "Leave Period")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        "Leave Period Closed" := false;
                        if HRLeavePeriods.Get("Leave Period") then begin
                            if HRLeavePeriods.Closed then
                                "Leave Period Closed" := true;
                        end;
                    end;
                }
                field("Staff No."; "Staff No.")
                {
                    ApplicationArea = all;
                    LookupPageID = "HR Employee List";
                }
                field("Staff Name"; "Staff Name")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Leave Entry Type"; "Leave Entry Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Days"; "No. of Days")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Leave Period Start Date"; "Leave Period Start Date")
                {
                    ApplicationArea = all;
                }
                field("Leave Period End Date"; "Leave Period End Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Post Adjustment")
                {
                    ApplicationArea = all;
                    Caption = 'Post Adjustment';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        //IF ISEMPTY THEN EXIT;

                        //RESET;
                        //SETRANGE("Journal Template Name",'ISSUE');
                        //SETRANGE("Journal Batch Name",'LEAVE');
                        //IF FIND('-') THEN BEGIN
                        CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", Rec);

                        //END;

                        CurrentJnlBatchName := GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Batch Allocation")
                {
                    ApplicationArea = all;
                    Image = Batch;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin

                        AllocationDone := false;

                        HRJournalBatch.Reset;
                        HRJournalBatch.Get("Journal Template Name", "Journal Batch Name");


                        //GET THE CURRENT LEAVE PERIOD
                        HRLeavePeriods.Reset;
                        HRLeavePeriods.SetRange(HRLeavePeriods."New Fiscal Year", false);
                        HRLeavePeriods.Find('-');


                        //WE ARE ALLOCATING FOR ACTIVE EMPLOYEES ONLY
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.FindFirst;

                        HRLeaveTypes.Reset;
                        HRLeaveTypes.FindFirst;
                        begin


                            repeat


                                repeat


                                    //CHECK IF ALLOCATION OF CURRENT LEAVE TYPE FOR THE CURRENT PERIOD AND FOR CURRENT EMPLOYEE HAS BEEN DONE
                                    HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.", HREmp."No.");
                                    HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type", HRLeaveTypes.Code);
                                    HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type", HRJournalBatch.Type);
                                    HRLeaveLedger.SetRange(HRLeaveLedger."Leave Period", Format(HRLeavePeriods."Starting Date"));
                                    if not HRLeaveLedger.Find('-') then
                                        OK := CheckGender(HREmp, HRLeaveTypes);

                                    if OK then begin

                                        //INSERT INTO JOURNAL
                                        Init;
                                        "Journal Template Name" := "Journal Template Name";
                                        "Journal Batch Name" := "Journal Batch Name";
                                        "Line No." := "Line No." + 1000;
                                        "Leave Period" := Format(HRLeavePeriods."Starting Date");
                                        "Staff No." := HREmp."No.";
                                        Validate("Staff No.");
                                        "Posting Date" := Today;
                                        Description := HRJournalBatch."Posting Description";
                                        "Leave Entry Type" := HRJournalBatch.Type;
                                        "Leave Type" := HRLeaveTypes.Code;
                                        "No. of Days" := HRLeaveTypes.Days;
                                        "Leave Period Start Date" := HRLeavePeriods."Starting Date";
                                        //"Leave Period End Date":=HRLeavePeriods.Ends;
                                        "Document No." := 'N/A';
                                        Insert();

                                        AllocationDone := true;

                                    end;

                                until HRLeaveTypes.Next = 0;

                                HRLeaveTypes.FindFirst;

                            until HREmp.Next = 0;
                        end;
                        HRLeaveTypes.FindFirst;

                        if not AllocationDone then
                            Message('Allocation of leave days for ' + Format(HRLeavePeriods."Starting Date") +
                             ' period has already been done for all ACTIVE employees');
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        InsuranceJnlManagement: Codeunit LeaveJnlManagement;
    begin
        OpenedFromBatch := ("Journal Batch Name" <> '') and ("Journal Template Name" = '');
        if OpenedFromBatch then begin
            CurrentJnlBatchName := "Journal Batch Name";
            InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
            exit;
        end;
        InsuranceJnlManagement.TemplateSelection(PAGE::"HR Leave Journal Lines", Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
    end;

    var
        HRLeaveTypes: Record "HR Leave Types";
        HREmp: Record "HR Employees";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        InsuranceJnlManagement: Codeunit LeaveJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[20];
        InsuranceDescription: Text[30];
        FADescription: Text[30];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRJournalBatch: Record "HR Leave Journal Batch";
        OK: Boolean;
        HRLeaveJournalTemplate: Record "HR Leave Journal Template";

    [Scope('OnPrem')]
    procedure CheckGender(Emp: Record "HR Employees"; LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin

        //CHECK IF LEAVE TYPE ALLOCATION APPLIES TO EMPLOYEE'S GENDER

        if Emp.Gender = Emp.Gender::Male then begin
            if LeaveType.Gender = LeaveType.Gender::Male then
                Allocate := true;
        end;

        if Emp.Gender = Emp.Gender::Female then begin
            if LeaveType.Gender = LeaveType.Gender::Both then
                Allocate := true;
        end;

        if LeaveType.Gender = LeaveType.Gender::Female then
            Allocate := true;
        exit(Allocate);

        if Emp.Gender <> LeaveType.Gender then
            Allocate := false;

        exit(Allocate);
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        //InsuranceJnlManagement.SetName(CurrentJnlBatchName,Rec);
        CurrPage.Update(false);
    end;
}

