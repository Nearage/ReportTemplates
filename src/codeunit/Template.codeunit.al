codeunit 50100 Template
{
    TableNo = Integer; // Integer table is used to generate blank lines.

    var
        Globals: Codeunit Globals;
        Mathx: Codeunit Mathx;
        GblDocHeight: Decimal; // Height of the document content.
        GblLinHeight: Decimal; // Default line height.
        GblPagHeight: Decimal; // Available height per page.

    /// <summary>
    /// Adjust the height of the document content according to the specified
    /// height.
    /// </summary>
    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-(GblDocHeight div GblLinHeight),
                                               GblPagHeight div GblLinHeight));
    end;

    /// <summary>
    /// Adjust the height of the document content according to the specified
    /// height.
    /// </summary>
    /// <param name="Height">Height to fill in.</param>
    procedure Fill(Height: Decimal)
    begin
        GblDocHeight += Height;
    end;

    /// <summary>
    /// Adjust the available height per page according to the specified height.
    /// </summary>
    /// <param name="Height">Height to fit in.</param>
    procedure Fit(Height: Decimal)
    begin
        GblPagHeight -= Height
    end;

    /// <summary>
    /// Calculates the initial height available per page based on the specified
    /// paper size and initializes all global variables.
    /// </summary>
    /// <param name="PaperSize">Paper size variant.</param>
    /// <param name="MarginTop">Top margin.</param>
    /// <param name="MarginBot">Bottom margin.</param>
    /// <param name="HeaderHgt">Header height.</param>
    /// <param name="FooterHgt">Footer height.</param>
    /// <param name="LinHeight">Line height.</param>
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