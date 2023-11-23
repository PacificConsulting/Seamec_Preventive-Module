table 50260 "Counter Master"
{
    DataClassification = ToBeClassified;
    DrillDownPageID = 50266;
    LookupPageID = 50266;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        /*field(3; "Meter Reading Applicable"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger onvalidate()
            begin
                if rec."Meter Reading Applicable" = false then begin
                    EquipRead.Reset();
                    //EquipRead.SetRange("Equipment code", rec."Equipment Code");
                    EquipRead.SetRange("Counter Code", Rec.Code);
                    if EquipRead.Findfirst() then begin
                        Error('On this equiment code, entry already exist on Equipment reading')
                    end;
                    TestField("Initial Meter Reading");
                end;
            end;
        }*/

        field(4; "Initial Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger onvalidate()
            begin
                "Current Meter Reading" := "Initial Meter Reading";
            end;
        }
        field(5; "Running Hrs."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            trigger OnValidate()
            begin
                //Rec.TestField("Meter Reading Applicable");
                EquipRead.Reset();
                if EquipRead.FindLast() then begin
                    cnt12 := EquipRead."Entry No";
                end;
                EquipRead.Reset();
                EquipRead.SetRange("Counter Code", Rec.Code);
                if EquipRead.FindLast() then begin
                    EquipCnt := EquipRead."Entry No";
                end;

                EquipRead.Reset();
                EquipRead.SetRange("Counter Code", Rec.Code);
                EquipRead.SetRange(Date, Today);
                if not EquipRead.FindFirst() then begin
                    EquipmentReding.Init();
                    EquipmentReding."Entry No" := cnt12 + 1;
                    EquipmentReding."Counter Code" := Rec.Code;
                    EquipmentReding.Description := Description;
                    EquipmentReding."Previous Meter Reading" := "Current Meter Reading";
                    EquipmentReding."Running Hrs." := "Running Hrs.";
                    EquipmentReding.Date := Today;
                    EquipmentReding.Insert();
                end else begin
                    //PCPL-25/280623
                    GenLedSetup.Get();
                    if GenLedSetup."Counter Reading Modification" then begin
                        EquipmentReding.Init();
                        EquipmentReding."Entry No" := cnt12 + 1;
                        EquipmentReding."Counter Code" := Rec.Code;
                        EquipmentReding.Description := Description;
                        EquipmentReding."Previous Meter Reading" := "Current Meter Reading";
                        EquipmentReding."Running Hrs." := "Running Hrs.";
                        EquipmentReding.Date := Today;
                        EquipmentReding.Insert();
                    end
                    else
                        //PCPL-25/280623
                        Error('On this current date, entry already exist');
                end;

                "Current Meter Reading" += "Running Hrs.";
                //PCPL-25/280623
                EquipMaster.Reset();
                EquipMaster.SetRange("Counter Code", Rec.Code);
                if EquipMaster.FindSet() then
                    repeat
                        EquipMaster."Current Meter Reading" := "Current Meter Reading";
                        EquipMaster.Modify();
                    until EquipMaster.Next() = 0;
                //PCPL-25/280623
            end;
        }
        field(6; "Current Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
    }

    keys
    {
        key(Key1; Code)
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
        GenLedSetup: Record "General Ledger Setup";
        EquipMaster: Record "Equipment Master";

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