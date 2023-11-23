report 50251 "Work Order Status Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Work Order Status Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src\ReportLayout/Work Order Status Report.rdl';

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

            trigger OnAfterGetRecord()
            var


            begin
                RecUserSetup.Reset();
                RecUserSetup.SetRange("User ID", UserId);
                if RecUserSetup.FindFirst() then begin
                    users := RecUserSetup."User ID";
                end;

                CurrDate := CurrentDateTime;

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
    end;

    var
        CompanyInfo: Record "Company Information";
        RecUserSetup: Record "User Setup";
        users: code[100];
        CurrDate: DateTime;
}