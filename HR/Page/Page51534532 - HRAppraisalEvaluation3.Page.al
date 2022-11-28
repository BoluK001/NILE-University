page 51534532 "HR Appraisal Evaluation 3"
{
    ApplicationArea = all;
    PageType = List;
    AdditionalSearchTerms = 'HR Appraisal Evaluation 3';
    SourceTable = "HR Appraisal Evaluations";
    SourceTableView = WHERE(Category = CONST("EMPLOYEE PERFORMANCE FACTOR"));
    UsageCategory = Lists;

    layout
    {
    }

    actions
    {
    }

    var
        YesNo: Boolean;
        HRAppraisalEvaluations: Record "HR Appraisal Evaluations";
        HREmp: Record "HR Employees";
        HRAppraisalRatings: Record "HR Appraisal Career Dev";
        TotalScore: Decimal;
        HRLookupValues: Record "HR Lookup Values";

    [Scope('OnPrem')]
    procedure TotScore()
    begin
    end;
}

