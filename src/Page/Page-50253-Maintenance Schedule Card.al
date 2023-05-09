page 50253 "Maintenance Schedule Card"
{
    PageType = Card;
    SourceTable = 50252;

    layout
    {
        area(content)
        {
            group(General)
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
            part(lines; 50254)
            {
                ApplicationArea = all;
                SubPageLink = "Schedule No." = FIELD("Schedule No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test")
            {
                ApplicationArea = all;
                RunObject = codeunit 50250;
            }
        }
    }
}

