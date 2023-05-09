table 50256 "PMS Job Lines"
{

    fields
    {
        field(1; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Task Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Task Master";
        }
        field(4; "Task Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Activities; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Job Done Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Job No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

