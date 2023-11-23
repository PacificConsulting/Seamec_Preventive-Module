tableextension 50252 "General Ledger Setup EXt" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50252; "PMS Module"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50253; "Counter Reading Modification"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-25/280623';
        }
    }

    var
        myInt: Integer;
}