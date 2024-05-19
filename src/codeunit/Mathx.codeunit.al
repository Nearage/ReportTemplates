codeunit 50101 Mathx
{
    /// <summary>
    /// En  AL, la  función  módulo  se  cauclula  `A mod B = A - B * (A \ B)`, donde `\`
    /// representa  una  división  entera  en  la  que  se descarta la parte decimal. Sin
    /// embargo, esa  operación  no  es  del todo correcta y no procesa corréctamente los
    /// valores negativos de A. Para corregir este comportamiento, este procedimiento usa
    /// la fórmula `A mod B = A - B * ⌊A / B⌋` en su lugar.
    /// </summary>
    /// <param name="A">El primer valor.</param>
    /// <param name="B">El segundo valor.</param>
    /// <returns></returns>
    procedure Modulo(A: Decimal; B: Decimal): Decimal
    var
        Math: Codeunit Math;
    begin
        exit(A - B * Math.Floor(A / B));
    end;
}