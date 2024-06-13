report 50104 "Demo 3"
{
    Caption = 'Demo 3';
    RDLCLayout = 'src/report/demo/layout/Demo3.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Sales_Header; Integer)
        {
            DataItemTableView = where(Number = filter(1 .. 50));

            column(Sales_Header_No; Number) { }

            dataitem(Company_Information; "Company Information")
            {
                #region columns
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
                #endregion columns
            }
            dataitem(Sales_Line; Integer)
            {
                column(Sales_Line_Line_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Sales_Header.Number);
                end;

                trigger OnAfterGetRecord()
                begin
                    Templates.Update();
                end;
            }
            dataitem(Totals; Integer)
            {
                column(Totals_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 0);

                    if IsEmpty() then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    Templates.Reserve(0.5, 0);
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blanks_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Templates.Reserve(0.25, 0.5);
                    Templates.Run(Blanks);

                    if IsEmpty() then CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Templates.Init(Global::A4, 0.25, 0, 0, 1.25, 1.25);
            end;
        }
    }

    var
        Globals: Codeunit "Global Values";
        Templates: Codeunit "Report Templates";
}