tableextension 50253 UserSetup extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50250; "Delete Equipment"; Boolean)
        {

        }
        field(50251; "Allow to Edit PMS Master"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 27sep2023';
        }
        field(50252; "Allow to Closed PMS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 6OCT2023';
        }
        field(50253; "Allow to Scheduled PMS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 6OCT2023';
        }
        field(50254; "Allow to Ready to Closed PMS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PCPL-064 6OCT2023';
        }
    }

    var
        myInt: Integer;
}