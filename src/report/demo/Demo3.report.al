report 50104 "Demo 3"
{
    Caption = 'Demo 3';
    RDLCLayout = 'src/report/demo/layout/Demo3.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = filter(1 .. 50));

            column(Parent_Number; Number) { }
            dataitem(Company_Information; "Company Information")
            {
                #region columns
                column(Company_Picture; Picture) { AutoCalcField = true; }
                column(Company_Name; Name) { }
                column(Company_Address; Address) { }
                #endregion columns
            }
            dataitem(Child; Integer)
            {
                column(Child_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Parent.Number);
                end;

                trigger OnAfterGetRecord()
                begin
                    Templates.Fill(0.25);
                end;
            }
            dataitem(Totals; Integer)
            {
                column(Totals_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1);
                    // SetRange(Number, 1, 2);
                    // SetRange(Number, 1, Random(3) - 1);

                    if IsEmpty() then CurrReport.Break();
                end;

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
                    Templates.Fit(0.25);
                    Templates.Fill(0.5);
                    Templates.Run(Blanks);

                    if IsEmpty() then CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Templates.Init(Global::A4, 0, 0, 1.25, 1.25, 0.25);
            end;
        }
    }

    var
        Globals: Codeunit "Global Values";
        Templates: Codeunit "Report Templates";
}