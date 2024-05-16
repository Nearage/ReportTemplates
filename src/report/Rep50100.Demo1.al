namespace Reports.Reports;

using System.Utilities;

report 50100 "Demo 1"
{
    Caption = 'Demo 1';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/Demo1.rdl';

    dataset
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
                var
                    LinesPerPage: Integer;
                    Section1Lines: Integer;
                    Lines: Integer;
                begin
                    LinesPerPage := 38;
                    SectionLines := 13;

                    Lines := (LinesPerPage - ((Child.Count() + SectionLines) mod LinesPerPage)) mod LinesPerPage;

                    SetRange(Number, 1, Lines);
                end;
            }
        }
    }
}
