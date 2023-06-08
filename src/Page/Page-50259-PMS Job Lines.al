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
                    //ApplicationArea = all;
                }
                field("Task Code"; rec."Task Code")
                {
                    ApplicationArea = all;
                }
                field("Task Name"; rec."Task Name")
                {
                    ApplicationArea = all;
                }
                field(Activities; rec.Activities)
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
                }
            }
        }
    }

    actions
    {
    }
}

