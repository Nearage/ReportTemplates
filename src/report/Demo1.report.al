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

            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }
            }

            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.IncludeDataitem(Child);
                    ReportTemplates.IncludeDataitem(Child2);
                    ReportTemplates.CalcBlanksRange(0.25, 9.69, 3.25);

                    SetRange(Number, 1, ReportTemplates.GetRange())
                end;
            }
        }
    }

    var
        ReportTemplates: Codeunit "Report Templates";
}
