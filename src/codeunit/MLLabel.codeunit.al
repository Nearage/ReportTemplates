codeunit 50102 "ML Label"
{
    procedure Get(Label: Enum Labels) Value: Text
    begin
        Value := Format(Label);
    end;

    procedure Concat(Label1: Enum Labels; Label2: Enum Labels) Value: Text
    begin
        Value := Format(Label1) + ' ' + Format(Label2);
    end;
}