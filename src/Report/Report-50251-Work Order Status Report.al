report 50251 "Work Order Status Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Work Order Status Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\ReportLayout/Work Order Status Report -1.rdl';

    dataset
    {
        dataitem("PMS Job Header"; "PMS Job Header")
        {
            RequestFilterFields = Status;
            column(CompanyInfo; CompanyInfo.Picture)
            {

            }
            column(Job_No_; "Job No.")
            {

            }
            column(Equipment_Description; "Equipment Description")
            {

            }
            column(Status; Status)
            {

            }
            column(Start_Date; "Start Date")
            {

            }
            column(End_Date; "End Date")
            {

            }
            column(Schedule_No_; "Schedule No.")
            {

            }
            column(Equipment_Code; "Equipment Code")
            {

            }
            column(Maintenance_Type; "Maintenance Type")
            {

            }
            column(Creation_Date; "Creation Date")
            {

            }
            column(RecUserSetup; RecUserSetup."User ID")
            {

            }
            column(CurrDate; CurrDate)
            {

            }
            column(RecStatus; RecStatus)
            {

            }
            column(RecDepartment; RecDepartment)
            {

            }
            column(Fromdate; Fromdate)
            {

            }
            column(Todate; Todate)
            {

            }
            column(Department; Department)
            {

            }
            column(JobDoneComments; JobDoneComments)
            {

            }

            trigger OnAfterGetRecord()
            var


            begin
                RecUserSetup.Reset();
                RecUserSetup.SetRange("User ID", UserId);
                if RecUserSetup.FindFirst() then begin
                    users := RecUserSetup."User ID";
                end;

                CurrDate := CurrentDateTime;
                PMSJobLines.Reset();
                PMSJobLines.SetRange("Job No.", "Job No.");
                if PMSJobLines.FindSet() then
                    TaskActLines.Reset();
                TaskActLines.SetRange("Task Code", PMSJobLines."Task Code");
                if TaskActLines.FindSet() then
                    repeat
                        IF TaskActLines."Job Done Comment" <> '' then
                            JobDoneComments += TaskActLines."Job Done Comment" + ',';
                    until TaskActLines.Next() = 0;
                if JobDoneComments <> '' then
                    JobDoneComments := DelStr(JobDoneComments, StrLen(JobDoneComments), 1);

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CalcFields(Picture);
        RecStatus := "PMS Job Header".GetFilter(Status);
        RecDepartment := "PMS Job Header".GetFilter(Department);
        if "PMS Job Header".GetFilter("Creation Date") <> '' then begin
            Fromdate := "PMS Job Header".GetRangeMin("Creation Date");
            Todate := "PMS Job Header".GetRangeMax("Creation Date");
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        RecUserSetup: Record "User Setup";
        users: code[100];
        CurrDate: DateTime;
        RecStatus: Text;
        JobDoneComments: Text;
        RecDepartment: Text;
        Fromdate: Date;
        Todate: Date;
        TaskActLines: Record "Task Activity Lines";
        PMSJobLines: Record "PMS Job Lines";

}