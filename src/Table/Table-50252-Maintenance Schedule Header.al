table 50252 "Maintenance Schedule Header"
{
    DrillDownPageID = 50252;
    LookupPageID = 50252;

    fields
    {
        field(1; "Schedule No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Schedule Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Schedule No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Schedule No.");
    end;


}

