pageextension 51534980 VendorExt extends "Vendor Card"
{
    Layout
    {
        addafter(Name)
        {
            field("Vendor Type"; "Vendor Type")
            {
                ApplicationArea = all;
            }
            field("W/Tax Code"; "W/Tax Code")
            {
                ApplicationArea = all;
                visible = false;
            }
            field("WHT Vendor Code"; "WHT Vendor Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Rate; "W/Tax Rate")
            {
                ApplicationArea = all;
                Editable = false;
                visible = false;
            }
            field(Status; Status)
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
        addafter("VAT Registration No.")
        {
            field("RC Number"; "RC Number")
            {

            }
        }

        Modify("Application Method")
        {
            Editable = false;
        }
        modify("VAT Registration No.")
        {
            Caption = 'Tin Number';
            ShowMandatory = true;
        }

        moveafter("No."; "VAT Registration No.")
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                Rec.TestField("VAT Registration No.");
            end;
        }
        addafter("Responsibility Center")
        {
            field("Main Product/Services"; Rec."Main Product/Services")
            {
                ToolTip = 'Specifies the value of the Main Product/Services field.';
                ApplicationArea = All;
            }
            field("Type of Business"; Rec."Type of Business")
            {
                ToolTip = 'Specifies the value of the Type of Business field.';
                ApplicationArea = All;
            }
            field("Nature Of Business"; "Nature Of Business")
            {
                ToolTip = 'Specifies the value of the Nature Of Business.';
                ApplicationArea = All;
            }
        }

        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("VAT Registration No.");
            end;
        }
    }

    actions
    {
        addafter("Ven&dor")
        {
            action("Update WHT Vendor Data")
            {
                Caption = 'Create WHT Vendor Data';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    WHTVendor: Record vendor;
                    DocNo: Code[20];
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    PPSetup: Record "Purchases & Payables Setup";
                begin
                    if Confirm('Create Vendor Data?', true) = false then exit;

                    PPSetup.Get();
                    //Check if With Hoding Tax vendor exist in Vendor Table
                    WHTVendor.Reset;
                    //WHTVendor.SetRange("WHT Vendor Code", 'WHT' + "No.");
                    if "WHT Vendor Code" = '' then begin
                        // if not WHTVendor.Find('-') then begin
                        WHTVendor.Init;
                        WHTVendor."No." := 'WHT' + "No.";//NoSeriesMgt.GetNextNo(PPSetup."WHT No.", TODAY, TRUE);
                        "WHT Vendor Code" := WHTVendor."No.";
                        // WHTVendor."No." := "No.";
                        WHTVendor.Name := Name;
                        WHTVendor."Name 2" := "Name 2";
                        WHTVendor."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        WHTVendor."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        WHTVendor."Search Name" := "Search Name";
                        WHTVendor."W/Tax Rate" := "W/Tax Rate";
                        WHTVendor."W/Tax Code" := "W/Tax Code";
                        WHTVendor."W/Tax Rate" := "W/Tax Rate";
                        WHTVendor."Vendor Type" := WHTVendor."Vendor Type"::"With Holding Tax";
                        WHTVendor."Responsibility Center" := "Responsibility Center";
                        WHTVendor."Purchaser Code" := "Purchaser Code";
                        WHTVendor.City := City;
                        WHTVendor.Address := Address;
                        WHTVendor."Country/Region Code" := "Country/Region Code";
                        WHTVendor."Vendor Posting Group" := 'WHT';
                        WHTVendor."VAT Bus. Posting Group" := 'WHT';
                        WHTVendor."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                        WHTVendor."Payment Terms Code" := '30D';
                        WHTVendor."WHT Vendor Code" := "No.";
                        WHTVendor.Insert;
                        WHTVendor.Validate("No.");
                        Message('Vendor data Successfully Created');
                        //"WHT Vendor Code" := WHTVendor."No.";
                    end;// else begin
                        /* WHTVendor.SetRange("No.", "WHT Vendor Code");
                         WHTVendor.Init;
                         //WHTVendor."No." := NoSeriesMgt.GetNextNo(PPSetup."WHT No.", TODAY, TRUE);
                         //"WHT Vendor Code" := WHTVendor."No.";
                         WHTVendor.Name := Name;
                         WHTVendor."Name 2" := "Name 2";
                         WHTVendor."Global Dimension 1 Code" := "Global Dimension 1 Code";
                         WHTVendor."Global Dimension 2 Code" := "Global Dimension 2 Code";
                         WHTVendor."Search Name" := "Search Name";
                         WHTVendor."W/Tax Rate" := "W/Tax Rate";
                         WHTVendor."W/Tax Code" := "W/Tax Code";
                         WHTVendor."W/Tax Rate" := "W/Tax Rate";
                         //WHTVendor."Vendor Type" := WHTVendor."Vendor Type"::"With Holding Tax";
                         WHTVendor."Responsibility Center" := "Responsibility Center";
                         WHTVendor."Purchaser Code" := "Purchaser Code";
                         WHTVendor.City := City;
                         WHTVendor.Address := Address;
                         WHTVendor."Country/Region Code" := "Country/Region Code";
                         WHTVendor."Vendor Posting Group" := "Vendor Posting Group";
                         WHTVendor."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                         WHTVendor."Payment Terms Code" := '30 DAYS';
                         WHTVendor."WHT Vendor Code" := "No.";
                         WHTVendor.Modify();
                         //WHTVendor.Validate("No.");
                         Message('Vendor data Successfully Updated');
                     end;
                     */
                        //end;
                        //end;
                        // end;
                        //"WHT Vendor Code" := WHTVendor."No.";

                end;
            }
        }
    }
    trigger OnOpenPage()
    var

    begin
        Rec.SetFilter("Vendor Type", '<>%1', 9);
    end;

    trigger OnClosePage()
    begin
        Rec.TestField("VAT Registration No.");
    end;
}
