page 51534447 "SIS Transaction Codes"
{
    ApplicationArea = All;
    Caption = 'SIS Transaction Codes';
    PageType = List;
    SourceTable = SIS_Transactions_Codes;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CodeID; Rec.CodeID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CodeID field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(IsActive; Rec.IsActive)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified Date field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(TransCode; Rec.TransCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TransCode field.';
                }
                field("Premilary GL Code"; Rec."Premilary GL Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Premilary GL Code field.';
                }
                field("Under Graduate GL Code"; Rec."Under Graduate GL Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Under Graduate GL Code field.';
                }
                field("Post Graduate GL Code"; Rec."Post Graduate GL Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Graduate GL Code field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action(TransactionCodes)
            {
                ApplicationArea = All;
                Caption = 'Get Transaction Codes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                visible = true;

                trigger OnAction();
                var
                    urlcu: Codeunit SisIntegration;
                begin
                    urlcu.getTramsactionCodes();
                end;
            }
        }
    }
}
