page 50100 "HTMLPort Preview"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'HTMLPort Preview';
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            usercontrol(HTMLPortPreview; HTMLPortPreview)
            {
                ApplicationArea = All;
            }

            group("Origen de datos")
            {
                field("Código HTML"; Content)
                {
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        CurrPage.HTMLPortPreview.SetContent(Content);
                    end;
                }
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

    var
        Content: Text;
}