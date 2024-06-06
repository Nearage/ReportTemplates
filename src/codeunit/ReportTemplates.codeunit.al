codeunit 50100 "Report Templates"
{
    // Tabla que se usará el el DataItem encargado de generar las líneas en blanco.
    TableNo = Integer;

    var
        BodyHeight: Decimal; // Altura disponible en el cuerpo del informe.
        NumBlankLins: Integer; // Número de líneas en blanco a añadir.
        TotalNumLins: Integer; // Número total de líneas reservadas en el informe.

    // Establece el rango del DataItem de las líneas en blanco.
    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, NumBlankLins);
    end;

    procedure Init()
    begin
        BodyHeight := 0;
        NumBlankLins := 0;
        TotalNumLins := 0;
    end;

    /// <summary>
    /// Calcula el número de líneas en blanco necesarias para mantener la distribución de
    /// los distintos elementos del informe.
    /// </summary>
    /// <param name="LineHeight">Altura por defecto de las líneas.</param>
    /// <param name="RsrvHeight">Altura reservada en la última página.</param>
    procedure CalcBlanksRange(LineHeight: Decimal; RsrvHeight: Decimal)
    var
        Mathx: Codeunit Mathx;
        LinesPerPage: Integer;
        ReserveLines: Integer;
    begin
        LinesPerPage := BodyHeight div LineHeight;
        ReserveLines := RsrvHeight div LineHeight;
        TotalNumLins += ReserveLines;

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

        NumBlankLins := Mathx.Modulo(-TotalNumLins, LinesPerPage);
    end;

    /// <summary>
    /// Calcula el espacio disponible en el cuerpo del informe descontando márgenes,
    /// cabecera y pie de página.
    /// </summary>
    /// <param name="DocHeight">Altura del documento.</param>
    /// <param name="MarginTop">Margen superior.</param>
    /// <param name="MarginBot">Margen inferior.</param>
    /// <param name="HeaderHgt">Altura de la cabecera.</param>
    /// <param name="FooterHgt">Altura del pie.</param>
    /// <param name="RservHght">Altura reservada en todas las páginas.</param>
    /// <returns>La altura disponible en el cuerpo.</returns>
    procedure CalcBodysHeight(DocHeight: Decimal;
                              MarginTop: Decimal;
                              MarginBot: Decimal;
                              HeaderHgt: Decimal;
                              FooterHgt: Decimal;
                              RservHght: Decimal): Decimal
    begin
        BodyHeight := DocHeight;
        BodyHeight -= (MarginTop + MarginBot);
        BodyHeight -= (HeaderHgt + FooterHgt);
        BodyHeight -= RservHght;
    end;

    /// <summary>
    /// Incluye  el _dataitem_  proporcionado  en  el  proceso de generación de líneas en
    /// blanco.
    /// </summary>
    /// <param name="DataItem">DataItem a incluir en el proceso.</param>
    procedure IncludeDataItem(DataItem: Variant)
    var
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(DataItem);

        TotalNumLins += RecordRef.Count();
    end;
}