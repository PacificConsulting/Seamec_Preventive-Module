page 50271 "Posted Task Activity List"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Task Activity Lines";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Task Code"; Rec."Task Code")
                {
                    ApplicationArea = All;

                }
                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = all;
                }
                field("Task Line No."; Rec."Task Line No.")
                {
                    ApplicationArea = all;
                }
                field(Activities; Rec.Activities)
                {
                    ApplicationArea = all;
                }
                field("Job Done Comment"; Rec."Job Done Comment")
                {
                    ApplicationArea = all;
                }
                field("Work Order No"; Rec."Work Order No")
                {
                    ApplicationArea = all;
                }
                field("Work Order Line No."; Rec."Work Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("Equipment Code"; Rec."Equipment Code")
                {
                    ApplicationArea = all;
                }
                field("Equipment Description"; Rec."Equipment Description")
                {
                    ApplicationArea = all;
                }
                field("Schedule No"; Rec."Schedule No")
                {
                    ApplicationArea = al;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        myInt: Integer;
}