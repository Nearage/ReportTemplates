report 50102 "Demo 5"
{
    ApplicationArea = All;
    Caption = 'Demo 5';
    RDLCLayout = 'src/report/demo/layout/Demo5.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Parent; Integer)
        {
            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Parent.Number);
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, 33);
            end;
        }
    }
}
