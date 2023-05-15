page 50262 "Equipment Readings"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 50258;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field("Equipment code"; rec."Equipment code")
                // {
                //     ApplicationArea = All;
                // }
                field("Counter Code"; Rec."Counter Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Previous Meter Reading"; Rec."Previous Meter Reading")
                {
                    ApplicationArea = All;
                }
                field("Running Hrs."; Rec."Running Hrs.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}