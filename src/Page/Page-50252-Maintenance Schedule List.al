page 50252 "Maintenance Schedule List"
{
    CardPageID = "Maintenance Schedule Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50252;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Schedule No."; rec."Schedule No.")
                {
                    ApplicationArea = all;
                }
                field("Schedule Description"; rec."Schedule Description")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;

    trigger OnOpenPage()
    var

    begin
        //<<pcpl -06427sep2023
        if UserSetup1.get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" = true then
                CurrPage.Editable(true)
            else
                CurrPage.Editable(false);
        end;
        // Message(FORMAT(UserSetup1."Allow to Edit PMS Master")); */
        /* //>>pcpl 06427sep2023
        if UserSetup1.Get(UserId) then begin //pcpl-064 27sep2023
            if UserSetup1."Allow to Edit PMS Master" then
                CurrPage.Editable(false); //pcpl-064 27sep2023
        end; */

    end;


    var
        useSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
}

