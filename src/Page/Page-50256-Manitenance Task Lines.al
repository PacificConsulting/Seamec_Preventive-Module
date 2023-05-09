page 50256 "Manitenance Task Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 50254;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Equipment Code"; rec."Equipment Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Task Code"; rec."Task Code")
                {
                    ApplicationArea = all;
                }
                field("Task Name"; rec."Task Name")
                {
                    ApplicationArea = all;
                }
                field(Activities; rec.Activities)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Schedule No."; rec."Schedule No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Schedule Line No."; rec."Schedule Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

