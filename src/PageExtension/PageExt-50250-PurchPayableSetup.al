pageextension 50250 "MyExtension" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posted Credit Memo Nos.")
        {
            field("PMS Job Nos"; Rec."PMS Job Nos")
            {
                ApplicationArea = All;
            }
            field("Work Order No."; Rec."Work Order No.")
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