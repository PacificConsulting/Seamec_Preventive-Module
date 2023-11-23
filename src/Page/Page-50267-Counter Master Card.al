page 50267 "Counter Card"
{
    PageType = Card;
    SourceTable = 50260;
    //DeleteAllowed = false;   //PCPL-25/280823

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }

                field("Initial Meter Reading"; rec."Initial Meter Reading")
                {
                    Editable = IsMeterReadingApplicable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if Rec."Initial Meter Reading" <> 0 then
                            IsMeterReadingApplicable := false
                    end;
                }
                field("Running Hrs."; rec."Running Hrs.")
                {
                    ApplicationArea = all;
                }
                field("Current Meter Reading"; rec."Current Meter Reading")
                {
                    Editable = False;//IsMeterReadingApplicable;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Counter Reading")
            {
                ApplicationArea = All;
                Caption = 'Counter Readings';
                Image = Image;
                RunObject = page "Counter Readings";
                RunPageLink = "Counter Code" = field(Code);
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (Rec."Initial Meter Reading" = 0) then
            IsMeterReadingApplicable := true
        else
            IsMeterReadingApplicable := false;

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

    trigger OnAfterGetRecord()
    begin
        //if (rec."Meter Reading Applicable") and (Rec."Initial Meter Reading" = 0) then
        if (Rec."Initial Meter Reading" = 0) then
            IsMeterReadingApplicable := true
        else
            IsMeterReadingApplicable := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;


    var
        useSetup: Record "User Setup";
        IsMeterReadingApplicable: Boolean;
        UserSetup1: Record "User Setup";
}

