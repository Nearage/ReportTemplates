report 50102 "Demo 3"
{
    Caption = 'Demo 3';
    RDLCLayout = 'src/report/demo/layout/Demo3.rdl';
    UsageCategory = ReportsAndAnalysis;

    DataSet
    {
        dataitem(Parent; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";

            column(Parent_Number; "No.") { }

            dataitem(Child; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Child_Number; "No.") { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Child);
                end;
            }
        }

        dataitem(Blanks; Integer)
        {
            column(Blank_Number; Number) { }

            trigger OnPreDataItem()
            begin
                ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1, 1);
                ReportTemplates.CalcBlanksRange(0.25, 3.25);
                ReportTemplates.Run(Blanks);
            end;
        }
    }

    var
        ReportTemplates: Codeunit "Report Templates";
}
