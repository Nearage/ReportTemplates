codeunit 50100 "Report Templates"
{
    TableNo = Integer;

    var
        Globals: Codeunit "Global Values";
        Mathx: Codeunit Mathx;
        GblDcmntHght: Decimal;
        GblLinHeight: Decimal;
        GblPPageHght: Decimal;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-(GblDcmntHght div GblLinHeight),
                                               GblPPageHght div GblLinHeight));
    end;

    procedure Fill(Height: Decimal)
    begin
        GblDcmntHght += Height;
    end;

    procedure Fit(Height: Decimal)
    begin
        GblPPageHght -= Height
    end;

    procedure Init(DocFormat: Variant;
                   MarginTop: Decimal;
                   MarginBot: Decimal;
                   HeaderHgt: Decimal;
                   FooterHgt: Decimal;
                   LinHeight: Decimal): Decimal
    begin
        GblPPageHght := Globals.GetValue(DocFormat);
        GblPPageHght -= MarginTop + MarginBot;
        GblPPageHght -= HeaderHgt + FooterHgt;
        GblLinHeight := LinHeight;
        GblDcmntHght := 0;
    end;
}