codeunit 50250 "Auto PMS Job Creation"
{
    //TableNo = "Maintenance Schedule Header";
    TableNo = "Job Queue Entry";
    Permissions = tabledata 50255 = RIM, tabledata 50256 = RIM, tabledata 50252 = RM;

    trigger OnRun()
    begin
        MainSchHead.Reset();
        //MainSchHead.SetRange("Schedule No.", 'TESTING16');
        if MainSchHead.FindSet() then
            repeat
                AutoMeterInterval(MainSchHead);
                AutoSchedulePMS(MainSchHead);
            until MainSchHead.Next() = 0;
        Message('hi');
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
        LineCnt: Integer;
        MTaskLine: Record "Manitenance Task Lines";
    begin
        MScheduleLine.Reset();
        MScheduleLine.SetRange("Schedule No.", Mschehead."Schedule No.");
        MScheduleLine.SetFilter(Scheduling, '<>%1', Stime);
        if MScheduleLine.FindSet() then
            repeat
                if EquipMaster.Get(MScheduleLine."Equipment Code") then;
                if Loc.Get(EquipMaster."Location Code") then;
                if MScheduleLine."Schedule Start Date" = Today then begin
                    PMSJobH.Reset();
                    PMSJobH.SetRange("Schedule No.", Mschehead."Schedule No.");
                    PMSJobH.SetRange("Equipment Code", MScheduleLine."Equipment Code");
                    PMSJobH.SetRange("Creation Date", Today);
                    if not PMSJobH.FindFirst() then begin
                        PMSJobH.Init();
                        Loc.TestField("PMS Job Nos");
                        PMSJobH."Job No." := NoSeriesMgt.GetNextNo(Loc."PMS Job Nos", Today, true);
                        PMSJobH.Validate("Schedule No.", Mschehead."Schedule No.");
                        PMSJobH.Validate("Equipment Code", MScheduleLine."Equipment Code");
                        PMSJobH.Validate("Maintenance Type", MScheduleLine."Maintenance Type");
                        PMSJobH.Validate("Location Code", EquipMaster."Location Code");
                        PMSJobH.Validate("Initial Meter Reading", EquipMaster."Initial Meter Reading");
                        PMSJobH.Validate("Current Meter Reading", EquipMaster."Current Meter Reading");
                        PMSJobH."Creation Date" := Today;
                        PMSJobH."Start Date" := Today;
                        PMSJobH."End Date" := Today;
                        PMSJobH."Created By" := UserId;
                        PMSJobH.Insert();

                        MTaskLine.Reset();
                        MTaskLine.SetRange("Schedule No.", MScheduleLine."Schedule No.");
                        MTaskLine.SetRange("Schedule Line No.", MScheduleLine."Line No.");
                        MTaskLine.SetRange("Equipment Code", MScheduleLine."Equipment Code");
                        if MTaskLine.FindFirst() then
                            repeat
                                Clear(LineCnt);
                                PMSJobLine.Reset();
                                PMSJobLine.SetRange("Job No.", PMSJobH."Job No.");
                                if PMSJobLine.FindLast() then
                                    LineCnt := PMSJobLine."Line No.";

                                PMSJobLine.Init();
                                PMSJobLine."Job No." := PMSJobH."Job No.";
                                PMSJobLine."Line No." := LineCnt + 10000;
                                PMSJobLine.Validate("Task Code", MTaskLine."Task Code");
                                PMSJobLine.Insert();
                            until MTaskLine.Next() = 0;

                        MScheduleLine."Schedule Start Date" := CalcDate(MScheduleLine.Scheduling, MScheduleLine."Schedule Start Date");
                        MScheduleLine.Modify();
                    end;
                end
            until MScheduleLine.Next() = 0;
        Message('done');
    end;

    Procedure AutoMeterInterval(Mschehead: Record "Maintenance Schedule Header")
    var
        MScheduleLine: Record "Maintenance Schedule Line";
        EquipMaster: Record "Equipment Master";
        PMSJobH: Record "PMS Job Header";
        PMSJobLine: Record "PMS Job Lines";
        Loc: Record Location;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Stime: DateFormula;
        LineCnt: Integer;
        MetHrs: Integer;
        MTaskLine: Record "Manitenance Task Lines";
    begin
        MScheduleLine.Reset();
        MScheduleLine.SetRange("Schedule No.", Mschehead."Schedule No.");
        MScheduleLine.SetFilter("Meter Interval in Hrs", '<>%1', 0);
        if MScheduleLine.FindSet() then
            repeat
                if EquipMaster.Get(MScheduleLine."Equipment Code") then;
                if Loc.Get(EquipMaster."Location Code") then;
                MetHrs := EquipMaster."Initial Meter Reading" + MScheduleLine."Meter Interval in Hrs";
                if MScheduleLine."Start Meter Interval" <= EquipMaster."Current Meter Reading" then begin
                    PMSJobH.Reset();
                    PMSJobH.SetRange("Schedule No.", Mschehead."Schedule No.");
                    PMSJobH.SetRange("Equipment Code", MScheduleLine."Equipment Code");
                    if not PMSJobH.FindFirst() then begin
                        PMSJobH.Init();
                        Loc.TestField("PMS Job Nos");
                        //NoSeriesMgt.InitSeries(Loc."PMS Job Nos", '', Today, PMSJobH."Job No.", Loc."PMS Job Nos");
                        PMSJobH."Job No." := NoSeriesMgt.GetNextNo(Loc."PMS Job Nos", Today, true);
                        PMSJobH.Validate("Schedule No.", Mschehead."Schedule No.");
                        PMSJobH.Validate("Equipment Code", MScheduleLine."Equipment Code");
                        PMSJobH.Validate("Maintenance Type", MScheduleLine."Maintenance Type");
                        PMSJobH.Validate("Location Code", EquipMaster."Location Code");
                        PMSJobH.Validate("Initial Meter Reading", EquipMaster."Initial Meter Reading");
                        PMSJobH.Validate("Meter Interval in Hrs", MScheduleLine."Meter Interval in Hrs");
                        PMSJobH.Validate("Current Meter Reading", EquipMaster."Current Meter Reading");
                        PMSJobH."Creation Date" := Today;
                        PMSJobH."Start Date" := Today;
                        PMSJobH."End Date" := Today;
                        PMSJobH."Created By" := UserId;
                        PMSJobH.Insert();

                        MTaskLine.Reset();
                        MTaskLine.SetRange("Schedule No.", MScheduleLine."Schedule No.");
                        MTaskLine.SetRange("Schedule Line No.", MScheduleLine."Line No.");
                        MTaskLine.SetRange("Equipment Code", MScheduleLine."Equipment Code");
                        if MTaskLine.FindFirst() then
                            repeat
                                Clear(LineCnt);
                                PMSJobLine.Reset();
                                PMSJobLine.SetRange("Job No.", PMSJobH."Job No.");
                                if PMSJobLine.FindLast() then
                                    LineCnt := PMSJobLine."Line No.";

                                PMSJobLine.Init();
                                PMSJobLine."Job No." := PMSJobH."Job No.";
                                PMSJobLine."Line No." := LineCnt + 10000;
                                PMSJobLine.Validate("Task Code", MTaskLine."Task Code");
                                PMSJobLine.Insert();
                            until MTaskLine.Next() = 0;

                        MScheduleLine."Start Meter Interval" := MScheduleLine."Start Meter Interval" + MScheduleLine."Meter Interval in Hrs";
                        MScheduleLine.Modify();
                    end;
                end
            until MScheduleLine.Next() = 0;
        Message('done');
    end;

    var
        MainSchHead: Record "Maintenance Schedule Header";

}