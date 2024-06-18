codeunit 50102 Globals
{
    procedure GetText(Global: Variant) Value: Text
    begin
        Value := Format(Global);
    end;

    procedure GetValue(Global: Variant) Value: Decimal
    begin
        if Evaluate(Value, GetText(Global).Replace('.', ',')) then exit(Value);
    end;
}