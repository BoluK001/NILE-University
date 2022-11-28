page 51534508 "HR E-Mail Parameters"
{
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With"; "Associate With")
                {
                    ApplicationArea = all;
                }
                field("Sender Name"; "Sender Name")
                {
                    ApplicationArea = all;
                }
                field("Sender Address"; "Sender Address")
                {
                    ApplicationArea = all;
                }
                field(Recipients; Recipients)
                {
                    ApplicationArea = all;
                }
                field(Subject; Subject)
                {
                    ApplicationArea = all;
                }
                field(Body; Body)
                {
                    MultiLine = true;
                    ApplicationArea = all;
                }
                field("Body 2"; "Body 2")
                {
                    ApplicationArea = all;
                }
                field("Body 3"; "Body 3")
                {
                    ApplicationArea = all;
                }
                field(HTMLFormatted; HTMLFormatted)
                {
                    ApplicationArea = all;
                }
                field(Image; Image)
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

