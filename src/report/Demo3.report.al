report 50102 "Demo 3"
{
    Caption = 'Demo 3';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/Demo3.rdl';

    DataSet
    {
        dataitem(Parent; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";

            column(Parent_Number; "No.") { }

            dataitem(Child1; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Child_Number; "No.") { }
            }

            dataitem(Blanks; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                var
                    ReportTemplates: Codeunit "Report Templates";
                begin
                    ReportTemplates.IncludeDataitem(Child1);
                    ReportTemplates.CalcBlanksRange(0.25, 9.69, 3.25);
                    ReportTemplates.Run(Blanks);
                end;
            }
        }
    }
}
