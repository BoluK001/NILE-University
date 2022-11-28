page 51534958 "HR Exit Interiew SF"
{
    PageType = ListPart;
    SourceTable = "HR Emp. Exit Interview Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Question; Question)
                {
                    ApplicationArea = all;
                }
                field("Yes/No"; "Yes/No")
                {
                    ApplicationArea = all;
                }
                field(Excellent; Excellent)
                {
                    ApplicationArea = all;
                }
                field(Good; Good)
                {
                    ApplicationArea = all;
                }
                field(Fair; Fair)
                {
                    ApplicationArea = all;
                }
                field(Poor; Poor)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

