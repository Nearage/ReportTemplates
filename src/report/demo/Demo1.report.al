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
                    ReportTemplates.Update();
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.Reserve(0, 3.25);
                    ReportTemplates.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Init(Global::A4, 0.25, 0, 0, 1, 1);
            end;
        }
    }

    var
        ReportTemplates: Codeunit "Report Templates";
}
