page 50251 "Task Master"
{
    PageType = List;
    SourceTable = 50251;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

