table 50250 "Equipment Master"
{
    DrillDownPageID = 50250;
    LookupPageID = 50250;

    fields
    {
        field(1; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Status; Enum "Equipment Status")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Installed,Withdrawn';
            // OptionMembers = Installed,Withdrawn;
        }
        field(4; Type; Enum "Equipment Type")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'System,Intermediate System,Sub-System,Equipments,Sub-Equipments,Assets';
            // OptionMembers = System,"Intermediate System","Sub-System",Equipments,"Sub-Equipments",Assets;
        }
        field(5; Department; Enum "Equipment Department")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Default,Marine,Diving,Deck';
            // OptionMembers = Default,Marine,Diving,Deck;
        }
        field(6; Owners; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Class Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Out of Service"; Enum "Out of Service")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Yes,No';
            // OptionMembers = Yes,No;
        }
        field(9; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
        }
        field(10; "Meter Reading Applicable"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger onvalidate()
            begin
                if rec."Meter Reading Applicable" = false then begin
                    EquipRead.Reset();
                    EquipRead.SetRange("Equipment code", rec."Equipment Code");
                    if EquipRead.Findfirst() then begin
                        Error('On this equiment code, entry already exist on Equipment reading')
                    end;
                end;
            end;
        }
        field(11; "Initial Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger onvalidate()
            begin
                "Current Meter Reading" := "Initial Meter Reading";
            end;
        }
        field(12; "Running Hrs."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger OnValidate()
            begin
                Rec.TestField("Meter Reading Applicable");
                EquipRead.Reset();
                if EquipRead.FindLast() then begin
                    cnt12 := EquipRead."Entry No";
                end;
                EquipRead.Reset();
                EquipRead.SetRange("Equipment code", rec."Equipment Code");
                if EquipRead.FindLast() then begin
                    EquipCnt := EquipRead."Entry No";
                end;
                EquipRead.Reset();
                EquipRead.SetRange("Equipment code", "Equipment Code");
                EquipRead.SetRange(Date, Today);
                if not EquipRead.FindFirst() then begin
                    "Current Meter Reading" += "Running Hrs.";
                    EquipmentReding.Init();
                    EquipmentReding."Entry No" := cnt12 + 1;
                    EquipmentReding."Equipment code" := "Equipment Code";
                    EquipmentReding.Description := Description;
                    if EquipCnt = 0 then
                        EquipmentReding."Previous Meter Reading" := "Initial Meter Reading"
                    else
                        EquipmentReding."Previous Meter Reading" := "Current Meter Reading";
                    EquipmentReding."Running Hrs." := "Running Hrs.";
                    EquipmentReding.Date := Today;
                    EquipmentReding.Insert();
                end else begin
                    Error('On this current date, entry already exist');
                end;
            end;
        }
        field(13; "Current Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
    }

    keys
    {
        key(Key1; "Equipment Code")
        {
            Clustered = true;
        }
    }

    var
        EquipRead: Record 50258;
        EquipmentReding: Record 50258;
        cnt: Integer;
        cnt12: Integer;
        EquipCnt: integer;

    trigger OnInsert()
    begin
        TestField("Equipment Code");
    end;
}

