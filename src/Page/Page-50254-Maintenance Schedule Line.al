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
                    //ApplicationArea = all;
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
                }
                field(Scheduling; rec.Scheduling)
                {
                    ApplicationArea = all;
                }
                field("Schedule Start Date"; Rec."Schedule Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Meter Interval in Hrs"; rec."Meter Interval in Hrs")
                {
                    ApplicationArea = all;
                }
                field(Priority; rec.Priority)
                {
                    ApplicationArea = all;
                }
                field("Start Meter Interval"; Rec."Start Meter Interval")
                {
                    ApplicationArea = All;
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
}

