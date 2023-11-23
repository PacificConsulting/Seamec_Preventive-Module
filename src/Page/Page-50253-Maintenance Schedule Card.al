page 50253 "Maintenance Schedule Card"
{
    PageType = Card;
    SourceTable = 50252;

    //Editable =
    //DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Schedule No."; rec."Schedule No.")
                {
                    ApplicationArea = all;
                }
                field("Schedule Description"; rec."Schedule Description")
                {
                    ApplicationArea = all;
                }
            }
            part(lines; 50254)
            {
                ApplicationArea = all;
                SubPageLink = "Schedule No." = FIELD("Schedule No.");
            }
        }
    }
    trigger OnOpenPage()
    var

    begin
        //<<pcpl -06427sep2023
        if UserSetup1.get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" = true then
                CurrPage.Editable(true)
            else
                CurrPage.Editable(false);
        end;
        //>>pcpl 06427sep2023
        //<<pcpl-064 27sep2023
        /* if UserSetup1.Get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" then
                CurrPage.Editable(false);
            //<<pcpl-064 27sep2023
        end; */
    end;
    /*   Message('Done');
      CurrPage.Editable(false);
*/
    // IsPermissionEdit := false;
    // IsPermissionEdit := IsHavePermissionToEditPage();

    // end;

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Test")
    //         {
    //             ApplicationArea = all;
    //             RunObject = codeunit 50250;
    //         }
    //     }
    // }
    trigger OnAfterGetRecord()

    begin
        /*  if UserSetup1.Get(UserId) then begin
             if UserSetup1."Allow to Edit PMS Master" then
                 exit;
             CurrPage.Editable(false);
         end;
         Message(' not done'); */
    end;



    trigger OnDeleteRecord(): Boolean
    begin
        //PCPL-25/280823
        if useSetup.Get(UserId) then;
        useSetup.TestField("Delete Equipment", true);
        //PCPL-25/280823
    end;



    var
        useSetup: Record "User Setup";
        [InDataSet]
        IsPermissionEdit: Boolean;

        UserSetup1: Record "User Setup";

    /* local procedure IsHavePermissionToEditPage(): Boolean
    var
        UserSetup1: Record "User Setup";
    begin
        if UserSetup1.Get(UserId) then begin
            if UserSetup1."Allow to Edit PMS Master" then
                exit(false)
            else
                exit(true)
        end else begin
            exit(true);
        end;


    end; */

}

