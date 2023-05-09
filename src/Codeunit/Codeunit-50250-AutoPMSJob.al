codeunit 50250 "Auto PMS Job Creation"
{
    TableNo = "Maintenance Schedule Header";

    trigger OnRun()
    begin
        AutoMeterInterval(Rec);
        AutoSchedulePMS(Rec);
    end;

    var
        myInt: Integer;

    Procedure AutoSchedulePMS(Mschehead: Record "Maintenance Schedule Header")
    var
        MScheduleLine: Record "Maintenance Schedule Line";
        EquipMaster: Record "Equipment Master";
        PMSJobH: Record "PMS Job Header";
        PMSJobLine: Record "PMS Job Lines";
        Loc: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Stime: DateFormula;
    begin
        MScheduleLine.Reset();
        MScheduleLine.SetRange("Schedule No.", Mschehead."Schedule No.");
        MScheduleLine.SetFilter(Scheduling, '<>%1', Stime);
        if MScheduleLine.FindSet() then
            repeat
                if EquipMaster.Get(MScheduleLine."Equipment Code") then;
                if Loc.Get(EquipMaster."Location Code") then;
                if MScheduleLine."Schedule Start Date" = Today then begin
                    PMSJobH.Init();
                    Loc.TestField("PMS Job Nos");
                    NoSeriesMgt.InitSeries(Loc."PMS Job Nos", '', Today, PMSJobH."Job No.", Loc."PMS Job Nos");
                    PMSJobH.Validate("Schedule No.", Mschehead."Schedule No.");
                    PMSJobH.Validate("Equipment Code", MScheduleLine."Equipment Code");
                    PMSJobH.Validate("Maintenance Type", MScheduleLine."Maintenance Type");
                    PMSJobH.Validate("Location Code", EquipMaster."Location Code");
                    PMSJobH.Insert();
                    MScheduleLine."Schedule Start Date" := CalcDate(MScheduleLine.Scheduling, MScheduleLine."Schedule Start Date");
                    MScheduleLine.Insert();
                end
            until MScheduleLine.Next() = 0;
    end;

    Procedure AutoMeterInterval(Mschehead: Record "Maintenance Schedule Header")
    var
        MScheduleLine: Record "Maintenance Schedule Line";
        EquipMaster: Record "Equipment Master";
        PMSJobH: Record "PMS Job Header";
        PMSJobLine: Record "PMS Job Lines";
        Loc: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        MScheduleLine.Reset();
        MScheduleLine.SetRange("Schedule No.", Mschehead."Schedule No.");
        MScheduleLine.SetFilter("Meter Interval in Hrs", '<>%1', 0);
        if MScheduleLine.FindSet() then
            repeat
                if EquipMaster.Get(MScheduleLine."Equipment Code") then;
                if Loc.Get(EquipMaster."Location Code") then;
                //if MScheduleLine."Schedule Start Date" = Today then begin
                PMSJobH.Init();
                Loc.TestField("PMS Job Nos");
                NoSeriesMgt.InitSeries(Loc."PMS Job Nos", '', Today, PMSJobH."Job No.", Loc."PMS Job Nos");
                PMSJobH.Validate("Schedule No.", Mschehead."Schedule No.");
                PMSJobH.Validate("Equipment Code", MScheduleLine."Equipment Code");

            //end
            until MScheduleLine.Next() = 0;
    end;
}