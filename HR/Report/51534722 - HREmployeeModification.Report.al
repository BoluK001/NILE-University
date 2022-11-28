report 51534722 "HR Employee Modification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HREmployeeModification.rdlc';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            DataItemTableView = WHERE ("Table Caption" = CONST ('Employee'));
            column(UserID_ChangeLogEntry; "Change Log Entry"."User ID")
            {
            }
            column(OldValue_ChangeLogEntry; "Change Log Entry"."Old Value")
            {
            }
            column(NewValue_ChangeLogEntry; "Change Log Entry"."New Value")
            {
            }
            column(PrimaryKey_ChangeLogEntry; "Change Log Entry"."Primary Key")
            {
            }
            column(Date_ChangeLogEntry; Format(DateModified))
            {
            }
            column(PrimaryKeyField1Value_ChangeLogEntry; "Change Log Entry"."Primary Key Field 1 Value")
            {
            }

            trigger OnAfterGetRecord()
            begin
                DateModified := DT2Date("Change Log Entry"."Date and Time");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DateModified: Date;
}

