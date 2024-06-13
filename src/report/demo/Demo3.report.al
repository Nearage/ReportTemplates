report 50104 "Demo 3"
{
    Caption = 'Demo 3';
    RDLCLayout = 'src/report/demo/layout/Demo3.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Sales_Header; Integer)
        {
            DataItemTableView = where(Number = filter(1 .. 80));

            dataitem(Company_Information; "Company Information")
            {
                #region columns
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
                #endregion columns
            }

            column(Sales_Header_No; Number) { }

            dataitem(Sales_Line; Integer)
            {
                column(Sales_Line_Line_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Sales_Header.Number);
                end;

                trigger OnAfterGetRecord()
                begin
                    ReportTemplates.Update();
                end;
            }

            dataitem(Totals; Integer)
            {
                column(Totals_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Random(3) - 1);

                    if IsEmpty() then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    ReportTemplates.Reserve(0.5, 0);
                end;
            }

            dataitem(Blanks; Integer)
            {
                column(Blanks_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.Reserve(0.25, 0.5);
                    ReportTemplates.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Init(Global::A4, 0.25, 0, 0, 1.25, 1.25);
            end;
        }
    }

    var
        Globals: Codeunit Globals;
        ReportTemplates: Codeunit "Report Templates";

}