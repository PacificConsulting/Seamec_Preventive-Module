table 50262 "Posted Task Activity Lines"
{
    // DrillDownPageID = 50251;
    // LookupPageID = 50251;

    fields
    {
        field(1; "Task Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Task Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Task Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Activities; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Job Done Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Schedule No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Work Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Equipment Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Work Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Task Code", "Task Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Task Code");
    end;
}

