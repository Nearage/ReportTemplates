report 50105 "Demo 4"
{
    Caption = 'Demo 4';
    RDLCLayout = 'src/report/demo/layout/Demo4.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            #region captions
            column(No_; Global.GetText(Caption::Number)) { }
            column(Description_; Global.GetText(Caption::Description)) { }
            column(Quantity_; Global.GetText(Caption::Quantity)) { }
            column(Amount_; Global.GetText(Caption::Amount)) { }
            column(VATPct_; Global.GetText(Caption::VATPct)) { }
            #endregion captions

            #region columns
            column(Type; "Document Type") { }
            column(Code; "No.") { }
            #endregion columns

            dataitem("Company Information"; "Company Information")
            {
                #region columns
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
                #endregion columns
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                #region columns
                column(Line_No; "Line No.") { }
                column(No; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Amount; Amount) { }
                column(VATPct; "VAT %") { }
                #endregion columns

                trigger OnAfterGetRecord()
                begin
                    Template.Fit(0.25);
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "No." = field("No.");

                #region columns
                column(Comment; Comment) { }
                #endregion columns

                trigger OnAfterGetRecord()
                begin
                    Template.Fix(0.5);
                end;
            }
            dataitem("Blank Line"; Integer)
            {
                column(Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Template.Run("Blank Line");

                    if IsEmpty() then CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Template.Set(Paper::A4, 0.25);
                Template.Fix(1.25);
                Template.Fit(0.25);
                Template.Fix(0.25);
                Template.Fit(0.25);
                Template.Fix(1.25);
            end;
        }
    }

    var
        Global: Codeunit Global;
        Template: Codeunit Template;
}