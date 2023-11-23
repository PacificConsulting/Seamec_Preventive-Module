page 50250 "Equipment Master List"
{
    CardPageID = "Equipment Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50250;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Equipment Code"; rec."Equipment Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                }
                field(Owners; rec.Owners)
                {
                    ApplicationArea = all;
                }
                field("Class Code"; rec."Class Code")
                {
                    ApplicationArea = all;
                }
                field("Out of Service"; rec."Out of Service")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
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
                    Editable = false;
                }
                // field("Running Hrs."; rec."Running Hrs.")
                // {
                //     ApplicationArea = all;
                // }
                field("Current Meter Reading"; rec."Current Meter Reading")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Equipment Master"),
                              "No." = FIELD("Equipment Code");
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


