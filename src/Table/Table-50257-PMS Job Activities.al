table 50257 "PMS Job Activities"
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
        field(3; Type; Enum "PMS Type")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,Item,G/L Account';
            // OptionMembers = " ",Item,"G/L Account";
        }
        field(4; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                              Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Blocked = CONST(false));
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantiry; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Location Code"; Code[10])
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

