codeunit 50100 Template
{
    TableNo = Integer; // La tabla Integer facilita generar líneas en blanco.

    var
        Globals: Codeunit Globals;
        Mathx: Codeunit Mathx;
        GblDocHeight: Decimal; // Altura del contenido del documento.
        GblLinHeight: Decimal; // Altura por defecto de las líneas.
        GblPagHeight: Decimal; // Altura disponible en cada página.

    // Calcula y establece el rango del dataitem encargado de rellenar el
    // espacio vacío con líneas en blanco.
    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-(GblDocHeight div GblLinHeight),
                                               GblPagHeight div GblLinHeight));
    end;

    /// <summary>
    /// Ajusta la altura del contenido del documento en función de la altura
    /// especificada.
    /// </summary>
    /// <param name="Height">Altura ajustada.</param>
    procedure Fill(Height: Decimal)
    begin
        GblDocHeight += Height;
    end;

    /// <summary>
    /// Ajusta la altura disponible en cada página en función de la altura
    /// especificada.
    /// </summary>
    /// <param name="Height">Altura ajustada.</param>
    procedure Fit(Height: Decimal)
    begin
        GblPagHeight -= Height
    end;

    /// <summary>
    /// Calcula la altura disponible en cada página en función de los
    /// parámetros especificados e inicializa las variables globales.
    /// </summary>
    /// <param name="PaperSize">Tamaño del papel.</param>
    /// <param name="MarginTop">Margen superior.</param>
    /// <param name="MarginBot">Margen inferior.</param>
    /// <param name="HeaderHgt">Altura de la cabecera.</param>
    /// <param name="FooterHgt">Altura del pie de página.</param>
    /// <param name="LinHeight">Altura por defecto de las líneas.</param>
    procedure Init(PaperSize: Variant;
                   MarginTop: Decimal;
                   MarginBot: Decimal;
                   HeaderHgt: Decimal;
                   FooterHgt: Decimal;
                   LinHeight: Decimal)
    begin
        GblPagHeight := Globals.GetValue(PaperSize);
        GblPagHeight -= MarginTop + MarginBot;
        GblPagHeight -= HeaderHgt + FooterHgt;
        GblLinHeight := LinHeight;
        GblDocHeight := 0;
    end;
}