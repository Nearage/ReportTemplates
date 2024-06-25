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
                    Template.Fit(0.25);
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Template.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Template.Set(Paper::A4, 0.25);
                Template.Fix(2);
                Template.Fit(3.25);
            end;
        }
    }

    var
        Template: Codeunit Template;
}
