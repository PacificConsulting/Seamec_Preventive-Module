page 50256 "Manitenance Task Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 50254;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Equipment Code"; rec."Equipment Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Task Code"; rec."Task Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        MTL: Record "Manitenance Task Lines";
                    begin
                        MTL.Reset();
                        //  MTL.SetRange("Task Code", rec."Task Code"); //pcpl-064 28sep2023
                        MTL.SetRange("Equipment Code", rec."Equipment Code"); //pcpl-064 1Nov2023
                        MTL.SetRange("Task Code", rec."Task Code");
                        MTL.SetRange("Schedule No.", Rec."Schedule No.");
                        if MTL.FindSet() then
                            repeat
                                Error('This Task code is already used');
                            until MTL.Next() = 0;
                    end;

                }
                field("Task Name"; rec."Task Name")
                {
                    ApplicationArea = all;
                }
                field(Activities; rec.Activities)
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Schedule No."; rec."Schedule No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Schedule Line No."; rec."Schedule Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
    /* trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        if rec."Task Code" = rec."Task Code" then //pcpl-064 28sep2023
            Error('Already Exist');
    end;
 */
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //if Rec."Task Code" = Rec."Task Code" then //pcpl-064 28sep2023
        //  Error('Already Exist');
    end;

    var
        MTL: Record "Manitenance Task Lines";
}

