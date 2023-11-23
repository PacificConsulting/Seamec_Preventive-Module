enum 50257 "PMS Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Scheduled)
    {
        Caption = 'Scheduled';
    }
    value(2; Closed)
    {
        Caption = 'Closed';
    }
    value(3; "Ready to Close") //pcpl-064 27sep2023
    {
        Caption = 'Ready to Close';
    }
    value(4; "Ready to stop")
    {
        Caption = 'Ready  to stop';
    }
}