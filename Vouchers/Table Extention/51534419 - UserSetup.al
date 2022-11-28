tableextension 51534408 UsersetupExt extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(50002; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = ToBeClassified;
        }
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = ToBeClassified;
        }
        field(50004; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = ToBeClassified;
        }
        field(50005; "Staff Travel Account"; Code[20])
        {
            Caption = 'Staff Travel Account';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50007; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
            DataClassification = ToBeClassified;
        }
        field(50008; "Is In HR"; Boolean)
        {
            Caption = 'Is In HR';
            DataClassification = ToBeClassified;
        }
        field(50009; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50010; "Released Status"; Boolean)
        {
            Caption = 'Released Status';
            DataClassification = ToBeClassified;
        }
        field(50011; "Unlimited PV Amount Approval"; Boolean)
        {
        }
        field(50012; "PV Amount Approval Limit"; Decimal)
        {
        }
        field(50013; "Unlimited PettyAmount Approval"; Boolean)
        {
        }
        field(50014; "Petty C Amount Approval Limit"; Decimal)
        {
        }
        field(50015; "Unlimited Imprest Amt Approval"; Boolean)
        {
        }
        field(50016; "Imprest Amount Approval Limit"; Decimal)
        {
        }
        field(50017; "Unlimited Store RqAmt Approval"; Boolean)
        {
        }
        field(50018; "Store Req. Amt Approval Limit"; Decimal)
        {
        }
        field(50019; "Unlimited ImprestSurr Amt Appr"; Boolean)
        {
        }
        field(50020; "ImprestSurr Amt Approval Limit"; Decimal)
        {
        }
        field(50021; "Unlimited Interbank Amt Appr"; Boolean)
        {
        }
        field(50022; "Interbank Amt Approval Limit"; Decimal)
        {
        }
        field(50023; "Post JVs"; Boolean)
        {
        }
        field(50024; "Post Bank Rec"; Boolean)
        {
        }
        field(50025; "Unlimited Receipt Amt Approval"; Boolean)
        {
        }
        field(50026; "Receipt Amt Approval Limit"; Decimal)
        {
        }
        field(50027; "Unlimited Claim Amt Approval"; Boolean)
        {
        }
        field(50028; "Claim Amt Approval Limit"; Decimal)
        {
        }
        field(50029; "Unlimited Advance Amt Approval"; Boolean)
        {
        }
        field(50030; "Advance Amt Approval Limit"; Decimal)
        {
        }
        field(50031; "Unlimited AdvSurr Amt Approval"; Boolean)
        {
        }
        field(50032; "AdvSurr Amt Approval Limit"; Decimal)
        {
        }
        field(50033; "Cash Advance Staff Account"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(50034; "ReOpen/Release"; Option)
        {
            OptionMembers = " ",ReOpen,Release;
        }
        field(50035; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50036; "default retail customer"; Code[20])
        {
            TableRelation = Customer;
        }
        field(50037; "Post Voucher"; Boolean)
        {

        }
        field(60000; Leave; Boolean)
        {
        }
        field(60001; "Payroll Type"; Option)
        {
            OptionCaption = 'General,Directors';
            OptionMembers = General,Directors;
        }
        field(60002; "Edit Posted Dimensions"; Boolean)
        {
        }
        field(60003; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(60004; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(60005; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(60006; "Modify Item Pricing"; Boolean)
        {
        }
        field(60007; "Modify ItemGross Profit Target"; Boolean)
        {
        }
        field(60008; "ReValidate LPOs"; Boolean)
        {
            Description = 'Can ReOpen Expired LPOs';
        }
        field(60009; "Service Amount Approval Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Sales Amount Approval Limit';

            trigger OnValidate()
            begin
                //   if "Unlimited Sales Approval" and ("Sales Amount Approval Limit" <> 0) then
                //      Error(Text003, FieldCaption("Sales Amount Approval Limit"), FieldCaption("Unlimited Sales Approval"));
                //if "Sales Amount Approval Limit" < 0 then
                //  Error(Text005);
            end;
        }
        field(60010; "Unlimited Service Approval"; Boolean)
        {
            Caption = 'Unlimited Sales Approval';

            trigger OnValidate()
            begin
                if "Unlimited Sales Approval" then
                    "Sales Amount Approval Limit" := 0;
            end;
        }
        field(60011; FC; Boolean)
        {
        }
        field(60012; "Unlimited WorkOrd Amt Approval"; Boolean)
        {
        }
        field(39004284; "WorkOrder Amt Approval Limit"; Decimal)
        {
        }
        field(39004285; "Assigned to Employee"; Boolean)
        {
        }
        field(39004286; "Reopen Doc"; Boolean)
        {
        }
        field(39004287; HR; Boolean)
        {
        }
        field(39004288; "PayRoll Cent. Filter"; Code[20])
        {
            TableRelation = "Payroll Classification";
        }
        field(39004289; "Payroll Substitute"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(39004290; "HR Job"; Boolean)
        {
            Description = 'Job Creation & Skip action on int evaluation card';
        }
        field(39004291; "Internal Audit"; Boolean)
        {
        }
        field(39004292; "Grade Classification"; Code[20])
        {
            TableRelation = "prEmployee Posting Group".Code;
        }
        field(39004293; "Full Name"; Text[100])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39004294; "LPO Check"; Boolean)
        {
        }
        field(39004295; "Modify Staff Advance"; Boolean)
        {
        }
        field(39004296; SignatureUser; BLOB)
        {
            SubType = Bitmap;
        }
        field(51534000; "Approval IDs"; Text[250])
        {

            trigger OnLookup()
            begin
                /*  UserSetup.Find('-');
                  if PAGE.RunModal(PAGE::"User Setup", UserSetup) = ACTION::LookupOK then begin
                      if ("Approval IDs" = '') and ("Approver ID" = '') then
                          "Approval IDs" := UserSetup."User ID"
                      else
                          if ("Approval IDs" = '') and ("Approver ID" <> '') then
                              "Approval IDs" := "Approver ID" + '|' + UserSetup."User ID"
                          else
                              if ("Approval IDs" <> '') then
                                  "Approval IDs" := "Approval IDs" + '|' + UserSetup."User ID";
                  end;
                  */
            end;
        }

        field(51534002; "Send SMS"; Boolean)
        {
        }
        field(51534003; "User Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
}