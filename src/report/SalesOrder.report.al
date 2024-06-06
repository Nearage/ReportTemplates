report 50103 "Sales Order"
{
    RDLCLayout = 'src/report/layout/SalesOrder.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Sales_Header; "Sales Header")
        {
            dataitem(Company_Information; "Company Information")
            {
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
            }

            column(Sales_Header_No; "No.") { }
            column(Order_Date; "Order Date") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Address; "Sell-to Address") { }

            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Sales_Line_No; "No.") { }
                column(Sales_Line_Description; Description) { }
                column(Sales_Line_Quantity; Quantity) { }
                column(Sales_Line_Amount; Amount) { }

                trigger OnPostDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Sales_Line);
                end;
            }

            column(Thanksgiving; Label.Get(Labels::ThanksForYourOrder)) { }
        }

        dataitem(Blanks_Line; Integer)
        {
            column(Blanks_Line_No; Number) { }

            trigger OnPreDataItem()
            begin
                ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1.5, 1);
                ReportTemplates.CalcBlanksRange(0.25, 0.25);
                ReportTemplates.Run(Blanks_Line);
            end;
        }
    }

    var
        Label: Codeunit Label;
        ReportTemplates: Codeunit "Report Templates";

}