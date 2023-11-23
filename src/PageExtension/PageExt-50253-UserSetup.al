pageextension 50253 usersetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Delete Equipment"; Rec."Delete Equipment")
            {
                ApplicationArea = all;
            }
            field("Allow to Edit PMS Master"; Rec."Allow to Edit PMS Master")
            {
                ApplicationArea = all;
            }
        }
        addafter("Allow Posting To")
        {
            field("Allow to Closed PMS"; Rec."Allow to Closed PMS")
            {
                ApplicationArea = all;
            }
            field("Allow to Scheduled PMS"; Rec."Allow to Scheduled PMS")
            {
                ApplicationArea = all;
            }
            field("Allow to Ready to Closed PMS"; Rec."Allow to Ready to Closed PMS")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
}