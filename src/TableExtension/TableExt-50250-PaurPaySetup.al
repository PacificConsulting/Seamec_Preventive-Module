tableextension 50250 "Purch And Payable Ext" extends "Purchases & Payables Setup"
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