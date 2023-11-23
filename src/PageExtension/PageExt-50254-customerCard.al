pageextension 50254 customer_ext extends "Customer Card"
{
    layout
    {


    }

    actions
    {
        // Add changes to page actions here
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        /* if UserSetup1.Get(UserId) then begin //pcpl-064 27sep2023
            if UserSetup1."Allow to Edit PMS Master" then
                Message('Done');
        end; */
        //CurrPage.Editable(false);

    end;


    var
        myInt: Integer;
        UserSetup1: Record "User Setup";
}