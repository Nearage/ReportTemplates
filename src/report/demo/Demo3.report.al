report 50104 "Demo 3"
{
    Caption = 'Demo 3';
    RDLCLayout = 'src/report/demo/layout/Demo3.rdl';
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
            column(Thanksgiving; GlobalLabels.Get("Global Label"::ThanksForYourOrder)) { }
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

            dataitem(Totals; Integer)
            {
                #region columns
                column(Totals_Number; Number) { }
                #endregion columns

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Random(3) - 1);
                end;
            }

            dataitem(Blanks; Integer)
            {
                column(Blanks_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    ReportTemplates.CalcBodysHeight(11.69, 0, 0, 1.25, 1.25);
                    ReportTemplates.CalcBlanksRange((Totals.Count() * 0.5) + 0.25, 0.5);
                    ReportTemplates.Run(Blanks);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ReportTemplates.Reset();
            end;
        }
    }

    trigger OnInitReport()
    begin
        ReportTemplates.Init(0.25);
    end;

    var
        GlobalLabels: Codeunit "Global Labels";
        ReportTemplates: Codeunit "Report Templates";

}