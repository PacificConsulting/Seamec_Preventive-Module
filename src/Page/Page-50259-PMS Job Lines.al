page 50259 "PMS Job Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50256;


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
                field("Task Code"; rec."Task Code")
                {
                    ApplicationArea = all;
                }
                field("Task Name"; rec."Task Name")
                {
                    ApplicationArea = all;
                }
                /*field(Activities; rec.Activities)
                {
                    ApplicationArea = all;
                }
                field("Job Done Comments"; rec."Job Done Comments")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        PMS_JobHdr: Record 50255;
                    Begin
                        IF PMS_JobHdr.GET(rec."Job No.") then;
                        IF PMS_JobHdr.Status <> PMS_JobHdr.Status::Scheduled then
                            Error('You can''t modify line Because order is not scheduled');
                    End;
                }*/ //PCPL-25/040923
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Task Lines")
            {
                ApplicationArea = all;
                RunObject = page "Task Activity List";
                RunPageLink = "Task Code" = field("Task Code");
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        PMSHeader.Reset();
        PMSHeader.SetRange("Job No.", rec."Job No.");
        if PMSHeader.FindFirst() then begin
            if PMSHeader."System Created" = true then  //PCPL -064 27sep2023
                Error('You can not modify system created work order');
        end;
    end;

    /*  trigger OnOpenPage()
     var
         myInt: Integer;
     begin
         //PCPL -064 27sep2023
         PMSHeader.Reset();
         PMSHeader.SetRange("Job No.", rec."Job No.");
         if PMSHeader.FindFirst() then begin
             if PMSHeader."System Created" = true then  //PCPL -064 27sep2023
                 Error('You can not modify system created work order');
         end;

     end; */

    var
        PMSHeader: record "PMS Job Header";
}

