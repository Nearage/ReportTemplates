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

                trigger OnAfterGetRecord()
                begin
                    ReportTemplates.Update();
                end;
            }
            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }

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
