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
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(9; "Req no."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Req Line no."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //PCPL-25/190523
        field(11; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get("Vendor No.") then;
                "Vendor Name" := Vend.Name;
            end;
        }
        field(12; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Work Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Charge Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Shortcut Dimension Code 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1), Blocked = CONST(false));
        }
        field(18; "Shortcut Dimension Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1), Blocked = CONST(false));
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

