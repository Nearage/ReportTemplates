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

                trigger OnAfterGetRecord()
                begin
                    ReportTemplates.Fill(0.25);
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Init(Paper::A4, 0, 0, 1, 1, 0.25);
                ReportTemplates.Fill(3.25);
            end;
        }
    }

    var
        ReportTemplates: Codeunit Template;
}
