page 51534599 "Emp. Training Eval - Card"
{
    DataCaptionFields = "Entry No.", "Emp Code";
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Emp Traing Eval. Questionaire";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp Code"; "Emp Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    HideValue = false;
                }
                field("Training Code"; "Training Code")
                {
                    ApplicationArea = all;
                }
                field("Training Evaluation Category"; "Training Evaluation Category")
                {
                    ApplicationArea = all;  //jj270422

                    trigger OnValidate()   //I unremmed this function
                    begin
                        TESTFIELD("Training Code");
                        TrainCat := 0;
                        EmpQuestionandanswer.RESET;
                        EmpQuestionandanswer.SETRANGE(EmpQuestionandanswer."Emp Code", "Emp Code");
                        EmpQuestionandanswer.SETRANGE(EmpQuestionandanswer."Training Code", "Training Code");
                        EmpQuestionandanswer.SETRANGE(EmpQuestionandanswer."Training Evaluation Category", "Training Evaluation Category");
                        IF NOT EmpQuestionandanswer.FINDFIRST THEN BEGIN
                            // IF NOT EmpQuestionandanswer.COUNT > 2 THEN BEGIN
                            Noofrecords := EmpQuestionandanswer.COUNT;

                            IF Noofrecords <= 1 THEN BEGIN

                                TrainingQuestions.RESET;
                                TrainingQuestions.SETRANGE(TrainingQuestions."Training Category", "Training Evaluation Category");
                                IF TrainingQuestions.FINDFIRST THEN BEGIN
                                    TrainCat := "Training Evaluation Category";
                                    EmpCode := "Training Code";


                                    REPEAT

                                        // EmpQuestionandanswer.RESET;
                                        IF FINDLAST THEN BEGIN
                                            "Entry No." := "Entry No." + 1;
                                            INIT;
                                            "Training Code" := EmpCode;
                                            "Training Evaluation Category" := TrainingQuestions."Training Category";
                                            "Evaluation question No" := TrainingQuestions."Training Eval Question No.";
                                            "Traning Evaluation Question" := TrainingQuestions."Training Eval. Question";
                                            // VALIDATE("Evaluation question No");
                                            //VALIDATE("Traning Evaluation Question");
                                            INSERT;
                                        END;

                                    UNTIL TrainingQuestions.NEXT = 0;
                                END;

                            END ELSE BEGIN
                                ERROR('The record already exist');
                            END;
                        END;


                    end;
                }
                field("Evaluation Date"; "Evaluation Date")
                {
                    ApplicationArea = all;
                }
                field("Sent to HR"; "Sent to HR")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group(Control9)
            {
                ShowCaption = false;
                part(Control5; "Emp Pre-Train Eval. Subform")
                {
                    SubPageLink = "Emp Code" = FIELD("Emp Code"),
                                  "Training Evaluation Category" = FIELD("Training Evaluation Category"),
                                  "Training Code" = FIELD("Training Code");
                    ApplicationArea = all;  //jj270422
                }
                part(Control8; "HR Evaluation Answer FB")
                {
                    Provider = Control5;
                    SubPageLink = "Emp Code" = FIELD("Emp Code"),
                                  "Training Evaluation Category" = FIELD("Training Evaluation Category"),
                                  "Training Code" = FIELD("Training Code"),
                                  "Line No." = FIELD("Line No.");
                    ApplicationArea = all;  //jj270422
                }
            }
            field(TrainCat; TrainCat)
            {
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            group(Action12)
            {
                action("Send to HR")
                {
                    Image = SendElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All; //jj270422

                    trigger OnAction()
                    begin
                        /*IF "Send to Hr" THEN
                         EXIT
                        
                        ELSE IF CONFIRM('Form will be forwarded to HR,click ok to continue',FALSE) THEN BEGIN
                        
                          IF "Training Code" <> '' THEN BEGIN
                            IF "Training Evaluation Category" = "Training Evaluation Category"::Post THEN BEGIN
                              ReminderBuffer.RESET;
                              IF ReminderBuffer.FIND('+') THEN
                              iEntryNo:=ReminderBuffer."Entry No";
                              iEntryNo:=iEntryNo+1;
                        
                              ReminderBuffer.INIT;
                              ReminderBuffer."Entry No" := iEntryNo;
                              ReminderBuffer."Reminder Code" := "Training Code";
                              ReminderBuffer."Reminder Type" := ReminderBuffer."Reminder Type"::"3 Months Post Evaluation";
                              ReminderBuffer."Entry Date" :=   TODAY;
                              ReminderBuffer."Reminder Start Date" :=  CALCDATE('3M',TODAY);
                              ReminderBuffer."User to be Reminded" := USERID;
                              ReminderBuffer."Entered by" := USERID;
                              ReminderBuffer."Reminder Message"  :=   '3 months post training evaluation for ' + FORMAT("Training Code");
                              ReminderBuffer."Reminder Expiry Date" := CALCDATE('93D',TODAY);
                              ReminderBuffer.INSERT;
                            END;
                          END;
                        
                          "Send to HR":=TRUE;
                          SenttoHR :=TRUE;
                          MODIFY;
                          MESSAGE('Document has been transferred to HR');
                        
                        END;
                        */

                        if "Send to Hr" then
                            Message('Form will be forwarded to HR,click ok to continue');
                        if Confirm('Form will be forwarded to HR,click ok to continue', false) then begin
                            "Send to Hr" := true;
                            //MESSAGE('I got here');
                            //EmpQuestionandanswer.GET;
                            //EmpQuestionandanswer."Sent to HR" := TRUE;
                            //EmpQuestionandanswer.MODIFY;
                            //HRTrainingRec.GET;
                            "Sent to HR" := true;
                            //HRTrainingRec."Sent to HR" := TRUE;
                            //HRTrainingRec.MODIFY;
                            Modify;
                            Message('Document has been transferred to HR');

                        end;

                    end;
                }
                action("Pre Evaluation")
                {
                    Caption = 'Pre Evaluation Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All; //jj270422

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("Emp Code", "Emp Code");
                        SetFilter("Training Code", "Training Code");
                        REPORT.Run(51534517, true, true, Rec);
                        Reset;
                    end;
                }
                action("Post Evaluation")
                {
                    Caption = 'Post Evaluation Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All; //jj270422

                    trigger OnAction()
                    begin
                        Reset;
                        SetFilter("Emp Code", "Emp Code");
                        SetFilter("Training Code", "Training Code");
                        REPORT.Run(51534519, true, true, Rec);
                        Reset;
                    end;
                }
                action("Test Attachment")
                {
                    Caption = 'Attachment';
                    Image = Attach;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = Page "Attachment Test";
                    //RunPageLink = "Employee No" = FIELD ("Emp Code"),
                    //            "Application No" = FIELD ("Entry No."),
                    //          "Folder Type" = CONST (HR),
                    //        "Document Type" = CONST (Evaluation);
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.Get(UserId);
        Emp.SetRange("User ID", UserSetup."User ID");
        if Emp.FindFirst then begin
            "Emp Code" := Emp."No.";
            "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
        end;
    end;

    trigger OnOpenPage()
    begin
        //
    end;

    var
        TrainingQuestions: Record "Training Eval. question line";
        EmpQuestionandanswer: Record "Emp Traing Eval. Questionaire";
        TrainCat: Option;
        EmpCode: Code[20];
        Noofrecords: Integer;
        UserSetup: Record "User Setup";
        Emp: Record "HR Employees";
        ReminderBuffer: Record "Reminder Buffer";
        iEntryNo: Integer;
        HRTrainingRec: Record "HR Training Applications";
        SentToHR: Boolean;
}

