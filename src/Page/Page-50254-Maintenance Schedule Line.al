page 50254 "Maintenance Schedule Line"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50253;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Schedule No."; rec."Schedule No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Equipment Code"; rec."Equipment Code")
                {
                    ApplicationArea = all;
                }
                field("Equipment Description"; rec."Equipment Description")
                {
                    ApplicationArea = all;
                }
                field("Schedule Type"; rec."Schedule Type")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    ApplicationArea = all;
                }
                field("Start Daterec."; rec."Start Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //PCPL-064<< 7nov2023
                        /*  MSL.Reset();
                         MSL.SetFilter("Meter Interval in Hrs", '<>%1', 0);
                         if MSL.FindFirst() then */
                        if Rec."Meter Interval in Hrs" <> 0 then
                            Error('Equipment can be scheduled either with scheduling or with meter interval at a time');
                        /*  if Format(rec."Meter Interval in Hrs") <> '' then
                             Error('Equipment can be scheduled either with scheduling or with meter interval at a time'); */
                    end;

                }
                field(Scheduling; rec.Scheduling)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //PCPL-064<< 7nov2023
                        /* if Format(rec."Meter Interval in Hrs") <> '' then
                            Error('Equipment can be scheduled either with scheduling or with meter interval at a time'); */
                        if Rec."Meter Interval in Hrs" <> 0 then
                            Error('Equipment can be scheduled either with scheduling or with meter interval at a time');
                    end;
                }

                field("Meter Interval in Hrs"; rec."Meter Interval in Hrs")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                        //if Format((rec."Start Date" <> '') and (Scheduling <> '')) then
                        // if (rec."Start Date" <> 0D) and (rec.Scheduling <> '') then
                        if Format(Rec."Start Date") <> '' then
                            if Format(Rec.Scheduling) <> '' then
                                Error('Equipment can be scheduled either with scheduling or with meter interval at a time');
                    end;
                }
                field(Priority; rec.Priority)
                {
                    ApplicationArea = all;
                }
                field("Start Meter Interval"; Rec."Start Meter Interval")
                {
                    ApplicationArea = All;
                }
                field("Schedule Start Date"; Rec."Schedule Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Meter Reading"; Rec."Initial Meter Reading") //pcpl-064 20sep2023
                {
                    ApplicationArea = all;
                }
                field("One Time Meter Interval"; Rec."One Time Adj. Meter Intvl") //pcpl-064 21sep2023
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)//pcpl-064 12dec2023
                {
                    ApplicationArea = all;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)//pcpl-064 12dec2023
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("PMS Task on Equipments ")
            {
                Image = MaintenanceRegistrations;
                ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = Page 50256;
                RunPageLink = "Schedule No." = FIELD("Schedule No."),
                              "Schedule Line No." = FIELD("Line No."),
                              "Equipment Code" = FIELD("Equipment Code");
            }
        }
    }
    var
        MSL: Record "Maintenance Schedule Line";
}

