table 50255 "PMS Job Header"
{

    fields
    {
        field(1; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Schedule No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Maintenance Schedule Header";
        }
        field(3; "Equipment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master";
            trigger OnValidate()
            var
                equipH: Record "Equipment Master";
            begin
                if equipH.Get("Equipment Code") then;
                "Equipment Description" := equipH.Description;
            end;
        }
        field(4; "Equipment Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Maintenance Type"; Enum "Maintaince Type")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Certification/Survey/Audit,Critical Equipments,Preventive Maintenance,Safety Mainetanance';
            // OptionMembers = "Certification/Survey/Audit","Critical Equipments","Preventive Maintenance","Safety Mainetanance";
        }
        field(8; Department; Enum "Equipment Department")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Default,Marine,Diving,Deck';
            // OptionMembers = Default,Marine,Diving,Deck;
        }
        field(9; Status; Enum "PMS Status")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Open,Scheduled,Closed';
            // OptionMembers = Open,Scheduled,Closed;
            Editable = false;
        }
        field(10; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(13; "Resource Provider"; Enum "Resource Provider")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = 'Internal,External,Internal & External';
            // OptionMembers = Internal,External,"Internal & External";
        }
        field(14; "Assigned To"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(15; "Initial Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(16; "Current Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(17; "Meter Interval in Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }

    }

    keys
    {
        key(Key1; "Job No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("Job No.");
        "Creation Date" := Today;
        "Created By" := UserId;
    end;

    procedure AssistEdit(pmsJob: Record "PMS Job Header"): Boolean
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("PMS Job Nos");
        //IF NoSeriesMgt.SelectSeries(PurchSetup."PMS Job Nos",rec."No. Series"'', "No. Series") THEN BEGIN
        IF NoSeriesMgt.SelectSeries(PurchSetup."PMS Job Nos", '', PurchSetup."PMS Job Nos") THEN BEGIN
            PurchSetup.GET;
            NoSeriesMgt.SetSeries(Rec."Job No.");
            EXIT(TRUE);
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}

