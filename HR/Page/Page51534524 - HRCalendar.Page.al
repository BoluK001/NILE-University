page 51534524 "HR Calendar"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "Base Calendar";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field(year; year)
                {
                    ApplicationArea = all;
                }
                field(Start; Start)
                {
                    ApplicationArea = all;
                }
                field(Ends; Ends)
                {
                    ApplicationArea = all;
                }
                field(Current; Current)
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = all;
                }
            }
            part(Control1102755000; "HR Non Working Days & Dates")
            {
            }
            part(Control1102755001; "Base Calendar Entries Subform")
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Effect Changes")
                {
                    ApplicationArea = all;
                    Caption = 'Effect Changes';
                    Image = Save;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRCalendarList.SetRange(HRCalendarList.Code, year);
                        HRCalendarList.SetRange("Non Working", true);
                        if HRCalendarList.Find('-') then
                            repeat
                                HRCalendarList."Non Working" := false;
                                HRCalendarList.Modify;
                            until HRCalendarList.Next = 0;




                        HRCalendarList.Reset;
                        REPORT.Run(51534634, true, true, HRCalendarList);
                        CurrPage.Update;
                    end;
                }
                action("Import Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Import Calendar';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //XMLPORT::Calendar;
                        //XMLPORT.RUN(XMLPORT::"HR Calendar");
                    end;
                }
            }
        }
    }

    var
        HRCalendarList: Record "HR Calendar List";
        Day: Date;
        year: Code[20];
        Start: Integer;
        Ends: Integer;
        Current: Integer;
}

