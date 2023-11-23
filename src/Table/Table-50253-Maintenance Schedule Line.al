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
                if equipH."Meter Reading Applicable" then
                    equipH.TestField("Counter Code");
                "Equipment Description" := equipH.Description;
                "Initial Meter Reading" := equipH."Initial Meter Reading"; //pcpl-064 20sep2023
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
                //PCPL-064<< 7nov2023
                //if "Meter Interval in Hrs" <> ''
                /*  MSL.Reset();
                 MSL.SetRange("Meter Interval in Hrs", "Meter Interval in Hrs");
                 if MSL.FindFirst() then
                     Error('Equipment can be scheduled either with scheduling or with meter interval at a time'); */
                //PCPL-064<< 7nov2023
                if EquipHead.Get("Equipment Code") then;
                // EquipHead.TestField("Meter Reading Applicable", false); 7Nov2023
                "Schedule Start Date" := CalcDate(Scheduling, "Start Date");

            end;
        }
        field(8; Scheduling; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                //PCPL-064<< 7nov2023
                /*  MSL.Reset();
                 MSL.SetRange("Meter Interval in Hrs", "Meter Interval in Hrs");
                 if MSL.FindFirst() then
                     Error('Equipment can be scheduled either with scheduling or with meter interval at a time'); */
                //PCPL-064<< 7nov2023
                if EquipHead.Get("Equipment Code") then;
                //  EquipHead.TestField("Meter Reading Applicable", false); 7Nov2023
                "Schedule Start Date" := CalcDate(Scheduling, "Start Date");
            end;
        }
        field(9; "Meter Interval in Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger onvalidate()
            begin
                //PCPL-064<< 7nov2023
                /* MSL.Reset();
                MSL.SetCurrentKey("Start Date", Scheduling);
                MSL.SetFilter(Scheduling, '<>%1', Scheduling);
                if MSL.FindFirst() then
                    //  if (rec."Start Date" <> '') and (Scheduling <> '') then
                    Error('Equipment can be scheduled either with scheduling or with meter interval at a time'); */
                //PCPL-064<< 7nov2023
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
        field(13; "Initial Meter Reading"; Decimal) //pcpl-064 20sep2023
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(14; "One Time Adj. Meter Intvl"; Decimal) //pcpl-064 21sep2023
        {

            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            // Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //PCPL-064<< 26sep2023
                TestField("Meter Interval in Hrs");
                TestField("Start Meter Interval");
                "Start Meter Interval" := "Start Meter Interval" - "One Time Adj. Meter Intvl"; //pcpl-064 22sep2023
                // if "One Time Adj. Meter Intvl" <> 0 then
                //     Error('You can not renter');
                if xRec."One Time Adj. Meter Intvl" <> 0 then //PCPL-064 26sep2023
                    Error('You can not Renter the value');
                //PCPL-064>> 26sep2023
            end;

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
    trigger OnInsert()
    begin
        //PCPL-064<< 26sep2023
        PMSJobhead.Reset();
        PMSJobhead.SetRange("Schedule No.", "Schedule No.");
        PMSJobhead.SetRange("Equipment Code", "Equipment Code");
        if PMSJobhead.FindFirst() then
            Error('Already exist');
        //PCPL-064>> 26sep2023

    end;

    var
        EquipHead: Record "Equipment Master";
        MaintSchLine: Record "Maintenance Schedule Line";
        Bol: Boolean;
        PMSJobhead: Record "PMS Job Header";
        MSL: Record "Maintenance Schedule Line";
}

