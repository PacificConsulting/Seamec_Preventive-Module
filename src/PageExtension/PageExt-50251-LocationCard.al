pageextension 50251 "Location" extends "Location Card"
{
    layout
    {
        // Add changes to page layout here
        addlast("Tax Information")
        {
            field("PMS Job Nos"; Rec."PMS Job Nos")
            {
                ApplicationArea = All;
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