report 50103 "Sales Header"
{
    RDLCLayout = 'src/report/layout/SalesHeader.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Sales_Header; "Sales Header")
        {
            dataitem(Company_Information; "Company Information")
            {
                #region columns
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
                #endregion columns
            }

            #region columns
            column(Sales_Header_No; "No.") { }
            column(Sales_Header_Document_Type; "Document Type") { }
            column(Order_Date; "Order Date") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Thanksgiving; Label.Get(Labels::ThanksForYourOrder)) { }
            #endregion columns

            dataitem(Sales_Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                #region columns
                column(Sales_Line_Line_No; "Line No.") { }
                column(Sales_Line_No; "No.") { }
                column(Sales_Line_Description; Description) { }
                column(Sales_Line_Quantity; Quantity) { }
                column(Sales_Line_Amount; Amount) { }
                #endregion columns

                trigger OnPostDataItem()
                begin
                    ReportTemplates.IncludeDataItem(Sales_Line);
                end;
            }

            dataitem(Blanks_Line; Integer)
            {
                #region columns
                column(Blanks_Line_No; Number) { }
                #endregion columns

                trigger OnPreDataItem()
                begin
                    ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1.25, 1, 0.25);
                    ReportTemplates.CalcBlanksRange(0.25, 0.5);
                    ReportTemplates.Run(Blanks_Line);
                end;
            }

            dataitem(Totals; Integer)
            {
                DataItemTableView = where(Number = const(1));

                #region columns
                column(Totals_Number; Number) { }
                #endregion columns
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Init();
            end;
        }
    }

    var
        Label: Codeunit Label;
        ReportTemplates: Codeunit "Report Templates";

}