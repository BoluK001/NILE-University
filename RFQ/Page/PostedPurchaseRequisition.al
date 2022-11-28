page 51534367 "Approved Purchase Requisition"
{
    ApplicationArea = All;
    Caption = 'Approved Purchase Requisition';
    PageType = List;
    CardPageId = "Released Internal Requisitions";
    SourceTable = "Purchase Header";
    UsageCategory = History;
    SourceTableView = WHERE("Document Type" = FILTER(Quote), "Purchase Type" = FILTER(Requisition), Status = CONST(Released));
    Editable = false;   //jj280522
    InsertAllowed = false; //jj280522

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date that you want the vendor to deliver your order. The field is used to calculate the latest date you can order, as follows: requested receipt date - lead time calculation = order date. If you do not need delivery on a specific date, you can leave the field blank.';
                    ApplicationArea = All;
                }
                field("Procurement Type Code"; Rec."Procurement Type Code")
                {
                    ToolTip = 'Specifies the value of the Procurement Type Code field.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(36), "No." = FIELD("No.");
            }
        }
    }
}

//     actions
//     {
//         action(Print)
//                 {
//           ApplicationArea = All;
//             Caption = 'Print', comment = 'NLB="YourLanguageCaption"';
//             Promoted = true;
//             PromotedCategory = Process;
//             PromotedIsBig = true;
//             Image = Image;

//             trigger OnAction()
//             begin
//                   SETRANGE("No.","No.");
//                     REPORT.RUN(39005563,TRUE,TRUE,Rec);
//   RESET;
//             end;
//         }}}

