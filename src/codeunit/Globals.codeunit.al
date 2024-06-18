codeunit 50102 Globals
{
    /// <summary>
    /// Gets the value of the specified global variant as text.
    /// </summary>
    /// <param name="Global">Global variant</param>
    /// <returns>The value of the specified global variant as Text.</returns>
    procedure GetText(Global: Variant) Value: Text
    begin
        Value := Format(Global);
    end;

    /// <summary>
    /// Gets the value of the specified global variant as a real number.
    /// </summary>
    /// <param name="Global">Global variant</param>
    /// <returns>The value of the specified global variant.</returns>
    procedure GetValue(Global: Variant) Value: Decimal
    begin
        if Evaluate(Value, GetText(Global).Replace('.', ',')) then exit(Value);
    end;
}