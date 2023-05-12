page 50266 "Counter Master List"
{
    CardPageID = "Counter Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50260;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Meter Reading Applicable"; rec."Meter Reading Applicable")
                {
                    ApplicationArea = all;
                }
                field("Initial Meter Reading"; rec."Initial Meter Reading")
                {
                    ApplicationArea = all;
                }
                field("Running Hrs."; rec."Running Hrs.")
                {
                    ApplicationArea = all;
                }
                field("Current Meter Reading"; rec."Current Meter Reading")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

