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

            #region columns
            column(Child_Number_Caption; Global.GetText(Caption::Number)) { }
            column(Parent_Number; Number) { }
            #endregion columns

            dataitem("Company Information"; "Company Information")
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
                    Template.Fit(0.25);
                end;
            }
            dataitem(Totals; Integer)
            {
                column(Totals_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    // SetRange(Number, 1, 0);
                    SetRange(Number, 1);
                    // SetRange(Number, 1, 2);
                    // SetRange(Number, 1, Random(3) - 1);

                    if IsEmpty() then CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    Template.Fix(0.5);
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(Blanks_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    Template.Run(Blanks);

                    if IsEmpty() then CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Template.Set(Paper::A4, 0.25);
                Template.Fix(1.25 + 1.25);
                Template.Fix(0.25);
                Template.Fit(0.5);
            end;
        }
    }

    var
        Global: Codeunit Global;
        Template: Codeunit Template;
}