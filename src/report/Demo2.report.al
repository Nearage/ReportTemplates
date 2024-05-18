report 50101 "Demo 2"
{
    Caption = 'Demo 2';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/Demo2.rdl';

    DataSet
    {
        dataitem(Parent; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            dataitem(Child1; Integer)
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
                var
                    ReportTemplates: Codeunit "Report Templates";
                begin
                    ReportTemplates.IncludeDataitem(Child1);
                    ReportTemplates.IncludeDataitem(Child2);
                    ReportTemplates.CalcBlanksRange(0.25, 9.69, 3.25);
                    ReportTemplates.Run(Blanks);
                end;
            }
        }
    }
}
