enum 50255 "Maintaince Type"
{
    Extensible = true;

    value(0; "Certification/Survey/Audit")
    {
        Caption = 'Certification/Survey/Audit';
    }
    value(1; "Critical Equipments")
    {
        Caption = 'Critical Equipments';
    }
    value(2; "Preventive Maintenance")
    {
        Caption = 'Preventive Maintenance';
    }
    value(3; "Safety Mainetanance")
    {
        Caption = 'Safety Mainetanance';
    }
    value(4; "unscheduled(Adhoc)") { Caption = 'unscheduled(Adhoc)'; }
    value(5; "Agency/Services") { Caption = 'Agency/Services'; }
    value(6; Breakdown) { Caption = 'Breakdown'; }
    value(7; "Drydock/ Layop") { Caption = 'Drydock/ Layop'; }
    value(8; "Repairable Spare") { Caption = 'Repairable Spare'; }
    value(9; "Running Repair List") { Caption = 'Running Repair List'; }
    value(10; "Work Shop Assistance") { Caption = 'Work Shop Assistance'; }
    value(11; "Service Engineer/ Technician") { Caption = 'Service Engineer/ Technician'; }
    value(12; "Project Related/ Equipment Hire") { Caption = 'Project Related/ Equipment Hire'; }
}