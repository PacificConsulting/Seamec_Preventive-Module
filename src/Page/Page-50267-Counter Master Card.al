page 50267 "Counter Card"
{
    PageType = Card;
    SourceTable = 50260;

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
    end;

    trigger OnAfterGetRecord()
    begin
        //if (rec."Meter Reading Applicable") and (Rec."Initial Meter Reading" = 0) then
        if (Rec."Initial Meter Reading" = 0) then
            IsMeterReadingApplicable := true
        else
            IsMeterReadingApplicable := false;
    end;

    var
        IsMeterReadingApplicable: Boolean;
}

