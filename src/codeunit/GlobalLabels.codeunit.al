codeunit 50102 "Global Labels"
{
    procedure Get(Label: Enum "Global Label") Value: Text
    begin
        Value := Format(Label);
    end;
}