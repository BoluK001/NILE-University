pageextension 51534407 fixedAssetCard extends "Fixed Asset Card"
{
    layout
    {
        addafter("No.")
        {
            field("Asset Tag"; "Asset Tag")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify(DepreciationMethod)
        {
            Editable = false;
        }
        /* modify(FAPostingGroup)
        {

        } */
    }
    actions
    {
        addbefore(Attachments)
        {
            action("Tag Asset")
            {
                ApplicationArea = All;
                //Caption = 'Caption', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;

                trigger OnAction()
                var
                    FADepBook: Record "FA Depreciation Book";
                begin
                    TestField("Global Dimension 1 Code");
                    TestField("FA Class Code");
                    FADepBook.Reset;
                    FADepBook.SetFilter("FA No.", '%1', "No.");
                    if FADepBook.FindFirst() then begin
                        FADepBook.TestField("Depreciation Book Code");
                        "Asset Tag" := FADepBook."Depreciation Book Code" + '/' + "Global Dimension 1 Code" + '/' + "FA Class Code" + '/' + CopyStr("No.", 3, StrLen("No.") - 2);
                        Modify();
                    end;

                end;
            }
        }

    }

}
