tableextension 50251 "Location Ext" extends Location
{
    fields
    {
        // Add changes to table fields here
        field(50250; "PMS Job Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}