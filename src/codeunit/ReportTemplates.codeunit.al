
codeunit 50100 "Report Templates"
{
    TableNo = Integer;

    // Establece el rango del dataitem de las líneas en blanco.
    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, NumBlankLins);
    end;

    var
        NumBlankLins: Integer;
        TotalNumLins: Integer;

    /// <summary>
    /// Incluye  el _dataitem_  proporcionado  en  el  proceso de generación de líneas en
    /// blanco.
    /// </summary>
    /// <param name="Dataitem">Dataitem a incluir en el proceso.</param>
    procedure IncludeDataitem(Dataitem: Variant)
    var
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(Dataitem);
        TotalNumLins += RecordRef.Count();
    end;

    /// <summary>
    /// Calcula el número de líneas en blanco necesarias para mantener la distribución de
    /// los distintos elementos del informe.
    /// </summary>
    /// <param name="LineHeight">Altura por defecto de las líneas.</param>
    /// <param name="BodyHeight">Altura del cuerpo del informe.</param>
    /// <param name="RsrvHeight">Altura reservada para secciones adicionales.</param>
    procedure CalcBlanksRange(LineHeight: Decimal; BodyHeight: Decimal; RsrvHeight: Decimal)
    var
        Mathx: Codeunit Mathx;
        LinesPerPage: Integer;
        ReserveLines: Integer;
    begin
        LinesPerPage := BodyHeight div LineHeight;
        ReserveLines := RsrvHeight div LineHeight;
        TotalNumLins += ReserveLines;

        /* El número de líneas en blanco se puede calcular de dos maneras equivalentes:

        NumBlankLins := (LinesPerPage - (TotalNumLins mod LinesPerPage)) mod LinesPerPage;
        NumBlankLins := (-TotalNumLins) mod LinesPerPage;

        La segunda opción es una versión refactorizada y simplificada de la primera, pero
        el resultado debería ser el mismo. Sin embargo, el operador módulo en AL no actúa
        de la forma esperada  para valores negativos. Para  corregir este problema, se ha
        creado el  procedimiento  Modulo  en la codeunit Mathx, que emplea una definición 
        distinta del operador módulo para realizar el cálculo. 
        
        De  ese  modo,  haiendo  uso  de  dicha función, la versión simplificada funciona
        corréctamente. */

        NumBlankLins := Mathx.Modulo(-TotalNumLins, LinesPerPage);
    end;
}