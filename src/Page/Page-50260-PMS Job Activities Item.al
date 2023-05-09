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
                field(Quantiry; rec.Quantiry)
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
    }
}

