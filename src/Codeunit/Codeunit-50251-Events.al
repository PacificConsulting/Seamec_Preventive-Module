codeunit 50251 DocumentAttachment
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        EquipmentMaster: Record "Equipment Master";
        PMSJobH: Record "PMS Job Header";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Equipment Master":
                begin
                    RecRef.Open(DATABASE::"Equipment Master");
                    if EquipmentMaster.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(EquipmentMaster);
                end;
            //PCPL-25/220823
            DATABASE::"PMS Job Header":
                begin
                    RecRef.Open(DATABASE::"PMS Job Header");
                    if PMSJobH.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(PMSJobH);
                end;
        //PCPL-25/220823    
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Equipment Master":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            //PCPL-25/220823
            DATABASE::"PMS Job Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        //PCPL-25/220823
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Equipment Master":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            //PCPl-25/220823
            DATABASE::"PMS Job Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        //PCPL-25/220823

        end;
    end;
}