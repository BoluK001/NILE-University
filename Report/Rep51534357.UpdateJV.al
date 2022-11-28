report 51534357 "Update PurchLine"
{
    Caption = 'Update PurchLine';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            trigger OnAfterGetRecord()
            begin
                purchline.SetRange(Type, Type::"G/L Account");
                purchline.SetRange("Document Type", "Document Type"::Order);
                purchline.SetRange("Gen. Prod. Posting Group", '');
                if purchline.FindSet() then begin
                    purchline."Gen. Prod. Posting Group" := 'MISC';
                    purchline.Modify();
                end;
            end;


        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        purchline: Record "Purchase Line";
}
