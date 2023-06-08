tableextension 50252 "General Ledger Setup EXt" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50252; "PMS Module"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}