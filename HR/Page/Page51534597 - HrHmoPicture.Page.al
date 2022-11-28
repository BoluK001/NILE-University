page 51534597 "Hr Hmo Picture"
{
    DataCaptionFields = "First Name", "Last Name";
    PageType = Card;
    SourceTable = "HR HMO Beneficiary";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Staff No."; "Staff No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Picture 1"; "Picture 1")
                {
                    ApplicationArea = all;
                }
                field("Picture 2"; "Picture 2")
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

