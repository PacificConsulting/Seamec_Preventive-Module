page 50269 "Tast Master Card"
{
    PageType = Card;
    SourceTable = "Task Master";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Task Code"; Rec."Task Code")
                {
                    ApplicationArea = All;
                }
                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = all;
                }
            }
            part("Task Activity Lines"; "Task Activity Lines")
            {
                ApplicationArea = all;
                SubPageLink = "Task Code" = field("Task Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }
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