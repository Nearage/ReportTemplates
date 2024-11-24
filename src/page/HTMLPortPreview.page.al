page 50100 "HTMLPort Preview"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'HTMLPort Preview';
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            /* group(fields)
            {
                field("test"; 'testfield') { }
            } */

            usercontrol(HTMLPortPreview; HTMLPortPreview)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Imprimir)
            {
                ApplicationArea = All;
                Caption = 'Imprimir';
                ToolTip = 'Imprime el documento.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Print;

                trigger OnAction()
                begin
                    CurrPage.HTMLPortPreview.Print();
                end;
            }
        }
    }
}