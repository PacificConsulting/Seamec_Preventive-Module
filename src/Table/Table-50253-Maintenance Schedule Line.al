table 50253 "Maintenance Schedule Line"
{
    DrillDownPageID = 50254;
    LookupPageID = 50254;

    fields
    {
        field(1; "Schedule No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master";

            trigger OnValidate()
            var
                equipH: Record "Equipment Master";
            begin
                MaintSchLine.Reset();
                MaintSchLine.SetRange("Schedule No.", "Schedule No.");
                MaintSchLine.SetRange("Equipment Code", "Equipment Code");
                if MaintSchLine.FindFirst() then
                    Error('Equipment code already exist for this entry');
                if equipH.Get("Equipment Code") then;
                "Equipment Description" := equipH.Description;
            end;
        }
        field(4; "Equipment Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Schedule Type"; Enum "Schedule Type")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Fixed,Variable';
            // OptionMembers = "Fixed",Variable;
        }
        field(6; "Maintenance Type"; Enum "Maintaince Type")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Certification/Survey/Audit,Critical Equipments,Preventive Maintenance,Safety Mainetanance';
            // OptionMembers = "Certification/Survey/Audit","Critical Equipments","Preventive Maintenance","Safety Mainetanance";
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if EquipHead.Get("Equipment Code") then;
                EquipHead.TestField("Meter Reading Applicable", false);
                "Schedule Start Date" := CalcDate(Scheduling, "Start Date");
            end;
        }
        field(8; Scheduling; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if EquipHead.Get("Equipment Code") then;
                EquipHead.TestField("Meter Reading Applicable", false);
                "Schedule Start Date" := CalcDate(Scheduling, "Start Date");
            end;
        }
        field(9; "Meter Interval in Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger onvalidate()
            begin
                if EquipHead.Get("Equipment Code") then;
                EquipHead.TestField("Meter Reading Applicable");
                "Start Meter Interval" := EquipHead."Initial Meter Reading" + "Meter Interval in Hrs";
            end;
        }
        field(10; Priority; Enum Priority)
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ' ,ASAP,Can Be Postponed Indefinitely,Dry Dock,Next Layout,Next Port of Call,No Priority';
            // OptionMembers = " ",ASAP,"Can Be Postponed Indefinitely","Dry Dock","Next Layout","Next Port of Call","No Priority";
        }
        field(11; "Schedule Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Start Meter Interval"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Schedule No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Equipment Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EquipHead: Record "Equipment Master";
        MaintSchLine: Record "Maintenance Schedule Line";
}

