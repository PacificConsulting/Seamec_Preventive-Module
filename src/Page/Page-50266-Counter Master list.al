page 50266 "Counter Master List"
{
    CardPageID = "Counter Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50260;
    UsageCategory = Lists;
    ApplicationArea = all;
    //DeleteAllowed = false;  //PCPL-25/280823

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
                // field("Meter Reading Applicable"; rec."Meter Reading Applicable")
                // {
                //     ApplicationArea = all;
                // }
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
    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;

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
        useSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
}

