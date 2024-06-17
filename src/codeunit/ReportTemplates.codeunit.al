codeunit 50100 "Report Templates"
{
    TableNo = Integer;

    var
        Mathx: Codeunit Mathx;
        Globals: Codeunit "Global Values";
        GblPPageHght: Decimal;
        GblLinHeight: Decimal;
        GblDcmntHght: Decimal;

    trigger OnRun()
    begin
        Rec.SetRange(Number, 1, Mathx.Modulo(-(GblDcmntHght div GblLinHeight),
                                               GblPPageHght div GblLinHeight));
    end;

    procedure Init(DocFormat: Enum Global;
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

    procedure Fit(Height: Decimal)
    begin
        GblPPageHght -= Height
    end;

    procedure Fill(Height: Decimal)
    begin
        GblDcmntHght += Height;
    end;
}