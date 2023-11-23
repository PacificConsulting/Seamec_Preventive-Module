page 50255 "Equipment Card"
{
    PageType = Card;
    SourceTable = 50250;
    //DeleteAllowed = false;  //PCPL-25/280823

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
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    /*trigger onvalidate()
                    var
                        myInt: Integer;
                        PageConfirmation: Page "Password Detail";
                        Employee: Record Employee;
                        ATS: Record "Audit Trail Setup";
                        GLSetup: Record "General Ledger Setup";
                    begin
                        //PCPL-0070 27June23 <<
                        GLSetup.GET;
                        IF GLSetup."Password Posting" then begin
                            IF Rec.Status = Rec.Status::Installed then begin
                                Clear(PageConfirmation);
                                PageConfirmation.LookupMode(true);
                                if PageConfirmation.RunModal() = Action::LookupOK then begin
                                    CurrentPassword := PageConfirmation.ReturnPassword();
                                    ATS.Reset();
                                    ATS.SetRange("User ID", UserId);
                                    ATS.SetRange(Password, CurrentPassword);
                                    IF not ATS.FindFirst() then
                                        Error('Given password is wrong or setup is missing');
                                    Rec."Employee ID" := ATS."Employee ID";
                                    Rec.Modify();
                                end Else
                                    Error('Please enter the password for change status.');
                            end;
                        end;
                        //PCPL-0070 27June23 <<
                    end; */   //PCPL-25/100823 temp commnet and hide dependacies authorization post

                }
                field("Revision Count"; Rec."Revision Count") //pcpl-064 27sep2023
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
    trigger OnModifyRecord(): Boolean
    begin
        rec."Revision Count" += 1; //pcpl-064 28sep2023
    end;

    trigger OnAfterGetRecord()
    begin

        if (rec."Meter Reading Applicable") and (Rec."Counter Code" = '') then
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

    trigger OnOpenPage()
    begin
        /* //<<pcpl-064 28sep2023
        if UserSetup1.Get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" then
                CurrPage.Editable(true);
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
        PerDelete: Boolean;
        IsMeterReadingApplicable: Boolean;
        CurrentPassword: Text[20];
        UserSetup1: Record "User Setup";
}

