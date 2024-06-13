codeunit 50100 "Report Templates"
{
    TableNo = Integer;

    var
        Globals: Codeunit Globals;
        BodyHeight: Decimal;
        LineHeight: Decimal;
        LinesPerPage: Integer;
        NumBlankLins: Integer;
        TotalNumLins: Integer;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, NumBlankLins);
    end;

    procedure Init(DocFormat: Enum Global;
                   LinHeight: Decimal;
                   MarginTop: Decimal;
                   MarginBot: Decimal;
                   HeaderHgt: Decimal;
                   FooterHgt: Decimal): Decimal
    begin
        BodyHeight := Globals.GetValue(DocFormat);
        LineHeight := LinHeight;
        BodyHeight -= (MarginTop + MarginBot);
        BodyHeight -= (HeaderHgt + FooterHgt);
        TotalNumLins := 0;
        LinesPerPage := BodyHeight div LineHeight;
    end;

    procedure Reserve(PerPage: Decimal; Once: Decimal)
    var
        Mathx: Codeunit Mathx;
    begin
        LinesPerPage -= PerPage div LineHeight;
        TotalNumLins += Once div LineHeight;
        NumBlankLins := Mathx.Modulo(-TotalNumLins, LinesPerPage);

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
        TotalNumLins += 1;
    end;
}