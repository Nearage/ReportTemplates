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
                    ReportTemplates.Fill(0.25);
                end;
            }
            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }

                trigger OnAfterGetRecord()
                begin
                    ReportTemplates.Fill(0.5);
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
