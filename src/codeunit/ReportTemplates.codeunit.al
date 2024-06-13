codeunit 50100 "Report Templates"
{
    TableNo = Integer;

    var
        Globals: Codeunit "Global Values";
        BodyHeight: Decimal;
        LineHeight: Decimal;
        LinPerPage: Integer;
        BlankLines: Integer;
        TotalLines: Integer;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, BlankLines);
    end;

    procedure Init(DocFormat: Enum Global;
                   LinHeight: Decimal;
                   MarginTop: Decimal;
                   MarginBot: Decimal;
                   HeaderHgt: Decimal;
                   FooterHgt: Decimal): Decimal
    begin
        BodyHeight := Globals.GetValue(DocFormat);
        BodyHeight -= MarginTop + MarginBot;
        BodyHeight -= HeaderHgt + FooterHgt;
        LinPerPage := BodyHeight div LinHeight;
        LineHeight := LinHeight;
        TotalLines := 0;
    end;

    procedure Reserve(PerPage: Decimal; Once: Decimal)
    var
        Mathx: Codeunit Mathx;
    begin
        LinPerPage -= PerPage div LineHeight;
        TotalLines += Once div LineHeight;
        BlankLines := Mathx.Modulo(-TotalLines, LinPerPage);

        /* El número de líneas en blanco se puede calcular de dos maneras equivalentes:

          1. (LinesPerPage - (TotalNumLins mod LinesPerPage)) mod LinesPerPage
          2. (-TotalNumLins) mod LinesPerPage

        La segunda opción es una versión refactorizada y simplificada de la primera, pero
        el resultado debería ser el mismo. Sin embargo, el operador módulo en AL no actúa
        de la forma esperada  para valores negativos. Para  corregir este problema, se ha
        creado el  procedimiento  Modulo  en la codeunit Mathx, que emplea una definición
        distinta del operador módulo para realizar el cálculo.

        Haiendo uso de dicho procedimiento, la versión simplificada funciona de la manera
        deseada. */
    end;

    procedure Update()
    begin
        TotalLines += 1;
    end;
}