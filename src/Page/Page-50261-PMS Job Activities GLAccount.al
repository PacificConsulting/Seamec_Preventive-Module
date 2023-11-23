page 50261 "PMS Job Activities-G/L Account"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50257;
    SourceTableView = WHERE(Type = FILTER("G/L Account"));

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
                field(Quantiry; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension Code 1"; Rec."Shortcut Dimension Code 1")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension Code 2"; Rec."Shortcut Dimension Code 2")
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Charge Description"; Rec."Charge Description")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Requsition")
            {
                Image = "Action";
                ApplicationArea = all;
                Caption = 'Create Requsition';
                trigger OnAction()
                begin
                    PurchSetup.get;
                    genLedSetup.GET();
                    genLedSetup.TestField("PMS Module");
                    PurchSetup.TestField("Work Order No.");
                    rec.TESTFIELD("Vendor No.");
                    rec.TESTFIELD("Work Order No.", '');
                    rec.TESTFIELD("Location Code");
                    PMSJobActivity.RESET;
                    PMSJobActivity.SETRANGE("Job No.", Rec."Job No.");
                    PMSJobActivity.SETRANGE(Type, PMSJobActivity.Type::"G/L Account");
                    PMSJobActivity.SETRANGE("Line No.", rec."Line No.");
                    IF NOT PMSJobActivity.FINDFIRST THEN
                        ERROR('GL lines are not available in this Job Card')
                    ELSE BEGIN
                        PMSHeade.RESET;
                        PMSHeade.SETRANGE("Job No.", Rec."Job No.");
                        IF PMSHeade.FINDFIRST THEN //
                            PurchaseHeader.INIT;
                        PurchSetup.GET;
                        PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchSetup."Work Order No.", TODAY, FALSE);
                        //NoSeriesMgt.InitSeries(PurchSetup."Work Order No.", PurchSetup."Work Order No.", TODAY, PurchaseHeader."No.", PurchSetup."Work Order No.");
                        //PurchaseHeader.VALIDATE("Work Order", TRUE);
                        PurchaseHeader.VALIDATE("Posting Date", TODAY);
                        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.VALIDATE("Buy-from Vendor No.", PMSJobActivity."Vendor No.");
                        PurchaseHeader.VALIDATE("Location Code", PMSJobActivity."Location Code");
                        PurchaseHeader.INSERT;
                        PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", PMSJobActivity."Shortcut Dimension Code 1");
                        PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code", PMSJobActivity."Shortcut Dimension Code 2");
                        PurchaseHeader.MODIFY;

                        CLEAR(vLine);
                        PMSJobActivity.RESET;
                        PMSJobActivity.SETRANGE("Job No.", Rec."Job No.");
                        PMSJobActivity.SETRANGE(Type, PMSJobActivity.Type::"G/L Account");
                        PMSJobActivity.SETRANGE("Line No.", rec."Line No.");
                        IF PMSJobActivity.FINDFIRST THEN
                            REPEAT
                                PurchaseLine.RESET;
                                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                                IF PurchaseLine.FINDLAST THEN
                                    vLine := PurchaseLine."Line No." + 10000
                                ELSE
                                    vLine := 10000;
                                PurchaseLine.INIT;
                                PurchaseLine."Document No." := PurchaseHeader."No.";
                                PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
                                PurchaseLine."Line No." := vLine;
                                PurchaseLine.VALIDATE(Type, PurchaseLine.Type::"G/L Account");
                                PurchaseLine.VALIDATE("No.", PMSJobActivity."No.");
                                PurchaseLine.VALIDATE(Quantity, PMSJobActivity.Quantity);
                                PurchaseLine.VALIDATE("Direct Unit Cost", PMSJobActivity."Unit Cost");
                                //PurchaseLine.VALIDATE("Charge Description", PMSJobActivity."Charge Description");
                                PurchaseLine.INSERT;
                                vLine += 10000;
                            UNTIL PMSJobActivity.NEXT = 0;
                        rec."Work Order No." := PurchaseHeader."No.";
                    END;
                    MESSAGE('Work Order is Created');
                end;
            }
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

