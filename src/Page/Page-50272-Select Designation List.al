page 50272 "Select Designation List"
{



    ApplicationArea = all;// BasicHR;
    Caption = 'Selsect Designation List';
    // CardPageID = 50263;
    // Editable = false;
    PageType = List;
    SourceTable = "Select Designation";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}