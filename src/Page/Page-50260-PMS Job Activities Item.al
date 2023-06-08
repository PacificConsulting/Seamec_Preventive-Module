page 50260 "PMS Job Activities-Item"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50257;
    SourceTableView = WHERE(Type = FILTER(Item));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }

    var
        PMSJob: Record "PMS Job Header";
        cnt: Integer;
        PMSJOBLIne: Record "PMS Job Lines";
        EquipCOmment: Record "Equipment Comment";
        EquuipMaster: Record "Equipment Master";
        commCount: Integer;
        PMSHeade: Record "PMS Job Header";
        PMSJobActivity: Record "PMS Job Activities";
        //RequisitionHeader: Record "Indent Header";
        ReqCreated: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        vLine: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //RequisitionLine: Record "Indent Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        recItem: Record Item;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchPaySet: Record "Purchases & Payables Setup";
        genLedSetup: Record "General Ledger Setup";
}

