page 50251 "Task Master"
{
    PageType = List;
    CardPageId = 50269;
    Caption = 'Task Master List';
    SourceTable = 50251;
    ApplicationArea = all;
    UsageCategory = Lists;

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
                // field(Activities; rec.Activities)
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        /* //<<pcpl-064 28sep2023
        if UserSetup1.Get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" then
                CurrPage.Editable(false);
            //<<pcpl-064 28sep2023
        end; */
        //<<pcpl -06427sep2023
        if UserSetup1.get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" = true then
                CurrPage.Editable(true)
            else
                CurrPage.Editable(false);
        end;
        //>>pcpl 06427sep2023
    end;

    var
        UserSetup1: Record "User Setup";
}

