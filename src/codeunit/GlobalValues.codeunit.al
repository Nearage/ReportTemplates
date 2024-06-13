codeunit 50102 "Global Values"
{
    procedure GetText(Global: Enum Global) Value: Text
    begin
        Value := Format(Global);
    end;

    procedure GetValue(Label: Enum Global) Value: Decimal
    begin
        if Evaluate(Value, GetText(Label).Replace('.', ',')) then exit(Value);
    end;
}