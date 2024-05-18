codeunit 50100 "Report Templates"
{
    var
        NumBlankLins: Integer;
        DataSetLines: Integer;

    procedure IncludeDataitem(Dataitem: Variant)
    var
        RecordRef: RecordRef;
    begin
        RecordRef.GetTable(Dataitem);
        DataSetLines += RecordRef.Count();
    end;

    procedure CalcBlanksRange(LineHeight: Decimal; BodyHeight: Decimal; RsrvHeight: Decimal)
    var
        LinesPerPage: Integer;
        ReserveLines: Integer;
    begin
        LinesPerPage := BodyHeight div LineHeight;
        ReserveLines := RsrvHeight div LineHeight;
        DataSetLines += ReserveLines;
        NumBlankLins := (LinesPerPage - (DataSetLines mod LinesPerPage)) mod LinesPerPage;
    end;

    procedure GetRange(): Integer
    begin
        exit(NumBlankLins);
    end;
}