table 50251 "Task Master"
{
    DrillDownPageID = 50251;
    LookupPageID = 50251;

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
        field(3; Activities; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Task Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Task Code");
    end;
}

