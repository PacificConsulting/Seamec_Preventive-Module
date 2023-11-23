table 50254 "Manitenance Task Lines"
{
    Caption = 'Manitenance Task Lines';
    DrillDownPageID = 50257;
    LookupPageID = 50257;

    fields
    {
        field(1; "Schedule No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Schedule Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Task Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Task Master";
            trigger OnValidate()
            var
                taskMaster: Record "Task Master";
            //TASkmasteLines: Record 50261;
            begin
                if taskMaster.Get("Task Code") then;
                "Task Name" := taskMaster."Task Name";
                Activities := taskMaster.Activities;

                /* taskMaster.Reset();
                taskMaster.SetRange("Task Code", "Task Code");
                if taskMaster.FindSet() then begin
                    repeat
                        "Task Name" := taskMaster."Task Name";
                        Activities := taskMaster.Activities;
                    until taskMaster.Next() = 0;
                end; */

            end;
        }
        field(6; "Task Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Activities; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Schedule No.", "Schedule Line No.", "Equipment Code", "Task Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        MTL: Record "Manitenance Task Lines";
}

