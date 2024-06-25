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
                    Template.Fit(0.25);
                end;
            }
            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }

                trigger OnAfterGetRecord()
                begin
                    Template.Fit(0.5);
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
                Template.Fix(1 + 1);
                Template.Fit(3.25);
            end;
        }
    }

    var
        Template: Codeunit Template;
}
