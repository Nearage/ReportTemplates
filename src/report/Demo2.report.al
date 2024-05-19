report 50101 "Demo 2"
{
    Caption = 'Demo 2';
    RDLCLayout = 'src/report/layout/Demo2.rdl';
    UsageCategory = ReportsAndAnalysis;

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
                    ReportTemplates.IncludeDataItem(Child1);
                    ReportTemplates.IncludeDataItem(Child2);
                    ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1, 1);
                    ReportTemplates.CalcBlanksRange(0.25, 3.25);
                    ReportTemplates.Run(Blanks);
                end;
            }
        }
    }
}
