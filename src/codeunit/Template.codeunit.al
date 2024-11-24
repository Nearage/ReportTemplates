codeunit 50100 Template
{
    TableNo = Integer; // La tabla Integer facilita generar líneas en blanco.

    // Calcula y establece el rango del dataitem encargado de rellenar el
    // espacio vacío con líneas en blanco.
    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, gMathx.Modulo(-(gDocHeight div gLinHeight),
                                                gPagHeight div gLinHeight));
    end;

    var
        gLabelManagement: Codeunit "Label Management";
        gMathx: Codeunit Mathx;
        gDocHeight: Decimal; // Altura del contenido del documento.
        gLinHeight: Decimal; // Altura por defecto de las líneas.
        gPagHeight: Decimal; // Altura disponible en cada página.

    /// <summary>
    /// Ajusta la altura del contenido del documento en función de la altura
    /// especificada.
    /// </summary>
    /// <param name="Height">Altura ajustada.</param>
    procedure Fit(Height: Decimal)
    begin
        gDocHeight += Height;
    end;

    /// <summary>
    /// Ajusta la altura disponible en cada página en función de la altura
    /// especificada.
    /// </summary>
    /// <param name="Height">Altura ajustada.</param>
    procedure Fix(Height: Decimal)
    begin
        gPagHeight -= Height
    end;

    /// <summary>
    /// Devuelve el número de páginas 
    /// </summary>
    /// <returns></returns>
    procedure Pages(): Integer
    var
        math: Codeunit Math;
    begin
        exit(Round(gPagHeight / gLinHeight, 1));
    end;

    /// <summary>
    /// Inicializa las variables globales en función de la variante de papel
    /// y la altura de línea especificadas.
    /// </summary>
    /// <param name="PaperSize">Variante de papel.</param>
    /// <param name="LinHeight">Altura por defecto de las líneas.</param>
    procedure Set(PaperSize: Variant; LinHeight: Decimal)
    begin
        gPagHeight := gLabelManagement.GetValue(PaperSize);
        gLinHeight := LinHeight;
        gDocHeight := 0;
    end;
}