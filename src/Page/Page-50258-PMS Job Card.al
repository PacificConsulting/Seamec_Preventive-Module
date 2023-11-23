page 50258 "PMS Job Card"
{
    PageType = Card;
    Caption = 'Work Order Card';
    SourceTable = 50255;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Schedule No."; rec."Schedule No.")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Equipment Code"; rec."Equipment Code")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Equipment Description"; rec."Equipment Description")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    //  Editable = EditableField;
                }
                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = all;
                    // Editable = EditableField;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    // Editable = EditableField;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Resource Provider"; rec."Resource Provider")
                {
                    ApplicationArea = all;
                    // Editable = EditableField;
                }
                field("Assigned To"; rec."Assigned To")
                {
                    ApplicationArea = all;
                    //  Editable = EditableField;
                }
                field("Assigned to designation"; Rec."Assigned to designation")
                {
                    ApplicationArea = all;
                    ///  Editable = EditableField;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecSelectDesignation: Record "Select Designation";
                    begin
                        RecSelectDesignation.Reset();
                        if Page.RunModal(Page::"Select Designation List", RecSelectDesignation) = Action::LookupOK then
                            rec."Assigned to designation" := RecSelectDesignation.Description;
                    end;


                }
                field("Initial Meter Reading"; Rec."Initial Meter Reading") //pcpl-064 20sep2023
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Meter Interval in Hrs"; Rec."Meter Interval in Hrs") //pcpl-064 20sep2023
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("Current Meter Reading"; Rec."Current Meter Reading") //pcpl-064 20sep2023
                {
                    ApplicationArea = all;
                    Editable = EditableField;
                }
                field("System Created"; Rec."System Created") //pcpl-064 27sep2023
                {
                    ApplicationArea = all;
                    //  Editable = EditableField;
                }
            }
            part("PMS Job Lines"; 50259)
            {
                ApplicationArea = all;
                Caption = 'Task Activities Lines';
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
        //PCPL-25/220823
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50255),
                              "No." = FIELD("Job No.");
            }
        }
        //PCPL-25/220823
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
                    if Usersetup_1.Get(UserId) then begin //PCPL-064 6oct2023
                        if Usersetup_1."Allow to Closed PMS" = false then
                            Error('You do not have Permission'); //PCPL-064 6oct2023
                    end;
                    // PMSJOBLIne.Reset();
                    // PMSJOBLIne.SetRange("Job No.", Rec."Job No.");
                    // if PMSJOBLIne.FindFirst() then
                    //     repeat
                    //         PMSJOBLIne.TestField("Job Done Comments");
                    //     until PMSJOBLIne.Next() = 0;

                    Clear(cnt);
                    if (Rec."Equipment Code" <> '') and (Rec."Schedule No." <> '') then begin
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
                    end else begin
                        Rec.Status := Rec.Status::Closed;
                        Rec."Closed user ID" := UserId;
                        Rec.Modify();
                        Message(Rec."Job No." + ' Job no is closed');
                    end;

                    if Rec.Status = Rec.Status::Closed then begin
                        PMSJObLine1.Reset();
                        PMSJObLine1.SetRange("Job No.", Rec."Job No.");
                        if PMSJObLine1.FindSet() then
                            repeat
                                TaskActLine.Reset();
                                TaskActLine.SetRange("Task Code", PMSJObLine1."Task Code");
                                if TaskActLine.FindSet() then
                                    repeat
                                        PosteTaskLine.Reset();
                                        PosteTaskLine.SetRange("Task Code", TaskActLine."Task Code");
                                        PosteTaskLine.SetRange("Task Line No.", TaskActLine."Line No.");
                                        if not PosteTaskLine.FindFirst() then begin
                                            PosteTaskLine.Init();
                                            PosteTaskLine."Task Code" := TaskActLine."Task Code";
                                            PosteTaskLine."Task Line No." := TaskActLine."Line No.";
                                            PosteTaskLine."Work Order No" := Rec."Job No.";
                                            PosteTaskLine."Work Order Line No." := PMSJObLine1."Line No.";
                                            PosteTaskLine."Schedule No" := Rec."Schedule No.";
                                            PosteTaskLine.Activities := TaskActLine.Activities;
                                            PosteTaskLine."Job Done Comment" := TaskActLine."Job Done Comment";
                                            PosteTaskLine."Equipment Code" := Rec."Equipment Code";
                                            PosteTaskLine."Equipment Description" := Rec."Equipment Description";
                                            PosteTaskLine.Insert();
                                        end;
                                    until TaskActLine.Next() = 0;
                            until PMSJObLine1.Next() = 0;
                    end;
                end;
            }

            action("Schedule PMS")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Usersetup_1.Get(UserId) then begin //PCPL-064 6oct2023
                        if Usersetup_1."Allow to Scheduled PMS" = false then
                            Error('You do not have Permission'); //PCPL-064 6oct2023
                    end;
                    if rec.Status = rec.Status::Open then begin
                        Rec.Status := Rec.Status::Scheduled;
                        Rec.Modify();
                        Message('This ' + Rec."Job No." + ' Job no is scheduled');
                    end
                end;
            }
            action("Ready to Close") //pcpl-06427sep2023
            {
                ApplicationArea = all;
                trigger OnAction()

                begin
                    if Usersetup_1.Get(UserId) then begin //PCPL-064 6oct2023
                        if Usersetup_1."Allow to Ready to Closed PMS" = false then
                            Error('You do not have Permission'); //PCPL-064 6oct2023
                    end;

                    if Rec.Status = Rec.Status::Open then
                        Error('You can not update status as ready to close if Work Order is not Scheduled')
                    else
                        if rec.Status = rec.Status::Scheduled then begin
                            Rec.Status := Rec.Status::"Ready to Close";
                            Rec.Modify();
                            // Commit();
                            Message(Format(Rec.Status));
                        end
                    /*  if rec.Status = rec.Status::Scheduled then
                    Rec.Status := Rec.Status::"Ready to Close" */
                    // Rec.Modify()
                    //  Message('This ' + Rec."Job No." + ' Job no is Ready to close')

                end;



            }
            /*   action("Ready to close new")
              {
                  ApplicationArea = all;
                  Visible = false;
                  trigger OnAction()
                  var
                      myInt: Integer;
                  begin
                      if Rec.Status = rec.Status::Scheduled then begin
                          rec.Status := Rec.Status::"Ready to stop";
                          rec.Modify();
                      end;
                  end;
              } */
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
    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        /*  if rec."System Created" = true then  //PCPL -064 28sep2023
             Error('You can not modify system created work order'); */
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;

    /* trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if rec."System Created" = true then  //PCPL -064 28sep2023
            Error('You can not modify system created work order');
    end; */


    trigger OnOpenPage()
    begin
        //  if rec."System Created" = true then  //PCPL -064 27sep2023
        //      Error('You can not modify system created work order');
        /* if Usersetup_1.Get(UserId) then begin
            if Usersetup_1."Allow to Closed PMS" then
            
        end; */
        //PCPL -064<< 11Nov2023
        if Rec."System Created" = false then
            EditableField := true
        else
            EditableField := false;
        //PCPL -064 >>11Nov2023

    end;

    trigger OnAfterGetRecord()
    begin
        //PCPL -064<< 11Nov2023
        if Rec."System Created" = false then
            EditableField := true
        else
            EditableField := false;
        //PCPL -064 >>11Nov2023  
    end;

    var
        Usersetup_1: Record "User Setup"; //PCPL-064 6oct2023
        useSetup: Record "User Setup";
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
        TaskActLine: Record "Task Activity Lines";
        PosteTaskLine: Record "Posted Task Activity Lines";
        PMSJObLine1: Record "PMS Job Lines";
        EditableField: Boolean;

}

