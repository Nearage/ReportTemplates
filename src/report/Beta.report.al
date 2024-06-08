report 50102 Beta
{
    ApplicationArea = All;
    Caption = 'Beta';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Beta.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 3));

                column(Child_Number; Number) { }
            }

            dataitem(Blank; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Blank_Number; Number) { }
            }
        }
    }
}