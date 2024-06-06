report 50101 "Demo 2"
{
    Caption = 'Demo 2';
    RDLCLayout = 'src/report/demo/layout/Demo2.rdl';
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

                trigger OnPreDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Child1);
                end;
            }
            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Child2);
                end;
            }
        }
        dataitem(Blanks; Integer)
        {
            column(Blank_Number; Number) { }

            trigger OnPreDataItem()
            begin
                ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1, 1, 0.25);
                ReportTemplates.CalcBlanksRange(0.25, 3.25);
                ReportTemplates.Run(Blanks);
            end;
        }
    }

    var
        ReportTemplates: Codeunit "Report Templates";
}
