page 50255 "Equipment Card"
{
    PageType = Card;
    SourceTable = 50250;

    layout
    {
        area(content)
        {
            group(General)
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
                    trigger OnValidate()
                    begin
                        IsMeterReadingApplicable := (rec."Meter Reading Applicable") AND (rec."Counter Code" = '');

                    end;
                }
                field("Initial Meter Reading"; rec."Initial Meter Reading")
                {
                    Editable = FALSE;// IsMeterReadingApplicable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if Rec."Initial Meter Reading" <> 0 then
                            IsMeterReadingApplicable := false
                    end;
                }

                field("Current Meter Reading"; rec."Current Meter Reading")
                {
                    Editable = False;
                    ApplicationArea = all;
                }

                field("Counter Code"; Rec."Counter Code")
                {
                    ApplicationArea = All;
                    Editable = IsMeterReadingApplicable;
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
        area(Processing)
        {
            action(Comments)
            {
                ApplicationArea = all;
                Image = ViewComments;
                trigger Onaction()
                var
                    EquipComment: Record "Equipment Comment";
                    pageEquipComm: Page "Equipment Comments";
                begin
                    EquipComment.SETRANGE("Equipment Code", Rec."Equipment Code");
                    pageEquipComm.SETTABLEVIEW(EquipComment);
                    pageEquipComm.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if (rec."Meter Reading Applicable") and (Rec."Counter Code" = '') then
            IsMeterReadingApplicable := true
        else
            IsMeterReadingApplicable := false;
    end;


    var
        IsMeterReadingApplicable: Boolean;
}

