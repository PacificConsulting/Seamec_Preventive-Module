page 50252 "Maintenance Schedule List"
{
    CardPageID = "Maintenance Schedule Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50252;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Schedule No."; rec."Schedule No.")
                {
                    ApplicationArea = all;
                }
                field("Schedule Description"; rec."Schedule Description")
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

