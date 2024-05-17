namespace Reports.Reports;

using System.Utilities;

report 50100 "Demo 1"
{
    Caption = 'Demo 1';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/Demo1.rdl';

    DataSet
    {
        dataitem(Parent; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            dataitem(Child; Integer)
            {
                RequestFilterFields = Number;

                column(Child_Number; Number) { }
            }

            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetBlankLinesRange(0.25, 9.69, 3.25);
                end;
            }
        }
    }

    /// <summary>
    /// Calcula y establece el número de líneas necesarias para distribuir el espacio del informe, de manera que las secciones 
    /// adicionales se sitúen al final del documento y antes del pie de página, si lo hay. La altura de los distintos elementos 
    /// puede especificarse en pulgadas o centimetros. Todas las medidas deben usar la misma unidad.
    /// </summary>
    /// <param name="LineHeight">Altura de las líneas que se repetirán en el informe.</param>
    /// <param name="BodyHeight">Altura disponible para ser ocupada por líneas del DataSet, en blanco o reservadas.</param>
    /// <param name="RsrvHeight">Altura del espacio reservado para secciones adicionales.</param>
    local procedure SetBlankLinesRange(LineHeight: Decimal; BodyHeight: Decimal; RsrvHeight: Decimal)
    var
        LinesPerPage: Integer; // Número de líneas por página.
        ReserveLines: Integer; // Numero de líneas reservadas.
        DataSetLines: Integer; // Número de líneas del DataSet, teniendo en cuenta el espacio reservado.
        NumBlankLins: Integer; // Número de líneas en blanco.
    begin
        LinesPerPage := BodyHeight div LineHeight; // Calcula cuántas líneas que caben en el cuerpo de una página.
        ReserveLines := RsrvHeight div LineHeight; // Calcula cuántas líneas que deben reservarse para secciones adicionales.
        DataSetLines := Child.Count() + ReserveLines; // Calcula cuántas lineas ocupa el DataSet tras procesarse, teniendo en cuenta el espacio reservado.
        NumBlankLins := (LinesPerPage - (DataSetLines mod LinesPerPage)) mod LinesPerPage; // Calcula el número de líneas en blanco a añadir.

        Blanks.SetRange(Number, 1, NumBlankLins); // Establece el rango del dataitem de las líneas en blanco.
    end;
}
