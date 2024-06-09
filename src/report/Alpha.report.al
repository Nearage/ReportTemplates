report 50103 Alpha
{
    ApplicationArea = All;
    Caption = 'Alpha';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Alpha.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Parent_Number; Number) { }

            dataitem(Content; Integer)
            {
                DataItemTableView = where(Number = const(1));

                dataitem(Child; Integer)
                {
                    DataItemTableView = where(Number = const(1));

                    column(Child_Number; Number) { }
                }

                dataitem(Blank; Integer)
                {
                    DataItemTableView = where(Number = const(1));

                    column(Blank_Number; Number) { }
                }

                dataitem(Total; Integer)
                {
                    DataItemTableView = where(Number = const(1));

                    column(Total_Number; Number) { }
                }
            }
        }
    }
}