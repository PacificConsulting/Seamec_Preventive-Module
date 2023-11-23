page 50265 "Closed PMS Job Card"
{
    PageType = Card;
    SourceTable = 50255;
    Caption = 'Closed Work Order Card';
    InsertAllowed = false;
    ModifyAllowed = false;
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
        }

    }
    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;

    var
        useSetup: Record "User Setup";
}

