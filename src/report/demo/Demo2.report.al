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
                    Template.Fix(0.25);
                end;
            }
            dataitem(Child2; Integer)
            {
                RequestFilterFields = Number;

                column(Child2_Number; Number) { }

                trigger OnAfterGetRecord()
                begin
                    Template.Fix(0.5);
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
                Template.Init(Paper::A4, 0.25);
                Template.Fit(1 + 1);
                Template.Fix(3.25);
            end;
        }
    }

    var
        Template: Codeunit Template;
}
