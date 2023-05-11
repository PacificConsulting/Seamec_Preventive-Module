page 50264 "Closed PMS Job List"
{
    CardPageID = "Closed PMS Job Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50255;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTableView = WHERE(Status = FILTER(Closed));
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Schedule Norec.."; rec."Schedule No.")
                {
                    ApplicationArea = All;
                }
                field("Equipment Coderec."; rec."Equipment Code")
                {
                    ApplicationArea = All;
                }
                field("Equipment Descriptionrec."; rec."Equipment Description")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    ApplicationArea = All;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Resource Provider"; rec."Resource Provider")
                {
                    ApplicationArea = All;
                }
                field("Assigned To"; rec."Assigned To")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

