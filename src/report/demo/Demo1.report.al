report 50100 "Demo 1"
{
    Caption = 'Demo 1';
    RDLCLayout = 'src/report/demo/layout/Demo1.rdl';
    UsageCategory = ReportsAndAnalysis;

    DataSet
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            dataitem(Child; Integer)
            {
                RequestFilterFields = Number;

                column(Child_Number; Number) { }

                trigger OnPostDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Child);
                end;
            }

            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1, 1);
                    ReportTemplates.CalcBlanksRange(0, 3.25);
                    ReportTemplates.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Reset();
            end;
        }
    }

    trigger OnInitReport()
    begin
        ReportTemplates.Init(0.25);
    end;

    var
        ReportTemplates: Codeunit "Report Templates";
}
