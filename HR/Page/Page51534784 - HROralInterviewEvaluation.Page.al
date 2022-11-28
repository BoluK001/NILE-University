page 51534784 "HR Oral Interview Evaluation"
{
    PageType = ListPart;
    SourceTable = "HR Oral Interview Evaluation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Interview Group"; "Interview Group")
                {
                    //Visible = false;
                    ApplicationArea = All;
                }
                field("Interview Code"; "Interview Code")
                {
                    ApplicationArea = All;
                }
                field("Interview No."; "Interview No.")
                {
                    //Visible = false;
                    ApplicationArea = All;
                }
                field("Target Score"; "Target Score")
                {
                    Editable = false;
                    //Visible = true;
                    ApplicationArea = All;
                }
                field(Emp1; Emp1)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    Visible = Field1Visible;
                    ApplicationArea = All;
                }
                field(Emp2; Emp2)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    Visible = Field2Visible;
                    ApplicationArea = All;
                }
                field(Emp3; Emp3)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    Visible = Field3Visible;
                    ApplicationArea = All;
                }
                field(Emp4; Emp4)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    Visible = Field4Visible;
                    ApplicationArea = All;
                }
                field(Emp5; Emp5)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    Visible = Field5Visible;
                    ApplicationArea = All;
                }
                field(Emp6; Emp6)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    Visible = Field6Visible;
                    ApplicationArea = All;
                }
                field(Emp7; Emp7)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    Visible = Field7Visible;
                    ApplicationArea = All;
                }
                field(Emp8; Emp8)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    Visible = Field8Visible;
                    ApplicationArea = All;
                }
                field(Emp9; Emp9)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    Visible = Field9Visible;
                    ApplicationArea = All;
                }
                field(Emp10; Emp10)
                {
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    Visible = Field10Visible;
                    ApplicationArea = All;
                }
                field("Candidate Score"; "Candidate Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*InterViewNo.SETRANGE(InterViewNo."Interview No.",rec."Interview No.");
        IF InterViewNo.FINDFIRST THEN
         */

    end;

    trigger OnInit()
    begin
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnOpenPage()
    begin
        //MESSAGE('%1',ARRAYLEN(ColumnCaptions));
    end;

    var
        MATRIX_NoOfMatrixColumns: Integer;
        MATRIX_CellData: array[32] of Decimal;
        MATRIX_ColumnCaption: array[32] of Text[1024];
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        InterViewNo: Record "HR Oral Interview Evaluation";
        TotalEmp: Integer;

    [Scope('OnPrem')]
    procedure SetVisible()
    begin
        Field1Visible := MATRIX_ColumnCaption[1] <> '';
        Field2Visible := MATRIX_ColumnCaption[2] <> '';
        Field3Visible := MATRIX_ColumnCaption[3] <> '';
        Field4Visible := MATRIX_ColumnCaption[4] <> '';
        Field5Visible := MATRIX_ColumnCaption[5] <> '';
        Field6Visible := MATRIX_ColumnCaption[6] <> '';
        Field7Visible := MATRIX_ColumnCaption[7] <> '';
        Field8Visible := MATRIX_ColumnCaption[8] <> '';
        Field9Visible := MATRIX_ColumnCaption[9] <> '';
        Field10Visible := MATRIX_ColumnCaption[10] <> '';
    end;

    [Scope('OnPrem')]
    procedure ShowColumnCap(ColumnCaptions: array[32] of Text[1024])
    var
        i: Integer;
    begin
        //Refresh Header
        //TotalEmp:=0;

        if MATRIX_ColumnCaption[1] <> '' then
            Clear(MATRIX_ColumnCaption);

        CurrPage.Update;
        for i := 1 to ArrayLen(ColumnCaptions) do begin
            if ColumnCaptions[i] = ' ' then begin
                MATRIX_ColumnCaption[i] := ' ';
                TotalEmp += 1;
            end
            else
                MATRIX_ColumnCaption[i] := ColumnCaptions[i];

        end;

        SetVisible;
        CurrPage.Update;
    end;
}

