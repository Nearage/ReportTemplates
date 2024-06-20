report 50105 "Demo 4"
{
    Caption = 'Demo 4';
    RDLCLayout = 'src/report/demo/layout/Demo4.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Company_Information; "Company Information")
        {
            #region columns
            column(Company_Picture; Picture) { AutoCalcField = true; }
            column(Company_Name; Name) { }
            column(Company_Address; Address) { }
            #endregion columns
        }
        dataitem("Sales Header"; "Sales Header")
        {
            #region columns
            column(Type; "Document Type") { }
            column(Code; "No.") { }
            #endregion columns

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                column(Line_No; "Line No.") { }
                column(No_; 'No.') { }
                column(No; "No.") { }
                column(Description_; 'Description') { }
                column(Description; Description) { }
                column(Quantity_; 'Quantity') { }
                column(Quantity; Quantity) { }
                column(Amount_; 'Amount') { }
                column(Amount; Amount) { }
                column(VATPct_; 'VAT %') { }
                column(VATPct; "VAT %") { }

                trigger OnAfterGetRecord()
                begin
                    Templates.Fill(0.25);
                end;
            }
            dataitem(Comments; "Sales Comment Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "No." = field("No.");

                column(Comment; Comment) { }

                trigger OnAfterGetRecord()
                begin
                    Templates.Fit(0.5);
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blanks_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Templates.Run(Blanks);

                    if IsEmpty() then CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Templates.Init(Paper::A4, 0, 0, 1.25, 1.25, 0.25);
                Templates.Fit(0.25);
                Templates.Fill(0.5);
            end;
        }
    }

    var
        Globals: Codeunit Globals;
        Templates: Codeunit "Report Templates";
}