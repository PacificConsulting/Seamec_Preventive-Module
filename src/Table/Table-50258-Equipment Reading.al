table 50258 "Equipment Reading"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Equipment code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Previous Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

        }
        field(4; "Running Hrs."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(5; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}