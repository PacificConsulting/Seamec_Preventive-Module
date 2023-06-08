report 50250 "PMS Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'PMS Job Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\ReportLayout/PMS Job Report.rdl';


    dataset
    {
        dataitem("PMS Job Header"; "PMS Job Header")
        {
            RequestFilterFields = "Job No.";
            column(Job_No_; "Job No.")
            {

            }
            column(Department; Department)
            {

            }
            column(Created_By; "Created By")
            {

            }
            column(Creation_Date; "Creation Date")
            {

            }
            column(Equipment_Code; "Equipment Code")
            {

            }
            column(Equipment_Description; "Equipment Description")
            {

            }
            column(Start_Date; "Start Date")
            {

            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {

            }
            column(CompanyInfo_Add; CompanyInfo.Address + CompanyInfo."Address 2" + CompanyInfo.City + ',' + CompanyInfo."State Code")
            {

            }
            column(CompanyInfo_PhoneNo; 'Tel No. : ' + CompanyInfo."Phone No.")
            {

            }
            column(CompanyInfo_FAX_No; 'FAX No.: ' + CompanyInfo."Fax No.")
            {

            }
            column(CompanyInfo_Email; 'E-mail :' + CompanyInfo."E-Mail")
            {

            }
            column(CompanyInfo_PAN; CompanyInfo."P.A.N. No.")
            {

            }
            column(Location_Info; Location_g.Code + '-' + Location_g.Name)
            {

            }
            column(Assigned_To; "Assigned To")
            {

            }
            column(Comment_Text; Comment_Text)
            {

            }
            column(Status; Status)
            {

            }
            column(Scheduler_Desc; MSH."Schedule Description")
            {

            }
            column(Maintenance_Type; "Maintenance Type")
            {

            }
            column(Schedule_No_; "Schedule No.")
            {

            }
            column(MSL_HrsFormat; MSL_Hrs)
            {

            }
            column(Priority; MSL.Priority)
            {

            }
            column(Scheduling; MSL.Scheduling)
            {

            }
            column(MRC; Equip_Mstr.Department)
            {

            }

            dataitem("PMS Job Lines"; "PMS Job Lines")
            {
                DataItemLink = "Job No." = field("Job No.");
                column(Task_Code; "Task Code")
                {

                }
                column(Activities; Activities)
                {

                }
                column(Task_Name; "Task Name")
                {

                }
                column(Job_Done_Comments; "Job Done Comments")
                {

                }
                trigger OnAfterGetRecord() //PMS-Line
                var
                Begin
                End;
            }
            trigger OnAfterGetRecord() //PMS-Hdr
            var
            Begin
                Clear(Equip_Comment_Text);
                Clear(MSL_Hrs);
                IF Location_g.GET("Location Code") then;
                MSL.Reset();
                MSL.SetRange("Equipment Code", "PMS Job Header"."Equipment Code");
                MSL.SetRange("Schedule No.", "PMS Job Header"."Schedule No.");
                if MSL.FindFirst() then;
                if MSL."Meter Interval in Hrs" <> 0 then
                    MSL_Hrs := MSL."Meter Interval in Hrs"
                ELSE
                    MSL_Hrs := 0;
                Equip_Comment.Reset;
                Equip_Comment.SetRange("Equipment Code", "PMS Job Header"."Equipment Code");
                if Equip_Comment.FindFirst() then
                    Equip_Comment_Text := Equip_Comment_Text + Equip_Comment.Comment + '|';

                if Equip_Comment_Text <> '' then begin
                    Comment_Text := DelStr(Equip_Comment_Text, StrLen(Equip_Comment_Text), 1);
                end;

                if Equip_Mstr.GET("Equipment Code") then;

            End;
        }


    }
    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record 79;
        MSH: Record 50252;
        MSL: Record 50253;
        Location_g: Record Location;
        Equip_Comment: Record 50259;
        Equip_Comment_Text: Text[1024];
        Comment_Text: Text[1024];
        Equip_Mstr: Record 50250;
        MSL_Hrs: Integer;
}