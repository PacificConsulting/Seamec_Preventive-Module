pageextension 50252 "General Ledger Setup EXT" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Account Nos.")
        {
            field("PMS Module"; Rec."PMS Module")
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