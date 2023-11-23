page 50268 "Task Activity Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Task Activity Lines";


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
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field(Activities; Rec.Activities)
                {
                    ApplicationArea = all;
                }
                // field("Job Done Comment"; Rec."Job Done Comment")
                // {
                //     ApplicationArea = all;
                // }
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