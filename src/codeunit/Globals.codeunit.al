codeunit 50102 Globals
{
    /// <summary>
    /// Obtiene el valor de la variante especificada como texto.
    /// </summary>
    /// <param name="Global">Variante</param>
    /// <returns>El valor de la variante especificada como texto.</returns>
    procedure GetText(Global: Variant) Value: Text
    begin
        Value := Format(Global);
    end;

    /// <summary>
    /// Obtiene el valor numérico de la variante especificada.
    /// </summary>
    /// <param name="Global">Variante</param>
    /// <returns>El valor numérico de la variante especificada.</returns>
    procedure GetValue(Global: Variant) Value: Decimal
    begin
        if Evaluate(Value, GetText(Global).Replace('.', ',')) then exit(Value);
    end;
}