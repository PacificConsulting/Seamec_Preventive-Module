page 50258 "PMS Job Card"
{
    PageType = Card;
    Caption = 'Work Order Card';
    SourceTable = 50255;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Schedule No."; rec."Schedule No.")
                {
                    ApplicationArea = all;
                }
                field("Equipment Code"; rec."Equipment Code")
                {
                    ApplicationArea = all;
                }
                field("Equipment Description"; rec."Equipment Description")
                {
                    ApplicationArea = all;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    ApplicationArea = all;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Resource Provider"; rec."Resource Provider")
                {
                    ApplicationArea = all;
                }
                field("Assigned To"; rec."Assigned To")
                {
                    ApplicationArea = all;
                }
            }
            part("PMS Job Lines"; 50259)
            {
                ApplicationArea = all;
                SubPageLink = "Job No." = FIELD("Job No.");
            }
            part("PMS Activities-Inventory"; 50260)
            {
                ApplicationArea = all;
                SubPageLink = "Job No." = FIELD("Job No.");
            }
            part("PMS Activities-Work Order"; 50261)
            {
                ApplicationArea = all;
                SubPageLink = "Job No." = FIELD("Job No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Closed PMS")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PMSJOBLIne.Reset();
                    PMSJOBLIne.SetRange("Job No.", Rec."Job No.");
                    if PMSJOBLIne.FindFirst() then
                        repeat
                            PMSJOBLIne.TestField("Job Done Comments");
                        until PMSJOBLIne.Next() = 0;

                    Clear(cnt);
                    PMSJob.Reset();
                    PMSJob.SetCurrentKey("Equipment Code", Status, "Creation Date");
                    PMSJob.SetRange("Equipment Code", Rec."Equipment Code");
                    PMSJob.SetFilter("Creation Date", '<%1', Rec."Creation Date");
                    PMSJob.SetFilter(Status, '<>%1', PMSJob.Status::Closed);
                    if PMSJob.FindFirst() then begin
                        cnt := PMSJob.Count;
                        Error(PMSJob."Job No." + ' job no is open or scheduled for ' + PMSJob."Equipment Code");
                    end else begin
                        Rec.Status := Rec.Status::Closed;
                        Rec."Closed user ID" := UserId;
                        Rec.Modify();
                        Message(Rec."Job No." + ' Job no is closed');
                    end;

                    /*
                    if cnt <> 0 then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify();
                        Message(Rec."Job No." + ' Job no is closed');
                    end
                    else
                        Error(PMSJob."Job No." + ' job no is open or scheduled for ' + PMSJob."Equipment Code");
*/
                end;
            }

            action("Schedule PMS")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if rec.Status = rec.Status::Open then begin
                        Rec.Status := Rec.Status::Scheduled;
                        Rec.Modify();
                        Message('This ' + Rec."Job No." + ' Job no is scheduled');
                    end
                end;
            }
            action(PMSReport)
            {
                Caption = 'PMS Job Report';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PrintReport;
                trigger OnAction()
                var
                    PMS_Hdr: Record "PMS Job Header";
                Begin
                    PMS_Hdr.Reset();
                    PMS_Hdr.SetRange("Job No.", Rec."Job No.");
                    if PMS_Hdr.FindFirst() then
                        Report.RunModal(50250, true, true, PMS_Hdr);
                End;
            }
            //additional part

            /* action("Create Item Journal")
             {
                 Enabled = true;
                 Image = Post;
                 ApplicationArea = all;

                 trigger OnAction()
                 begin
                     PMSJobActivity.RESET;
                     PMSJobActivity.SETRANGE("Job No.", Rec."Job No.");
                     PMSJobActivity.SETRANGE(Type, PMSJobActivity.Type::Item);
                     IF PMSJobActivity.FINDFIRST THEN
                         REPEAT
                         // PMSJobActivity.CalcFields(PMSJobActivity."Inventory  Qty");
                         // IF PMSJobActivity."Inventory  Qty" < MaintenanceLine.Quantity THEN //PCPL0017 New
                         //     ERROR('Inventory  Quantity is 0 for Item %1', PMSJobActivity."No.");
                         UNTIL PMSJobActivity.NEXT = 0;

                     PMSJobActivity.RESET;
                     PMSJobActivity.SETRANGE("Job No.", Rec."Job No.");
                     PMSJobActivity.SETRANGE(Type, PMSJobActivity.Type::Item);
                     IF PMSJobActivity.FINDFIRST THEN
                         CLEAR(vLine);
                     REPEAT
                         IF vLine = 0 THEN
                             vLine := 10000;
                         ItemJournalLine.RESET;
                         ItemJournalLine.INIT;
                         ItemJournalLine."Journal Batch Name" := 'PREV MAINT';
                         ItemJournalLine."Journal Template Name" := 'ITEM';
                         ItemJnlTemplate.GET('ITEM');
                         ItemJnlBatch.GET('ITEM', 'PREV MAINT');
                         ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                         ItemJournalLine."Document Date" := WORKDATE;
                         IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                             CLEAR(NoSeriesMgt);
                             ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", TODAY, FALSE);
                         END;
                         ItemJournalLine."Line No." := vLine;
                         ItemJournalLine."Posting Date" := TODAY;
                         ItemJournalLine."Item No." := PMSJobActivity."No.";
                         ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, PMSJobActivity.Quantity);
                         ItemJournalLine."Location Code" := PMSJobActivity."Location Code";
                         //ItemJournalLine."Bin Code" := PMSJobActivity."Bin Code";
                         recItem.GET(PMSJobActivity."No.");
                         ItemJournalLine.Description := recItem.Description;
                         ItemJournalLine."Unit of Measure Code" := recItem."Base Unit of Measure";
                         ItemJournalLine."Gen. Prod. Posting Group" := recItem."Gen. Prod. Posting Group";
                         ItemJournalLine."Job Card Ref." := Rec."Job No.";
                         ItemJournalLine.INSERT;
                         vLine += 10000;
                     UNTIL PMSJobActivity.Next() = 0;
                     MESSAGE('Item Journal Line has been created');
                 end;
             } */
            //
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

}

