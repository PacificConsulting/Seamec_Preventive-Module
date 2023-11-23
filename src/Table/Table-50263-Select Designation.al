table 50263 "Select Designation"
{
    DataClassification = ToBeClassified;
    Caption = 'Select Designation';
    DataCaptionFields = "Code", "Description";

    fields
    {
        field(1; Code; Integer)
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;

        }
        field(2; Description; text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Code; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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





