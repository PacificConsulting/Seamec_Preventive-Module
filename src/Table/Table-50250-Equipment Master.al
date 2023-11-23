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
            trigger onvalidate()
            var
                myInt: Integer;
                //PageConfirmation: Page "Password Detail";  //PCPL-25/100823
                Employee: Record Employee;
                //ATS: Record "Audit Trail Setup";  //PCPL-25/100823
                GLSetup: Record "General Ledger Setup";
            begin
                if Status = Status::Withdrawn then
                    "Out of Service" := "Out of Service"::No;

                if Status = Status::Installed then
                    "Out of Service" := "Out of Service"::Yes;
                /* //PCPL-0070 27June23 <<
                IF GLSetup."Password Posting" then begin
                    IF Status = Status::Installed then begin
                        Clear(PageConfirmation);
                        PageConfirmation.LookupMode(true);
                        if PageConfirmation.RunModal() = Action::LookupOK then begin
                            CurrentPassword := PageConfirmation.ReturnPassword();
                            ATS.Reset();
                            ATS.SetRange("User ID", UserId);
                            ATS.SetRange(Password, CurrentPassword);
                            IF not ATS.FindFirst() then
                                Error('Given password is wrong or setup is missing');
                            Rec."Employee ID" := ATS."Employee ID";
                            Rec.Modify();
                        end Else
                            Error('Please enter the password for change status.');
                    end;
                end;
                //PCPL-0070 27June23 <<
 */
            end;

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
            Editable = false;
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
                    // EquipRead.Reset();
                    // EquipRead.SetRange("Equipment code", rec."Equipment Code");
                    // if EquipRead.Findfirst() then begin
                    //     Error('On this equiment code, entry already exist on Equipment reading')
                    // end;
                    TestField("Initial Meter Reading", 0);
                    TestField("Current Meter Reading", 0);
                end;
            end;
        }
        field(11; "Initial Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
            // trigger onvalidate()
            // begin
            //     "Current Meter Reading" := "Initial Meter Reading";
            // end;
        }
        /*field(12; "Running Hrs."; Decimal)
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
                    EquipmentReding.Init();
                    EquipmentReding."Entry No" := cnt12 + 1;
                    EquipmentReding."Equipment code" := "Equipment Code";
                    EquipmentReding.Description := Description;
                    // if EquipCnt = 0 then
                    //     EquipmentReding."Previous Meter Reading" := "Initial Meter Reading"
                    // else
                    EquipmentReding."Previous Meter Reading" := "Current Meter Reading";
                    EquipmentReding."Running Hrs." := "Running Hrs.";
                    EquipmentReding.Date := Today;
                    EquipmentReding.Insert();
                end else begin
                    Error('On this current date, entry already exist');
                end;

                "Current Meter Reading" += "Running Hrs.";
            end;
        }
        */
        field(13; "Current Meter Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }

        field(14; "Counter Code"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Counter Master";
            trigger OnValidate()
            var
                CounMaster: Record "Counter Master";
            begin
                Rec.TestField("Meter Reading Applicable");
                if CounMaster.Get("Counter Code") then;
                "Initial Meter Reading" := CounMaster."Initial Meter Reading";
                "Current Meter Reading" := CounMaster."Current Meter Reading";
            end;
        }
        field(15; "Employee ID"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            Description = 'PCPL-0070 27June23';
        }
        field(16; "Revision Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 27sep2023';
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
        CurrentPassword: Text[20];

    trigger OnInsert()
    begin
        TestField("Equipment Code");
    end;
}

