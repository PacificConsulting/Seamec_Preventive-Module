table 50259 "Equipment Comment"
{
    DataClassification = ToBeClassified;
    DrillDownPageID = 50259;
    LookupPageID = 50259;


    fields
    {
        field(1; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Equipment Code", "Line No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}