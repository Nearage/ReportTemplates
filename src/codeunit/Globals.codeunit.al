codeunit 50102 Globals
{
    procedure GetText(Label: Enum Global) Value: Text
    begin
        Value := Format(Label);
    end;

    procedure GetValue(Label: Enum Global) Value: Decimal
    begin
        Evaluate(Value, GetText(Label).Replace('.', ','));
        exit(Value);
    end;
}